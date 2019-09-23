// Base_Items - Rect

// 四角
class Rect extends ItemBase
{
  boolean isFill = true;
  boolean isStroke = true;
  color clr_fill = #FFFFFF;
  color clr_stroke = #000000;
  int weight_stroke = 1;

  Rect(String name, ItemCtrl ctrl, int page)
  {
    super(name, ctrl, page);
  }

  void display()
  {
    if (isFill)
    {
      fill(clr_fill);
    } else
    {
      noFill();
    }

    if (isStroke)
    {
      stroke(clr_stroke);
      strokeWeight(weight_stroke);
    } else
    {
      noStroke();
    }

    rect(getPos().x, getPos().y, getScl().x, getScl().y);
  }
}
