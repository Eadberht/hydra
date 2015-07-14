// Original code/math formulas taken from Copyright by Diana Lange 2014
// mail: kontakt@diana-lange.de
// web: diana-lange.de

final int NB_HYDRA = 100;
final float CELL_RADIUS = 45;
HYDRA[] tabHYDRA = new HYDRA[NB_HYDRA];


PImage imgB; 

void setup()
{
  size(600, 400, P3D);
   imgB = loadImage("background.jpg");
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


