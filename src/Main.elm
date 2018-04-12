module Main exposing (..)

import Html exposing (Html, text, div, h1, img, input, Attribute, li, ul, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


type alias Model = {
    finishInput: String,
    inprogressInput: String,
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
    todoInput = "",
    finishInput = "",
    inprogressInput = ""}

type Msg = ADDTODO | ADDFINISH | ADDINPROGRESS | TODO String| FINISH String| INPROGRESS String

update: Msg -> Model -> Model
update msg model = 
    case msg of 
        TODO item -> { model | todoInput = item}
        FINISH item -> {model | finishInput = item}
        INPROGRESS item -> {model | inprogressInput = item}
        ADDTODO -> { model | todo = model.todo ++ [model.todoInput] , todoInput = "" }
        ADDFINISH -> { model | finish = model.finish ++ [model.finishInput], finishInput = ""}
        ADDINPROGRESS -> { model | inprogress = model.inprogress ++ [model.inprogressInput], inprogressInput = ""}
        
view : Model -> Html Msg
view model = 
    div [class "container"] [
        div [class "item"]
        [ input [placeholder "Todo", onInput TODO] []
        , button [onClick ADDTODO] [text "add todo"]
        , div [] (renderTodos model.todo)
        ],
        div [class "item"]
        [ input [placeholder "Inprogress", onInput INPROGRESS] []
        , button [onClick ADDINPROGRESS] [text "add inprogress"]
        , div [] (renderTodos model.inprogress)
        ],
        div [class "item"]
        [ input [placeholder "finish", onInput FINISH] []
        , button [onClick ADDFINISH] [text "add finish"]
        , div [] (renderTodos model.finish)
        ]
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