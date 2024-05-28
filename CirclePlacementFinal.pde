//Code modified from TSP problem on blackboard and module workshops
import java.util.Arrays; 
import java.util.Collections;
import java.util.List;
import java.util.Random;

int currentScreen;
boolean GARun;
boolean[] screensDisplayed = {false, false, false};
// create an object (class instance) for each algorithm used
GreedyPlace greedyAlg;
RandomPlace randomAlg;


// width and height of screen
int w = 800;
int h = 600;
float selectionPressure;
int tournamentSize;
int generation;
float target= 183.6;
Bunch best;
Population pop;

// determine centre point of screen
int cx = w / 2; // always width/2
int cy = h / 2; // always height/2

PFont f;
int[] r1 = {10,12,15,20,21,30,30,30,50,40};
float opR1 = 112.2;
int[] r2 = {10,40,25,15,18};
float opR2 = 91.8;
int[] r3 = {10,34,10,55,30,14,70,14};
float opR3 = 152;
int[] r4 = {5,50,50,50,50,50,50};
float opR4 = 176.46;
int[] r5 = {10,34,10,55,30,14,70,14,50,16,23,76,34,10,12,15,16,11,48,20};
float opR5 = 183.6;
int[] t1 = {20, 22, 17, 17, 7, 21, 11, 5, 23, 8};
float opT1 = 69.9;
int[] t2 = {8,14,8,15,11,17,21,16,6,18,24,13,20,10};
int[] t3 = {24,16,19,7,14,24,15,6,16,16,23,10,9,10,18,22,7,9,7,13,14,8,18,6,8};
int[] t4 = {6,12,20,6,14,19,9,20,10,13,12,14,23,17,16,19,15,10,12,18,21,6,20,17,13,20,17,6,21,15,12,9,14,20,23,16,23,9,23,18};
float opT4 = 133.1;
int[] t5 = {17,23,17,13,18,21,23,22,7,9,8,13,20,11,10,19,10,
    14,12,22,19,10,17,11,21,8,15,16,19,21,17,19,8,6,
    13,13,14,19,18,23,20,24,24,13,13,19,7,6,10,8,8,10,24,19,24};

int[] radii = t1;
//for instances with no optimal shown make op 0
float op = opT1;
void setup()
{
    //noLoop();
    size(800,600);
    f = createFont("Arial",16,true);
    
    //set up the problem instance
    //int[] radii={10,40,25,15,18};
    //best result for GA=90.0
    
    //create a new algorithm instance with these radii
    greedyAlg = new GreedyPlace(radii);
    randomAlg = new RandomPlace(radii);
    //GAAlg=new GAPlace(radii);
    pop = new Population(radii);
    generation = 0;
    selectionPressure = 0.4;
    tournamentSize = 20;
    currentScreen = 0;
    GARun = false;
}

void draw()
{
    
    switch(currentScreen) {
        case 0:
           if (!screensDisplayed[0]) {
                greedy();
                screensDisplayed[0] = true; // Mark the screen as displayed
    }
            break;
        case 1:
           if (!screensDisplayed[1]) {
                random();
                screensDisplayed[1] = true; // Mark the screen as displayed
    }
            break;
        case 2:
           if (!screensDisplayed[2]) {
                GA();
                screensDisplayed[2] = true; // Mark the screen as displayed
    }
            break;
    }
    
    //Display buttons for navigation
    fill(0);
    rect(10, height - 40, 80, 30); // Previous button
    rect(width - 90, height - 40, 80, 30); // Next button
    
    fill(255);
    text("Previous", 30, height - 20);
    text("Next", width - 80, height - 20);
    
}

void mouseClicked() {
    //Check if the mouse is clicked on the Previous button
    if(mouseX > 10 && mouseX < 90 && mouseY > height - 40 && mouseY < height - 10) {
        currentScreen = (currentScreen - 1 + 3) % 3; // Ensure looping between screens
        runAlgorithm(currentScreen);
    }
    
    //Check if the mouse is clicked on the Next button
    if(mouseX > width - 90 && mouseX < width - 10 && mouseY > height - 40 && mouseY < height - 10) {
        currentScreen = (currentScreen + 1) % 3; // Ensure looping between screens
        runAlgorithm(currentScreen);
    }
}
void runAlgorithm(int screen) {
    switch(currentScreen) {
        case 0:
            greedy();
            break;
        case 1:
            random();
            break;
        case 2:
            GA();
            break;
    }
}

void GA() {
    if (GARun ==  false) {
      background(255); // clear window
      textFont(f,16);
      fill(0);
      text("GA Calculating: ", 50,50);
        while(!pop.finished) {
            //print(generation);
            generation++;
            pop.evolve(generation);
            best = pop.getBestBunch();
            best.orderedPlace();
            print("\n"+generation+" "+pop.getBestFitness()+"\n");
            
            background(255); // clear window
            textFont(f,16);
            fill(0);
            text("Bounding circle radius: " + pop.getBestFitness(), 50,50);
            best.draw();
            GARun = true;
        }
    }
    else{
        background(255); // clear window
        textFont(f,16);
        fill(0);
        text("GA PLACEMENT", 50,20);
        text("Bounding circle radius: " + pop.getBestFitness(), 50,50);
        text("Generations taken: " + generation, 50,80);
        best.draw();
    }
}
void random() {
    float boundary = randomAlg.randomPlacement();
    println("Random placement gives boundary of " + boundary);
    background(255);
    
    // draw the placement
    randomAlg.randomCircles.draw();
    fill(0);
    textFont(f,16);
    text("RANDOM PLACEMENT", 50,20);
    text("Bounding circle radius: " + boundary, 50,50); 
}
void greedy() {
    float boundary = greedyAlg.greedyPlacement();
    println("Greedy placement gives boundary of " + boundary);
    background(255);
    
    // draw the placement
    greedyAlg.greedyCircles.draw();
    fill(0);
    textFont(f,16);
    text("GREEDY PLACEMENT", 50,20);
    text("Bounding circle radius: " + boundary, 50,50); 
}
