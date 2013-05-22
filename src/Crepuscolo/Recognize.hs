module Crepuscolo.Recognize
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Crepuscolo.Recognize.DSL
import qualified Crepuscolo.Recognizer.C as C
import qualified Crepuscolo.Recognizer.CXX as CXX
import qualified Crepuscolo.Recognizer.Ruby as Ruby

recognize :: String -> IO (Maybe String)
recognize path =
    C.recognize path >>|
    CXX.recognize path >>|
    Ruby.recognize path

recognizePath :: String -> Maybe String
recognizePath path =
    C.recognizePath path >|
    CXX.recognizePath path >|
    Ruby.recognizePath path

recognizeContent :: String -> Maybe String
recognizeContent string =
    C.recognizeContent string >|
    CXX.recognizeContent string >|
    Ruby.recognizeContent string

