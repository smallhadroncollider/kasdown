module Kasdown.Serve
    ( serve
    ) where

import ClassyPrelude

import Network.HTTP.Types       (status200)
import Network.Info             (getNetworkInterfaces, ipv4)
import Network.Wai              (Application, responseLBS)
import Network.Wai.Handler.Warp (run)

import Kasdown.CLI (message)

getIP :: IO [Text]
getIP = do
    interfaces <- getNetworkInterfaces
    pure . filter (/= "0.0.0.0") $ tshow . ipv4 <$> interfaces

serve :: Int -> Text -> IO ()
serve port content = do
    ips <- getIP
    let items = unlines $ ("    - http://" <>) . (<> ":" <> tshow port) <$> ips
    message $ "Available on:\n" <> items
    run port (app content)

app :: Text -> Application
app content _ respond = respond (responseLBS status200 headers bs)
  where
    headers = [("Content-Type", "text/html")]
    bs = fromStrict (encodeUtf8 content)
