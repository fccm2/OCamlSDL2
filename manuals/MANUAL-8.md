## A Better Organisation of the Code

### The "MVC" organisation

If you want to continue with the previous example
to create something more complex, with more elements,
we will need to use a better organisation of the code,
than to put all the code in the same function for the
main loop.

In the computer-science area, the organisation of code
recommanded for programs which present a window to a
user, is the organisation of code called "MVC".

It means: "Model-View-Controller"

We have to separate each of these three elements, so
that we can grow our software with a code correctly
organised.

The "Model" contains, the data which is represented on
screen (or used by the program to do something.) In
our example this is the recangle, and the background
color.

In the programming language we are using, the type of
this data also has to be defined first, for somehting
constructed like that. Here we can use this type:

```
type game_state = {
  bg_color: int * int * int;
  rect: Sdlrect.t;
}
```

This type is then initialised like this:

```
  let rect = Sdlrect.make (20, 20) (60, 60) in

  let game_state = {
    bg_color = (0,255,255);
    rect = rect;
  } in
```

The code to display one state of the data:

```
  let display game_state =
    let bg_color = game_state.bg_color in
    let rect = game_state.rect in

    Sdlrender.set_draw_color renderer ~rgb:bg_color ~a:255;
    Sdlrender.clear renderer;
 
    Sdlrender.set_draw_color renderer ~rgb:(0,0,127) ~a:255;
    Sdlrender.fill_rect renderer rect;
 
    Sdlrender.render_present renderer;
    ()
  in
```

This `display` function is the "View".

And the main-loop then becomes:

```
  let rec loop i game_state =
    display game_state;
    let game_state = update i game_state in
    Sdltimer.delay 120;

    if i < 80 then loop (succ i) game_state
  in
```

And we group the functions that update the data together
in a function which is also called once at each animation
step:

```
  let update i game_state =
    let rect = game_state.rect in
    let rect = Sdlrect.move rect ~x:(20 + i) ~y:20 in

    { game_state with
      rect = rect;
    }
  in
```

This `update` function is: the "Controller".

Please find the result in the file `examples/ex_man8.ml`, that
you can run as:

```
$ ocaml -I src/ sdl2.cma examples/ex_man8.ml
```

With this architecture, it becomes easier to develop our code
further.

