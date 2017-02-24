{-# LANGUAGE DeriveAnyClass #-}
module TimeTracker.Library where

-- import Data.Aeson
-- import Data.Swagger
import Data.Time
-- import GHC.Generics

data TimeTrackerStatus =
  TimeTrackerStatus
    { ttsTimeTracked :: NominalDiffTime
    , ttsMode        :: TimeTrackerMode
    }
  deriving (Show)
  -- deriving (Show, Generic, ToJSON, FromJSON, ToSchema)

data TimeTrackerMode =
    Off
  | On { ttmSince :: UTCTime }
  deriving (Show)
  -- deriving (Show, Generic, ToJSON, FromJSON, ToSchema)

initialTimeTrackerStatus :: TimeTrackerStatus
initialTimeTrackerStatus =
  TimeTrackerStatus 0 Off

startTracking :: UTCTime -> TimeTrackerStatus -> TimeTrackerStatus
startTracking now (status@(TimeTrackerStatus _ mode)) =
  case mode of
    On _ -> status
    Off  -> status { ttsMode = On now }

stopTracking :: UTCTime -> TimeTrackerStatus -> TimeTrackerStatus
stopTracking now (status@(TimeTrackerStatus total mode)) =
  case mode of
    Off      -> status
    On since ->
      let
        newTotal = total + diffUTCTime now since
      in
        TimeTrackerStatus newTotal Off

prettyStatus :: UTCTime -> TimeTrackerStatus -> String
prettyStatus now (TimeTrackerStatus total mode) =
  case mode of
    Off -> "off, current total " ++ show total
    On since ->
      let
        combinedTotal = total + diffUTCTime now since
      in
        "on since " ++ show since ++ ", current total " ++ show combinedTotal

