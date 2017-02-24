module TimeTracker.API where

import Servant.API

import TimeTracker.Library

type TimeTrackerAPI =
       "start"  :> PostNoContent '[JSON] NoContent
  :<|> "stop"   :> PostNoContent '[JSON] NoContent
  :<|> "status" :> Get '[JSON] TimeTrackerStatus
