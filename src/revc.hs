main = interact $ map transform . reverse . init where
    transform 'A' = 'T'
    transform 'T' = 'A'
    transform 'C' = 'G'
    transform 'G' = 'C'