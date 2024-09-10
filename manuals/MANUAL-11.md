## Loading Sprites

Check example: `ex_man11.ml`, for an example of use
of an image loaded with pieces of it used as sprites:

```
$ ocaml -I src/ sdl2.cma examples/ex_man11.ml
```

PS: Be carefull, the image should not be an indexed
one if you want to use a color-key for transparency.

