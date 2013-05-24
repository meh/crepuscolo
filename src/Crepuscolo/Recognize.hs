module Crepuscolo.Recognize
    ( recognize
    , recognizePath
    , recognizeContent
    ) where

import Data.List (find)
import qualified Crepuscolo.Recognize.DSL as DSL

import qualified Crepuscolo.Recognizer.C as C
import qualified Crepuscolo.Recognizer.CXX as CXX
import qualified Crepuscolo.Recognizer.Ruby as Ruby

recognizers :: [DSL.Recognizable]
recognizers = [C.recognizer, CXX.recognizer, Ruby.recognizer]

recognize :: String -> IO (Maybe String)
recognize path =
    first $ map (flip DSL.recognize path) recognizers
  where
    first :: [IO (Maybe String)] -> IO (Maybe String)
    first []       = return Nothing
    first (x : xs) = do
        c <- x
        case c of
             Nothing -> first xs
             v       -> return v

recognizePath :: String -> Maybe String
recognizePath path =
    first $ map (flip DSL.recognizePath path) recognizers

recognizeContent :: String -> Maybe String
recognizeContent string =
    first $ map (flip DSL.recognizeContent string) recognizers

first :: [Maybe String] -> Maybe String
first []             = Nothing
first (Nothing : xs) = first xs
first (x : _)        = x


