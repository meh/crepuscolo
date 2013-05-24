{-# LANGUAGE ExistentialQuantification #-}

module Crepuscolo.Recognize.DSL
    ( (>|)
    , (>>|)
    , Recognizer
    , recognize
    , recognizePath
    , recognizeContent
    , Recognizable
    , recognizable
    ) where

(>|) :: Maybe a -> Maybe a -> Maybe a
Just s  >| _ = Just s
Nothing >| a = a

(>>|) :: IO (Maybe a) -> IO (Maybe a) -> IO (Maybe a)
a >>| b = do
    a' <- a

    case a' of
         (Just t)  -> return (Just t)
         (Nothing) -> do
             b' <- b

             case b' of
                  (Just t)  -> return (Just t)
                  (Nothing) -> return Nothing

class Recognizer a where
    recognize        :: a -> String -> IO (Maybe String)
    recognizePath    :: a -> String -> Maybe String
    recognizeContent :: a -> String -> Maybe String

data Recognizable = forall a . Recognizer a => Recognizable a

instance Recognizer Recognizable where
    recognize (Recognizable a) path          = recognize a path
    recognizePath (Recognizable a) path      = recognizePath a path
    recognizeContent (Recognizable a) string = recognizeContent a string

recognizable :: Recognizer a => a -> Recognizable
recognizable = Recognizable
