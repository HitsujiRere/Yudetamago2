// Base_Items - Button

// ボタン
class Button extends ItemBase
{
  boolean value = false;
  boolean pvalue = false;
  boolean isValueChanged = false;
  boolean isValueChangedTrue = false;

  // クリックでonからoffに戻ることができる
  boolean ableClickToOff = false;
  // offに自動的に戻るかどうか
  boolean isRetToOff = true;
  // onになっているフレーム
  int onTime = 0;
  int onTimeMax = 120;

  // ディスプレイへの描画のモード
  // 0:描かない
  // 1:四角
  // 2:画像
  int displayMode = 1;

  // 描く 四角や画像
  // 0:On
  // 1:Touch
  // 2:Off
  Rect[] rects = new Rect[3];
  Image[] images = new Image[3];

  Button(String name, ItemCtrl ctrl, int page)
  {
    super(name, ctrl, page);

    for (int i = 0; i < 3; i++)
    {
      rects[i] = new Rect(name + "_r" + i, null, page);
      rects[i].parent = this;
      rects[i].scl = new PVector(1, 1);
      rects[i].isFill = true;
      rects[i].isStroke = true;
      rects[i].clr_stroke = #000000;
      rects[i].weight_stroke = 1;
    }
    rects[0].clr_fill = #7A7AFF;
    rects[1].clr_fill = #6161CC;
    rects[2].clr_fill = #494999;

    for (int i = 0; i < 3; i++)
    {
      images[i] = new Image(name + "_i" + i, null, page);
      images[i].parent = this;
      images[i].drawMode = CORNER;
    }
  }

  void update()
  {
    //値が0、かつマウスが四角をクリックしたなら値を1に
    //値が1なら、一定時間後に0にする
    if (ctrl.mouseClicked && isMouseTouch())
    {
      if (value)
      {
        if (ableClickToOff)
        {
          value = false;
          onTime = 0;
        }
      } else
      {
        value = true;
        onTime = 0;
      }
    }

    if (value)
    {
      onTime += 1;
      if (isRetToOff && onTime >= onTimeMax)
      {
        value = false;
        onTime = 0;
      }
    }

    if (runTime != 0)
    {
      if (value != pvalue)
      {
        isValueChanged = true;
        if (value)
        {
          isValueChangedTrue = true;
        }
      } else
      {
        isValueChanged = false;
        isValueChangedTrue = false;
      }
    }

    pvalue = value;
  }

  void display()
  {
    switch (displayMode)
    {
    case 1:
      drawRect();
      break;

    case 2:
      drawImage();
      break;
    }
  }

  void drawRect()
  {
    if (value)
    {
      rects[0].run();
    } else
    {
      //マウスが四角内にあるならtouch用の色にする
      if (isMouseTouch())
      {
        rects[1].run();
      } else
      {
        rects[2].run();
      }
    }
  }

  void drawImage()
  {
    if (value)
    {
      images[0].run();
    } else
    {
      //マウスが四角内にあるならtouch用の色にする
      if (isMouseTouch())
      {
        images[1].run();
      } else
      {
        images[2].run();
      }
    }
  }

  boolean isMouseTouch()
  {
    PVector pos = getPos();
    return mouseX >= pos.x && mouseX < pos.x + getScl().x 
      && mouseY >= pos.y && mouseY < pos.y + getScl().y;
  }

  void copyRect(int from)
  {
    Rect fromRect = rects[from];

    for (int i = 0; i < 3; i++)
    {
      rects[i] = fromRect;
    }
  }
  void copyImage(int from)
  {
    Image fromImg = images[from];

    for (int i = 0; i < 3; i++)
    {
      images[i] = fromImg;
    }
  }
}
