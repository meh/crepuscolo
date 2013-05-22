import Crepuscolo.Recognize
import Control.Monad

import System.Environment
import System.Exit

main = do
    [path] <- getArgs
    result <- recognize path

    case result of
         Just t  -> putStrLn t
         Nothing -> exitFailure
