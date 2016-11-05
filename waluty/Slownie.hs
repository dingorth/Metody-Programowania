module Slownie (Rodzaj(..), Waluta(..), slownie) where

import qualified Data.Map as M
import           Data.Maybe (fromMaybe)
import           Waluty(Waluta(..), Rodzaj(..))
import           Liczby


slownie :: Waluta -> Integer -> String
slownie w l 
    | al == 0                = "zero " ++ p
    | al > (10 ^ 6000 -1)   = "mnóstwo"
    | al < -(10 ^ 6000 -1)  = "malutko"
    | l > 0                  = (make_liczba l (rodzaj w)) ++ p
    | otherwise              = "minus " ++ (make_liczba al (rodzaj w)) ++ p
    where
        p = przypadek w al
        al = abs(l)

przypadek :: Waluta -> Integer -> String
przypadek w l
    | al == 0                       = dopelniacz_mn w
    | al == 1                       = mianownik_poj w
    | al >= 2 && al <= 4            = mianownik_mn w
    | (dwost > 20 | dwost <10) && (ost == 2 || ost == 3 || ost == 4) = mianownik_mn w
    | otherwise                     = dopelniacz_mn w
    where 
        trzyost = al `mod` 1000
        dwost = al `mod` 100
        ost = al `mod` 10
        al = abs(l)
        