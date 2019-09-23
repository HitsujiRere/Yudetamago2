// Base_Items - Flag

// 数字の管理用
class Flag
{
  // 名前
  String name = null;
  // コントローラー
  ItemCtrl ctrl = null;
  // 値
  int value = 0;

  Flag(String name_, ItemCtrl ctrl_)
  {
    name = name_;
    ctrl = ctrl_;

    if (ctrl != null)
    {
      ctrl.flags.put(name_, this);
    }
  }
}
