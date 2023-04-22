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




