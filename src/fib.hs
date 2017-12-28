main = interact $ show . run . map read . words where
    run (n:k:[]) = fib !! (n-1) where
        fib = [1, 1] ++ zipWith (+) (tail fib) (map (k*) fib)