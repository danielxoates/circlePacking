//Code modified from TSP problem on blackboard
class Population{
   Bunch[] population;
   int [] radii;
   int populationSize;
   int maxGens;
   float bestFitness;
   Bunch bestBunch;
   boolean finished;
   float mutation_rate;
  Population(int[] inRad){
    maxGens=1000;
    bestFitness=9999.0;
    radii=new int[inRad.length];
    for (int i=0; i<inRad.length; i++)
      radii[i]=inRad[i];
    populationSize=9;
    population=new Bunch[populationSize];
    population = this.createPopulation();
    mutation_rate=0.055;
  }
  
  Bunch[] createPopulation(){
    for(int j=0;j<populationSize;j++){
      int [] radCopy=Arrays.copyOf(radii, radii.length);
      //Random rand = new Random();

      for (int i = 0; i < radCopy.length; i++) 
      {
        // pick a random array element
        int randomIndex = int(random(radCopy.length));
        
        // swap it with the current element
        int temp = radCopy[randomIndex];
        radCopy[randomIndex] = radCopy[i];
        radCopy[i] = temp;
      }
      Bunch add = new Bunch(radCopy);
      population[j]=add;
    }
    return population;
  }
  
  Bunch tournamentSelection(){
    Bunch[] tourn = new Bunch[tournamentSize];
    float shortestTour=99999999;
    int shortestIndex=0;
    for(int i=0;i<tournamentSize;i++){
      int randomID = (int) (Math.random() * populationSize);
      tourn[i]=population[randomID];
    }
    if (random(1)<selectionPressure){
      for(int i=0;i<tournamentSize;i++){
        Bunch current = tourn[i];
        current.orderedPlace();
        float currentBound = current.computeBoundary();
        if(currentBound<shortestTour){
          shortestTour=tourn[i].bound;
          shortestIndex=i;
        }
      }
      return (tourn[shortestIndex]);
    }
    else
      return (tourn[0]);
  }


  Bunch getBestBunch(){
    return bestBunch;
  }
 float getBestFitness(){
    return bestFitness;
  }
  
  void evolve(int gens){
   if (gens>maxGens || bestFitness<op){
     finished=true;
     for(int i=0;i<bestBunch.Circles.length;i++){
      print(" "+bestBunch.Circles[i].radius+" ");
     }
   }
   else{
     for(int i=0; i<populationSize; i++){
       population[i].orderedPlace();
       float current=population[i].computeBoundary();
       //print(" "+current+" ");
       if(current<bestFitness){
         bestFitness=current;
         bestBunch=population[i];
       }
     }
   }
   if(!finished){
    ArrayList<Bunch> matingPool = new ArrayList<Bunch>();
    for(int i=0; i<populationSize;i++){
      matingPool.add(tournamentSelection());
    }
    for(int i=0; i<(populationSize); i++){
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      Bunch parentA = matingPool.get(a);
      Bunch parentB = matingPool.get(b);
      
      int[] aRadii = new int[parentA.Circles.length];
      int[] bRadii = new int[parentA.Circles.length];
      for(int j=0; j<aRadii.length;j++){
        aRadii[j]=parentA.Circles[j].radius;
        bRadii[j]=parentB.Circles[j].radius;
      }
      /*printArray(aRadii);
      print("\n next array \n");
      printArray(bRadii);*/
      
      OrderedCrossover crossover = new OrderedCrossover(aRadii,bRadii);
      crossover.doCrossover();
      int[] child_genome=crossover.getOffspring();
      Bunch child=new Bunch(child_genome);
      child.mutate(mutation_rate);
      //TODO add mutations

      population[i]=child;
    }
   }
  }

}
