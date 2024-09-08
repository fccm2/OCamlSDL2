
let () =
  Sdl.init [`VIDEO];

  let width, height = (320, 240) in

  let window, renderer =
    Sdlrender.create_window_and_renderer ~width ~height ~flags:[]
  in

  Sdlrender.set_draw_color renderer ~rgb:(0,255,255) ~a:255;
  Sdlrender.clear renderer;

  let a = (20, 20) in
  let b = (120, 120) in

  Sdlrender.set_draw_color renderer (0,0,127) 255;
  Sdlrender.draw_line renderer (a, b);

  Sdlrender.render_present renderer;

  Sdltimer.delay 6000;
  Sdl.quit ();
;;
