module TimeTracker.Server where

import Data.Proxy
import Network.Wai.Handler.Warp

import Servant.API
import Servant.Server

import TimeTracker.API
import TimeTracker.Library

handleStart :: Handler NoContent
handleStart = return NoContent

handleStop :: Handler NoContent
handleStop = return NoContent

handleStatus :: Handler TimeTrackerStatus
handleStatus = return initialTimeTrackerStatus

timeTrackerServer :: Server TimeTrackerAPI
timeTrackerServer =
  handleStart :<|> handleStop :<|> handleStatus

serverMain :: IO ()
serverMain =
  run 8083 (serve (Proxy :: Proxy TimeTrackerAPI) timeTrackerServer)
