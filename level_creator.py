#!/usr/bin/python

from enum import Enum

import sys
import json

class StarType(Enum):
    BRONZE = 'bronze'
    SILVER = 'silver'
    GOLD = 'gold'

usable_colors = []



#### CONSOLE READER HELPER FUNCTIONS ####
def parse_int_input_with_bounds(prompt, min, max):
    value = 0

    try:
        value = int(input(prompt + ':\n'))
    except Exception as error:
        print('Error! Integer must be specified. Defaulting to 0.\n')

    if not check_bounds(value, min, max):
        print('The value `' + str(value) 
            + '` is invalid. Defaulting to minimum value `' + str(min) 
            + '`...')
        value = 0
    return value

def parse_float_input_with_bounds(prompt, min, max):
    value = 0

    try:
        value = float(input(prompt + ':\n'))
    except Exception as error:
        print('Error! Floating point must be specified. Defaulting to 0.\n')

    if not check_bounds(value, min, max):
        print('The value `' + str(value) 
            + '` is invalid. Defaulting to minimum value `' + str(min) 
            + '`...')
        value = 0
    return value

def parse_int_input(prompt):
    return parse_int_input_with_bounds(prompt, 0, 0)

def parse_float_input(prompt):
    return parse_float_input_with_bounds(prompt, 0, 0)

def check_bounds(val, min, max):
    return (min + max == 0 and val >= 0) or min <= val <= max



#### DATA SETUP HELPER FUNCTIONS ####
def setup_wheel():
    radius = parse_float_input('Enter the radius of the wheel')
    centerX = parse_float_input('Enter the x position of the wheel center')
    centerY = parse_float_input('Enter the y position of the wheel center')
    num_slices = parse_int_input_with_bounds(
        'Enter how many slices you would like to add for this wheel', 
        1, sys.maxsize)
    slices = []

    for i in range(0, num_slices):
        color = input('Enter the color for slice #' + str(i + 1) + ':\n')
        usable_colors.append(color)
        scale = parse_float_input('Now enter the scalar value for slice #' 
            + str(i + 1))
        slices.append(color + ':' + str(scale))

    return {'centerX': centerX, 
            'centerY': centerY, 
            'radius': radius, 
            'slices': ','.join(slices)}

def setup_particles():
    particles = []
    num_particles = parse_int_input_with_bounds('Enter how many particles you would like to add for this level', 1, sys.maxsize)
    for i in range(0, num_particles):
        print('Setting up particle #' + str(i + 1))
        x = parse_float_input('Enter the x position of the particle')
        y = parse_float_input('Enter the y position of the particle')
        radius = parse_float_input('Enter the radius of the particle')

        color = parse_particle_colors()

        speed = parse_float_input('Enter the speed of the particle')
        repeat = parse_int_input(
            'Enter the repeat interval of the particle in ticks')
        starting = parse_int_input(
            'Enter the start time of the particle in ticks')
        particles.append({
            'x': x, 
            'y': y, 
            'radius': radius, 
            'color': color, 
            'speed': speed, 
            'repeatEvery': repeat, 
            'startingTick': starting})

    return particles

def parse_particle_colors():
    formatted_usable_colors = ', '.join(str(e) for e in set(usable_colors))
    formatted_usable_colors = '[%s]' % formatted_usable_colors
    color = input('Enter the color (one of ' + formatted_usable_colors 
        + ') of the particle:\n')
    if color not in set(usable_colors):
        print('Invalid color specified. Defaulting to ' + usable_colors[0] 
            + '.')
        color = usable_colors[0]
    return color

def setup_stars():
    stars = []
    for type in StarType:
        threshold = parse_int_input('Enter the score threshold for a ' 
            + type.value + ' star')
        stars.append({'type': type.value, 'scoreThreshold': threshold})
    return stars



#### MAIN SCRIPT ####
if __name__ == '__main__':
    print('=========================================')
    print('Now setting up a new json level format...')
    print('=========================================')
    level = parse_int_input_with_bounds('Enter a level number (int > 0)', 1, 
        sys.maxsize)
    tps = parse_int_input_with_bounds(
        'Enter the tps for the level (int in [0, 60])', 0, 60)
    safety_buffer = parse_float_input_with_bounds(
        'Enter the safety buffer for the level (float in [0, 1])', 0, 1)

    print('\nAwesome. Now beginning wheel setup...\n')
    wheel = setup_wheel()

    print('\nSweet. Now beginning particle setup...\n')
    particles = setup_particles()

    print('\nWoohoo! Now beginning star setup...\n')
    stars = setup_stars()

    filename = 'level' + str(level) + '.json'
    with open('Colorspin/Levels/' + filename, 'w') as outfile:
        json.dump(
            {
                'tps': tps, 
                'safetyBuffer': safety_buffer, 
                'wheel': wheel, 
                'particles': particles, 
                'stars': stars
            }, 
            outfile, indent = 4)
    print(filename + ' has been successfully saved.')
