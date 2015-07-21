class HYDRA
{
  final int LENGTH = height*2/3; //300;
  final float POINTS_DIST = 3;//distance between each point
  final int NB_POINTS = (int)(LENGTH/POINTS_DIST);
  final float AMPLITUDE = random(1.5, 2);
  final float MIN_SPEED = .2;//min 'elastic speed' of each segment
  final float MAX_SPEED = .99;//max 'elastic speed' of each segment
  final float period = random(.5, 5);//number of 'complete waves' per Hydra
  final float step = random(.02, .20);//speed of the wave
  final float PERIODS = random(1.2, 2);
  final float s = TWO_PI * PERIODS / NB_POINTS;
  float hspread = 30; // spread of worms across field, higher is tighter
  float vspread = 30;
  float radius;
  PVector[] pos = new PVector[NB_POINTS];
  float angle;
  PVector D;//default delta when at rest
  float time = random(123456);//used to cycle the oscillation
  color[] colors = new color[NB_POINTS];
  float colorAdjust = random(0, 20);
  
  HYDRA(float p_radius, float p_angle, float x, float y)
  {
    int xx,yy;
    xx = round(map(x,0.0,1.0,0.0,(float)width));
    yy = height -  round(map(y,0.0,1.0,0.0,(float)height));
    angle = p_angle;
    radius = p_radius;
    D = new PVector(POINTS_DIST*cos(angle), POINTS_DIST*sin(angle));
    for (int i = 0; i < NB_POINTS; i++)
    {
      pos[i] = new PVector(xx, yy);    
      colors[i] = 0;
    }
  }
 
  void process(PVector point)
  {
    time += step;
    //this was used for worms to follow the mouse 
    //pos[0] = new PVector(mouseX + radius * cos(angle), mouseY + radius * sin(angle));
    //pos[0] = new PVector(0,height);
    
    // I would *like* the arm direction to be affected by the mouse,
    // it kind of looks like just the length is? 
    for (int i = 1; i < NB_POINTS; i++)
    {
      PVector delta = new PVector(pos[i].x - pos[i-1].x, pos[i].y - pos[i-1].y);
      float coeff = map(i, 0, NB_POINTS, MIN_SPEED, MAX_SPEED);
      
     //delta.x += 0.1 * coeff * (pos[i].x - mouseX)/width;
     //delta.y += 0.03 * i * (pos[i].y - mouseY);
      
      delta.x -= coeff * (delta.x - D.x);
      delta.y -= coeff * (delta.y - D.y);
      

      //repulsed from cursor?
      float close = 1;
      float tmpX = i * period / NB_POINTS;
      float tmpY = AMPLITUDE * sin(i * s + time) * cos(HALF_PI + HALF_PI * i / NB_POINTS);
      delta.x += tmpX * cos(angle) - tmpY * sin(angle);//angle roatation of the oscillation
      delta.y += tmpX * sin(angle) + tmpY * cos(angle);//angle roatation of the oscillation
 
      close = dist(pos[i].x,pos[i].y,point.x,point.y)/width;
 
      delta.normalize();
      delta.mult(POINTS_DIST*close);
 
      pos[i].x = pos[i-1].x + delta.x;
      pos[i].y = pos[i-1].y + delta.y;
      //pos[i].x += 0.01 * (abs(pos[i].x - mouseX));
      //pos[i].x += 0.0001 * i * mouseX;
      //println(sqrt(abs(mouseX - pos[i].x)), pos[i].x);
      //pos[i].y += 0.0001 * i * mouseY;
    }
  }
 
  void render(int p_rank)
  {
    //line(pos[p_rank-1].x, pos[p_rank-1].y, pos[p_rank].x, pos[p_rank].y);
    //noStroke();
    //fill(constrain(2.2*(NB_POINTS-p_rank) - 20, 0, 250));
    //fill(map(p_rank, NB_POINTS, 0, 0, 250));
    stroke (255, 130, 11, 20);
    fill(255,255, 255);

    ellipse(pos[p_rank].x, pos[p_rank].y, 10,10);//(int)sqrt(10*(NB_POINTS-p_rank)), (int)sqrt(10*(NB_POINTS-p_rank)));
  }
}

