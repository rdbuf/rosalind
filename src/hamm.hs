main = interact $ show . length . filter (== False) . uncurry (zipWith (==)) . toTuple . lines where
    toTuple (x:y:[]) = (x, y)