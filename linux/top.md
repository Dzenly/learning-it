R - running
S - sleeping
Z - zombie

PR - Priority (0-99 for real time, 100 - 139 for users) PR = NI + 20 ?

NI - Nice value (user-space, -20 (highest), +19 (lowest)) (nice/renice) (-20 to 0 - root only). Not uset for Real Time processes.

Virt - Virtual image (all memory including swap)

RES - Resident Size (memory without swap). RSS can be more that actually used memory in case of shared libraries reusage. Many logical pages can point to one physical page.

SHR - Shared memory.

PSS - proportional set size.
Приватная память, плюс пропорция от Shared memory.

PSS is defined as the sum of the unshared memory of a process and the proportion of memory shared with other processes
В среднем по больнице сколько ест памяти.



