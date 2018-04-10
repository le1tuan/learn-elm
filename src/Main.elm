module Main exposing (..)

import Html exposing (Html, text, div, h1, img, input, Attribute, li, ul)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


type alias Model = {
    todo: List String,
    finish: List String,
    inprogress: List String
}

model: Model
model = {
    todo = [],
    finish = [],
    inprogress = []}

type Msg = TODO String| FINISH String| INPROGRESS String

update: Msg -> Model -> Model
update msg model = 
    case msg of 
        TODO item -> { model | todo = model.todo ++ [item]}
        FINISH item -> model
        INPROGRESS item -> model

view : Model -> Html Msg
view model = 
    div []
    [ input [placeholder "Todo", onInput TODO] []
    , div [] (renderTodos model.todo)
    ]

renderTodo modelTodo = 
    let 
        children = 
        [
            li [] [text modelTodo]
        ]
    in 
        ul [] children

renderTodos todo = List.map renderTodo todo