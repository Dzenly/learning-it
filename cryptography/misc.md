DES - Data Encryption Standard (1977)

AES - Advanced Encryption Standard (2001) Rijndael он же?
Симметричные блочные шифры.
Блок 128 бит, ключи - 128, 192, 256.

Исходные данные разбиваются на блоки фиксированной длины, и к этим блокам применяется ключ.


CBC - Cipher Blоck Chaining (сцепление) - каждый блок данных побитово складывается по модулю два (XOR) с предыдущим результатом шифрования.
ECB - electronic code block (простая замена)
CFB - cipher feed back - обратная связь по шифротексту.
OFB - output feed back - обратная связь по выходу.

3 DES - троекратное выполнение DES.



===========

# TLS

https://tls.dxdt.ru/tls.html

DH Perfect Forward Secrecy (PFS).

Есть однонаправленная функция.
Узнать аргумент по возвращаемому значению оч. сложно.

Аргументы секретны. Передаем друг другу значение функции.
Проводим над значениями некоторые манипуляции, чтобы прийти к одному значению.

P - простое число.
G - генератор.

Два целых числа, меньше модуля.

a и b - секреты.

A = G^a mod P
B = G^b mod P

Обмениваемся A и B.
`A^b=G^(a*b) = B^a = G^(b*a)`
Общий секретный ключ - G^(a*b)

Возведение в степень - однонаправленная функция.

TLS сервер передает DH параметры и свой публичный ключ A.
И подписывает их своим RSA или ECDSA.

Прослушивающая сторона знает P, G, A, B.

A = G^x mod P

Задача дискретного логарифмирования в конечной группе.

Квантовый алгоритм Шора взламывает DH ?

#EC
вместо P задается эллиптическая кривая.
Вместо возведения в степень - умножение на скаляр.
Генератор - точка кривой.
Ab = (Ga)b = Ba = (Gb)a = Gab.












https://habr.com/ru/articles/258285/

Клиент и сервер должны согласовать:
* Версию используемого протокола,
* Способ шифрования,
* Проверить сертификаты.

1. Сначала устанавливается TCP соединение.
2. Клиент высылает на сервер спеку (версия протокола шифрования, поддерживаемые методы).
3. Сервер утверждает протокол, и выбирает метод. Прикрепляет сертификат.
4. Клиент инициирует либо RSA, либо обмен ключами по Диффи-Хеллману.

RSA (аббревиатура от фамилий Rivest, Shamir и Adleman)
DH
https://crypto.stackexchange.com/questions/2867/whats-the-fundamental-difference-between-diffie-hellman-and-rsa

DH - shared key for symmetric encryption.
Key identity: (gens1)^s2 = (gens2)^s1 = shared secret   (mod prime)
Where:
gen is an integer whose powers generate all integer in [1, prime)   (mod prime)
s1 and s2 are the individuals' "secrets", only used to generate the symmetric key

Key identity: (me)d = m   (mod n)   (lets you recover the encrypted message)
Where:

n = prime1 × prime2    (n is publicly used for encryption)
φ = (prime1 - 1) × (prime2 - 1)   (Euler's totient function)
e is such that 1 < e < φ, and (e, φ) are coprime    (e is publicly used for encryption)
d × e = 1   (mod φ)    (the modular inverse d is privately used for decryption)

RSA  -

Клиент генерит симметричный ключ. Шифрует с помощью публичного ключа сервера. Сервер расшифровывает с помощью приватного.

Когда злоумышленник получает доступ к закрытому ключу.
Он может расшифровать весь сеанс связи.

DH - Симметричный ключ никогда не покидает клиента или сервера.
Для каждого сеанса связи временный симметричный ключ.

На сегодняшний день браузеры отдают предпочтение DH.


p * q = n
e - шифрующая экспонента
d - дешифрующая
e * d = 1

n, e - публичные
d - секрет
p, q - забыть.

С = M ^e mod n

C1 = (M^e)^d = M^(e*d) = M^1 = M mod n


p = 11, q = 13

n = p * q = 143

Ф(n) = (p-1)(q-1) = 120

e = 7

d * e = 1 mod 120 = 103

7 * 103 mod 120 = 1

Secret key (103, 143)
Public key (7, 143)

C = M ^ 7 mod 143

M =

Эль Гамаль

============

DSA

============

# ECC - Elliptic Curve Cryptography
https://habr.com/ru/articles/335906/
ECDH -
ECDSA -

============

GPG - GNU Privacy Guard
PGP - Pretty Good Privacy

============

# Квантовая криптография


============

