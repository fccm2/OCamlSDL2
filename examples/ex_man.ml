
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

  Sdltimer.delay 2000;

  Sdl.quit ();
;;
