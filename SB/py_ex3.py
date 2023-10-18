"""
3) Целочисленное разделение n представляет собой слабо убывающий список положительных целых чисел,
сумма которых равна n.

Например, есть 3 целочисленных разделов по 3:

[3], [2,1], [1,1,1].
Напишите функцию, которая возвращает количество целочисленных разделов n.
Функция должна уметь находить количество целочисленных разделов n менее 100.

"""


def entire_sections(n, section=None, k=None):
    res = []
    if not section:
        section = list()
    if n:
        for i in range(n + 1, 0, -1):
            if not k:
                k = n
            if i <= k:
                res.extend(entire_sections(n - i, section + [i], i))
    else:
        res.append(section)
    return res


def main():
    n = 3
    print(*entire_sections(n), sep=', ')


if __name__ == '__main__':
    main()
