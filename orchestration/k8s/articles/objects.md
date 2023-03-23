https://habr.com/ru/post/589415/

# Pod

# ReplicaSet
Гарантирует, что определенное кол-во экземпляров всегда будет запущено в кластере.

# Deployment
Управляет контроллерами ReplicaSet.

# DaemonSet
Гарантирует что на каждом узле будет экземпляр пода.


https://habr.com/ru/company/southbridge/blog/526130/

# Job
Разовая задача.
Перезапускается до тех пор, пока не выполнится успешно,
или пока не истечет таймаут или не сгорят все попытки.
activeDeadlineSeconds
backoffLimit (время между попытками увеличивается)

Докер демон тормозит, если много контейнеров - поэтому лучше автоудалять.

# CronJob

Выполнение Job по расписанию.

* startingDeadlineSeconds
* concurrencyPolicy
* successfulJobsHistoryLimit
* failedJobsHistoryLimit
* concurrencyPolicy






