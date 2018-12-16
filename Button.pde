public class Button
{
  int buttonWidth;

  int buttonHeight;

  int x;

  int y;

  public Button(int buttonWidth, int buttonHeight)
  {
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
  }

  public void setPos(int x, int y)
  {
    this.x = x;
    this.y = y;
  }

  public boolean isPressed()
  {
    if (abs(mouseX-x)<buttonWidth/2)
    {
      if (abs(mouseY-y)<buttonHeight/2)
      {
        return true;
      }
    }
    return false;
  }

  public void show() {
    fill(255);
    drawButton();
  }

  public void setText(String text)
  {
    if (text.isEmpty())
    {
      drawButton();
      return;
    }
    pushMatrix();
    translate(x, y);
    fill(0);
    textAlign(CENTER, CENTER);
    text(text, 0, 0);
    popMatrix();
  }

  public void colorButton(int r, int g, int b)
  {
    fill(r, g, b);
    drawButton();
    fill(255);
  }

  public void colorButton(int b)
  {
    fill(b);
    drawButton();
    fill(255);
  }

  private void drawButton()
  {
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    rect(0, 0, buttonWidth, buttonHeight, 7);
    popMatrix();
  }
}
