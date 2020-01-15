module Kasdown.File
    ( get
    ) where

import ClassyPrelude
import System.Directory (doesFileExist)

import Kasdown.HTML (html)

read :: FilePath -> IO Text
read path = html . decodeUtf8 <$> readFile path

get :: Text -> IO (Either Text Text)
get path = bool err suc =<< doesFileExist path'
  where
    path' = unpack path
    err = pure $ Left "File does not exist"
    suc = Right <$> read path'
