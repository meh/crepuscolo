module Crepuscolo.Highlighter.C
    ( highlighter
    ) where

import Crepuscolo
import Crepuscolo.DSL

highlighter :: Highlighted -> Highlighted
highlighter = keyword "c:statement" ["goto", "break", "return", "continue", "asm"]
          ||| keyword "c:label" ["case", "default"]
          ||| keyword "c:conditional" ["if", "else", "switch"]
          ||| keyword "c:repeat" ["while", "for", "do"]
