module Main where

import System.Environment(getArgs)
import Slownie(slownie)
import Waluty(Waluta(..), parseCurrency)

main :: IO ()
main = do
    args <- getArgs
    if length args < 2 then
        putStrLn "wrong input data"
    else
        case (parseCurrency $ args !! 1) of
            Just currency -> putStrLn $ slownie currency ( read $ head args )
            Nothing       -> putStrLn "unknown value"
    return ()