from Bio import SeqIO
import sys
from operator import itemgetter

def lcp(a, b):
    i = 0
    for x, y in zip(a, b):
        if x != y:
            return i
        i += 1
    return i

def lcs(strings, k):
    prefixes = []
    for idx, s in enumerate(strings):
        for offset in range(len(s)):
            prefixes.append((s[offset:], idx))
    prefixes = sorted(prefixes)
    lcps = [lcp(a[0], b[0]) for a, b in zip(prefixes, prefixes[1:])]

    i = 0
    best = 0
    best_solution = ''
    inside_window = dict([(k, 0) for k in range(len(strings))])
    while i < len(prefixes) - k:
        cnt_unique = sum(v > 0 for k, v in inside_window.items())
        cnt_overall = sum(v for k, v in inside_window.items())
        if cnt_unique >= k:
            candidate = min(lcps[i:i+cnt_overall-1])
            if candidate > best:
                best = candidate
                best_solution = prefixes[i][0][:best]
            inside_window[prefixes[i][1]] -= 1
            i += 1
        else:
            if i+cnt_overall+1 >= len(prefixes): break
            inside_window[prefixes[i+cnt_overall+1][1]] += 1
    return best_solution

if __name__ == '__main__':
    inp = list(SeqIO.parse(sys.stdin, 'fasta'))
    print(lcs([s.seq for s in inp], len(inp)))
