module Main exposing (..)

import Html exposing (Html, text, div, h1, img, input, Attribute, li, ul, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


type alias Model = {
    todoInput: String,
    todo: List String,
    finish: List String,
    inprogress: List String
}

model: Model
model = {
    todo = [],
    finish = [],
    inprogress = [],
    todoInput = ""}

type Msg = ADDTODO | TODO String| FINISH String| INPROGRESS String

update: Msg -> Model -> Model
update msg model = 
    case msg of 
        TODO item -> { model | todoInput = item}
        FINISH item -> model
        INPROGRESS item -> model
        ADDTODO -> { model | todo = model.todo ++ [model.todoInput] , todoInput = "" }

view : Model -> Html Msg
view model = 
    div []
    [ input [placeholder "Todo", onInput TODO] []
    , button [onClick ADDTODO] [text "add todo"]
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