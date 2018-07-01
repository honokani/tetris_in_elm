module Tetromino exposing (..)

import List    as Ls
import Color         exposing (Color)
import Collage as GC exposing (..)
import Element as GE exposing (..)
import Html    as H  exposing (Html)
-- my module
import Block         exposing (Block)

-- main for debug this file
main : H.Html msg
main = 
    let
        tgt : Tetromino
        tgt = shift (3,3) <| o
    in
        GE.toHtml
        <| GC.collage 400 400
        <| Ls.map (\f -> f tgt) [ toForm
                                , drawPivot
                                ]



toForm : Tetromino -> Form
toForm tet =
    let
        translate : Location -> Form
        translate (r,c) = Block.toForm tet.block
                          |> move ( (toFloat c) * Block.size
                                  , (toFloat r) * Block.size
                                  )
    in
        group <| Ls.map translate tet.shape

drawPivot : Tetromino -> Form
drawPivot { pivot } =
    let
        dot = circle 5 |> filled Color.black
        translate : Form -> Form
        translate = move (pivot.c * Block.size, pivot.r * Block.size)
    in
        translate dot

rotateLocation : { r:Float, c:Float } -> Float -> Location -> Location
rotateLocation piv agl (posR,posC) =
    let
        orgR = (toFloat posR) - piv.r
        orgC = (toFloat posC) - piv.c
        (s, c) = (sin(agl), cos(agl))
        rtR = orgR*c - orgC*s
        rtC = orgR*s + orgC*c
    in
        (round <| rtR+piv.r, round <| rtC+piv.c)

rotateR : Tetromino -> Tetromino
rotateR t =
    let
        rHelper : Location -> Location
        rHelper = rotateLocation t.pivot (degrees 90)
    in
        { t | shape = Ls.map rHelper t.shape
            , rows  = t.cols
            , cols  = t.rows
        }

shift : (Int, Int) -> Tetromino -> Tetromino
shift (v,h) t =
    let newPiv = { r = t.pivot.r + (toFloat v)
                 , c = t.pivot.c + (toFloat h)
                 }
        newShp = Ls.map (\(r,c) -> (r+v,c+h)) t.shape
    in
        { t | shape = newShp
            , pivot = newPiv
        }





-- objects
type alias Location = (Int, Int)
type alias Tetromino = { shape : List Location
                       , block : Block
                       , pivot : { r : Float
                                 , c : Float
                                 }
                       , rows : Int
                       , cols : Int
                       }

i : Tetromino
i = { shape = [ ( 1, 0)
              , ( 0, 0)
              , (-1, 0)
              , (-2, 0)
              ]
    , block = Block Color.lightBlue
    , pivot = { r = -0.5, c = 0.5 }
    , rows = 4
    , cols = 1
    }

j : Tetromino
j = { shape = [          ( 1, 0)
              ,          ( 0, 0)
              , (-1,-1), (-1, 0)
              ]
    , block = Block Color.red
    , pivot = { r = 0, c = 0 }
    , rows = 3
    , cols = 2
    }

l : Tetromino
l = { shape = [ ( 1, 0)
              , ( 0, 0)
              , (-1, 0), (-1, 1)
              ]
    , block = Block Color.green
    , pivot = { r = 0, c = 0 }
    , rows = 3
    , cols = 2
    }

z : Tetromino
z = { shape = [ ( 0,-1), ( 0, 0)
              ,          (-1, 0), (-1, 1)
              ]
    , block = Block Color.purple
    , pivot = { r = 0, c = 0 }
    , rows = 2
    , cols = 3
    }

s : Tetromino
s = { shape = [          ( 0, 0), ( 0, 1)
              , (-1,-1), (-1, 0)
              ]
    , block = Block Color.yellow
    , pivot = { r = 0, c = 0 }
    , rows = 2
    , cols = 3
    }

t : Tetromino
t = { shape = [ ( 0,-1), ( 0, 0), ( 0, 1)
              ,          (-1, 0)
              ]
    , block = Block Color.orange
    , pivot = { r = 0, c = 0 }
    , rows = 3
    , cols = 2
    }

o : Tetromino
o = { shape = [ ( 0, 0), ( 0, 1)
              , (-1, 0), (-1, 1)
              ]
    , block = Block Color.orange
    , pivot = { r = -0.5, c = 0.5 }
    , rows = 2
    , cols = 3
    }


