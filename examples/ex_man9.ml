type color = int * int * int

type game_rect = {
  rect_colors: color * color;
  rect: Sdlrect.t;
  dir: int * int;
}

type game_state = {
  bg_color: color;
  rects: game_rect list;
  renderer: Sdlrender.t;
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

let new_rect () =
  let pos = rand_pos () in
  let dims = (20, 20) in
  let rect = Sdlrect.make pos dims in
  let rect_color1 = (0,0,191) in
  let rect_color2 = (255,191,127) in
  { rect_colors = (rect_color1, rect_color2);
    rect = rect;
    dir = rand_take dirs;
  }

let initialise renderer =
  let rects = List.init 12 (fun _ -> new_rect ()) in
  { bg_color = (0,239,255);
    rects = rects;
    renderer;
  }

let update_rect _rect =
  let rect = _rect.rect in
  let dir = _rect.dir in
  let x = rect.Sdlrect.x in
  let y = rect.Sdlrect.y in
  let dx, dy = dir in
  let x, y = (x + dx, y + dy) in
  let dir = if x < 0 then d0 else dir in
  let dir = if y < 0 then d1 else dir in
  let dir = if x + 20 > width then d2 else dir in
  let dir = if y + 20 > height then d3 else dir in
  let dir = if Random.int 100 < 3 then dirs.(Random.int 4) else dir in
  let rect = Sdlrect.move rect ~x:x ~y:y in
  { _rect with rect; dir }

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

let display_rect renderer _rect =
  let rect_color1, rect_color2 = _rect.rect_colors in
  let rect = _rect.rect in

  Sdlrender.set_draw_color renderer ~rgb:rect_color1 ~a:255;
  Sdlrender.fill_rect renderer rect;

  Sdlrender.set_draw_color renderer ~rgb:rect_color2 ~a:255;
  Sdlrender.draw_rect renderer rect;
  ()

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

    display_background game_state;
    List.iter (display_rect renderer) rects;
    Sdlrender.render_present renderer;
    ()
  in

  let rec loop i game_state =
    display game_state;
    let game_state = update game_state in
    Sdltimer.delay 60;

    if i < 600 then loop (succ i) game_state
  in
  loop 0 game_state;

  Sdl.quit ();
;;

