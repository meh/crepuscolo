module Crepuscolo.Recognizer.C
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List
import System.FilePath
import Crepuscolo.Recognize.DSL

recognize :: String -> IO (Maybe String)
recognize path =
    case takeExtension path of
         ".c" -> return (Just "c")
         ".h" -> readFile path >>= return . recognizeContent
         _    -> return Nothing

recognizePath :: String -> Maybe String
recognizePath path =
    case takeExtension path of
         ".c" -> Just "c"
         ".h" -> Just "c"
         _    -> Nothing

recognizeContent string =
    undefined
