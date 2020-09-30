import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  //angiver et array for føde
  private Dot[] food;
  private int maxPlayerLife = 100;
  private int minPlayerLife = 0;

  // private int randomSpawn = random((25,25(25,5))

  //som jeg så sætter ind i parameteren
  Game(int width, int height, int numberOfEnemies, int amountOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(0, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    food  = new Dot[amountOfFood];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    for (int i = 0; i < amountOfFood; ++i)
    {
      food[i] = new Dot(width-1, height-1, width-1, height-1);
    }


    this.playerLife = maxPlayerLife;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }

  public void update()
  {
    updatePlayer();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
    //Update player2
    if (keys.wDown() && !keys.sDown())
    {
      player2.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player2.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player2.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //flyt efter spiller eller random
      if (rnd.nextInt(3) < 2)
      {

        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int dx2 = player2.getX() - enemies[i].getX();
        int dy2 = player2.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
        //player 2
        if (abs(dx2) > abs(dy2))
        {
          if (dx2 > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy2 > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }

        {
          //We move randomly
          int move = rnd.nextInt(4);
          if (move == 0)
          {
            //Move right
            enemies[i].moveRight();
          } else if (move == 1)
          {
            //Move left
            enemies[i].moveLeft();
          } else if (move == 2)
          {
            //Move up
            enemies[i].moveUp();
          } else if (move == 3)
          {
            //Move down
            enemies[i].moveDown();
          }
        }
      }
    }
  }
  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {

      if (rnd.nextInt(3) < 2)
      {
        //We avoid
        int dx = player.getX() - food[i].getX();
        int dy = player.getY() - food[i].getY();
        int dx2 = player.getX() - food[i].getX();
        int dy2 = player.getY() - food[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the left
            food[i].moveLeft();
          } else
          {
            //Player is to the right
            food[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is up;
          food[i].moveUp();
        } else
        {//Player is down;
          food[i].moveDown();
        }
        //player 2
        if (abs(dx2) > abs(dy2))
        {
          if (dx2 > 0)
          {
            //Player is to the left
            food[i].moveLeft();
          } else
          {
            //Player is to the right
            food[i].moveRight();
          }
        } else if (dy2 > 0)
        {
          //Player is up;
          food[i].moveUp();
        } else
        {//Player is down;
          food[i].moveDown();
        }
      } else
      {

        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 1)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 2)
        {
          //Move down
          food[i].moveDown();
        } else if (move == 3)
        {
          //Move up
          food[i].moveUp();
        }
      }
    }
  }
  private void populateBoard()
  {
    //Insert player 1 but only if he has any lives left
    if (playerLife>minPlayerLife) {

      board[player.getX()][player.getY()] = 1;
    }
    //inset player 2
    if (playerLife>minPlayerLife) {

      board[player2.getX()][player2.getY()] = 1;
    }
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert food
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3; //farvelægger den til grøn samt sætter det i spillet
    }
  }

  private void checkForCollisions()

  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision and we can no longer get in life debt:-)
        --playerLife;
        if (playerLife<minPlayerLife) {
          playerLife = minPlayerLife ;
        }
        for (int i1 = 0; i1 < food.length; ++i1)
        {
          if (food[i1].getX() == player.getX() && food[i1].getY() == player.getY())
          {
            //ved kollision så giv 1 liv. 
            ++playerLife;
            if (playerLife>maxPlayerLife) {
              playerLife = maxPlayerLife;
            }
          }
        }
      }
    }
  }
}
