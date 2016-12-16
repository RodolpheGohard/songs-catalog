import Html exposing (Html, div, input, button, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import String

main =
    Html.beginnerProgram { model = model, view = view, update = update }
    

type Msg
    = Change String | AddSong


type alias Model
    = {
        songs: List String,
        inputSong: String
    }

model : Model
model = Model ["Cantaloupe Island"] ""
    

view : Model -> Html Msg
view model =
    div []
        [
            div [] [ text <| String.join "" model.songs],
            div [] (List.map (\songName -> text songName) model.songs),
            input [value model.inputSong, placeholder "Text placeholder", onInput Change] [],
            button [onClick AddSong] [text "add"]
        ]
        
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddSong -> 
            Model (model.inputSong :: model.songs) ""
        Change newContent ->
            { model | inputSong = newContent }


