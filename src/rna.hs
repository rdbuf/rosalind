-- Data.List.Utils.replace could've been used instead
main = interact $ map transform where
    transform 'T' = 'U'
    transform = id