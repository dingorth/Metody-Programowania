module Liczby(make_liczba) where

import qualified Data.Map as M
import Data.Maybe (fromMaybe)
import Waluty(Rodzaj(..))

-- te mapy częściowo napisane przez Macieja Buszkę
pk = M.fromList
  [(1, "mi"),     (2, "bi"),     (3, "try")
  ,(4, "kwadry"), (5, "kwinty"), (6, "seksty")
  ,(7, "septy"),  (8, "okty"),   (9, "noni")]

qa = M.fromList
  [(1, "un"),      (2, "do"),   (3, "tri")
  ,(4, "kwatuor"), (5, "kwin"), (6, "seks")
  ,(7, "septen"),  (8, "okto"), (9, "nowem")]

rb = M.fromList
  [(1, "decy"),     (2, "wicy"),     (3, "trycy")
  ,(4, "kwadragi"), (5, "kwintagi"), (6, "seksginty")
  ,(7, "septagi"),  (8, "oktagi"),   (9, "nonagi")]

sc = M.fromList
  [(1, "centy"),    (2, "ducenty"), (3, "trycenty")
  ,(4, "kwadryge"), (5, "kwinge"),  (6, "sescenty")
  ,(7, "septynge"), (8, "oktynge"), (9, "nonge")]

under20 = 
  M.fromList[(1, "jeden"),       (2, "dwa"),           (3, "trzy")
  ,(4, "cztery"),      (5, "pięć"),          (6, "sześć")
  ,(7, "siedem"),      (8, "osiem"),         (9, "dziewięć")
  ,(10, "dziesięć"),   (11, "jedenaście"),   (12, "dwanaście")
  ,(13, "trzynaście"), (14, "czternaście"),  (15, "piętnaście")
  ,(16, "szesnaście"),  (17, "siedemnaście"), (18, "osiemnaście")
  ,(19, "dziewiętnaście")]

dziesiatki = 
    M.fromList[(20, "dwadzieścia"), (30, "trzydzieści"), 
    (40, "czterdzieści"), (50, "pięćdziesiąt"), (60, "sześćdziesiąt"),
    (70, "siedemdziesiąt"), (80, "osiemdziesiąt"), (90, "dziewięćdziesiąt")]

setki = 
    M.fromList[(100, "sto"), (200, "dwieście"), (300, "trzysta"), 
    (400, "czterysta"), (500, "pięćset"), (600, "sześćset"),
    (700, "siedemset"), (800, "osiemset"), (900, "dziewięćset")]

type Base = Integer
type Rozklad = [(Integer, Integer)]

mapNumberBase :: Integer -> Base -> Rozklad -> Integer -> Rozklad
mapNumberBase 0 _ list _ = list
mapNumberBase n base list wykladnik 
    | reszta /= 0   = mapNumberBase calkow base ( (reszta,wykladnik):list ) $ wykladnik + 1
    | otherwise     = mapNumberBase calkow base list $ wykladnik + 1
    where
        calkow = n `div` base
        reszta = n `mod` base

sto :: Integer -> String
sto n = if n >= 100 then (fromMaybe "" $ M.lookup (n `div` 100 * 100) setki ) else ""

dziesiec :: Integer -> Integer -> Rodzaj -> Bool -> String
dziesiec n wykladnik rodzaj change = 
    if liczba > 19 then 
        ( fromMaybe "" $ M.lookup (liczba `div` 10 * 10) dziesiatki ) ++ 
        if liczba `mod` 10 /= 0 then
            " " ++ if rodzaj == Zenski && ost_cyf== 2 && wykladnik==0 then "dwie" else 
                        --if rodzaj == Zenski && ost_cyf ==1 && wykladnik==0 then "jedna" else 
                            {-if rodzaj == Nijaki && ost_cyf ==1 && wykladnik==0 then "jedno" else-} fromMaybe "" $ M.lookup (ost_cyf) under20
        else
            ""
    else 
        if rodzaj == Zenski && liczba== 2 && wykladnik==0 then "dwie" else 
            if rodzaj == Zenski && liczba ==1 && wykladnik==0 && change == True then "jedna" else 
                if rodzaj == Nijaki && liczba ==1 && wykladnik==0  && change == True then "jedno" else fromMaybe "" $ M.lookup (liczba) under20
    where 
        liczba = n `mod` 100
        ost_cyf = n `mod` 10

small_number :: Integer -> Rodzaj -> Integer -> Bool -> String
small_number n rodzaj wykladnik change = sto n ++ 
    if n >= 100 
        then 
            if (n `mod` 100) /= 0 then " " ++ (dziesiec n wykladnik rodzaj change) else ""
        else 
            dziesiec n wykladnik rodzaj change


tysiac :: Integer -> String
tysiac odmiana 
    | odmiana == 1  = "tysiąc"
    | odmiana >1 && odmiana < 5    = "tysiące"
    | odmiana `mod` 10 <= 4 && odmiana `mod` 10 > 1 && odmiana `mod` 100 /=12 = "tysiące"
    | otherwise  = "tysięcy"

big_odmiana :: Integer -> String
big_odmiana ile
    | ile == 1 = ""
    | ile < 5  = "y"
    | (dwost > 20 || dwost <12) && (ost == 2 || ost == 3 || ost == 4) = "y"
    | otherwise = "ów"
    where
        dwost = ile `mod` 100
        ost = ile `mod` 10
    
lionliard :: Integer -> String
lionliard tmp
    | tmp == 1 = "liard"
    | otherwise = "lion"

big_number :: Integer -> Integer -> String
big_number wykladnik ile
    | wykladnik == 0 = ""
    | wykladnik == 1 = tysiac ile
    | wykladnik < 20 = (fromMaybe "" $ M.lookup k pk) ++ (lionliard p ) ++ (big_odmiana ile)
    | otherwise      = (fromMaybe "" $ M.lookup a qa) ++ (fromMaybe "" $ M.lookup b rb) ++ (fromMaybe "" $ M.lookup c sc) ++ (lionliard p) ++ (big_odmiana ile)
    where
        k = wykladnik `div` 2
        p = wykladnik `mod` 2
        a = k `mod` 10
        b = k `div` 10 `mod` 10
        c = k `div` 100 `mod` 10

fold_help :: Rodzaj -> Integer -> String -> (Integer, Integer) -> String
fold_help rodzaj liczba left right = 
    if bigger /="" then left ++ smaller ++ " " ++ bigger ++ " " else left ++ smaller ++ " " ++ bigger
    where
        smaller = small_number (fst right) rodzaj (snd right) change
        bigger  = big_number (snd right) (fst right)
        change = if liczba < 10 then True else False 

make_liczba :: Integer -> Rodzaj -> String
make_liczba liczba rodzaj = foldl (fold_help rodzaj liczba) "" mapa
    where mapa = mapNumberBase liczba 1000 [] 0

