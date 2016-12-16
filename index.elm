import Html exposing (Html, Attribute, div, input, button, text, ul, li)
import Html.Attributes exposing (..)
import Html.Events exposing (on, onClick, onInput, keyCode)
import Json.Decode as Json

onKeyUp : (Int -> msg) -> Attribute msg
onKeyUp tagger =
  on "keyup" (Json.map tagger keyCode)

onEnter : (Msg) -> Attribute Msg
onEnter callback =
    onKeyUp (\keyCode -> if keyCode==13 then callback else Noop)




main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }
    

type Msg
    = Change String | AddSong | Noop


type alias Model
    = {
        songs: List String,
        inputSong: String
    }

model : Model
model = Model ["Cantaloupe Island"] ""

--onEnter : (String -> msg) -> Html.Attribute msg 

view : Model -> Html Msg
view model =
    div []
        [
            ul [] (List.map (\songName -> li [] [text songName]) model.songs),
            input [value model.inputSong, placeholder "Text placeholder", onInput Change, onEnter AddSong] [],
            button [onClick AddSong] [text "add"]
        ]
        
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddSong -> 
            Model (model.inputSong :: model.songs) ""
        Change newContent ->
            { model | inputSong = newContent }
        Noop ->
            model


