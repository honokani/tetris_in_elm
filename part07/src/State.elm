module State exposing (..)

import Element    as GE exposing (Element, show)
import Collage    as GC exposing (..)
import Html       as H  exposing (Html,program)
-- not html
import Time             exposing (Time)
import Keyboard   as KB exposing (KeyCode, presses)
-- my module
import Tetromino  as TE exposing (..)
import Controller as CL exposing (..)


-- main
main : Program Never Model Msg
main =
    H.program
        { init = init, view = view, update = update, subscriptions = subscriptions }


type alias Model = { mTimimg : CL.Model
                   , state   : State
                   }

type alias State = { falling : TE.Tetromino
                   }

type alias Msg = CL.Msg


defaultState : State
defaultState = { falling = TE.j
               }

init : ( Model, Cmd Msg )
init = ( { mTimimg = Just 0
         , state = defaultState
         }
       , Cmd.none
       )

view : Model -> H.Html msg
view { mTimimg, state } =
    let
        scrW = 800
        scrH = 600
        fallingForm = TE.toForm state.falling
    in
        GE.toHtml <| GC.collage scrW scrH [fallingForm]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        (newM, ipt) = CL.update msg model.mTimimg
        newS = updateAct ipt model.state
    in
        ( { mTimimg = newM
          , state = newS
          }
        , Cmd.none
        )


updateAct : Input -> State -> State
updateAct ipt sOld =
    case ipt of
        Enter     -> { sOld | falling = TE.rotateR sOld.falling }
        Dir Up    -> { sOld | falling = TE.shift ( 1, 0) sOld.falling }
        Dir Down  -> { sOld | falling = TE.shift (-1, 0) sOld.falling }
        Dir Left  -> { sOld | falling = TE.shift ( 0,-1) sOld.falling }
        Dir Right -> { sOld | falling = TE.shift ( 0, 1) sOld.falling }
        _         -> sOld

subscriptions : Model -> Sub Msg
subscriptions _ = CL.subscriptions

