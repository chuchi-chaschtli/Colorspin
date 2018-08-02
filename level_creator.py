#!/usr/bin/python

from enum import Enum

import sys
import json

class StarType(Enum):
BRONZE = 'bronze'
SILVER = 'silver'
GOLD = 'gold'

usableColors = []



#### CONSOLE READER HELPER FUNCTIONS ####
def readIntInputWithBounds(prompt, min, max):
    value = 0

    try:
        value = int(input(prompt + ':\n'))
    except Exception as error:
        print('Error! Integer must be specified. Defaulting to 0.\n')

    if not checkBounds(value, min, max):
        print('The value `' + str(value) + '` is invalid. Defaulting to minimum value `' + str(min) + '`...')
        value = 0
    return value

def readFloatInputWithBounds(prompt, min, max):
    value = 0

    try:
        value = float(input(prompt + ':\n'))
    except Exception as error:
        print('Error! Floating point must be specified. Defaulting to 0.\n')

    if not checkBounds(value, min, max):
        print('The value `' + str(value) + '` is invalid. Defaulting to minimum value `' + str(min) + '`...')
        value = 0
    return value

def readIntInput(prompt):
    return readIntInputWithBounds(prompt, 0, 0)

def readFloatInput(prompt):
    return readFloatInputWithBounds(prompt, 0, 0)

def checkBounds(val, min, max):
    return (min + max == 0 and val >= 0) or min <= val <= max



#### DATA SETUP HELPER FUNCTIONS ####
def setupWheelData():
    radius = readFloatInput('Enter the radius of the wheel')
    centerX = readFloatInput('Enter the x position of the wheel center')
    centerY = readFloatInput('Enter the y position of the wheel center')
    numSlices = readIntInputWithBounds('Enter how many slices you would like to add for this wheel', 1, sys.maxsize)
    slices = []

    for i in range(0, numSlices):
        color = input('Enter the color for slice #' + str(i + 1) + ':\n')
        usableColors.append(color)
        scale = readFloatInput('Now enter the scalar value for slice #' + str(i + 1))
        slices.append(color + ':' + str(scale))

    return {'centerX': centerX, 'centerY': centerY, 'radius': radius, 'slices': ','.join(slices)}

def setupParticleData():
    particles = []
    numParticles = readIntInputWithBounds('Enter how many particles you would like to add for this level', 1, sys.maxsize)
    for i in range(0, numParticles):
        print('Setting up particle #' + str(i + 1))
        x = readFloatInput('Enter the x position of the particle')
        y = readFloatInput('Enter the y position of the particle')
        radius = readFloatInput('Enter the radius of the particle')

        color = setupParticleColor()

        speed = readFloatInput('Enter the speed of the particle')
        repeat = readIntInput('Enter the repeat interval of the particle in ticks')
        starting = readIntInput('Enter the start time of the particle in ticks')
        particles.append({'x': x, 'y': y, 'radius': radius, 'color': color, 'speed': speed, 'repeatEvery': repeat, 'startingTick': starting})

    return particles

def setupParticleColor():
    formattedUsableColors = ', '.join(str(e) for e in set(usableColors))
    formattedUsableColors = '[%s]' % formattedUsableColors
    color = input('Enter the color (one of ' + formattedUsableColors + ') of the particle:\n')
    if color not in set(usableColors):
        print('Invalid color specified. Defaulting to ' + usableColors[0] + '.')
        color = usableColors[0]
    return color

def setupStarData():
    stars = []
    for type in StarType:
        threshold = readIntInput('Enter the score threshold for a ' + type.value + ' star')
        stars.append({'type': type.value, 'scoreThreshold': threshold})
    return stars



#### MAIN SCRIPT ####
    if __name__ == '__main__':
    print('=========================================')
    print('Now setting up a new json level format...')
    print('=========================================')
    level = readIntInputWithBounds('Enter a level number (int > 0)', 1, sys.maxsize)
    tps = readIntInputWithBounds('Enter the tps for the level (int in [0, 60])', 0, 60)
    safetyBuffer = readFloatInputWithBounds('Enter the safety buffer for the level (float in [0, 1])', 0, 1)

    print('\nAwesome. Now beginning wheel setup...\n')
    wheel = setupWheelData()

    print('\nSweet. Now beginning particle setup...\n')
    particles = setupParticleData()

    print('\nWoohoo! Now beginning star setup...\n')
    stars = setupStarData()

    fileName = 'level' + str(level) + '.json'
    with open('Colorspin/Levels/' + fileName, 'w') as outputFile:
        json.dump({'tps': tps, 'safetyBuffer': safetyBuffer, 'wheel': wheel, 'particles': particles, 'stars': stars}, outputFile, indent = 4)
    print(fileName + ' has been successfully saved.')
