{-# LANGUAGE TemplateHaskell #-}

module Kasdown.HTML
    ( html
    ) where

import ClassyPrelude

import CMarkGFM       (commonmarkToHtml)
import Data.FileEmbed (embedFile)
import Data.Text      (replace)

css :: Text
css = decodeUtf8 $(embedFile "templates/css.css")

js :: Text
js = decodeUtf8 $(embedFile "templates/js.js")

template :: Text
template = decodeUtf8 $(embedFile "templates/template.html")

html :: Text -> Text
html md = do
    let content = commonmarkToHtml [] [] md
    replace "@content" content (replace "@js" js (replace "@css" css template))
