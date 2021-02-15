import processing.sound.*;
SoundFile hit;
SoundFile score;

//ball
float ball_x, ball_y, ball_rad;
float ball_speed_x;
float ball_speed_y;

int a_y;
int b_y;

int paddle_x;

int paddle_width = 50;
int paddle_height = 100;

int prob;

float global_speed = 2;
float gspeed;
float inc_speed = 0.25; //Bola
int paddle_speed = 3;

int score_a = 0;
int score_b = 0;

void setup() {
  hit = new SoundFile(this, "Hit11.wav");
  score = new SoundFile(this, "Hit10.wav");
  frameRate(200);
  size(750, 500);
  background(0);

  ball_rad = 15;
  ball_x = width/2;
  ball_y = height/2;
  
  a_y = height/2;
  b_y = height/2;
  
  prob = round(random(100));
  if (prob > 50){
    //Derecha
    ball_speed_x = global_speed;
    ball_speed_y = round(random(-global_speed, global_speed));
  } else {
    ball_speed_x = -global_speed;
    ball_speed_y = round(random(-global_speed, global_speed));
  }
  
  paddle_x = 100;

  paddle_width = 16;
  paddle_height = 100;
  
  gspeed = global_speed;
}

void draw() {
  //background(map(mouseX,0,255,0,width),map(mouseY,0,255,0,height), ball_x);
  background(0);
  stroke(255);
  strokeWeight(3);
  
  textSize(100);
  fill(255);
  text(score_b, (width/2) + 75, height/4);
  text(score_a, (width/2) - 200, height/4);
  
  for (int i = 0; i < 10; i++){
    line(width/2, i * 50, width/2, i * 50 + 25);
  }
  noStroke();
  
  int paddle_a_center_x = paddle_x - paddle_width/2;
  int paddle_a_center_y = a_y;
  int paddle_b_center_x = width - paddle_x - paddle_width + paddle_width/2;
  int paddle_b_center_y = b_y;
  
  ball_x = ball_x + ball_speed_x;
  ball_y = ball_y + ball_speed_y;
  
  circle(ball_x, ball_y, ball_rad);
  rect(paddle_a_center_x, a_y - paddle_height/2, paddle_width, paddle_height);
  rect(paddle_b_center_x, b_y - paddle_height/2, paddle_width, paddle_height);
  
  //Teclas
  if (keyPressed) {
    if (key == 'w'){
      a_y -= paddle_speed;
      print("up\n");
    }
    
    if (key == 's'){
      a_y += paddle_speed;
      print("down\n");
    }
    
    if (keyCode == UP){
      b_y -= paddle_speed;
      print("up\n");
    }
    
    if (keyCode == DOWN){
      b_y += paddle_speed;
      print("down\n");
    }
  }
  
  //Condiciones de punto
  //Gana izquierdo
  if (ball_x + ball_rad/2 > width) {
    ball_x = width/2;
    ball_y = height/2;
    
    score_a++;
    gspeed = global_speed;
    
    //La bola se saca hacia el derecho
    ball_speed_x = -gspeed;//round(random(-3,3));
    score();
    //ball_speed_x = -ball_speed_x;
  }

  //Gana derecho
  if (ball_x - (ball_rad/2) < 0) {
    ball_x = width/2;
    ball_y = height/2;
    
    score_b++;
    gspeed = global_speed;
    
    //La bola se saca hacia el izquierdo
    ball_speed_x = gspeed;//round(random(-3,3));
    score();
  }

  //Colisiones
  //Paredes
  if (ball_y + (ball_rad/2) > height || ball_y - (ball_rad/2) < 0) {
    ball_speed_y = -ball_speed_y;
  }

  //Palas
  //Pala izquierda
  if ((ball_x - ball_rad/2 < paddle_a_center_x + paddle_width) &&
      (ball_x + ball_rad/2 > paddle_a_center_x - paddle_width) &&
      (ball_y - ball_rad/2 > paddle_a_center_y - paddle_height/2) &&
      (ball_y + ball_rad/2 < paddle_a_center_y + paddle_height/2)) {
    ball_speed_x = abs(gspeed);
    bounce();
  }
  
  //Pala derecha
  if ((ball_x - ball_rad/2 < paddle_b_center_x + paddle_width) &&
      (ball_x - ball_rad/2 > paddle_b_center_x - paddle_width) &&
      (ball_y - ball_rad/2 > paddle_b_center_y - paddle_height/2) &&
      (ball_y + ball_rad/2 < paddle_b_center_y + paddle_height/2)) {
    ball_speed_x = -abs(gspeed);
    bounce();
  }
}

void bounce(){
  hit.play();
  //gspeed = gspeed + inc_speed;
  ball_speed_y = round(random(-gspeed, gspeed));
  //a_y = 0;
  //b_y = 0;
}

void score(){
  score.play();
  ball_speed_y = round(random(-gspeed, gspeed));
  a_y = height/2;
  b_y = height/2;
}
