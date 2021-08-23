module Main where

import           Cloudflare
import           HelloCloudflare.API

-- | This is not needed and could be `undefined` as well.
main :: IO ()
main = putStrLn "Hello Cloudlfare worker"

handleReq :: JSRequest -> IO JSResponse
handleReq = fromWaiApplication helloCloudflareApp

foreign export javascript "handleReq" handleReq :: JSRequest -> IO JSResponse
