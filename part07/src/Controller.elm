module Controller exposing (..)

import Element   as GE exposing (Element, show)
import Collage   as GC exposing (..)
import Html      as H  exposing (Html,program)
-- not html
import Time            exposing (Time)
import Keyboard  as KB exposing (KeyCode, presses)
-- my module
import Tetromino as TE exposing (..)

type Direction = Undef
               | Up
               | Down
               | Left
               | Right

type Input = Dir Direction
           | Key KeyCode
           | Frame Time Time
           | Enter

type alias Model = Maybe Time

type Msg = PressDown KeyCode
         | Tick Time

update : Msg -> Model -> (Model, Input)
update msg model =
    case msg of
        PressDown k ->
            if      (k == 37) then (model, Dir Left)
            else if (k == 38) then (model, Dir Up)
            else if (k == 39) then (model, Dir Right)
            else if (k == 40) then (model, Dir Down)
            else if (k == 13) then (model, Enter)
            else                   (model, Enter)
        Tick t ->
            case model of
                Nothing -> (Just t, Frame t 0)
                Just om ->
                    let interval = t - om
                    in  (Just t, Frame t interval)

subscriptions : Sub Msg
subscriptions =
    Sub.batch [ KB.downs PressDown
              , Time.every (1000.0/33) Tick
              ]

