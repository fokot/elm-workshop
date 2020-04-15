# Elm tutorial given at 15. Apr 2020

Bug part of it is not in this repository as was only shown as live coding or in different project 

## Topics
* basic syntax - types, functions and operators (`<|`, `|>`, `>>`, `<<`), `List`, `Maybe`, `List.Extra`, `Maybe.Extra`
* TEA - app with one button and changing screen background
* subscriptions - rotating colors on time events
* elm-ui
* routing
* moving component to extra file 
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
* json encoders/decoders are lot of boilerplate