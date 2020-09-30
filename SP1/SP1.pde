
import java.util.Random;

Game game = new Game(25, 25, 5, 5);
PFont font;

public void settings() {
  size(1001, 1001);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
}

void keyReleased()                
{
  game.onKeyReleased(key);
}

void keyPressed()
{
  game.onKeyPressed(key);
}

void draw()
{
  game.update();
  background(0); //Black
 
  int[][] board = game.getBoard();
  for (int y = 0; y < game.getHeight(); y++)
  {
    for (int x = 0; x < game.getWidth(); x++)
    {
      if(board[x][y] == 0)
      {
        fill(0,0,0);
      }
      else if(board[x][y] == 1)
      {
        fill(0,0,255);
      }
      else if(board[x][y] == 2)
      {
        fill(255,0,0);
      }
      else if(board[x][y] == 3)
      {
        fill(0,255,0);
      }
       
      else if(board[x][y] == 4)
      {
        fill(69,69,69);
      }
      stroke(100,100,100);
      rect(x*40, y*40, 40, 40);
    }
  }
  fill(255);
  text("Lifes: "+game.getPlayerLife(), 25,25);
}
