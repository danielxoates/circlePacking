class Circle {
  int x, y, i;
  int radius;
  
  // Default is "not placed"
  boolean computed;
  
  Circle (int r, int num) {
    x=0; y=0;
    radius = r;
    i=num;
    computed=false;
  }
  
  void computePosition (Circle[] c) {
    int i, j;
    boolean collision;
    Point[] openPoints = new Point[0];
    int ang;
    Point pnt;
    
    // This circle already placed, so just quit
    if (computed) { return; }
    
    for (i=0; i<c.length; i++)
    {
      // Check all other circles currently in place
      if (c[i].computed)
      {
        ang = 0;
        // move clockwise
        for (ang=0; ang<360; ang+=1)
        {
          collision = false;
          pnt = new Point();
          pnt.x = c[i].x + int(cos(ang*PI/180) * (radius+c[i].radius+1));
          pnt.y = c[i].y + int(sin(ang*PI/180) * (radius+c[i].radius+1));
          
          for (j=0; j<c.length; j++)
          {
            if (c[j].computed && !collision)
            {
              // Two circles intersect if, and only if, the distance between 
              // their centre points is between the sum and the difference of their radii
              if (dist(pnt.x, pnt.y, c[j].x, c[j].y) < radius + c[j].radius)
              {
                collision = true;
              }
            }
          }
          
          // if no overlap, add this location to the list of open points
          if (!collision)
          {
            openPoints =  (Point[]) expand(openPoints, openPoints.length+1);
            openPoints[openPoints.length-1] = pnt;
          }
        }
      }
    }
    
    // find the open point that's closest to the centre
    float min_dist = -1;
    int best_point = 0;
    for (i=0; i<openPoints.length; i++)
    {
      if (min_dist == -1 || dist(cx, cy, openPoints[i].x, openPoints[i].y) < min_dist)
      {
        best_point = i;
        min_dist = dist(cx, cy, openPoints[i].x, openPoints[i].y);
      }
    }
    if (openPoints.length == 0)
    {
      println("no points?");
    } else
    {
      //println(openPoints.length + " points");
      x = openPoints[best_point].x;
      y = openPoints[best_point].y;
    }
    computed = true;
  }
  
  void draw () 
  {
      fill(255);
      ellipseMode(CENTER);
      ellipse(x, y, radius*2, radius*2);
      fill(255,0,0);
      textFont(f,8);
      text(""+i, x, y);
  }
 
}
