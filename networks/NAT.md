https://www.youtube.com/watch?v=L1JtmAiSaFQ&ab_channel=AndreySozykin

IP не хватает.

# Static NAT.

Тупо внутренние памятся во внешние 1 к 1.

# Dynamic NAT.

Есть пул внешних адресов и они поочередно используются
для внутренних.

# Маскарадинг:

Наиболее исползуемый.
Все внутренние адреса - на один внешний.

Внутренний адрес: внутренний порт.
Внешний IP, внешний порт (случайно сгенеренный).

# Недостатки:
* Нет возможности извне подключиться к компам внутренней сети.
* Плохо работают протоколы, рассчитывающиеся на соединение
между компами.
* Плохо работают протоколы, не устанавшивающие соединение.
* 









