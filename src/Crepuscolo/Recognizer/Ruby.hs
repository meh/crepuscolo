module Crepuscolo.Recognizer.Ruby
    ( recognizer
    ) where

import System.FilePath (takeExtension)
import qualified Crepuscolo.Recognize.DSL as DSL

data Recognizer = Ruby deriving (Show)

instance DSL.Recognizer Recognizer where
    recognize Ruby path =
        return (DSL.recognizePath Ruby path)

    recognizePath Ruby path =
        case takeExtension path of
             ".rb" -> Just "ruby"
             _     -> Nothing

    recognizeContent Ruby string =
        undefined

recognizer :: DSL.Recognizable
recognizer = DSL.recognizable Ruby
