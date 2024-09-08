## Filling Squares and Rectangles

### And Signatures

We already saw how to draw squares and rectangles,
now here is how to also fill the inside area of it.

```
  Sdlrender.fill_rect renderer rect;
```

The signature of the function to achieve this is:

```
val fill_rect : t -> Sdlrect.t -> unit
```

It is also a function from the `Sdlrender` module.

The returned element is `unit`, which means that the function doesn't
return anything. It produces an effet (side effect), which is to display
a filled rectangle on screen.

The type of the second parameter is: `Sdlrect.t`, which is the main
type (called `t`) inside the module `Sdlrect`.

In this interface to the sdl2 library, we separated all the elements
into several modules, because there are a lot of elements.

If the library was smaller, with fewer number of elements, we could
put everything in a single module, and the type for rectangles
could be:

```
type rect
```

This is why a type `Sdlrect.t`, is usually the equivalent for a type
that could be named `rect`.

In the signature above the first parameter is `t`, because this function
is inside the module `Sdlrender`. This is why this first parameter is
equivalent than `Sdlrender.t`, which in a similar way is equivalent than
a type that could be named:

```
type renderer
```

Here is the full example:

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
  Sdlrender.fill_rect renderer rect;

  Sdlrender.render_present renderer;

  Sdltimer.delay 6000;

  Sdl.quit ();
;;
```

This example is exactly the same than the one at step-3 of the manual,
except that it calls `Sdlrender.fill_rect`, in stead of `Sdlrender.draw_rect`.

