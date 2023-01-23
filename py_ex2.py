"""2) Простое число-близнец — это простое число, которое отличается от другого простого числа на 2.
Напишите функцию с именем prime, которая принимает int параметр и возвращает значение true,
если оно является простым числом-близнецом, иначе false.

Примеры:

5- простое число
5 + 2 = 7, тоже простое
5 - 2 = 3, тоже простое
Тогда 5 – число близнец

"""


def is_prime(x: int) -> bool:
    return all(x % i != 0 for i in range(2, int(x**0.5 + 1)))


def prime(x: int) -> bool:
    return is_prime(x) and (is_prime(x - 2) or is_prime(x + 2))


def main():
    for i in range(2, 1001):
        print(i, prime(i))


if __name__ == '__main__':
    main()

