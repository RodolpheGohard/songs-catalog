import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String

main =
    Html.beginnerProgram { model = model, view = view, update = update }
    
type alias Model =
    List String

type Msg
  = Change String | Tg

model : Model
model =
    ["Cantaloupe Island"]

view : Model -> Html Msg
view model =
    div []
        [
            div [] [ text <| String.join "" model],
            div [] (List.map (\songName -> text songName) model),
            input [placeholder "Text placeholder", onInput Change] [],
            button [onClick Tg] [text "add"]
        ]
        
update : Msg -> Model -> Model
update msg model =
    case msg of
        Tg -> 
            "ta soeur" :: model
        Change newContent ->
            newContent :: model


