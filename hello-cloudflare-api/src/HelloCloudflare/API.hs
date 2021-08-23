{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications  #-}
{-# LANGUAGE TypeOperators     #-}
module HelloCloudflare.API
  ( helloCloudflareApp
  ) where

import           Data.Proxy (Proxy (..))
import           Data.Text  (Text)
import           Servant    (Application, Get, Header, JSON, Server, serve,
                             (:<|>) (..), (:>))

type HelloCloudflare =
  "ip" :> Header "cf-connecting-ip" Text :> Get '[JSON] Text
    :<|> "country" :> Header "cf-ipcountry" Text :> Get '[JSON] Text
    :<|> "user-agent" :> Header "user-agent" Text :> Get '[JSON] Text

helloCloudflareServer :: Server HelloCloudflare
helloCloudflareServer = f :<|> f :<|> f
  where
    f (Just s) = pure s
    f _        = pure "Header not found."

helloCloudflareApp :: Application
helloCloudflareApp = serve (Proxy @HelloCloudflare) helloCloudflareServer
