import requests
import sys
from Bio import SeqIO
from io import StringIO
import re

def find_Nglycosylation_motifs(s):
    res = set()
    regex = re.compile('N[^P][ST][^P]')
    for offset in range(len(s)):
        match = re.search(regex, s[offset:])
        if match:
            res.add(offset + match.span()[0]+1)
    return sorted(res)

if __name__ == '__main__':
    ids = [line for line in sys.stdin]
    for id_ in ids:
        id_ = id_.strip()
        data = StringIO(requests.get(f'https://www.uniprot.org/uniprot/{id_}.fasta').content.decode('ascii'))
        entry = SeqIO.read(data, 'fasta')
        result = find_Nglycosylation_motifs(str(entry.seq))
        if result:
            print(id_)
            print(' '.join(str(x) for x in result))
