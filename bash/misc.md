# flags

# input parameters

$@ - array of input parameters.
$* - as one string.

$# - count

$_ - last arg of last command

IFS - internal field separator.

$0 - name of shell or shell script
$! - pid of the most recent background command.
$? - most recent foreground pipeline exit status.
$$ - PID of current shell.

# Arrays

```bash
myArray=(1 2 "three" 4 "five")
# ${myArray[@]} - all array elements.
# ${!myArray[@]} - all array indexes.

echo ${myArray[1]}
for item in ${myArray[@]}; do
  echo $item
done

myArray+=( "newElement1" "newElement2" )


arr=()	Create an empty array
arr=(1 2 3)	Initialize array
${arr[2]}	Retrieve third element
${arr[@]}	Retrieve all elements
${!arr[@]}	Retrieve array indices
${#arr[@]}	Calculate array size
arr[0]=3	Overwrite 1st element
arr+=(4)	Append value(s)
str=$(ls)	Save ls output as a string
arr=( $(ls) )	Save ls output as an array of files
${arr[@]:s:n}	Retrieve n elements starting at index s
```

========

IFS - влияет на итерации.

single [], VS [[ ]]

wildcard expansion
double asterisk

https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425