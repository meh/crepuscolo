module Crepuscolo.Highlight.DSL
    ( (|||)
    , inside
    , region
    , match
    , keyword
    ) where

import Crepuscolo.Highlight
import Text.Regex.PCRE ((=~), getAllMatches)

(|||) :: Highlighter -> Highlighter -> Highlighter
a ||| b = a . b

inside :: String -> Highlighter -> Highlighter
inside group highlighter =
    undefined

region :: String -> String -> String -> Highlighter
region group start end =
    undefined

match :: String -> String -> Highlighter
match group regex = make
  where
    make (Group elements) =
        Group $ map make elements

    make (Content string) = Group $ map match matches
      where
        match (True, piece)  = Highlight Match group (Content piece)
        match (False, piece) = Content piece

        matches = split string (getAllMatches (string =~ regex) :: [(Int, Int)])

    make x = x

keyword :: String -> [String] -> String -> Highlighter
keyword group names keywordRegex = make
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
               else map snd $ split s (getAllMatches (s =~ keywordRegex) :: [(Int, Int)])
          where
            spaced = concat $
                map (filter (not . null) . tail)
                    (string =~ "(\\s+)?([^\\s]+)?(\\s+)?" :: [[String]])

    make x = x

-- This function splits a string based on a getAllMatches result with start and
-- offset, the result is a list of tuples where the Bool indicates if the
-- String was a match or not.
split :: String -> [(Int, Int)] -> [(Bool, String)]
split string matches = get 0 string matches
  where get _ "" []                                 = []
        get _ string []                             = [(False, string)]
        get current string ((0, length) : next)     =
            let (this, tail)  = splitAt length string
                in (True, this) : get length tail next
        get current string ((start, length) : next) =
            let (before, tail) = splitAt (start - current) string
                (this, tail')  = splitAt length tail
                in (False, before) : (True, this) : get (start + length) tail' next

