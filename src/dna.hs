main = interact $ unwords . map show . run where 
  run = flip map (map (length .) (map (filter . (==)) "ACGT")) . flip ($)