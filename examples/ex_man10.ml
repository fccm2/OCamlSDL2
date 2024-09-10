type game_state = {
  bg_color: int * int * int;
  rect: Sdlrect.t;
}

let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  let rect = Sdlrect.make (20, 20) (60, 60) in
  let game_state = {
    bg_color = (0,255,255);
    rect = rect;
  } in
 
  let update i game_state =
    let rect = game_state.rect in
    let rect = Sdlrect.move rect ~x:(20 + i) ~y:20 in

    { game_state with
      rect = rect;
    }
  in

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

  let proc_event e game_state =
    match e with
    | Sdlevent.Quit _ -> Sdl.quit (); exit 0
    | Sdlevent.KeyDown ke -> begin
        match ke.Sdlevent.keycode with
        | Sdlkeycode.Escape -> Sdl.quit (); exit 0
        | Sdlkeycode.A ->
            { game_state with
              bg_color = (255,223,31);
            }
        | Sdlkeycode.B ->
            { game_state with
              bg_color = (0,255,255);
            }
        | _ -> game_state
        end
    | _ -> game_state
  in

  let rec events_loop game_state =
    match Sdlevent.poll_event () with
    | Some e -> events_loop (proc_event e game_state)
    | None -> game_state
  in

  let rec loop i game_state =
    let game_state = events_loop game_state in
    let game_state = update i game_state in
    display game_state;

    Sdltimer.delay 120;
    if i < 80 then loop (succ i) game_state
  in
  loop 0 game_state;

  Sdl.quit ();
;;

