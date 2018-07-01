module Block exposing (..)

import Color         exposing (Color)
import Collage as GC exposing (..)
import Element as GE exposing (..)



type alias Block = { color : Color }

size : Float
size = 25

toForm : Block -> Form
toForm b =
    let
        shape  = square size
        border = GC.outlined (solid Color.black) shape
    in
        group [filled b.color shape, border]

-- main
main = GE.toHtml <| GC.collage 400 400 [toForm (Block Color.blue)]

