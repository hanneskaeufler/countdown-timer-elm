module Timer exposing
    ( Timer(..)
    , tick
    , timeRemainingInSeconds
    )

import TypedTime exposing (TypedTime, seconds)


type Timer
    = ActiveTimer Bool TypedTime
    | ExpiredTimer


tickTimer : Bool -> TypedTime -> Timer
tickTimer paused timeRemaining =
    let
        newTimeRemaining =
            TypedTime.sub timeRemaining (seconds 1)
    in
    if TypedTime.gt newTimeRemaining (seconds 0) then
        ActiveTimer paused newTimeRemaining

    else
        ExpiredTimer


tick : Timer -> Timer
tick timer =
    case timer of
        ExpiredTimer ->
            timer

        ActiveTimer paused timeRemaining ->
            tickTimer paused timeRemaining


timeRemainingInSeconds : Timer -> Int
timeRemainingInSeconds timer =
    case timer of
        ActiveTimer _ timeRemaining ->
            TypedTime.toSeconds timeRemaining |> floor

        _ ->
            0
