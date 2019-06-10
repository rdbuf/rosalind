from operator import itemgetter
import sys

def parse(strings):
    current = ''
    for s in strings:
        if s.startswith('>'):
            if current != '':
                yield current
                current = ''
        else: current += s
    yield current

def freq(inputs):
    d = {}
    for x in inputs:
        if not x in d: d[x] = 0
        d[x] += 1
    return d

def f(inputs):
    s = ''
    fr = {'A':[],'C':[],'G':[],'T':[]}
    for j in range(len(inputs[0])):
        frequences = freq(map(itemgetter(j), inputs))
        s += sorted(frequences.items(), key=itemgetter(1))[-1][0]
        for a in fr:
            fr[a].append(frequences.get(a, 0))
    return s, fr

if __name__ == '__main__':
    s, fr = f(list(parse(line.strip() for line in sys.stdin)))
    print(s)
    for a, cs in fr.items():
        print(f'{a}: {" ".join(str(x) for x in cs)}')

        
