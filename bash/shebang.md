Passing options to node on the shebang (#!) line
I was chatting with someone on #node.js who wanted his script to pass a command-line option to node, so that his script was run in a particular node environment. The problem is that under linux you get to pass exactly one argument on the shebang (#!) line. If you use #!/usr/bin/env node, you’ve already used your one argument. When I suggested he use the “-x” hack, we discovered that node didn’t have this hack. So I made a pull request complete with a TL;DR justification for why -x is necessary.

Turns out there’s a tidier hack that doesn’t require any changes to node, which relies on the interaction between bash and node.  Here’s an example, lifted from pm2 and lightly modified for clarity:

#!/bin/sh 
":" //# comment; exec /usr/bin/env node --noharmony "$0" "$@"

console.log('javascript');
Here’s how it works:

The #!/bin/sh causes the script to be identified as a shell script, and passed to /bin/sh for execution. /bin/sh reads and executes scripts one line at a time, and we’re taking advantage of that below.

The second line, as interpreted by the shell, consists of two commands.

2a. The first command is ":", which is the quoted version of the rarely-used bash command :, which means “expand arguments and no-op”. The only argument to : is //, which is a valid path. The following # is a bash comment, which is valid until the command separator ;.

2b. The second command is exec /usr/bin/env node --noharmony "$0" "$@" which executes the node interpreter with the desired arguments and passes argument 0 (this script file) and the rest of the arguments to the bash script ("$@")

The exec causes the bash process to be replaced by the node process, so bash does not attempt to process any further lines.

Now we’re running under node, with the desired command line arguments set. Unlike bash, node wants to read and parse the whole file. So let’s see what node sees:

The #!/bin/sh line is ignored due to a special one-off in node – when loading a module, the contents of the first line will be ignored from #! up to the first \n.
The second line contains a string constant, the quoted string ":", followed by a Javascript comment introduced with //. Automatic semicolon insertion happens so the constant is interpreted as a string in a statement context. Then the comment is parsed, and everything up to the end of the line is ignored by node.
This won’t lint clean. jslint and jshint both complain:

$ jslint test
test:2:1: Expected an assignment or function call and instead saw an expression.
test:2:4: Expected ';' and instead saw 'console'.
$ jshint test
test: line 2, col 1, Missing semicolon.

1 error
But it works right now, as a hack-around for the Linux one-argument shebang problem.

Note that there’s a spot in the line where you can insert a comment (as long as it doesn’t contain anything that bash interprets, notably ;). What to put there? I recommend a link to a web page (such as the one you’re reading now, http://sambal.org/?p=1014) that explains WTF this weird-looking line is all about. For example:

#!/bin/sh 
":" //# http://sambal.org/?p=1014 ; exec /usr/bin/env node --noharmony "$0" "$@"

console.log('javascript');
Happy hacking!