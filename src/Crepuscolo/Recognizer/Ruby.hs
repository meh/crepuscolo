module Crepuscolo.Recognizer.Ruby
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List
import Crepuscolo.Recognize.DSL

recognize :: String -> IO (Maybe String)
recognize path =
    return (recognizePath path)

recognizePath path =
    if isSuffixOf ".rb" path
       then Just "ruby"
       else Nothing

recognizeContent string =
    undefined
