import Control.Applicative

main = interact $ show . run . map read . words where
    run (n:m:[]) = sum $ fib !! (n-1) where
        fib = (replicate (m-1) 0 ++ [1]) : map (liftA2 (++) tail ((:[]) . sum . init)) fib
        -- Somewhat ugly, but nevertheless working & obvious solution