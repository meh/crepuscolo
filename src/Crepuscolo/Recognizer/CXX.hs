module Crepuscolo.Recognizer.CXX
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
         ".cpp" -> return (Just "c++")
         ".hpp" -> return (Just "c++")
         ".tpp" -> return (Just "c++")
         ".h"   -> do
             content <- readFile path
             return $ if notC content
                then Just "c++"
                else Nothing

         _ -> return Nothing

recognizePath :: String -> Maybe String
recognizePath path =
    case takeExtension path of
         ".cpp" -> Just "c++"
         ".hpp" -> Just "c++"
         ".tpp" -> Just "c++"
         _      -> Nothing

recognizeContent :: String -> Maybe String
recognizeContent string =
    if string =~ "^\\s*#include" || string =~ "\\bclass\\b" || string =~ "::"
       then Just "c++"
       else Nothing

notC string = string =~ "\\bclass\\b" || string =~ "::"
