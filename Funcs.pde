// Base_Items - Funcs

// 関数
static class Funcs
{
  //値nowNumをtoNumまで最大addNumぶん近づける
  static float access(float nowNum, float toNum, float addNum)
  {
    if (addNum != 0)
    {
      if ((toNum-nowNum > 0 && toNum-(nowNum+addNum) > 0) || 
        (toNum-nowNum < 0 && toNum-(nowNum+addNum) < 0))
        return nowNum+addNum;
      else
        return toNum;
    }

    return nowNum;
  }
}
