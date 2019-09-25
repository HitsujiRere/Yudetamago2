// Base_Items - Textbox

// テキスト用
class Text extends ItemBase
{
  String font = "main";
  String text = "";

  int alignX = LEFT, alignY = TOP;
  color clr = #000000;

  Text(String name, ItemCtrl ctrl, int page)
  {
    super(name, ctrl, page);
  }

  void display()
  {
    textFont(ctrl.fonts.get(font));
    textAlign(alignX, alignY);
    textSize(getScl().y);
    fill(clr);
    text(text, getPos().x, getPos().y);
  }

  void setParentOnCenter(ItemBase p)
  {
    parent = p;
    pos = new PVector(p.scl.x / 2, p.scl.y / 2);
    alignX = CENTER;
    alignY = CENTER;
    isIncParentGetScl = false;
  }
}
