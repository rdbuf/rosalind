import Data.List.Split (wordsBy)
import Data.List (maximumBy, foldl')
import Data.Char (isAlpha, isSpace)
import Data.Bifunctor (second)
import Data.Tuple (snd)
import Data.Function (on)
import Data.Monoid ((<>))
import Data.Foldable (foldMap)
import Foreign.Marshal.Utils (fromBool)

-- TODO:
-- - Profile memory usage
-- - Employ parsec

data Percentage = Percentage { numerator :: !Integer, denominator :: !Integer }

instance Monoid Percentage where
    mempty = Percentage 0 0
    mappend (Percentage nL dL) (Percentage nR dR) = Percentage (nL + nR) (dL + dR)

main = interact $ format . maximumBy (compare `on` snd) . map processItem . wordsBy (=='>') where
    processItem = second (getPercentage . foldMap percentage . filter isAlpha) . break isSpace where
        percentage = flip Percentage 1 . fromBool . flip elem "GC"
        getPercentage (Percentage numerator 0) = 0
        getPercentage (Percentage numerator denominator) = 100.0 * (fromIntegral numerator) / (fromIntegral denominator)
    format = uncurry ((<>) . flip (<>) "\n") . second show