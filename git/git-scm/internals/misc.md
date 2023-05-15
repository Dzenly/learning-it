Хэш считается как :

printf "blob $(printf "$s" | wc -c)\0$s" | sha1sum

