module TimeTracker.API where

import Servant.API

import TimeTracker.Library

type TimeTrackerAPI =
       "start"  :> Post '[JSON] NoContent
  :<|> "stop"   :> Post '[JSON] NoContent
  :<|> "status" :> Get '[JSON] TimeTrackerStatus
