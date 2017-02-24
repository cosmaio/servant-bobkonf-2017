module TimeTracker.API where

import Data.Time
import Servant.API

import TimeTracker.Library

type TimeTrackerAPI =
  StartStop :<|> StatusSet

type StartStop =
       "start"  :> PostNoContent '[JSON] NoContent
  :<|> "stop"   :> PostNoContent '[JSON] NoContent

type StatusSet =
       "status" :> Get '[JSON] TimeTrackerStatus
  :<|> "set"    :> ReqBody '[JSON] NominalDiffTime :> PostNoContent '[JSON] NoContent
