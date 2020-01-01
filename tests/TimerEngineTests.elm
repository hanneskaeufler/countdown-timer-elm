module TimerEngineTests exposing (allTests)

import Expect
import Fuzz exposing (intRange)
import Test exposing (Test, describe, fuzz, test)
import Timer exposing (Timer, expiredTimer, tick, timeRemainingInSeconds)
import TypedTime


newActiveTimerSetInSecondsAsInt : Int -> Timer
newActiveTimerSetInSecondsAsInt =
    toFloat >> TypedTime.seconds >> Timer.ActiveTimer


allTests : Test
allTests =
    describe "When running the timer"
        [ describe "tick causes the timer to tick down one second"
            [ fuzz (intRange 1 10000) "boring happy path" <|
                \startTimeInSecondsAsInt ->
                    newActiveTimerSetInSecondsAsInt startTimeInSecondsAsInt
                        |> tick
                        |> timeRemainingInSeconds
                        |> Expect.equal (startTimeInSecondsAsInt - 1)
            , test "expired timer doesn't tick" <|
                \() ->
                    expiredTimer
                        |> tick
                        |> timeRemainingInSeconds
                        |> Expect.equal 0
            ]
        ]
