https://petermalmgren.com/signal-handling-docker/

PID 1 - main docker process.
If shell script - will not pass any signals to child process.

So even SIGTERM will be ignored by the process.

To avoid problem you can use exec.





