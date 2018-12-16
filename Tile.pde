public class Tile
{
  boolean mine = false;

  int tileWidth = 10;

  int tileHeight = 10;

  int x;

  int y;

  int neigbourMines = 0;

  ArrayList<Tile> neigbours = new ArrayList<Tile>();

  Button button = null;

  Status status = Status.hidden;

  public Tile(boolean mine) {
    this.mine = mine;
  }

  public boolean hasMine() {
    return mine;
  }

  public void setNeigbourMines(int neigbourMines) {
    this.neigbourMines = neigbourMines;
  }

  public int getNeigbourMines() {
    return neigbourMines;
  }

  public void setTileWidth(int tileWidth) {
    this.tileWidth = tileWidth;
  }

  public void setTileHeight(int tileHeight) {
    this.tileHeight = tileHeight;
  }

  public void setStatus(Status status)
  {
    this.status = status;
  }

  public Status getStatus()
  {
    return status;
  }

  public Button getButton()
  {
    if (button == null)
    {
      button = new Button(tileWidth, tileHeight);
    }
    return button;
  }

  private void showNeigbours()
  {
    for (Tile neigbour : neigbours)
    {
      if (neigbour.getStatus() == Status.hidden)
      {
        neigbour.showTile();
      }
    }
  }

  public void showTile()
  {
    if (status == Status.marked)
    {
      return;
    }
    if (this.hasMine()) {
      getButton().colorButton(245, 0, 0);
      println("Game Over");
      setStatus(Status.gameOver);
    } else {

      if (getNeigbourMines() == 0)
      {
        getButton().colorButton(235);
      } else {
        getButton().colorButton(245);
        getButton().setText(Integer.toString(getNeigbourMines()));
      }
      setStatus(Status.shown);

      if (getNeigbourMines()== 0)
      {
        showNeigbours();
      }
    }
  }

  public void markTile()
  {
    if (this.status == Status.hidden) {
      status = Status.marked;
      getButton().setText("!");
    } else if (this.status == Status.marked) {
      status = Status.hidden;
      getButton().setText("");
    }
  }

  public void setPos(int x, int y)
  {
    this.x = x;
    this.y = y;
    getButton().setPos(x, y);
  }

  public void addNeigbour(Tile neigbour)
  {
    neigbours.add(neigbour);
  }
}
