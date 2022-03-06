String url;
ArrayList<Planet> planets;
int distance;
Planet sun;
float x, y, z, radius;
boolean has_moon, ship_view;
int w, a, s, d, e, q, au, ad;
PShape ship;
float z_axis, z_angle, ship_speed, look_angle;
PVector xy_axis, xy_angle, xy_eye, cam_adjust;


void setup(){
  size(1920, 1080, P3D);
  url = "sun.jpg";
  distance = 150;
  x=0;
  y=0;
  z=0;
  w=0;
  a=0;
  s=0;
  d=0;
  e=0;
  q=0;
  au=0;
  ad=0;
  radius = 80;
  z_axis = 20;
  z_angle = 0;
  look_angle = 0;
  xy_axis = new PVector(400, 400);
  xy_angle = new PVector(960,540);
  xy_eye = new PVector(0,1);
  cam_adjust = new PVector(0,100);
  ship_view=false;
  ship = createShape(BOX,10);
  ship_speed = 0;
  sun = new Planet(x, y, z, radius, url, "Sol",false);
  planets = new ArrayList<Planet>();
  url="planet.jpg";
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(10,20), y + random(-10,10), z, random(25,50), url, "Planeta1", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(120,150), y + random(-15,15), z, random(25,50), url, "Planeta2", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(250,350), y + random(-20,20), z, random(25,50), url, "Planeta3", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(500,630), y + random(-30,30), z, random(25,50), url, "Planeta4", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(800,1000), y + random(-50,50), z, random(25,50), url, "Planeta5", has_moon));
}

void draw(){
  background(200);
  print_all();
}



void print_all(){
  translate(width/2,height/2,0);
  rotateX(radians(-50));
  pushMatrix();
  sun.print_planet();
  sun.update_pos();
  translate(x,y,z);
  for (Planet planet : planets) {
    planet.print_planet();
    planet.update_pos();
  }
  popMatrix();
  pushMatrix();
  move_ship();
  popMatrix();
  if(ship_view){
    camera(xy_axis.x, xy_axis.y, z_axis, xy_angle.x, xy_angle.y, z_axis+z_angle, xy_eye.x, xy_eye.y, 0);
  } else{
    print_ship();
    camera();
  }
}

void print_ship(){
  translate(xy_axis.x,xy_axis.y,z_axis);
  shape(ship);
}

void move_ship(){
  if(e==1){
    if(ship_speed<5){
      ship_speed += 0.01;
    }
  }
  if(q==1){
    if(ship_speed>0){
      ship_speed -= 0.01;
    }
  }
  if(w==1){
    z_axis += 5;
  }
  if(s==1){
    z_axis -= 5;
  }
  if(d==1){
    look_angle -= 0.05;
    if(look_angle<0){
      look_angle+=360;
    }
  }
  if(a==1){
    look_angle += 0.05;
    if(look_angle>360){
      look_angle-=360;
    }
  }
  if(au==1){
    z_angle += 5;
  }
  if(ad==1){
    z_angle -= 5;
  }
  
  xy_angle.x = xy_axis.x + 10 * sin(look_angle);
  xy_angle.y = xy_axis.y + 10 * cos(look_angle);
  xy_eye = xy_angle.copy();
  xy_eye.rotate(-PVector.angleBetween(cam_adjust,xy_angle));
  xy_axis.x += ship_speed*sin(look_angle);
  xy_axis.y += ship_speed*cos(look_angle);
}

void keyPressed(){
  if(keyCode == 87){
    w = 1;
  }
  if(keyCode == 65){
    a = 1;
  }
  if(keyCode == 83){
    s = 1;
  }
  if(keyCode == 68){
    d = 1;
  }
  if(keyCode == 69){
    e = 1;
  }
  if(keyCode == 81){
    q = 1;
  }
  if(keyCode == UP){
    au = 1;
  }
  if(keyCode == DOWN){
    ad = 1;
  }
  if(keyCode == ' '){
    ship_view= !ship_view;
  }
}

void keyReleased(){
  if(keyCode == 87){
    w = 0;
  }
  if(keyCode == 65){
    a = 0;
  }
  if(keyCode == 83){
    s = 0;
  }
  if(keyCode == 68){
    d = 0;
  }
  if(keyCode == 69){
    e = 0;
  }
  if(keyCode == 81){
    q = 0;
  }
  if(keyCode == UP){
    au = 0;
  }
  if(keyCode == DOWN){
    ad = 0;
  }
}


class Planet{

  private PShape planet_shape;
  private PImage planet_texture;
  private float x, y, z, radius, degrees, speed;
  private String name;
  private boolean has_moon;
  private Planet moon;
  
  Planet(float x, float y, float z, float radius, String url, String name, boolean has_moon){
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.degrees = 0;
    this.speed = random(0.1, 1.0);
    this.name = name;
    this.planet_shape = createShape(SPHERE, this.radius);
    this.planet_texture = loadImage(url);
    this.planet_shape.setTexture(this.planet_texture);
    this.planet_shape.setStroke(0);
    this.has_moon = has_moon;
    if(has_moon){
      url="moon.jpg";
      moon = new Planet(radius + random(25,40),y,z,random(10,20),url,"Luna",false);
    }else{
      this.moon=null;
    }
  }
  
  void update_pos(){
    this.degrees += this.speed;
    if(this.degrees >=360) this.degrees -= 360;
  }
  
  void print_planet(){
    pushMatrix();
    rotateY(radians(this.degrees));
    translate(this.x, this.y, this.z);
    text(this.name, 0, - (this.radius + 25));
    shape(this.planet_shape);
    if(this.has_moon){
      rotateY(radians(this.moon.degrees));
      translate(this.moon.x, this.moon.y, this.moon.z);
      text(this.moon.name, 0, - (this.moon.radius + 25));
      shape(this.moon.planet_shape);
      this.moon.update_pos();
    }
    popMatrix();
  }
}
