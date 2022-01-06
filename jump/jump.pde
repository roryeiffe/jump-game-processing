//Gamemodes:
boolean menumode = true;
boolean gamemode = false;
boolean helpmode = false;
//Images:
PImage image;
PImage catright;
PImage catleft;
PImage jumpingcat;
PImage jumpingcatleft;
PImage duckedcat;
PImage duckedcatleft;
//Size dimensions:
int charheight = 150;
int charwidth = 150;
int enemysize = 150;
int canvassize = 1000;
//player x motion values:
float playerx = charwidth;  
float playerxv = 0;
float playerxa = 1;
int max_player_speed = 1;
int sign;
//player y motion values:
float playery = canvassize-charheight*2;     
float playeryv = 0;
float playerya = 0;
//enemy values:
int enemyx = 410;        
float enemyy = canvassize - charheight*2;
int enemyspeed = 4;
//point values:
int score = 0;           
int money = 0;
//powerups:
boolean powerupexists = false;
boolean tunacan = false;
float randint;
//Misc:
boolean hit = false;

void setup() { 
  size(1000, 1000);       //setup
  frameRate(150);



  catright = loadImage("cat.jpg");
  catright.resize(charwidth, charheight);
  catleft = loadImage("catleft.jpg");
  catleft.resize(charwidth, charheight);

  jumpingcat = loadImage("jumpingcat.jpg");
  jumpingcat.resize(charwidth, charheight);
  jumpingcatleft = loadImage("jumpingcatleft.jpg");
  jumpingcatleft.resize(charwidth, charheight);

  duckedcat = loadImage("duckedcat.jpg");
  duckedcat.resize(charwidth, charheight);
  duckedcatleft = loadImage("duckedcatleft.jpg");
  duckedcatleft.resize(charwidth, charheight);



  image = catright;
}
//default image




void draw()
{
  if (menumode) {
    //Clicking Stuff:
    if (mouseX > 250 & mouseX < 750 & mouseY > 400 & mouseY < 650) {
      fill(8, 255, 17);
      if (mousePressed) {
        gamemode = true;
        menumode = false;
      }
    } else {
      fill(255, 0, 0);
    }
    //Menu Stuff:
    background(255,255,255);
    stroke(255, 255, 255);
    strokeWeight(3);
    rect(250, 400, 500, 250);
    textSize(150);
    fill(0, 0, 0);
    text("Start", canvassize - canvassize/1.5, canvassize - canvassize/2.3);
    fill(255, 0, 0);
    rect(300,700,400,100);
    if (mouseX > 250 & mouseX < 750 & mouseY > 400 & mouseY < 650) {
      fill(8, 255, 17);
      if (mousePressed) {
        gamemode = true;
        menumode = false;
      }
    } else {
      fill(255, 0, 0);
    }
    
  }
  if (helpmode & (gamemode || menumode) == false) {
    

  }



  if (gamemode == true) {

    hit = false;
    background(255,255,255); //background
    textSize(26);                //Displaying the score
    text(" Score:", 250, 50);
    text(score, 350, 50);
    text("Money:", 250, 100);
    text(money, 350, 100);

    fill(0, 38, 255);
    image(image, playerx, playery);     //The player

    if (keyPressed) {       //The different motions (up, left, right)
      if ((key == 'D' || key == 'd')) {
        playerxv += 15;
        playerxa = 15;
        sign = -1;
      }
      if ((key == 'A' || key == 'a')) {
        playerxa = -15;
        playerxv -= 15;
        sign = 1;
      }
    }

    if (keyPressed) {
      if (playeryv == 0 & (key == 'W' || key == 'w')) {
        playeryv = 7;
        playerya = 0.08;
      }
    }

    //Pictures
    if (playeryv > 0) {
      if (playerxv > 0) {
        image = jumpingcat;
      }
      if (playerxv < 0) {
        image = jumpingcatleft;
      }
    }
    if (playeryv == 0) {
      if (playerxv > 0) {
        image = catright;
      }
      if (playerxv < 0) {
        image = catleft;
      }
    }


    if (keyPressed) {
      if ((key == 's' || key == 'S') & (playery == canvassize - 300)) {
        charheight = 75;
        playerxv = 0;
        if (image == catright) {
          image = duckedcat;
        }
        if (image == catleft) {
          image = duckedcatleft;
        }
      } else {
        charheight = 150;
      }
    }

    // motion
    playerx += playerxv;
    playerxv += playerxa*sign;
    playerxa = -sign*(abs(playerxa) - 0.05);
    playerxv = -sign * max(playerxv, max_player_speed);

    playeryv = playeryv - playerya;
    playery = playery - playeryv;









    // bounds
    if (playerx >= canvassize - charwidth) {
      playerx = canvassize - charwidth -2;
    }
    if (playerx <= 0) {
      playerx = 2;
    }
    if (playery >= canvassize-150*2) {
      playerxv = 0;
      playeryv = 0;
      playery = canvassize-150*2;
      playerya = 0;
      playerxv = 0;
    }






    fill(255, 0, 0);
    rect(enemyx, enemyy, enemysize, enemysize);
    enemyx -= enemyspeed;

    if ((enemyx <=playerx + charwidth) & (enemyx >= playerx - charwidth) & (playery >enemyy - charheight) & (playery < enemyy + charheight)) {
      score = 0;
      hit = true;
      enemyx = canvassize + charwidth;
      playerx = 50;
      playery = canvassize - charheight - 2;
      enemyy = canvassize - (300 + 50 * random(0, 6));
    }

    if (enemyx <= -50 & hit == false) {
      enemyx = canvassize + charwidth + 50;
      score ++;
      money ++;
      enemyy = canvassize - (300 + 50 * random(0, 6));
    }





    //PowerupStuff
    randint = random(0, 1000);
    println(randint);
    if (99 <= randint & randint <= 99.5) {
      powerupexists = true;
      tunacan = true;
    }
  }
};