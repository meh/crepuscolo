module Crepuscolo.Recognize.DSL
    ( (>|)
    , (>>|)
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
