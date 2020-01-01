module Timer exposing
    ( Timer(..)
    , expiredTimer
    , stoppedTimerSetTo
    , tick
    , timeRemainingInSeconds
    )

import TypedTime exposing (TypedTime, seconds)


type Timer
    = ActiveTimer TypedTime
    | StoppedTimer TypedTime
    | ExpiredTimer


stoppedTimerSetTo : TypedTime -> Timer
stoppedTimerSetTo timeRemaining =
    StoppedTimer timeRemaining


expiredTimer : Timer
expiredTimer =
    ExpiredTimer


tick : Timer -> Timer
tick timer =
    case timer of
        StoppedTimer _ ->
            timer

        ActiveTimer timeRemaining ->
            let
                newTimeRemaining =
                    TypedTime.sub timeRemaining (seconds 1)
            in
            if TypedTime.gt newTimeRemaining (seconds 0) then
                ActiveTimer newTimeRemaining

            else
                ExpiredTimer

        ExpiredTimer ->
            timer


timeRemainingInSeconds : Timer -> Int
timeRemainingInSeconds timer =
    case timer of
        StoppedTimer timeRemaining ->
            TypedTime.toSeconds timeRemaining |> floor

        ActiveTimer timeRemaining ->
            TypedTime.toSeconds timeRemaining |> floor

        ExpiredTimer ->
            0
