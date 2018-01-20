{-# LANGUAGE TypeFamilies #-}

import Control.Applicative (liftA2)
import Data.List.Split (wordsBy)
import Data.Char (isAlpha, isSpace)
import Data.Bifunctor (second)
import Data.Monoid ((<>))
import Data.Foldable (foldMap)
import Foreign.Marshal.Utils (fromBool)


-- TODO:
-- - Profile memory usage
-- - Employ parsec


class Aggregation a where
    type Summarize a :: *
    summarize :: a -> Summarize a


data Percentage = Percentage { numerator :: !Integer, denominator :: !Integer }

instance Monoid Percentage where
    mempty = Percentage 0 0
    mappend (Percentage nL dL) (Percentage nR dR) = Percentage (nL + nR) (dL + dR)

instance Aggregation Percentage where
    type Summarize (Percentage) = Double
    summarize (Percentage numerator 0) = 0.0
    summarize (Percentage numerator denominator) = 100.0 * (fromIntegral numerator) / (fromIntegral denominator)


data MaxItem = MaxItem { name :: !String, value :: !Double } | EmptyMaxItem

instance Monoid MaxItem where
    mempty = EmptyMaxItem
    mappend (MaxItem nameL valueL) (MaxItem nameR valueR) 
        | valueL < valueR = MaxItem nameR valueR
        | otherwise = MaxItem nameL valueL
    mappend (MaxItem name value) EmptyMaxItem = MaxItem name value
    mappend EmptyMaxItem (MaxItem name value) = MaxItem name value
    mappend EmptyMaxItem EmptyMaxItem = EmptyMaxItem

instance Aggregation MaxItem where
    type Summarize MaxItem = String
    summarize EmptyMaxItem = "EmptyMaxItem"
    summarize (MaxItem name value) = name <> "\n" <> show value


main = interact $ summarize . foldMap processItem . wordsBy (=='>') where
    processItem = uncurry MaxItem . second (summarize . foldMap percentage) . break isSpace where
        percentage = liftA2 Percentage (fromBool . flip elem "GC") (fromBool . isAlpha)
