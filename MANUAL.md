# Manual for: OCamlSDL2

## Initialisation

```
let () =
  Sdl.init [`VIDEO]
```

Initialises the SDL2 library, for use with something visible
on screen.

## Prefixed, or Prefixless?

If you prefer to use the modules, without the 'Sdl' prefix,
you can add this open, at the beginning of your file:

```
open Sdl
```

## Render, and Renderers

A possibility to draw on screen, inside the window, is to use
a `renderer` with the `render` module.

We can initialise a window, and a renderer, with the function:

```
  Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
```

Here is an example, which will draw four points in a window,
with a renderer, and the render module:

```
let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
  Sdlrender.clear renderer;

  Sdlrender.set_draw_color renderer ~rgb:(0,0,127) ~a:255;
  Sdlrender.draw_point renderer (120, 120);
  Sdlrender.draw_point renderer (122, 120);
  Sdlrender.draw_point renderer (124, 120);
  Sdlrender.draw_point renderer (126, 120);

  Sdlrender.render_present renderer;
  Sdltimer.delay 6000;

  Sdl.quit ();
;;
```

Here are some explanations about how this example works:

- first we have to fill the background with a color,
  this operation is achieved with two function calls,
  
  the first one, defines the color,
```
  Sdlrender.set_draw_color
```
  and the second one, requests the renderer to erase the
  contents of the window, with this selected color.
```
  Sdlrender.clear renderer;
```
  this is usually what we do, if we want to display, a
  game, or any other kind of content that we want to
  animate (in case the background doesn't fill all the
  window, inside the drawing area).

- After we draw four points with the function below:
```
  Sdlrender.draw_point
```

Again we have to define a color first, as if we would
choose a color pen:
```
  Sdlrender.set_draw_color
```

While painting, the primary colors are: cyan, magenta,
and yellow. But with a screen, the primary colors are:
red, green, and blue.

Most often these three colors have to be defined in this
order.
With screen colors, we create a yellow color, by mixing
red and green. And leaving blue to zero, or any value
close to zero.

In the above example, we select a turquoise color, for
the background, with:
```
  (0,255,255)
```

And a dark-blue, for the four points, with:
```
  (0,0,127)
```

At the end of all the draw request elements, we should
call the `renderer` with the `render_present` function,
to make the drawing visible on screen:
```
  Sdlrender.render_present renderer;
```

Then we ask to wait 6 seconds:
```
  Sdltimer.delay 6000;
```
This function uses milliseconds, to make pauses smaller
than one second (so that we can make smooth animations).

The equivalent of 6 seconds, is 6000 milliseconds.

Then we can quit if we have finished with what we want
to display:
```
  Sdl.quit ()
```

## Sprites Elements

If you want to create a game, or an animation, with
real painting, you can take a picture of your painting
with a smartphone (if you don't have one, you can ask
a friend). Small pieces of images, that are used to
display, are often called "sprites" (or "tiles" for
background elements.)

The prefered image-file format for use with sdl-2 is
the ".bmp" format.

In the console, an easy way to convert a ".png" or ".jpg"
image to ".bmp", is to use a command from image-magick:

```
$ convert my_sprite.png my_sprite.bmp
```

