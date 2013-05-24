module Crepuscolo.Recognizer.CXX
    ( recognizer
    ) where

import System.FilePath (takeExtension)
import Text.Regex.PCRE ((=~))
import qualified Crepuscolo.Recognize.DSL as DSL

data Recognizer = CXX deriving (Show)

instance DSL.Recognizer Recognizer where
    recognize CXX path =
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
      where
        notC string = string =~ "\\bclass\\b" || string =~ "::"

    recognizePath CXX path =
        case takeExtension path of
             ".cpp" -> Just "c++"
             ".hpp" -> Just "c++"
             ".tpp" -> Just "c++"
             _      -> Nothing

    recognizeContent CXX string =
        if string =~ "^\\s*#include" || string =~ "\\bclass\\b" || string =~ "::"
           then Just "c++"
           else Nothing

recognizer :: DSL.Recognizable
recognizer = DSL.recognizable CXX
