import java.util.Collections;
import java.util.Arrays; 

public class Bunch
{
    Circle[] Circles;
    int numCircles;
    float bound;
    
    Bunch(int[] radii) // specified circles
        {
        Circles = new Circle[radii.length];
        
        // assign the specified radii to new Circles
        numCircles = radii.length;
        for (int i = 0; i < numCircles; i++)
        {
            Circles[i] = new Circle(radii[i], i);
        }
        bound = computeBoundary();
}
    
    
    
    public void draw()
        {
        float bound = computeBoundary();
        stroke(0);
        fill(255);
        ellipse(cx,cy, bound * 2, bound * 2);
        
        // draw each circle
        for (int i = 0; i < numCircles; i++)
        {
           if (Circles[i].computed)
                Circles[i].draw();
        }
        
}
    
    public void orderedPlace()
        {
        // new version of the OrderedPlace() method
        // doing it this way means we don't need to access
        // the OpenPoints list, we simply place each circle
        // knowing the locations of all of the other circles
        // (by passing Circles into the computePosition() method
        
        int[] Ordering = new int[numCircles];
        
        for (int i = 0; i < numCircles; i++)
        {
            Ordering[i] = i;
        }
        
        // place the first circle
        Circles[Ordering[0]].x = cx;
        Circles[Ordering[0]].y = cy;
        Circles[Ordering[0]].computed = true;
        
        // place subsequent circles
        for (int i = 1; i < numCircles; i++)
        {
            Circles[Ordering[i]].computePosition(Circles);
        }
}
    
    float computeBoundary() 
        {
        // Find bounding circle for circles
        int i;
        float outer_limit = 0;
        int furthest = 0;
        float dist = 0;
        
        // for each of the circles
        for (i = 0; i < numCircles; i++)
        {
           // if it's been placed....
           if (Circles[i].computed)
            {
                int farx = Circles[i].x - w / 2;
                int fary = Circles[i].y - h / 2;
                
                // calculate distance from the centre point
               dist = (Circles[i].radius + (sqrt((farx * farx) + (fary * fary))));
                
                // if this distance is greater than what we've seen so far
                if (dist>= outer_limit)
                {
                   // this distance becomes the new outer limit
                    outer_limit = dist;
                    furthest = i;
                }
        }
            
        }
        return(outer_limit);
}
    
    void mutate(float mut_rate) {
        if (random(1)<mut_rate) {
            int i,j;
        do{
                i = (int)(Math.random() * numCircles);
                j = (int)(Math.random() * numCircles);
        }
        while(i!= j);
            Circle temp = Circles[j];
            Circles[j] = Circles[i];
            Circles[i] = temp;
            
        }
}
    
}
