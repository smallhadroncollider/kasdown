{-# LANGUAGE TemplateHaskell #-}

module Kasdown.App
  ( go
  ) where

import           ClassyPrelude
import           CMarkGFM         (commonmarkToHtml)
import           Data.FileEmbed   (embedFile)
import           System.Directory (doesFileExist)

css :: Text
css = "<style>" <> decodeUtf8 $(embedFile "templates/css.css") <> "</style>"

js :: Text
js = "<script>" <> decodeUtf8 $(embedFile "templates/js.js") <> "</script>"

read :: FilePath -> IO Text
read path = do
  content <- decodeUtf8 <$> readFile path
  let html = commonmarkToHtml [] [] content
  pure $
    concat ["<html><head>", css, "</head><body>", html, js, "</body></html>"]

get :: FilePath -> IO (Either Text Text)
get path = bool err suc =<< doesFileExist path
  where
    err = pure $ Left "File does not exist"
    suc = Right <$> read path

parseArgs :: [Text] -> IO (Either Text Text)
parseArgs [path] = get (unpack path)
parseArgs _      = pure $ Left "Invalid arguments"

go :: IO ()
go = do
  result <- parseArgs =<< getArgs
  case result of
    Left err     -> putStr err
    Right output -> putStr output
