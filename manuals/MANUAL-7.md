## Animation Loop

### And Recursion

Now that we now how to draw squares and rectangles, we can try
to animate it!

A possible solution is to use the function `Sdlrect.move` to
move the rectangle at a different position:

```
    let rect = Sdlrect.move rect ~x:(new_x_pos) ~y:20 in
```

In the example below, we keep the same `y` coordinate, this is
why the rectangle will move along the y-axis.

A possibility to display several frames, in order to achieve an
animation is to create a `loop` function which will repeat itself
several times, for each image of the animation.

This `loop` function repeats itself several times, this is why
it should be created with the `rec` keyword after the `let`
statment.

This `loop` function repeats itself several times, by calling
itself at the end of its operations.

In a function that produces a display, typically the first
operation is to erase the previous frame image, by for example
filling all the drawing area with a selected color.

In the example below, this is achieved with the two function
calls:

```
    Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
    Sdlrender.clear renderer;
```

Int the `loop` function, we put an iterator variable `i`, and
we also pass the initial rectangle `rect`, which will be modified
at each steps of the `loop` function, with `Sdlrect.move`:

```
let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  let rect = Sdlrect.make (20, 20) (60, 60) in
 
  let rec loop i rect =
    Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
    Sdlrender.clear renderer;
 
    Sdlrender.set_draw_color renderer ~rgb:(0,0,127) ~a:255;
    Sdlrender.fill_rect renderer rect;
 
    Sdlrender.render_present renderer;
    Sdltimer.delay 120;

    let rect = Sdlrect.move rect ~x:(20 + i) ~y:20 in

    if i < 80 then loop (succ i) rect
  in
  loop 0 rect;

  Sdl.quit ();
;;
```

You can find this example ready to run as the file `ex_man7.ml`,
in the `examples/` directory:

```
$ ocaml -I src/ sdl2.cma examples/ex_man7.ml 
```

