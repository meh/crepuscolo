module Crepuscolo.Recognizer.C
    ( recognizer
    ) where

import System.FilePath (takeExtension)
import Text.Regex.PCRE ((=~))
import qualified Crepuscolo.Recognize.DSL as DSL

data Recognizer = C deriving (Show)

instance DSL.Recognizer Recognizer where
    recognize C path =
        case takeExtension path of
             ".c" -> return (Just "c")
             ".h" -> do
                 content <- readFile path
                 return $ if notCXX content
                    then Just "c"
                    else Nothing

             _ -> return Nothing
      where
        notCXX string = not (string =~ "\\bclass\\b") && not (string =~ "::")

    recognizePath C path =
        case takeExtension path of
             ".c" -> Just "c"
             ".h" -> Just "c"
             _    -> Nothing

    recognizeContent C string =
        if string =~ "^\\s*#include" && not (string =~ "\\bclass\\b") && not (string =~ "::")
           then Just "c"
           else Nothing

recognizer :: DSL.Recognizable
recognizer = DSL.recognizable C
