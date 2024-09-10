type color = int * int * int

type game_rect = {
  src_rects: Sdlrect.t array array;
  dst_rect: Sdlrect.t;
  dir: int * int;
  col: int;
}

type game_state = {
  bg_color: color;
  rects: game_rect list;
  renderer: Sdlrender.t;
  tex: Sdltexture.t;
}

let d0 = (1, 0)
let d1 = (0, 1)
let d2 = (-1, 0)
let d3 = (0, -1)
let dirs = [| d0; d1; d2; d3; |]
let rand_take arr =
  let n = Array.length arr in
  arr.(Random.int n)

let width, height = (320, 240)
let rand_pos () =
  (Random.int (width - 20),
   Random.int (height - 20))

let new_rect renderer () =
  let pos = rand_pos () in
  let dims = (20, 20) in
  let dst_rect = Sdlrect.make pos dims in
  let col = Random.int 3 in

  let src_rect1 = Sdlrect.make1 (30, 0, 10, 10) in
  let src_rect2 = Sdlrect.make1 (20, 0, 10, 10) in
  let src_rect3 = Sdlrect.make1 ( 0, 0, 10, 10) in
  let src_rect4 = Sdlrect.make1 (10, 0, 10, 10) in

  let src_rect5 = Sdlrect.make1 (30, 10, 10, 10) in
  let src_rect6 = Sdlrect.make1 (20, 10, 10, 10) in
  let src_rect7 = Sdlrect.make1 ( 0, 10, 10, 10) in
  let src_rect8 = Sdlrect.make1 (10, 10, 10, 10) in

  let src_rect9  = Sdlrect.make1 (30, 20, 10, 10) in
  let src_rect10 = Sdlrect.make1 (20, 20, 10, 10) in
  let src_rect11 = Sdlrect.make1 ( 0, 20, 10, 10) in
  let src_rect12 = Sdlrect.make1 (10, 20, 10, 10) in

  let src_rects = [|
    [| src_rect1; src_rect2;  src_rect3;  src_rect4; |];
    [| src_rect5; src_rect6;  src_rect7;  src_rect8; |];
    [| src_rect9; src_rect10; src_rect11; src_rect12; |];
  |]
  in
  { src_rects = src_rects;
    dst_rect = dst_rect;
    dir = rand_take dirs;
    col = col;
  }

let load_texture renderer =
  let dirname = Filename.dirname Sys.argv.(0) in
  let filename = Filename.concat dirname "assets/sprites-3b.bmp" in
  let surf = Sdlsurface.load_bmp ~filename in
  Sdlsurface.set_color_key surf ~enable:true ~key:0x00ffffffl;
  let tex = Sdltexture.create_from_surface renderer surf in
  (tex)

let initialise renderer =
  let tex = load_texture renderer in
  let rects = List.init 26 (fun _ -> new_rect renderer ()) in
  { bg_color = (127,255,135);
    renderer = renderer;
    rects = rects;
    tex = tex;
  }

let side_change_dir (x, y) dir =
  let dir = if x < 0 then d0 else dir in
  let dir = if y < 0 then d1 else dir in
  let dir = if x + 20 > width then d2 else dir in
  let dir = if y + 20 > height then d3 else dir in
  (dir)

let rect_resize (w, h) rect =
  { rect with Sdlrect.w; h }

let update_rect _rect =
  let dst_rect = _rect.dst_rect in
  let dir = _rect.dir in
  let x = dst_rect.Sdlrect.x in
  let y = dst_rect.Sdlrect.y in
  let dx, dy = dir in
  let x, y = (x + dx, y + dy) in
  let dir = side_change_dir (x, y) dir in
  let dir = if Random.int 100 < 3 then dirs.(Random.int 4) else dir in
  let dst_rect = Sdlrect.move dst_rect ~x:x ~y:y in
  { _rect with dst_rect; dir }

let update game_state =
  let rects = game_state.rects in
  let rects = List.map update_rect rects in
  { game_state with
    rects = rects;
  }

let display_background game_state =
  let renderer = game_state.renderer in
  let bg_color = game_state.bg_color in
  Sdlrender.set_draw_color renderer ~rgb:bg_color ~a:255;
  Sdlrender.clear renderer;
  ()

let display_rect tex renderer _rect =
  let dst_rect = _rect.dst_rect in
  let src_rects = _rect.src_rects in
  let dir = _rect.dir in
  let c = _rect.col in
  let src_rect =
    if dir = d0 then src_rects.(c).(0) else
    if dir = d1 then src_rects.(c).(1) else
    if dir = d2 then src_rects.(c).(2) else
    if dir = d3 then src_rects.(c).(3) else
    assert false
  in
  Sdlrender.copyEx renderer
     ~texture:tex
     ~src_rect:src_rect
     ~dst_rect:dst_rect ();
  ()

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
      | Sdlkeycode.C ->
          let change_dir _rect =
            { _rect with
              dir = rand_take dirs;
            }
          in
          let rects = game_state.rects in
          let rects = List.map change_dir rects in
          { game_state with
            rects = rects;
          }
      | _ -> game_state
      end
  | _ -> game_state

let rec events_loop game_state =
  match Sdlevent.poll_event () with
  | Some e -> events_loop (proc_event e game_state)
  | None -> game_state

let () =
  Random.self_init ();
  Sdl.init [`VIDEO];

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  let game_state = initialise renderer in

  let display game_state =
    let renderer = game_state.renderer in
    let rects = game_state.rects in
    let tex = game_state.tex in

    display_background game_state;
    List.iter (display_rect tex renderer) rects;
    Sdlrender.render_present renderer;
    ()
  in

  let rec loop i game_state =
    let game_state = events_loop game_state in
    let game_state = update game_state in

    display game_state;

    Sdltimer.delay 60;

    if i < 800 then loop (succ i) game_state
  in
  loop 0 game_state;

  Sdl.quit ();
;;

