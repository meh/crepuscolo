module Crepuscolo.DSL
    ( keyword
    , match
    , (|||)
    ) where

import Crepuscolo

import Text.Regex.PCRE ((=~), getAllMatches)

(|||) :: Highlighter -> Highlighter -> Highlighter
a ||| b = b . a

region :: String -> String -> String -> Highlighter
region group start end =
    undefined

match :: String -> String -> Highlighter
match group regex =
    undefined

keyword :: String -> [String] -> String -> Highlighter
keyword group names keywordRegex = \h -> make h
  where
    make (Group elements) =
        Group $ map make elements

    make (Content string) = Group $ map keyword pieces
      where
        keyword w = if w `elem` names
           then Highlight Keyword group (Content w)
           else Content w

        pieces = concat $ flip map spaced $ \s ->
            if s =~ "\\s"
               then [s]
               else split s (getAllMatches (s =~ keywordRegex) :: [(Int, Int)])
          where
            split string matches = get 0 string matches
              where get _ "" []                                 = []
                    get _ string []                             = [string]
                    get current string ((0, length) : next) =
                        let (this, tail)  = splitAt length string
                            in this : get length tail next
                    get current string ((start, length) : next) =
                        let (before, tail) = splitAt (start - current) string
                            (this, tail')  = splitAt length tail
                            in before : this : get (start + length) tail' next

            spaced = concat $
                map (filter (not . null) . tail)
                    (string =~ "(\\s+)?([^\\s]+)?(\\s+)?" :: [[String]])

    make x = x
