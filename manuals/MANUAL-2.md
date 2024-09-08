## Drawing Points

### X and Y Coordinates

The positions of the points are given with x and y
coordinates along the x and y-axes (abscissa and
ordinate.)

```
  Sdlrender.draw_point renderer (x, y);
```

The x coordinate is the distance from the left side
of the window. The x-axis is the horizontal axis.

The y-axis is the vertical axis. The y coordinate is
used reversed, compared to the mathematic direction.

With computers, the y coordinates are often used in
the direction: "top-to-bottom".

If you want to place points on the first (top) line
of the window, the y coordinate should be: `0`

Similarly, the x coordinates for points on the first
left column, is also: `0`

Considering the width was defined with `320` in the
above example, points on the last, right column,
should have the x coordinates, set to `320 - 1`,
because to have exactly `320` columns, if the first
one has coordinate 0 (and not 1), the last one then
has coordinate `width - 1`

```
  let width, height = (320, 240)
```

In the programming language used by this package,
there is a predefined function, to get the previous
integer: `pred`

This is why, to check if a coordinate will be inside
the view area of the window, the comparision check
has to be: `if x < width` and not: `if x <= width`

