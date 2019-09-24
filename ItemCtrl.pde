// Base_Items - ItemCtrl

// アイテムのコントローラー
class ItemCtrl
{
  // 前フレームのmousePressedの値
  boolean pmousePressed = false;
  // マウスが今離れたかどうか
  boolean mouseReleased = false;
  // マウスが今クリックしたかどうか
  boolean mouseClicked = false;

  // アイテムのグラフィックページの枚数
  int itemPage = 0;
  // アイテムの管理所
  //  数字が多いほど手前に表示される（遅く実行される
  HashMap<String, ItemBase>[] items;

  // フラグの管理所
  HashMap<String, Flag> flags = new HashMap();

  // Textboxのフォント
  //  指定がない場はmainを使用する
  HashMap<String, PFont> fonts = new HashMap();

  ItemCtrl(int page)
  {
    itemPage = page;
    items = new HashMap[itemPage];
    for (int i = 0; i < itemPage; i++)
    {
      items[i] = new HashMap();
    }
  }

  // 実行
  void run()
  {
    if (mousePressed && !pmousePressed)
    {
      mouseClicked = true;
      if (debugMode)
        println(""+frameCount+":mouseClicked");
    } else
    {
      mouseClicked = false;
    }

    if (!mousePressed && pmousePressed)
    {
      mouseReleased = true;
      if (debugMode)
        println(""+frameCount+":mouseReleased");
    } else
    {  
      mouseReleased = false;
    }

    // アイテムの実行
    for (int i = 0; i < itemPage; i++)
    {
      for (ItemBase a : items[i].values())
      {
        a.run();
      }
    }

    pmousePressed = mousePressed;
  }

  // アイテムを追加
  void addItem(String name, ItemBase a, int page)
  {
    items[page].put(name, a);
  }

  // 名前からItemを取得
  // 存在しない場合はnullを返す？
  ItemBase getItem(String name)
  {
    for (int i = 0; i < itemPage; i++)
    {
      ItemBase tmp = items[i].get(name);
      if (tmp != null)
      {
        return tmp;
      }
    }

    return null;
  }

  Button getButton(String name)
  {
    ItemBase tmp = getItem(name);
    if (tmp instanceof Button)
    {
      return (Button)tmp;
    }

    return null;
  }
  Textbox getText(String name)
  {
    ItemBase tmp = getItem(name);
    if (tmp instanceof Textbox)
    {
      return (Textbox)tmp;
    }

    return null;
  }
  Image getImage(String name)
  {
    ItemBase tmp = getItem(name);
    if (tmp instanceof Image)
    {
      return (Image)tmp;
    }

    return null;
  }
  Rect getRect(String name)
  {
    ItemBase tmp = getItem(name);
    if (tmp instanceof Rect)
    {
      return (Rect)tmp;
    }

    return null;
  }

  Flag getFlag(String name)
  {
    return flags.get(name);
  }

  // 全削除
  void reset()
  {
    mouseReleased = false;
    mouseClicked = false;

    for (int i = 0; i < itemPage; i++)
      items[i] = new HashMap();
    flags = new HashMap();
  }
}
