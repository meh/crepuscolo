module Crepuscolo.DSL
    ( keyword
    , match
    , (|||)
    ) where

import Crepuscolo

import Text.Regex.PCRE ((=~))

(|||) :: Highlighter -> Highlighter -> Highlighter
a ||| b = b . a

region :: String -> String -> String -> Highlighter
region group start end =
    undefined

match :: String -> String -> Highlighter
match group regex =
    undefined

keyword :: String -> [String] -> Highlighter
keyword group names = \h -> make h
  where
    make (Group elements) =
        Group $ map make elements

    make (Content string) = Group $ map keyword keywords
      where
        keyword w = if w `elem` names
           then Highlight Keyword group (Content w)
           else Content w

        keywords = concat $ map (filter (not . null) . tail)
                                (string =~ "(\\s+)?([^\\s]+)?(\\s+)?" :: [[String]])

    make x = x
