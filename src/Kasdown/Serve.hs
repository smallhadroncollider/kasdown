module Kasdown.Serve
    ( serve
    ) where

import ClassyPrelude

import Network.HTTP.Types       (status200)
import Network.Wai              (Application, responseLBS)
import Network.Wai.Handler.Warp (run)

import Kasdown.CLI (message)

serve :: Int -> Text -> IO ()
serve port content = do
    message $ "Listening on port " <> tshow port <> "..."
    run port (app content)

app :: Text -> Application
app content _ respond = respond (responseLBS status200 headers bs)
  where
    headers = [("Content-Type", "text/html")]
    bs = fromStrict (encodeUtf8 content)
