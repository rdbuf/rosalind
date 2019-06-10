from Bio import SeqIO
import sys

def f(inp, k):
    result = []
    for a in inp:
        for b in inp:
            if a.seq != b.seq:
                if a.seq[-k:] == b.seq[:k]:
                    result.append((a, b))
    return result

if __name__ == '__main__':
    inp = list(SeqIO.parse(sys.stdin, 'fasta'))
    for a, b in f(inp, 3):
        print(a.name, b.name)