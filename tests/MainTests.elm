module MainTests exposing (allTests)

import Main
import ProgramTest exposing (clickButton, expectViewHas, fillIn)
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (all, tag, text)


start =
    ProgramTest.createElement
        { init = Main.init
        , update = Main.update
        , view = Main.view
        }
        |> ProgramTest.start ()


allTests : Test
allTests =
    describe "the countdown timer"
        [ test "it starts with a default timer" <|
            \_ ->
                start
                    |> expectViewHas [ text "00:10:00" ]
        , test "it parses the entered time on the fly" <|
            \_ ->
                start
                    |> fillIn "" "Time to count down" "4"
                    |> expectViewHas [ all [ tag "label", text "00:00:04" ] ]
        , test "it sets the time when clicking the 'set' button" <|
            \_ ->
                start
                    |> fillIn "" "Time to count down" "4"
                    |> clickButton "set"
                    |> expectViewHas [ all [ tag "div", text "00:00:04" ] ]
        ]
