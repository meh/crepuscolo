module Crepuscolo.Recognizer.C
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List

recognize :: String -> IO (Maybe String)
recognize path =
    if isSuffixOf ".c" path
       then Just "c"
       else

recognizePath :: String -> Maybe String
recognizePath path =
    if isSuffixOf ".c" path
       then Just "c"
       else Nothing

recognizeContent string =
    undefined
