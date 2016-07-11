import math

def table_format(number):
    if math.isnan(number) or number == float('inf'):
        return 'N/A'
    # If it's really small, put 4 numbers after the decimal
    if number <= 0.001:
        return '%.4f' % number
    if number <= 100:
        return '%.3f' % number
    if number > 100:
        return '{0:,d}'.format(int(number))
    else:
        return 'N/A'