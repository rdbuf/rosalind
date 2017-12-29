import Data.List.Split
import Data.Ratio
import Data.Char

main = interact $ format . maximum . map (run . lines) . wordsBy (=='>') where
    run (label:dnaParts) = ((fromIntegral . length . filter (`elem` "GC")) dna / (fromIntegral . length) dna, label) where
        dna = (filter isAlpha . unlines) dnaParts
    format (ratio, title) = title ++ "\n" ++ show (100 * ratio)