// Original code/math formulas taken from Copyright by Diana Lange 2014
// mail: kontakt@diana-lange.de
// web: diana-lange.de


final int NB_HYDRA = 10;
final float CELL_RADIUS = 45;
HYDRA[] tabHYDRA = new HYDRA[NB_HYDRA];
HYDRA[] secondHYDRA = new HYDRA[NB_HYDRA];
HYDRA[] centerHYDRA = new HYDRA[NB_HYDRA];
import de.voidplus.leapmotion.*;

//sets up Leap
LeapMotion leap;

//Test week one, drawing dots on the canvas
int height = 400;
int width = 600;

PImage imgB; 

void setup()
{
  size(width, height, P3D);
   imgB = loadImage("corals.jpg");
   // leap = new LeapMotion(this).withGestures("circle, swipe, screen_tap, key_tap");
  // leap = new LeapMotion(this).withGestures("swipe"); // Leap detects only swipe gestures.
   leap = new LeapMotion(this).withGestures();
  
  //  strokeCap(ROUND);
  //  strokeJoin(ROUND);
   
  for (int i = 0; i < NB_HYDRA; i++)
  {
    //this creates each arm (1/arm)
      centerHYDRA[i] = new HYDRA(CELL_RADIUS, -PI/2, 0.3+i*0.015,0.0);
     tabHYDRA[i] = new HYDRA(CELL_RADIUS, ((float)i/NB_HYDRA)*(-PI/2), 0.0, 0.0);
     secondHYDRA[i] = new HYDRA(CELL_RADIUS, ((float)i/NB_HYDRA)*(PI/2) + PI*3, 1.0, 0.0);
  }
}
 
void draw()
{
  //for coordinates fetched from the leap
 PVector pointFinger=new PVector();
 // for coordinates scaled to screen 
 PVector cursor=new PVector(); 
 
 for (Hand hand : leap.getHands ()) {
   //this gets position of Finger
    pointFinger=hand.getFrontFinger().getPosition();
  }
  //this is to scale it to the screen coordinates
  cursor.x=map(pointFinger.x, -10.0, 10.0, 0, width);
  cursor.y=map(pointFinger.x, -10.0, 10.0, 0, width);
  image(imgB, 0, 0);
  noStroke();
  

  for (int i = 0; i < NB_HYDRA; i++)
  {
    tabHYDRA[i].process(pointFinger);
    secondHYDRA[i].process(pointFinger);
    centerHYDRA[i].process(pointFinger);

  }
  for (int i = tabHYDRA[0].NB_POINTS-1; i >= 0; i--)//draw the tips first
  {
    for (int j = 0; j < NB_HYDRA; j++)
    {
      tabHYDRA[j].render(i);
      secondHYDRA[j].render(i);
      centerHYDRA[j].render(i);
    }
  }
}


