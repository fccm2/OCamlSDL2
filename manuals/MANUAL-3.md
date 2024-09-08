## Drawing Squares and Rectangles

### First Square

You can create rectangles and squares with the "Sdlrect" module.

In the functions: make1, make2, make4, the number represents the arity,
which is the number of arguments for a function.

The function `Sdlrect.make` points to the function: `Sdlrect.make2`

The parameters are the same, but are grouped differently with tuples.

Here, `(20, 20)` is the position of the rectangle:

```
  let rect = Sdlrect.make (20, 20) (120, 120)
```

And, `(120, 120)` are the dimensions.

Here is a complete example:

```
let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
  Sdlrender.clear renderer;

  let rect = Sdlrect.make (20, 20) (120, 120) in

  Sdlrender.set_draw_color renderer ~rgb:(0,0,127) ~a:255;
  Sdlrender.draw_rect renderer rect;

  Sdlrender.render_present renderer;

  Sdltimer.delay 6000;

  Sdl.quit ();
;;
```

You can test this example with the file `"ex_man2.ml"`, from
the "examples/" directory.

