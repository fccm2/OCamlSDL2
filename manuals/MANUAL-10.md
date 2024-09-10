## Processing Events

### The Events Loop

Processing events can be done with the `Sdlevent.poll_event`
function. An event can be a key-press from the user, or a
move of the mouse, or a button-clic on the button of the mouse.

Pressing the little cross on the handle of the window, is
also an event that we should connect with an exit, if we
want that the user can exit while pressing this cross.

If we make a small game, or any other kind of application,
getting only one event at each game-step (or frame) is not
enough. Because there might be several events arriving at
each frame, for example if the user is mouving the mouse,
the event queue will possibly contain several, or even a
lot of events.

This is why we have to create a loop to get all the events
repeatedly at each frame.

A possible way to achieve this process is to create a
recursive function that will loop until the function
`Sdlevent.poll_event ()` returns `Some event`, and stop
by returning to the caller function, when we recieve
`None`.

```
val poll_event : unit -> t option
```

This function belongs to the module: `Sdlevent`, and can
be called like that:

```
  match Sdlevent.poll_event () with
  | Some event -> (* event-processing-loop *)
  | None -> (* returning *)
```

You can run and study the example: `ex_man10.ml`, from the
directory: `examples/`. This example, starts back, from the
`ex_man8.ml` example, and adds events handling.

Press keys 'A' and 'B', to change the background color:

```
$ ocaml -I src/ sdl2.cma examples/ex_man10.ml
```

You can check, that now, the cross of the window handle
is connected correctly with an exit.

