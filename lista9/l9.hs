-- zadanie 5
delta :: (Double, Double, Double) -> Double
delta (a,b,c) = b*b - 4*a*c

roots :: (Double, Double, Double) -> [Double]
roots (a,b,c)
	| wyr < 0 = []
	| wyr == 0 = [ -b / 2 * a ]
	| otherwise			= [ (-b + sqrt (wyr))/2*a , (-b - sqrt (wyr))/2*a ]
	where wyr = delta (a,b,c)

data Roots = No 
	| One Double 
	| Two (Double, Double)
	deriving Show

roots2 :: (Double, Double, Double) -> Roots
roots2 (a,b,c)
	| wyr < 0 = No
	| wyr == 0 = One (-b / 2 * a)
	| otherwise = Two (( (-b + sqrt (wyr))/2*a ), ((-b - sqrt (wyr))/2*a) )
	where wyr = delta (a,b,c)


-- zadanie 4
fib = 0:1:(zipWith (+) fib (tail fib ))
fibonacci n = fib !! n

-- zadanie 7
newtype FSet a = FSet ( a -> Bool )
unFSet ( FSet f ) = f

empty :: FSet a
empty = FSet (\_ -> False)

singleton :: Ord a => a -> FSet a
singleton x = FSet(\y -> y == x)

member :: Ord a => a -> FSet a -> Bool
member x (FSet f) = f x

-- member = flip unFSet

fromList :: Ord a => [a] -> FSet a
fromList xs = FSet (\y -> y `elem` xs)

union :: Ord a => FSet a -> FSet a -> FSet a
union ( FSet f ) ( FSet g ) = FSet (\x -> f x || g x)

intersection :: Ord a => FSet a -> FSet a -> FSet a 
intersection ( FSet f ) ( FSet g ) = FSet ( \x -> f x && g x )


-- zadanie 6
integerToString :: Integer -> String
integerToString = reverse . unfoldr f where
	f n = | n < 10 Just ( intToDigit n, Nothing )
		  | otherwise Just ( intToDigit $ fromEnum x `mod` 10, x `div` 10 )