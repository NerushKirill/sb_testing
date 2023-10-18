"""
1) Ваша задача — построить модель[1], которая может предсказывать координату y.
Вы можете пройти тесты, если прогнозируемые координаты y находятся в пределах погрешности.

Вы получите комплект train, который нужно использовать для сборки модели.
После того как вы создадите модель, тесты будут вызывать функцию predict и передавать ей x.

Ошибка будет рассчитана с помощью RMSE.
Нельзя использовать библиотеки: sklearn, pandas, tensorflow, numpy, scipy

example_train_set = [
    (0, 1),
    (2, 2),
    (4, 3),
    (9, 8),
    (3, 5),
]

predicted = [dm.predict(point[0]) for point in example_test_set]

Объяснение
[1]Модель интеллектуального анализа данных создается путем применения алгоритма к данным, но это больше,
чем алгоритм или контейнер метаданных: это набор данных, статистики и шаблоны, которые можно применять к новым данным
для создания прогнозов и выводов о взаимосвязях.
"""

# -*- coding: utf-8 -*-
from __future__ import annotations


class Predictor:
    """This class is used for solving linear regression problems."""
    def __init__(self):
        # As part of the job, example_train_set locked for changes
        self.__example_train_set = list()
        pass

    def __str__(self):
        """
        Returns the training data instance used to train model.

        :return: self.example_train_set from this model
        """
        pass

    # Static functions are chosen for more flexible use of the class
    #          and possible improvement of the algorithm.

    @staticmethod
    def _mean(values: list[int | float]) -> float:
        """
        Calculation of the average value of the test sample by x | y.

        :param values: list of values int or float
        :return: series average
        """
        pass

    @staticmethod
    def _variance(values: list[int | float], mean: float) -> float:
        """
        Finding the variance.

        :param values: list value
        :param mean: average of this list
        :return: variance
        """
        pass

    @staticmethod
    def _covariance(x, mean_x, y, mean_y) -> float:
        """
        Finds the covariance between x and y.

        :param x: list x from train set
        :param mean_x: average list all x
        :param y: list y from train set
        :param mean_y: average list all x
        :return: coefficient covariance
        """
        pass

    def _coefficients(self) -> list:
        """
        Calculation of coefficients for prediction.

        :return: coefficients for predict
        """
        pass

    def predict(self, input_value: int | float) -> float:
        """
        Predicts a number.

        :param input_value: Number to be predicted | x
        :return: Prediction | y
        :except TypeError: print Error & return str(Error)
        """
        pass
