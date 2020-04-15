module ElmUI exposing (..)

import Browser
import Element exposing (Color, Element, centerX, column, fill, htmlAttribute, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Events exposing (onClick)
import Element.Font as Font exposing (Font)
import Element.Input exposing (button)
import Html.Attributes
import Platform.Cmd
import Platform.Sub
import Time exposing (Posix, every)

type BgColor = Red | Green | Blue | Black | Yellow

nextColor : BgColor -> BgColor
nextColor c = case c of
    Red ->  Green
    Green ->  Blue
    Blue ->  Black
    Black ->  Yellow
    Yellow ->  Red

colorToString : BgColor -> Color
colorToString c = case c of
    Red ->  rgb255 255 0 0
    Green ->  rgb255 0 255 0
    Blue ->  rgb255 0 0 255
    Black ->  rgb255 0 0 0
    Yellow -> rgb255 255 255 0

type alias Model = { bgColor: BgColor, time : Posix }

type Msg =
    NoOp
    | ChangeColor BgColor
    | Tick Posix

view : Model -> Element Msg
view model =
    column
    [ Background.color <| colorToString model.bgColor
    , width fill
    , spacing 20
    , Font.size 30
    ]
    [ Element.el [ centerX ] <| text "Boris"
    , button [ centerX ] { onPress = Just <| ChangeColor <| nextColor model.bgColor, label = text "Click me" }
    , button [ htmlAttribute <| Html.Attributes.attribute "data-test" "red" ] { onPress = Just <| ChangeColor Red, label = text "Red" }
    , button [] { onPress = Just <| ChangeColor Blue, label = text "Blue" }
    ]

init : (Model, Cmd Msg)
init = ({ bgColor = Red, time = Time.millisToPosix 0 }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp -> (model, Cmd.none)
        ChangeColor c -> ( { model | bgColor = c }, Cmd.none )
        Tick t -> ( { model | time = t, bgColor = nextColor model.bgColor }, Cmd.none )

main : Program () Model Msg
main =
    Browser.element
        --{ view = \model -> Element.layout [] <| view model
        { view = view >> Element.layout []
        , init = \_ -> init
        , update = update
        , subscriptions = \_ -> Time.every 3000 Tick
        }