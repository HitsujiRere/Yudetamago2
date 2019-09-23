// Base_Items - Image

// イメージ
class Image extends ItemBase
{
  int drawMode = CORNER;
  PImage img = null;

  Image(String name, ItemCtrl ctrl, int page)
  {
    super(name, ctrl, page);
  }

  void display()
  {
    imageMode(drawMode);

    if (img != null)
    {
      image(img, getPos().x, getPos().y);
    }
  }

  void resize()
  {
    img.resize((int)getScl().x, (int)getScl().y);
  }
}
