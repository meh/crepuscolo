module Crepuscolo.DSL
    ( keyword
    , match
    , (|||)
    ) where

import Crepuscolo

(|||) :: Highlighter -> Highlighter -> Highlighter
a ||| b = b . a

region :: String -> String -> String
region group start end =
    undefined

match :: String -> String -> Highlighter
match group regex =
    undefined

keyword :: String -> [String] -> (String -> Bool) -> Highlighter
keyword group names isKeyword = \h -> make h
  where
    make (Group elements) =
        Group $ map make elements

    make (Content string) = Group $ map (\w ->
        if isKeyword w && w `elem` names
           then Highlight Keyword group (Content w)
           else Content w) (words string)

    make x = x
