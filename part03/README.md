# part03

# What I did  

   *  about **tetris**  
      +  block  
      +  tetromino  

   *  about **elm**  
      +  source directories  
         -  At `source-directories` in `elm-package.json`, use `"src"` instead of `"."`.  
      +  look for package  
         - `elm-package install evancz/elm-graphics`  
      +  `Collage` and `Element`  
         -  In v0.18, use `Collage` instead of `Graphics.Collage`.  
            `Element` too.  
      +  main  
         -  `main` must `Html` type.  
            I use `Element.toHtml` with Element.  

