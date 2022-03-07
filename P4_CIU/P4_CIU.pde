String url;
ArrayList<Planet> planets;
int distance, planet_selected, i;
Planet sun;
float x, y, z, radius, temp_x, temp_y;
boolean has_moon, simulation_started, up_pressed, down_pressed, ship_view, q_pressed, e_pressed, w_pressed,a_pressed,s_pressed,d_pressed;
PShape ship;
PImage ship_img;
float ship_speed;
PVector ship_pos, ship_look, ship_v, aux;



void setup(){
  size(1920, 1080, P3D);
  url = "sun.jpg";
  distance = 150;
  x=0;
  y=0;
  z=0;
  i=0;
  radius = 80;
  sun = new Planet(x, y, z, radius, url, "Sol",false);  
  create_planets();
  temp_x=0.0;
  temp_y=0.0;
  create_ship();
  
  //controls
  ship_view=false;
  q_pressed=false;
  e_pressed=false;
  w_pressed=false;
  a_pressed=false;
  s_pressed=false;
  d_pressed=false;
  up_pressed=false;
  down_pressed=false;
  planet_selected=6; // 6 = all planets, 1 = innermost, 5 = outermost
}



void draw(){
  if(simulation_started){
    background(0);
    textSize(18);
    text("Pulsa M/ENTER para volver a inicio, planeta elegido: "+planet_selected,width/2,height/10);
    print_system();
    move_ship();
    if(ship_view){
      see_ship();
    }else{
      print_ship();
      camera();
    }
  }else{
    print_welcome();
  }
}



void create_planets(){
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


void create_ship(){
  ship_pos = new PVector(200,200,200);
  ship_look = new PVector(0,1,0);
  ship_v = new PVector(0,1,0);
  ship_img = loadImage("ship_img.png");
  beginShape();
  ship = createShape(SPHERE, 10);
  ship.setStroke(255);
  ship.setTexture(ship_img);
  endShape(CLOSE);
}


void print_welcome(){
  background(128);
  textAlign(CENTER);
  textSize(32);
  text("Simulación de un sistema planetario simple con nave",width/2,height/8); 
  text("Pulsa enter o 'M' para empezar",width/2,height/6);
  text("Pulsa 'R' para cambiar la configuración de los planetas",width/2,height/4);
  text("Pulsa del 1 al 5 para elegir planeta, o 6 para elegir a todos",width/2,height/2.8);
  text("Pulsa la tecla UP para acelerar el planeta elegido",width/2,height/2.3);
  text("Pulsa la tecla DOWN para detener el planeta elegido",width/2,height/1.9);
  text("Pulsa la tecla 'V' para cambiar entre la vista general y la vista de la nave",width/2,height/1.6);
  text("Pulsa las teclas 'W', 'A', 'S', 'D' para mover la cámara",width/2,height/1.4);
  text("Pulsa las teclas 'E' y 'Q' para acelerar y decelerar",width/2,height/1.25);
}


void print_system(){
  translate(width/2,height/2,0);
  rotateX(radians(-45));
  pushMatrix();
  sun.print_planet();
  sun.update_pos();
  translate(x,y,z);
  i=0;
  for (Planet planet : planets) {
    i++;
    if(planet_selected==i || planet_selected == 6){
      if(up_pressed){
        planet.update_pos_extra(true);
      } else if(down_pressed){
        planet.update_pos_extra(false);
      }
    }
    planet.print_planet();
    planet.update_pos();
  }
  popMatrix();
}


void move_ship(){
  ship_pos.add(PVector.mult(ship_look,ship_speed));
  if(q_pressed){
    if(ship_speed>=(-1.5)){
      ship_speed-=0.01;
    }
  }
  if(e_pressed){
    if(ship_speed<=2.0){
      ship_speed+=0.01;
    }
  }
  if(w_pressed){
    temp_y -= 1;
    temp_y = temp_y % 360;
  }
  if(s_pressed){
    temp_y += 1;
    temp_y = temp_y % 360;
  }
  if(a_pressed){
    temp_x -= 1;
    temp_x = temp_x % 360;
  }
  if(d_pressed){
    temp_x += 1;
    temp_x = temp_x % 360;
  }
  aux = new PVector(cos(radians(temp_x))*cos(radians(temp_y)),sin(radians(temp_y)),sin(radians(temp_x))*cos(radians(temp_y)));
  aux.normalize();
  ship_look = aux;
}


void print_ship(){
  translate(ship_pos.x,ship_pos.y,ship_pos.z);
  shape(ship);
}


void see_ship(){
  aux = PVector.add(ship_pos,ship_look);
  camera(ship_pos.x,ship_pos.y,ship_pos.z,aux.x,aux.y,aux.z,ship_v.x,ship_v.y,ship_v.z);
}


void keyPressed(){
  if((key == 'q' || key == 'Q')&&simulation_started){
    q_pressed=true;
  }
  if((key == 'e' || key == 'E')&&simulation_started){
    e_pressed=true;
  }
  if((key == 'a' || key == 'A')&&simulation_started){
    a_pressed=true;
  }
  if((key == 'd' || key == 'D')&&simulation_started){
    d_pressed=true;
  }
  if((key == 'w' || key == 'W')&&simulation_started){
    w_pressed=true;
  }
  if((key == 's' || key == 'S')&&simulation_started){
    s_pressed=true;
  }
  if((key == 'v' || key == 'V')&&simulation_started){
    ship_view=!ship_view;
  }
  if(key == 'r' || key == 'R'){
    create_planets();
  }
  if(keyCode == ENTER || key == 'm' || key == 'M'){
    planet_selected=6;
    simulation_started = !simulation_started;
  }
  if(key == '1'){
    planet_selected=1;
  }
  if(key == '2'){
    planet_selected=2;
  }
  if(key == '3'){
    planet_selected=3;
  }
  if(key == '4'){
    planet_selected=4;
  }
  if(key == '5'){
    planet_selected=5;
  }
  if(key == '6'){
    planet_selected=6;
  }
  if(keyCode == UP){
    up_pressed=true;
  }
  if(keyCode == DOWN){
    down_pressed=true;
  }
}


void keyReleased(){
  if(keyCode == UP){
    up_pressed=false;
  }
  if(keyCode == DOWN){
    down_pressed=false;
  }
  if(key == 'q' || key == 'Q'){
    q_pressed=false;
  }
  if(key == 'e' || key == 'E'){
    e_pressed=false;
  }
  if(key == 'w' || key == 'W'){
    w_pressed=false;
  }
  if(key == 'a' || key == 'A'){
    a_pressed=false;
  }
  if(key == 's' || key == 'S'){
    s_pressed=false;
  }
  if(key == 'd' || key == 'D'){
    d_pressed=false;
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
    this.planet_texture = loadImage(url);
    beginShape();
    this.planet_shape = createShape(SPHERE, this.radius);
    this.planet_shape.setStroke(255);
    this.planet_shape.setTexture(this.planet_texture);
    endShape(CLOSE);
    this.has_moon = has_moon;
    if(has_moon){
      url="moon.jpg";
      moon = new Planet(radius + random(25,40),y,z,random(10,20),url,"Luna",false);
      url="planet.jpg";
    }else{
      this.moon=null;
    }
  }

  
  void update_pos(){
    this.degrees += this.speed;
    if(this.degrees >=360) this.degrees -= 360;
  }
  
  
  void update_pos_extra(boolean positive){
    if(positive){
      this.degrees += this.speed;
      if(this.degrees >=360) this.degrees -= 360;
    } else{
      this.degrees -= this.speed;
      if(this.degrees <=0) this.degrees += 360;
    }
  }
  
  void print_planet(){
    pushMatrix();
    rotateY(radians(this.degrees));                      // update matrix to planet position
    translate(this.x, this.y, this.z);
    pushMatrix();
    rotateY(radians(-this.degrees));                    //  adjust for text
    rotateX(radians(45));
    text(this.name, 0, - (this.radius + 25));
    popMatrix();                                        // rollback text adjustment
    shape(this.planet_shape);
    if(this.has_moon){
      this.moon.update_pos();
      rotateY(radians(this.moon.degrees));              //  update matrix to moon position
      translate(this.moon.x, this.moon.y, this.moon.z);
      pushMatrix();
      rotateY(radians(-this.moon.degrees));
      rotateY(radians(-this.degrees));                  //  adjust for text
      rotateX(radians(45));
      text(this.moon.name, 0, - (this.moon.radius + 25));
      popMatrix();                                      //  rollback text adjustment
      shape(this.moon.planet_shape);
    }
    popMatrix();
  }
}
