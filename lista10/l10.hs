--zadanie 1
cantor = [ (y,x-y) | x <- [0..], y <- [0.. x]]

--zadanie 2
halve :: [a] -> ([a],[a])

halve xs = ( take pivot xs, drop pivot xs )
	where pivot = ((length xs) `div` 2 )

merge :: Ord a => ([a],[a]) -> [a]

merge ([],[]) = []
merge (xs,[]) = xs
merge ([],xs) = xs
merge ( x:xs , y:ys ) = if x <= y then x:merge(xs,y:ys) else y:merge(x:xs,ys)

cross :: ( a-> c, b-> d) -> (a,b) -> (c,d)
cross (f,g) = pair( f.fst, g.snd )

pair :: (a->b,a->c) -> a -> (b,c)
pair (f,g) x = (f x , g x)


msort [] = []
msort [x] = [x]
msort xs = merge . cross (msort,msort) . halve $ xs

--zadanie 3

merge_unique :: Ord a => [a] -> [a] -> [a]
merge_unique xs [] = xs
merge_unique [] xs = xs
merge_unique (x:xs) (y:ys) = if x < y then x:merge_unique xs (y:ys) else if x > y then y:merge_unique (x:xs) ys else y:merge_unique xs ys
	{-| x < y = x:merge_unique xs (y:ys)
	| x > y = y:merge_unique (x:xs) ys
	| otherwise = y:merge_unique xs ys-}

d235 :: [Integer]
d235 = 1:merge_unique l2 l35 where
	l2 = (map (*2) d235)
	l35 = merge_unique (map (*3) d235) (map (*5) d235)

--zadanie 4
msortn :: Ord a => [a] -> Int -> [a]
msortn xs 0 = []
msortn (x:xs) 1 = [x]
msortn xs n = merge ( ( msortn xs half ) , (msortn (drop half xs) (n-half)) ) where
	half = n `div` 2

msortnl xs = msortn xs (length xs)


--zadanie 5

class Monoid a where
	(***) :: a -> a -> a
	e :: a
infixl 6 ***

instance Monoid Integer where
	e = 0
	(***) = (+)	

infixr 7 ^^^
(^^^) :: Monoid a => a -> Integer -> a
a ^^^ 0 = e
a ^^^ n 
 	| n `mod` 2 == 1 = a *** c *** c
 	| otherwise	= c *** c
 	where c = a ^^^ ( n `div` 2)

{-newtype Zn = Zn Integer

instance Monoid Zn where
		e = Zn 1	
		(Zn a) *** (Zn b) = Zn(a*b `mod` n)-}

-- zadanie 6
data Mtx2x2 a = Mtx2x2 a a a a

instance (Num a) => Monoid (Mtx2x2 a) where
	(***) (Mtx2x2 a11 a12 a21 a22) (Mtx2x2 b11 b12 b21 b22) = Mtx2x2 (a11*b11 + a12*b21) (a11*b12 + a12*b22) (a21*b11 + a22*b21) (a21*b21 + a22*b22)
	e = (Mtx2x2 1 0 0 1) 

takem (Mtx2x2 a b n c) = n
fib n = takem ((Mtx2x2 0 1 1 1) ^^^ n)

