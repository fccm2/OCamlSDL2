
let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
  Sdlrender.clear renderer;

  let rect = Sdlrect.make (20, 20) (80, 80) in

  Sdlrender.set_draw_color renderer ~rgb:(0,0,127) ~a:255;
  Sdlrender.fill_rect renderer rect;

  Sdlrender.render_present renderer;

  Sdltimer.delay 5000;

  Sdl.quit ();
;;
