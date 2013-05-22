module Crepuscolo.Recognizer.Ruby
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List

recognize path =
    recognizePath path

recognizePath path =
    if isSuffixOf ".rb" path
       then Just "ruby"
       else Nothing

recognizeContent string =
    undefined
