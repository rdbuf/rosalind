main = interact $ show' . run
  where run = (flip map) (map (length .) (map (filter . (==)) "ACGT")) . flip ($)
        show' = unwords . map show