import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onClick)

main =
    Html.beginnerProgram { model = model, view = view, update = update }
    
type alias Model =
    List String

type Msg = Tg | Tgg

model : Model
model =
    ["Cantaloupe Island"]

view : Model -> Html Msg
view model =
    div []
        [
            div [] [ text <| String.join "" model],
            div [] (List.map (\songName -> text songName) model),
            input [] [],
            button [onClick Tg] [text "add"]
        ]
        
update : Msg -> Model -> Model
update msg model =
    case msg of
        Tg -> 
            "ta soeur" :: model
        Tgg -> 
            model


