module Crepuscolo.Highlighter.C
    ( highlighter
    ) where

import Crepuscolo
import qualified Crepuscolo.DSL as DSL
import Crepuscolo.DSL ((|||))

import Text.Regex.Posix

highlighter :: Highlighted -> Highlighted
highlighter = keyword "c:statement" ["goto", "break", "return", "continue", "asm"]
          ||| keyword "c:label" ["case", "default"]
          ||| keyword "c:conditional" ["if", "else", "switch"]
          ||| keyword "c:repeat" ["while", "for", "do"]

keyword group names =
    DSL.keyword group names (=~ "^[A-Za-z_$][A-Za-z0-9_$]+$")
