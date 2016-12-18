import Html exposing (Html, Attribute, div, input, button, text, select, option, ul, li)
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
    = Change String | AddSong | AddParticipant Participant | Noop

type Role
    = Lead | Comping | Bass | Drums | Support | Solo
roles = [Lead, Comping, Bass, Drums, Support, Solo]

type alias User = String

type alias Participant
    = {
        song: String,
        user: User,
        role: Role
    }

type alias Model
    = {
        user: User,
        songs: List {name: String, pendingParticipant: Participant},
        inputSong: String,
        participants: List Participant
    }

user : User
user = "Johny"

model : Model
model = Model user [] "" []
--model = Model user ["Cantaloupe Island"] "" [Participant "Cantaloupe Island" user Lead]

buildSongListItem : {name: String, pendingParticipant: Participant} -> Html msg
buildSongListItem songEntry = 
    let
        songName = songEntry.name
    in
        li [] [
            text songName,
            select [on "change" (Json.map SetDuration targetValueIntDecoder)] (List.map (\role -> option [] [text (toString role)]) roles)
            --button [onClick (AddParticipant (Participant songName user role))] [text "participate"]
        ]

view : Model -> Html Msg
view model =
    div []
        [
            ul [] (List.map buildSongListItem model.songs),
            input [value model.inputSong, placeholder "Text placeholder", onInput Change, onEnter AddSong] [],
            button [onClick AddSong] [text "add"],

            ul [] (List.map (\participant -> li [] [text participant.user]) model.participants)
        ]
        
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddSong -> 
            Model user ({name = model.inputSong, pendingParticipant = Participant model.inputSong user Lead} :: model.songs) "" model.participants
        Change newContent ->
            { model | inputSong = newContent }
        Noop ->
            model
        AddParticipant participant ->
            { model | participants = participant :: model.participants}


