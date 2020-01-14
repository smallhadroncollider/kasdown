module Kasdown
    ( start
    ) where

import ClassyPrelude

import Kasdown.Output (outputInvalid, outputServe, outputStr)

parseArgs :: [Text] -> IO ()
parseArgs [path]             = outputStr path
parseArgs ["-s", path]       = outputServe "8000" path
parseArgs ["-p", port, path] = outputServe port path
parseArgs _                  = outputInvalid

start :: IO ()
start = parseArgs =<< getArgs
