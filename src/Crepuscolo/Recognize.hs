module Crepuscolo.Recognize
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import System.IO

import qualified Crepuscolo.Recognizer.C as C
import qualified Crepuscolo.Recognizer.Ruby as Ruby

(>>|) :: Maybe a -> Maybe a -> Maybe a
Just s  >>| _ = Just s
Nothing >>| a = a

recognize :: String -> IO (Maybe String)
recognize path =
    C.recognize path >>|
    Ruby.recognize path

recognizePath :: String -> Maybe String
recognizePath path =
    C.recognizePath path >>|
    Ruby.recognizePath path

recognizeContent :: String -> Maybe String
recognizeContent string =
    C.recognizeContent string >>|
    Ruby.recognizeContent string

