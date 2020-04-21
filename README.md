# Elm workshop given at April 15 2020

Big part of it is not in this repository as was only shown as live coding or in different project 

## Topics
* basic syntax - types, functions and operators (`<|`, `|>`, `>>`, `<<`), `List`, `Maybe`, `List.Extra`, `Maybe.Extra`
* TEA - app with one button and changing screen background
* subscriptions - rotating colors on time events
* elm-ui
* routing
* moving component to extra file (embedding component model and messages to global one)
* ports + working with jsons

## Run as
```
elm reactor
```

## Notes
* Create new elm project as
```
mkdir new-project
cd new-project
elm init
```
* Types start with uppercase
* Variables and also type variables with lowercase
* Structural typing
```
type alias A1 = { a : String }
type alias A2 = { a : String }
type alias A3 = { a : Int }
type alias AB = { a : String, b : String }

a1 : A1
a1 = { a = "" }

a2 : A2
a2 = { a = "" }

a3 : A3
a3 = { a = 123 }

ab : AB
ab = { a = "a", b = "b" }

a2_a1 : A2
a2_a1 = a1

-- not compilable
--a2_a3 : A2
--a2_a3 = a3

-- not compilable
--a2_ab : A2
--a2_ab = ab

f1 : A2 -> Int
f1 _ = 123

-- works with A1 and A2
r1a1 = f1 a1
r1a2 = f1 a2

-- does not compile with AB
--r1ab = f1 ab

f2 : { a | a : String } -> Int
f2 _ = 123

-- works with A1, A2 and AB
r2a1 = f2 a1
r2a2 = f2 a2
r2ab = f2 ab
```
* These three are equivalent
```
-- onClick : msg -> Attribute msg
-- type Msg = ChangeColor Color
-- this creates constructor function: ChangeColor : Color -> Msg

-- these are equivalent and all of them return Attribute Msg
onClick (ChangeColor Red)
onClick <| ChangeColor Red
ChangeColor Blue |> onClick
```
* To find elm packages use [https://package.elm-lang.org/]
* `List` and `Maybe` modules in core are sparse, you will probably need `List.Extra` and `Maybe.Extra`
* Install new package as
```
elm install mdgriffith/elm-ui
```
* There is only single model, all submodels need to be embedded into it
* All updates to model go through single `update` function all partial updates needs to be embedded into it
* Only was to update model is through `Msg`
* `Cmd` are run by Elm platform and only way how they can return value back to application is that they produce `Msg` which is processed by `update`
* Communication with JS is done via `ports`
* [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest) is cool
* Json encoders/decoders are lot of boilerplate
* For routing use `Browser.application`
```
application :
    { init : flags -> Url.Url -> Navigation.Key -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url.Url -> msg
    }
    -> Program flags model msg
```
