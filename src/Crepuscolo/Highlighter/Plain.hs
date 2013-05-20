module Crepuscolo.Highlighter.Plain
    ( highlighter
    ) where

import Crepuscolo

highlighter :: Highlighted -> Highlighted
highlighter c@(Content _) = Highlight Region "plain" c

highlighter h = h
