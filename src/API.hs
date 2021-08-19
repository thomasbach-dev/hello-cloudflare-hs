{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}
{-# LANGUAGE TypeOperators     #-}
module API
  ( handleReq
  ) where

import           Cloudflare
import           Data.Text  (Text)
import           Servant

type HttpBin =
  "ip" :> Header "cf-connecting-ip" Text :> Get '[JSON] Text
    :<|> "country" :> Header "cf-ipcountry" Text :> Get '[JSON] Text
    :<|> "user-agent" :> Header "user-agent" Text :> Get '[JSON] Text

httpBinServer :: Server HttpBin
httpBinServer = f :<|> f :<|> f
  where
    f (Just s) = pure s
    f _        = pure "Header not found."

httpBinApp :: Application
httpBinApp = serve (Proxy @HttpBin) httpBinServer

handleReq :: JSRequest -> IO JSResponse
handleReq = fromWaiApplication httpBinApp

foreign export javascript "handleReq" handleReq :: JSRequest -> IO JSResponse
