module Crepuscolo.Highlighter.C
    ( highlighter
    ) where

import Crepuscolo
import Crepuscolo.DSL hiding (keyword)
import qualified Crepuscolo.DSL as DSL (keyword)

import Text.Regex.PCRE

highlighter :: Highlighted -> Highlighted
highlighter = keyword "c:statement" ["goto", "break", "return", "continue", "asm"]
          ||| keyword "c:label" ["case", "default"]
          ||| keyword "c:conditional" ["if", "else", "switch"]
          ||| keyword "c:repeat" ["while", "for", "do"]

keyword group names =
    DSL.keyword group names "[A-Za-z_$][A-Za-z0-9_$]+"
