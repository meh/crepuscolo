module Crepuscolo.Highlighter.Plain
    ( highlighter
    ) where

import Crepuscolo.Highlight

highlighter :: Highlighted -> Highlighted
highlighter c@(Content _) = Highlight Region "plain" c

highlighter h = h
