// Base_Items - Textbox

// テキスト用
class Textbox extends ItemBase
{
  String font = "main";
  String text = "";

  int alignX = LEFT, alignY = TOP;
  color clr = #000000;

  Textbox(String name, ItemCtrl ctrl, int page)
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
}
