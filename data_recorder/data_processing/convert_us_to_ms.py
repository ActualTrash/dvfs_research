import sys

data = []
with open(sys.argv[1], 'r') as src:
    header = src.readline()

    for l in src.read().splitlines():
        time, freq = l.split(',')
        time = int(time) // 1000
        data.append( f'{time},{freq}\n' )


with open(sys.argv[2], 'w') as dst:
    dst.write(header.replace('us', 'ms'))
    for d in data:
        dst.write(d)
