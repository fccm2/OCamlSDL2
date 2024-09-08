
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
