{- |
Module                  : Lecture1
Copyright               : (c) 2021-2022 Haskell Beginners 2022 Course
SPDX-License-Identifier : MPL-2.0
Maintainer              : Haskell Beginners 2022 Course <haskell.beginners2022@gmail.com>
Stability               : Stable
Portability             : Portable

Exercises for the Lecture 1 of the Haskell Beginners course.

To complete exercises, you need to complete implementation and add
missing top-level type signatures. You can implement any additional
helper functions. But you can't change the names of the given
functions.

Comments before each function contain explanations and example of
arguments and expected returned values.

It's absolutely okay if you feel that your implementations are not
perfect. You can return to these exercises after future lectures and
improve your solutions if you see any possible improvements.
-}

module Lecture1
    ( makeSnippet
    , sumOfSquares
    , lastDigit
    , minmax
    , subString
    , strSum
    , lowerAndGreater
    ) where

-- VVV If you need to import libraries, do it after this line ... VVV
import Debug.Trace
-- ^^^ and before this line. Otherwise the test suite might fail  ^^^

{- | Specify the type signature of the following function. Think about
its behaviour, possible types for the function arguments and write the
type signature explicitly.
-}
makeSnippet :: Int -> String -> String
makeSnippet limit text = take limit ("Description: " ++ text) ++ "..."

{- | Implement a function that takes two numbers and finds sum of
their squares.

>>> sumOfSquares 3 4
25

>>> sumOfSquares (-2) 7
53

Explanation: @sumOfSquares 3 4@ should be equal to @9 + 16@ and this
is 25.
-}
-- DON'T FORGET TO SPECIFY THE TYPE IN HERE
sumOfSquares :: (Num a) => a -> a -> a
sumOfSquares x y = (x * x) + (y * y)

{- | Implement a function that returns the last digit of a given number.

>>> lastDigit 42
2
>>> lastDigit (-17)
7

🕯 HINT: use the @mod@ function

-}
-- DON'T FORGET TO SPECIFY THE TYPE IN HERE
lastDigit :: Int -> Int
lastDigit n = (mod (abs(n)) 10)

{- | Write a function that takes three numbers and returns the
difference between the biggest number and the smallest one.

>>> minmax 7 1 4
6

Explanation: @minmax 7 1 4@ returns 6 because 7 is the biggest number
and 1 is the smallest, and 7 - 1 = 6.

Try to use local variables (either let-in or where) to implement this
function.
-}
minmax :: (Integral a) => a -> a -> a -> a
minmax x y z =
    let mx = max (max x y) z
        mi = min (min x y) z
    in  abs(mx - mi)

{- | Implement a function that takes a string, start and end positions
and returns a substring of a given string from the start position to
the end (including).

>>> subString 3 7 "Hello, world!"
"lo, w"

>>> subString 10 5 "Some very long String"
""

This function can accept negative start and end position. Negative
start position can be considered as zero (e.g. substring from the
first character) and negative end position should result in an empty
string.
-}
subString :: Int -> Int -> String -> String
subString start end str = [str!!x | x <- [0..(length str -1)], start<=x && x<= end]

{- | Write a function that takes a String — space separated numbers,
and finds a sum of the numbers inside this string.

>>> strSum "100    -42  15"
73

The string contains only spaces and/or numbers.
-}

merge :: [String] -> String -> [String]
merge res word
    | word=="" = res
    | otherwise = res ++ [word]

splitImpl :: String -> [String] -> String -> [String]
splitImpl input res word
    | input==""  = merge res word
    | c==' '     = splitImpl other (merge res word) ""
    | otherwise  = splitImpl other res (word++[c])
    where c:other = input

charToInt :: Char -> Int
charToInt c = (fst . head) (filter (\x -> snd x == c) (zip [-1..9] ('-':['0'..'9'])))

stringToInt :: String -> Int
stringToInt str
    | c=='-' = -1 * f other
    | otherwise = f str
    where f s = foldl (\x c -> x*10 + (charToInt c)) 0 s
          c:other = str

strSum :: String -> Int
strSum str =
    sum(map stringToInt (split str))
    where split s = splitImpl s [] ""
{- | Write a function that takes a number and a list of numbers and
returns a string, saying how many elements of the list are strictly
greater than the given number and strictly lower.

>>> lowerAndGreater 3 [1 .. 9]
"3 is greater than 2 elements and lower than 6 elements"

Explanation: the list [1 .. 9] contains 9 elements: [1, 2, 3, 4, 5, 6, 7, 8, 9]
The given number 3 is greater than 2 elements (1 and 2)
and lower than 6 elements (4, 5, 6, 7, 8 and 9).

🕯 HINT: Use recursion to implement this function.
-}

intToString :: Int -> String
intToString x
    | x < 10 = [c]
    | otherwise = (intToString other) ++ [c]
    where other = div x 10
          c     = ['0'..'9'] !! (mod x 10)

lowerAndGreater :: Int -> [Int] -> String
lowerAndGreater n list =
    intToString(n) ++
    " is greater than " ++
    (intToString . length) (filter (<n) list) ++
    " elements and lower than " ++
    intToString(length(filter (>n) list)) ++
    " elements"
