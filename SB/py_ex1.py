# -*- coding: utf-8 -*-


class Predictor:

    def __init__(self):
        self.__example_train_set = [
            (0, 1),
            (2, 2),
            (4, 3),
            (9, 8),
            (3, 5)
        ]

    @staticmethod
    def _mean(values):
        return sum(values) / float(len(values))

    @staticmethod
    def _variance(values, mean):
        return sum([(x - mean) ** 2 for x in values])

    @staticmethod
    def _covariance(x, mean_x, y, mean_y):
        covar = 0.0
        for i in range(len(x)):
            covar += (x[i] - mean_x) * (y[i] - mean_y)
        return covar

    def _coefficients(self):
        x = [row[0] for row in self.__example_train_set]
        y = [row[1] for row in self.__example_train_set]
        x_mean, y_mean = self._mean(x), self._mean(y)
        b1 = self._covariance(x, x_mean, y, y_mean) / self._variance(x, x_mean)
        b0 = y_mean - b1 * x_mean
        return [b0, b1]

    def predict(self, input_value):
        try:
            b0, b1 = self._coefficients()
            return b0 + b1 * input_value
        except TypeError:
            print('\033[41mERROR: %s' % TypeError)
            return 'Error'

    def __str__(self):
        return 'example_train_set: %s' % self.__example_train_set


def main():
    example_test_set = [
        [1, None],
        ['asd', None],
        [6, None],
        [6, None],
        [4, None],
        [5, None],
        [6, None],
        [7, None],
    ]

    dm = Predictor()
    print(dm)
    predicted = [dm.predict(point[0]) for point in example_test_set]
    print(predicted)


if __name__ == '__main__':
    main()
