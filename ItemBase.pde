// Base_Items - ItemBase

// アイテムたちのスーパークラス
class ItemBase
{
  // 名前
  //  変更しないこと！
  //  TODO:変更できるようにする
  //       →ctrl.itemsのkeyを変える？
  String name = null;
  // コントローラー
  ItemCtrl ctrl = null;
  // 親
  ItemBase parent = null;

  // 座標
  PVector pos = new PVector(0, 0);
  boolean isIncParentGetPos = true;

  // 大きさ
  PVector scl = new PVector(1, 1);
  boolean isIncParentGetScl = true;

  // 実行回数
  int runTime = 0;
  // 実行の可否
  boolean isRun = true;
  // 更新の可否
  boolean isUpdate = true;
  // 描画の可否
  boolean isDisplay = true;

  //アニメーション関係
  // アニメーションの移動先座標
  PVector[] anmsPos = null;
  // アニメーションの待機時間
  int[] anmsWeitTime = null;
  // アニメーションの実行回数
  //    0  行わない
  //   -1  無限
  int anmRepeatTime = 0;
  // 現在の残り待機時間
  int anmWeitTime = 0;
  // 現在の移動番号
  int anmMoveNum = 0;

  ItemBase(String name_, ItemCtrl ctrl_, int page_)
  {
    name = name_;
    ctrl = ctrl_;

    if (ctrl != null)
    {
      ctrl.addItem(name_, this, page_);
    }
  }

  // 実行
  void run()
  {
    if (isRun)
    {
      runBefore();

      if (isUpdate)
      {
        update();
      }

      if (isDisplay)
      {
        display();
      }

      runAfter();
    }
  }

  // 実行するまえに行うこと
  void runBefore()
  {
    //アニメーション処理
    if (anmRepeatTime > 0 || anmRepeatTime == -1)
    {
      anmWeitTime--;
      if (anmWeitTime >= 0)
      {
        pos.x = Funcs.access(pos.x, anmsPos[anmMoveNum].x, 
          (anmsPos[anmMoveNum].x - anmsPos[anmMoveNum-1].x) / 
          anmsWeitTime[anmMoveNum-1]);
        pos.y = Funcs.access(pos.y, anmsPos[anmMoveNum].y, 
          (anmsPos[anmMoveNum].y - anmsPos[anmMoveNum-1].y) / 
          anmsWeitTime[anmMoveNum-1]);
      } else
      {
        anmMoveNum++;
        if (anmMoveNum >= anmsPos.length)
        {
          if (anmRepeatTime > 0)
            anmRepeatTime--;
          if (anmRepeatTime > 0 || anmRepeatTime == -1)
          {
            anmMoveNum = 1;
            pos.x = anmsPos[0].x;
            pos.y = anmsPos[0].y;
            anmWeitTime = anmsWeitTime[0];
          }
        } else
        {
          anmWeitTime = anmsWeitTime[anmMoveNum-1];
          pos.x = anmsPos[anmMoveNum-1].x;
          pos.y = anmsPos[anmMoveNum-1].y;
        }
      }
    }
  }

  // 計算など
  void update()
  {
  }

  // 描写
  void display()
  {
  }

  // 実行したあとに行うこと
  void runAfter()
  {
    runTime++;
  }

  // 位置を取得
  PVector getPos()
  {
    if (!isIncParentGetPos || parent == null)
    {
      return pos;
    } else
    {
      PVector parePos = parent.getPos();
      return new PVector(pos.x + parePos.x, pos.y + parePos.y);
    }
  }

  // 大きさを取得
  PVector getScl()
  {
    if (!isIncParentGetScl || parent == null)
    {
      return scl;
    } else
    {
      PVector pareScl = parent.getScl();
      return new PVector(scl.x * pareScl.x, scl.y * pareScl.y);
    }
  }

  void anmReset()
  {
    anmMoveNum = 1;
    pos.x = anmsPos[0].x;
    pos.y = anmsPos[0].y;
    anmWeitTime = anmsWeitTime[0];
  }
}
