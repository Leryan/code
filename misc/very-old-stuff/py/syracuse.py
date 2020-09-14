#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

__author__ = "Florent Peterschmitt <fpeterscom@yahoo.fr>"

if __name__ == '__main__':
    value = 5
    score = 0
    max_value = 0
    iterations = 0
    while iterations < 700:
        b = value
        iterations = 0
        #Calcul de la suite jusqu'à arrivée à 1
        while b != 1:
            if b % 2 == 0:
                b = b / 2
            else:
                b = (3 * b + 1) / 2
                iterations += 1
            iterations += 1
        if iterations > score:
            score = iterations
            max_value = value
            print("{} with {} numbers".format(value, iterations))
        value += 1
    print("{} with {} numbers".format(max_value, score))
