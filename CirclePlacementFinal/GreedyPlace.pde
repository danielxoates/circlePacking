class GreedyPlace
{
    int[] radii;
    Bunch greedyCircles;
    
    GreedyPlace(int[] inRad)
        {
        radii = new int[inRad.length];
        for (int i = 0; i < inRad.length; i++)
            radii[i] = inRad[i];
  }
    
    float greedyPlacement() {
        int[] radCopy = Arrays.copyOf(radii, radii.length);
        radCopy = sort(radCopy);
        Bunch tmpBunch = new Bunch(radCopy);
        
        tmpBunch.orderedPlace();
        
        greedyCircles = tmpBunch;
        
        return(tmpBunch.computeBoundary());
}
    
}
