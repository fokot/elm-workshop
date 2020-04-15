module Main exposing (..)
import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
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

colorToString : BgColor -> String
colorToString c = case c of
    Red ->  "red"
    Green ->  "green"
    Blue ->  "blue"
    Black ->  "black"
    Yellow -> "yellow"

type alias Model = { bgColor: BgColor, time : Posix }

type Msg =
    NoOp
    | ChangeColor BgColor
    | Tick Posix

view : Model -> Html Msg
view model =
    div [ style "background-color" <| colorToString model.bgColor ]
    [ text "Boris"
    , button [ onClick <| ChangeColor <| nextColor model.bgColor ] [text "Click me"]
    , button [ onClick <| ChangeColor Red ] [text "Red"]
    , button [ ChangeColor Blue |> onClick ] [text "Blue"]
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
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = \_ -> Time.every 3000 Tick
        }