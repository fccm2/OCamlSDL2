## Continuing with the "MVC" model

### Populating the area with several Entities

With the separation of code realised at step-8
of this "manual", we can now add more entities
in our small-demo.

In the example `ex_man9.ml`, with transform our
previous `rect` into an entity, initialised with:
- `new_rect ()`

We add 12 of these entities in our `game_state`,
with:

- `List.init 12`

These entities now have a direction, with the
field: `dir`

This direction is used in the function `update_rect`,
to move the entities.

The function `update_rect`, also changes this direction
to the opposite direction when an entity reaches
the side of their living area.

(with the code below)
```
  let dir = if x < 0 then d0 else dir in
  let dir = if y < 0 then d1 else dir in
  let dir = if x + 20 > width then d2 else dir in
  let dir = if y + 20 > height then d3 else dir in
```

Check the result with this command:

```
$ ocaml -I src/ sdl2.cma examples/ex_man9.ml 
```

!!! Warning: The cross of the window handle is not
     connected yet with an exit in the demo, so
     you'll have to wait:
     (600 * 60) milliseconds, (= 36000 milliseconds),
     or 36 seconds, for this demo to exit.

Processing events, (and the "escap" key-press event)
will be seen in the next step (step-10) of these manuals.

