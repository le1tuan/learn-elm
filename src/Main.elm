module Main exposing (..)

import Html exposing (Html, text, div, h1, img, input, Attribute, li, ul, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (isEmpty)
import List.Extra exposing (removeAt)

validateInput text = isEmpty text == False

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

type Msg = ADDTODO | ADDFINISH | ADDINPROGRESS | TODO String| FINISH String| INPROGRESS String | CHECKBOX Int String 

update: Msg -> Model -> Model
update msg model = 
    case msg of 
        TODO item -> { model | todoInput = item}
        FINISH item -> {model | finishInput = item}
        INPROGRESS item -> {model | inprogressInput = item}
        ADDTODO -> if validateInput model.todoInput then { model | todo = model.todo ++ [model.todoInput] , todoInput = "" } else  { model | todoInput = "" }
        ADDFINISH -> if validateInput model.finishInput then { model | finish = model.finish ++ [model.finishInput], finishInput = ""} else  { model | finishInput = "" }
        ADDINPROGRESS -> if validateInput model.inprogressInput then { model | inprogress = model.inprogress ++ [model.inprogressInput], inprogressInput = ""} else  { model | inprogressInput = "" }
        CHECKBOX index typeOfInput  -> if typeOfInput == "todo" then 
        { model | inprogress = model.inprogress ++ [model.todo[index]]} removeAt index model.todo
        
view : Model -> Html Msg
view model = 
    div [class "container"] [
        div [class "item"]
        [ input [placeholder "Todo", onInput TODO, value model.todoInput] []
        , button [onClick ADDTODO] [text "add todo"]
        , div [] (renderTodos { typeOfData = "todo", data = model.todo})
        ],
        div [class "item"]
        [ input [placeholder "Inprogress", onInput INPROGRESS, value model.inprogressInput] []
        , button [onClick ADDINPROGRESS] [text "add inprogress"]
        , div [] (renderTodos { typeOfData = "inprogress", data = model.inprogress})
        ],
        div [class "item"]
        [ input [placeholder "finish", onInput FINISH, value model.finishInput] []
        , button [onClick ADDFINISH] [text "add finish"]
        , div [] (renderTodos { typeOfData = "finish", data = model.finish})
        ]
    ]
    

renderTodos inputData = List.indexedMap (\index data ->  let 
        children = 
        [
            li [] [
                input [type_ "checkbox" onClick ] [],
                text data
            ]
        ]
    in 
        ul [] children) inputData.data