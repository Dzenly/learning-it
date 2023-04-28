GNU - GNU is Not Unix

Ричард Столлман.

91г - Линус Торвалдс.

https://habr.com/ru/post/655275/

# Загрузка.

POST - Power On Self Test

MBR (Master Boot Record) / GPT (GUID Partition Table)
Это простой загрузчик, который дергает загрузчик посложнее, например GRUB2.

GRUB2 - /boot (после выбора - подгружает FS и запускает ядро).

https://sysadminium.ru/adm_serv_linux-boot_algorithm/

Kernel->Init, (SystemD (устаревшее - SystemV))
initrd.img
`lsinitramfs`

Debian11, Ubuntu22.04 - SystemD.

`ps -p 1`

======

# Process states

* Running
* Sleep (waiting for software interruption)
* Direct (waiting for hardware interruption)
* Tracing
* Zombie

======

https://www.youtube.com/watch?v=BeP3XOPJoww&list=PLMiVLClzZDbRv6BiFpkndO41DcTn0ILQE

https://www.baeldung.com/linux/process-states

* Running or Runnable (R)
* Uninterruplible Sleep (D) (does not react any signals)
* Interruptable Sleep (S)
* Stopped (T) (SIGSTOP, SIGTSTP, SIGCONT)
* Zombie (Z) (Послал SIGCHLD to parent, parent should clear process table from zombie, read exit value, wait waitpid.)

==============

nice
ionice
tc (QoS) (traffic control)

strace
https://jtprog.ru/strace/#:~:text=%D0%A0%D0%B0%D0%B1%D0%BE%D1%82%D0%B0%20strace%20%D0%B7%D0%B0%D0%BA%D0%BB%D1%8E%D1%87%D0%B0%D0%B5%D1%82%D1%81%D1%8F%20%D0%B2%20%D0%BE%D1%82%D1%81%D0%BB%D0%B5%D0%B6%D0%B8%D0%B2%D0%B0%D0%BD%D0%B8%D0%B8,%D0%B2%D0%B0%D0%BC%20%D0%BD%D0%B8%D1%87%D0%B5%D0%B3%D0%BE%20%D0%BD%D0%B5%20%E2%80%9C%D0%BE%D1%82%D1%81%D0%BB%D0%B5%D0%B4%D0%B8%D1%82%E2%80%9D.

ptrace






