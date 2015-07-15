// Original code/math formulas taken from Copyright by Diana Lange 2014
// mail: kontakt@diana-lange.de
// web: diana-lange.de


final int NB_HYDRA = 100;
final float CELL_RADIUS = 45;
HYDRA[] tabHYDRA = new HYDRA[NB_HYDRA];
import de.voidplus.leapmotion.*;

//sets up Leap
LeapMotion leap;

//Test week one, drawing dots on the canvas
int height = 600;
int width = 400;

PImage imgB; 

void setup()
{
  size(600, 400, P3D);
   imgB = loadImage("background.jpg");
   // leap = new LeapMotion(this).withGestures("circle, swipe, screen_tap, key_tap");
  // leap = new LeapMotion(this).withGestures("swipe"); // Leap detects only swipe gestures.
   leap = new LeapMotion(this).withGestures();
  
  //  strokeCap(ROUND);
  //  strokeJoin(ROUND);
   
  for (int i = 0; i < NB_HYDRA; i++)
  {
    //this creates each arm (1/arm)
    tabHYDRA[i] = new HYDRA(CELL_RADIUS, i * TWO_PI / NB_HYDRA, random(1), random(1));
  }
}
 
void draw()
{
 for (Hand hand : leap.getHands ()) {
    println(hand.getFrontFinger().getPosition());
  }
  
  image(imgB, 0, 0);
  noStroke();
  

  for (int i = 0; i < NB_HYDRA; i++)
  {
    tabHYDRA[i].process();
  }
  for (int i = tabHYDRA[0].NB_POINTS-1; i >= 0; i--)//draw the tips first
  {
    for (int j = 0; j < NB_HYDRA; j++)
    {
      tabHYDRA[j].render(i);
    }
  }
}


