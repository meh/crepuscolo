module Crepuscolo.Recognizer.C
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List
import System.FilePath
import Text.Regex.PCRE
import Crepuscolo.Recognize.DSL

recognize :: String -> IO (Maybe String)
recognize path =
    case takeExtension path of
         ".c" -> return (Just "c")
         ".h" -> do
             content <- readFile path
             return $ if notCXX content
                then Just "c"
                else Nothing

         _ -> return Nothing

recognizePath :: String -> Maybe String
recognizePath path =
    case takeExtension path of
         ".c" -> Just "c"
         ".h" -> Just "c"
         _    -> Nothing

recognizeContent :: String -> Maybe String
recognizeContent string =
    if string =~ "^\\s*#include" && not (string =~ "\\bclass\\b") && not (string =~ "::")
       then Just "c"
       else Nothing

notCXX string = not (string =~ "\\bclass\\b") && not (string =~ "::")
