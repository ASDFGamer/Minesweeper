Field field; 

final static int STANDARD_SIZE = 32;

Button restart;

GameStatus status = GameStatus.playing;

int gameHeight = 800;
int gameWidth = 800;

void setup() {
  size(800, 900);
  textSize(STANDARD_SIZE);
  startGame();
  showButtons();
}

void draw() {
}

void keyPressed() {
  if (key == ESC) {
    print("Exit");
    exit();
  }
}

void mousePressed()
{
  if (buttonsPressed())
  {
    return;
  }
  if ( status != GameStatus.playing)
  {
    return;
  }
  status = field.update();
  if (status == GameStatus.win)
  {
    win();
  } else if (status == GameStatus.gameOver) {
    gameOver();
    //startGame();
  }
}

boolean buttonsPressed()
{
  if (restart.isPressed())
  {
    startGame();
    return true;
  }
  return false;
}

void showButtons()
{
  restart = new Button(150, 50);
  restart.setPos(width/2, height-((height-gameHeight)/2));
  restart.show();
  restart.setText("Restart");
}

void win()
{
  status = GameStatus.win;
  println("Win");
  text("You have won!", height/2, width/2);
}

void gameOver()
{
  status = GameStatus.gameOver;
  println("GameOver");
  showTextField("Game Over!");
}

void startGame()
{
  field = new Field(10, 10);
  field.show(gameHeight, gameWidth);
  status =GameStatus.playing;
}

void showTextField(String text)
{
  fill(240, 128);
  rect(gameHeight/2, gameWidth/2, gameHeight, gameWidth);
  textSize(64);
  fill(0);
  textAlign(CENTER);
  text(text, gameHeight/2, gameWidth/2);
  fill(255);
  textSize(STANDARD_SIZE);
}
