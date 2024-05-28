class RandomPlace
{
    int[] radii;
    Bunch randomCircles;
    
    RandomPlace(int[] inRad)
        {
        radii = new int[inRad.length];
        for (int i = 0; i < inRad.length; i++)
            radii[i] = inRad[i];
        
        
}
    
    float randomPlacement()
        {
        // this method illustrates how we can take a specific ordering,
        // create the circle structure that it encodes, and evaluate it.....
        
        // take a copy of the Radii list and shuffle it
        // there are quicker ways to do this, but being explicit is better here...
        int[] radCopy = Arrays.copyOf(radii, radii.length);
        Random rand = new Random();
        float bestFitness = 500;
        //Bunch bestBunch;
        
        for (int j = 0;j < 10;j++) {
            // shuffle the array
            for (int i = 0; i < radCopy.length; i++) 
            {
               // pick a random array element
                int randomIndex = rand.nextInt(radCopy.length);
                
               // swap itwith the current element
                int temp =radCopy[randomIndex];
                radCopy[randomIndex] = radCopy[i];
                radCopy[i]= temp;
            }
            println("Shuffled radii:");
            System.out.println(Arrays.toString(radCopy));
            
            // create a new Bunch object 
            Bunch tmpBunch = new Bunch(radCopy);
            
            // placethe Circles with the shuffled ordering
            tmpBunch.orderedPlace();
            
            // save it
            randomCircles = tmpBunch;
            
            // assess it
            float score = tmpBunch.computeBoundary();
            if (score < bestFitness) {
                bestFitness = score;
                //bestBunch=tmpBunch;
            }
        }
        
        return bestFitness;
}
    
}
