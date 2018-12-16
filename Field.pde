public class Field {

  final int fieldWidth;

  final int fieldHeight;

  final int tileCount;

  final Tile[][] tiles;

  final int bombs;

  int tilesShown = 0;
  int tilesMarked = 0;

  public Field(int fieldWidth, int fieldHeight)
  {
    if (fieldHeight<2 || fieldWidth<2)
    {
      throw new IllegalArgumentException("The Field must have a minimum width and hight of 2");
    }
    this.fieldWidth = fieldWidth;
    this.fieldHeight = fieldHeight;
    this.tileCount = fieldHeight*fieldWidth;
    this.bombs = initBombs();
    this.tiles = createTiles();

    initTiles();
  }

  private int initBombs() {
    int bombs = int(tileCount/10);
    if (bombs > fieldHeight* fieldWidth)
    {
      bombs = tileCount-1;
    }
    return bombs;
  }

  private Tile[][] createTiles()
  {
    Tile[][] tiles = new Tile[fieldWidth][fieldHeight];
    boolean[][] bombs = createBombs();
    for (int x = 0; x< fieldWidth; x++)
    {
      for (int y = 0; y < fieldHeight; y++ )
      {
        tiles[x][y] = new Tile(bombs[x][y]);
      }
    }
    return tiles;
  }

  private void initTiles()
  {
    for (int x = 0; x< fieldWidth; x++)
    {
      for (int y = 0; y < fieldHeight; y++ )
      {
        setNeigbours(x, y, tiles[x][y]);
      }
    }
  }

  private void setNeigbours(int x, int y, Tile tile)
  {
    int neigbours = 0;
    for (int i = max(0, x-1); i <= min(x+1, fieldWidth-1); i++) {
      for (int j = max(0, y-1); j <= min(y+1, fieldHeight-1); j++) {
        if (x != i || y != j) {
          tile.addNeigbour(tiles[i][j]);
          if (tiles[i][j].hasMine())
          {
            neigbours ++;
          }
        }
      }
    }
    tile.setNeigbourMines(neigbours);
  }

  private boolean[][] createBombs()
  {
    boolean[][] bombs = new boolean[fieldWidth][fieldHeight];
    int i = 0;
    while (i< this.bombs)
    {

      int x = int(random(fieldHeight));
      int y = int(random(fieldWidth));
      if (!bombs[x][y])
      {
        bombs[x][y] = true;
        i++;
      }
    }


    return bombs;
  }

  public void show(int fieldPixelWidth, int fieldPixelHeight)
  {
    int tileWidth = int(fieldPixelWidth /fieldWidth);
    int tileHeight = int(fieldPixelHeight /fieldHeight);
    int x = int(tileWidth/2);
    int y = int(tileHeight/2);
    for (Tile[] collum : tiles)
    {
      for (Tile tile : collum)
      {
        tile.setTileHeight(tileHeight);
        tile.setTileWidth(tileWidth);
        tile.setPos(x, y);
        tile.getButton().show();
        x +=tileWidth;
      }
      x = int(tileWidth/2);
      y += tileHeight;
    }
  }

  public GameStatus update()
  {  

    Status status = pressButton();
    switch (status)
    {
    case gameOver: 
      return GameStatus.gameOver;
    case shown:
      tilesShown = 0;
      for (Tile[] collum : tiles)
      {
        for (Tile tile : collum)
        {
          tilesShown = (tile.getStatus()==Status.shown)?tilesShown+1:tilesShown;
        }
      }
      break;
    case marked:
      tilesMarked++;
      break;
    default:
      break;
    }
    if (this.tilesShown+this.bombs == this.tileCount)
    {
      return GameStatus.win;
    }
    return GameStatus.playing;
  }

  private Status pressButton()
  {
    for (Tile[] collum : tiles)
    {
      for (Tile tile : collum)
      {
        Button button = tile.getButton();
        if (button.isPressed())
        {
          if (mouseButton == LEFT)
          {
            tile.showTile();
          } else if (mouseButton == RIGHT)
          {
            tile.markTile();
          }
          return tile.getStatus();
        }
      }
    }
    return Status.nothing;
  }
}
