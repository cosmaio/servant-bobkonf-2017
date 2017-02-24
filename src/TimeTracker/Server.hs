module TimeTracker.Server where

import Control.Concurrent.STM
import Control.Monad.IO.Class
import Data.Time
import Data.Proxy
import Network.Wai.Handler.Warp

import Servant.API
import Servant.Server

import TimeTracker.API
import TimeTracker.Library

handleStart :: TVar TimeTrackerStatus -> Handler NoContent
handleStart statusVar = liftIO $ do
  now <- getCurrentTime
  atomically $ modifyTVar statusVar (startTracking now)
  return NoContent

handleStop :: TVar TimeTrackerStatus -> Handler NoContent
handleStop statusVar = liftIO $ do
  now <- getCurrentTime
  atomically $ modifyTVar statusVar (stopTracking now)
  return NoContent

handleStatus :: TVar TimeTrackerStatus -> Handler TimeTrackerStatus
handleStatus statusVar = liftIO (readTVarIO statusVar)

handleSet :: TVar TimeTrackerStatus -> NominalDiffTime -> Handler NoContent
handleSet _ _ = return NoContent

timeTrackerServer :: TVar TimeTrackerStatus -> Server TimeTrackerAPI
timeTrackerServer statusVar = startStopServer statusVar :<|> statusSetServer statusVar

startStopServer statusVar =
       handleStart  statusVar
  :<|> handleStop   statusVar

statusSetServer statusVar =
       handleStatus statusVar
  :<|> handleSet    statusVar

serverMain :: IO ()
serverMain = do
  statusVar <- newTVarIO initialTimeTrackerStatus
  run 8083
    (serve
      (Proxy :: Proxy TimeTrackerAPI)
      (timeTrackerServer statusVar)
    )
