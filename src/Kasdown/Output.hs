module Kasdown.Output
    ( outputStr
    , outputServe
    , outputInvalid
    ) where

import ClassyPrelude

import System.Exit (exitFailure, exitSuccess)

import Kasdown.CLI   (errorMessage)
import Kasdown.File  (get)
import Kasdown.Serve (serve)

outputStr :: Text -> IO ()
outputStr path = do
    response <- get path
    case response of
        Right res -> putStr res >> void exitSuccess
        Left err  -> errorMessage err >> void exitFailure

outputServe :: Text -> Text -> IO ()
outputServe port path = do
    response <- get path
    case response of
        Right res -> serve (fromMaybe 8000 $ readMay port) res >> void exitSuccess
        Left err  -> errorMessage err >> void exitFailure

outputInvalid :: IO ()
outputInvalid = errorMessage "Invalid arguments" >> void exitFailure
