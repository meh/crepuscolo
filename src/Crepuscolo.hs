module Crepuscolo
    ( Context(..)
    , Highlighted(..)
    , Highlighter
    , highlight
    , extend
    , dehighlight
    ) where

data Context = Keyword | Match | Region | Cluster deriving (Show)

data Highlighted = Content String
                 | Group [Highlighted]
                 | Highlight { context :: Context
                             , name    :: String
                             , content :: Highlighted
                             }
                 deriving (Show)

type Highlighter = Highlighted -> Highlighted

highlight :: Highlighter -> String -> Highlighted
highlight h s =
    flatten $ h $ Content s

extend h s =
    h s

dehighlight :: Highlighted -> String
dehighlight (Content s) = s
dehighlight (Highlight { content = c }) = dehighlight c
dehighlight (Group c) = concat $ map dehighlight c

flatten :: Highlighted -> Highlighted
flatten (Content s) = Content s
flatten h@(Highlight { content = c }) = h { content = flatten c }
flatten (Group c) = case map flatten c of
    (x:[])  -> x
    c@(_:_) -> Group c
