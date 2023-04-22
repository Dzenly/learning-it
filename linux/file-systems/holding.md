https://blog.bissquit.com/unix/udalenie-otkrytogo-fajla-v-linux/

? Что такое inodes ?

Index Node
Data Structure for file or directory.

touch small/file{001..010}.img

lsof | grep deleted


df -i - колво inodes в разных местах.

rm удаляет ссылку на файл, которую хранит объект каталога,
но не смогла удалить файл с диска.

du работает со ссылками.
df с реальным дисковым хранилищем.



