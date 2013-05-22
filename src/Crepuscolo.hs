module Crepuscolo
    ( Context(..)
    , Highlighted(..)
    , Highlighter
    , highlight
    , extend
    , dehighlight
    ) where

import Data.List (groupBy)

data Context = Keyword | Match | Region | Cluster | Custom deriving (Show, Eq)

data Highlighted = Content String
                 | Group [Highlighted]
                 | Highlight { context :: Context
                             , name    :: String
                             , content :: Highlighted
                             }
                 deriving (Show, Eq)

type Highlighter = Highlighted -> Highlighted

highlight :: Highlighter -> String -> Highlighted
highlight h s =
    flatten $ h $ Content s
  where
    flatten (Content s) = Content s
    flatten h@(Highlight { content = c }) = h { content = flatten c }
    flatten (Group c) = case map flatten c of
        (x:[])  -> x
        c'@(_:_) -> Group $ merge $ contents c'
      where 
        isContent (Content _) = True
        isContent _           = False

        contents = groupBy $ \a b ->
            isContent a && isContent b

        merge cs = concat $ flip map cs $ \xs@(x:_) -> case x of
            Content _ -> [Content $ concat $ map (\(Content s) -> s) xs]
            _         -> xs

extend h s =
    h s

dehighlight :: Highlighted -> String
dehighlight (Content s) = s
dehighlight (Highlight { content = c }) = dehighlight c
dehighlight (Group c) = concat $ map dehighlight c
