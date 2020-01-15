{-# LANGUAGE TemplateHaskell #-}

module Kasdown.HTML
    ( html
    ) where

import ClassyPrelude
import CMarkGFM       (commonmarkToHtml)
import Data.FileEmbed (embedFile)

css :: Text
css = "<style>" <> decodeUtf8 $(embedFile "templates/css.css") <> "</style>"

js :: Text
js = "<script>" <> decodeUtf8 $(embedFile "templates/js.js") <> "</script>"

html :: Text -> Text
html content = do
    let converted = commonmarkToHtml [] [] content
    concat ["<html><head>", css, "</head><body>", converted, js, "</body></html>"]
