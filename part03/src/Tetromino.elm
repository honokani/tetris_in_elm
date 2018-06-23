module Tetromino exposing (..)

import List    as Ls
import Color         exposing (Color)
import Collage as GC exposing (..)
import Element as GE exposing (..)
import Block         exposing (Block)



type alias Location = (Int, Int)
type alias Tetromino = { shape : List Location
                       , block : Block
                       }

toForm : Tetromino -> Form
toForm tet =
    let
        translate : (Int,Int) -> Form
        translate (r,c) = Block.toForm tet.block
                          |> move ( (toFloat c) * Block.size
                                  , (toFloat r) * Block.size
                                  )
    in
        group <| Ls.map translate tet.shape


-- main
main = GE.toHtml
       <| GC.collage 400 400
       <| [toForm l]


-- objects
i : Tetromino
i = { shape = [ ( 1, 0)
              , ( 0, 0)
              , (-1, 0)
              , (-2, 0)
              ]
    , block = Block Color.lightBlue
    }

j : Tetromino
j = { shape = [ ( 1, 0)
              , ( 0, 0)
              , (-1, 0)
              , (-1,-1)
              ]
    , block = Block Color.red
    }

l : Tetromino
l = { shape = [ ( 1, 0)
              , ( 0, 0)
              , (-1, 0)
              , (-1, 1)
              ]
    , block = Block Color.green
    }

