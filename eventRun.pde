int eventRun(int num)
{
  //Textbox t1;
  Button b1, b2;
  Image i1, i2;
  Rect r1;
  Flag f1;

  switch (num)
  {
    // プレイ
  case -2:

    if (ctrl.getButton("menu").isValueChanged)
    {
      stage = 1;
      eventPut(stage);
      return 1;
    }

    if (get_nabe.value > 0 && get_water.value > 0 &&
      get_konro.value > 0)
    {
      stage = -3;
      eventPut(stage);
      return 1;
    }

    time.value--;
    if (time.value < 0)
    {
      stage = -4;
      eventPut(stage);
      return 1;
    }

    float dy = (640-16*2-128) * time.value / timeMax.value;
    r1 = ctrl.getRect("timerIn");
    r1.pos.y = 16.0 + (640-16*2-128) - dy;
    r1.scl.y = dy;

    ctrl.getImage("icon_nabe" ).isDisplay = get_nabe.value > 0 ? 
      true : false;
    ctrl.getImage("icon_water").isDisplay = get_water.value > 0 ? 
      true : false;
    ctrl.getImage("icon_konro").isDisplay = get_konro.value > 0 ? 
      true : false;

    break;

    // クリア
  case -3:
    // アウト
  case -4:

    f1 = ctrl.getFlag("eggNum");
    for (int i = 0; i < f1.value; i++)
    {
      i1 = ctrl.getImage("egg_"+i);
      i1.pos.y += 10.0;
      if (i1.pos.y > height+70.0)
      {
        i1.pos = new PVector(random(0, width), random(-width, 0));
      }
    }

    if (ctrl.getButton("menu").isValueChanged)
    {
      stage = 1;
      eventPut(stage);
      return 1;
    }

    break;

    // タイトル
  case 0:

    f1 = ctrl.getFlag("eggNum");
    for (int i = 0; i < f1.value; i++)
    {
      i1 = ctrl.getImage("egg_"+i);
      i1.pos.y += 10.0;
      if (i1.pos.y > height+70.0)
      {
        i1.pos = new PVector(random(0, width), random(-width, 0));
      }
    }

    if (ctrl.getButton("startButton").isValueChanged)
    {
      stage = 1;
      eventPut(stage);
      return 1;
    }
    if (ctrl.getButton("howButton").isValueChanged)
    {
      stage = 2;
      eventPut(stage);
      return 1;
    }

    break;

    // メニュー
  case 1:

    if (ctrl.getButton("backButton").isValueChanged)
    {
      stage = 0;
      eventPut(stage);
      return 1;
    }

    for (int i = 0; i < stageMax; i++)
    {
      b1 = ctrl.getButton("stage"+i+"Button");

      if (b1.isValueChanged && stageTitles[i] != null)
      {
        stage = 100+i;
        eventPut(stage);
        return 1;
      }
    }

    break;

    // How to
  case 2:

    if (ctrl.getButton("closeButton").isValueChanged)
    {
      stage = 0;
      eventPut(stage);
      return 1;
    }

    if (ctrl.getButton("openButton").isValueChanged)
    {
      stage = 3;
      eventPut(stage);
      return 1;
    }

    break;

    // 使用素材
  case 3:

    if (ctrl.getButton("closeButton").isValueChanged)
    {
      stage = 2;
      eventPut(stage);
      return 1;
    }

    break;

    // stage 0
  case 100:

    if (eventRun(-2) != 0)
      return 1;

    b1 = ctrl.getButton("water");
    if (b1.isValueChanged)
    {
      get_water.value++;
      b1.isRun = false;
      b1.isValueChanged = false;
      message.text = "水を手に入れた！\nこの水は右上に表示されるよ！\n"+
        "次は右にあるコンロを手に入れよう！";
    }

    b1 = ctrl.getButton("konro");
    if (b1.isValueChanged)
    {
      get_konro.value++;
      b1.isRun = false;
      b1.isValueChanged = false;
      message.text = "コンロを手に入れた！\n最後の鍋は、あの宝箱の中かな？\n";
    }

    b1 = ctrl.getButton("key");
    if (b1.isValueChanged)
    {
      ctrl.getFlag("get_key").value++;
      b1.isRun = false;
      message.text = "鍵が手に入れた！\nこれで宝箱が開けられるぞ！\n";
    }

    b1 = ctrl.getButton("nabe");
    if (b1.isValueChangedTrue)
    {
      if (ctrl.getFlag("get_key").value > 0)
      {
        if (ctrl.getFlag("open_tre").value > 0)
        {
          get_nabe.value++;
          b1.isRun = false;
          message.text = "なべを手に入れた！\n";
        } else
        {
          ctrl.getFlag("open_tre").value++;
          b1.images[0].img = Images.get("nabe").copy();
          b1.images[0].resize();
          b1.copyImage(0);
          message.text = "宝箱が開いた！\n";
        }
      } else
      {
        ctrl.getButton("key").isRun = true;
        message.text = "鍵がかかっている・・・\nどこかに鍵は落ちていないだろうか\n";
      }
    }

    break;

    // stage 1
  case 101:

    if (eventRun(-2) != 0)
      return 1;

    b1 = ctrl.getButton("hebi");
    if (b1.isValueChanged)
    {
      endMessageNum = 1;
      stage = -4;
      eventPut(stage);
      return 1;
    }

    b1 = ctrl.getButton("dra");
    if (b1.isValueChanged)
    {
      endMessageNum = 1;
      stage = -4;
      eventPut(stage);
      return 1;
    }

    b1 = ctrl.getButton("water_back");
    if (get_water.value > 0 && b1.isValueChangedTrue)
    {
      if (ctrl.getFlag("show_key").value > 0)
      {
        ctrl.getFlag("have_key").value++;
        message.text = "鍵を手に入れた！\n";
        b1.isRun = false;
        b1.isValueChanged = false;
      } else
      {
        b1.displayMode = 2;
        b1.images[0].img = Images.get("key").copy();
        b1.images[0].resize();
        b1.copyImage(0);
        ctrl.getFlag("show_key").value++;
      }
    }

    b1 = ctrl.getButton("water");
    if (b1.isValueChanged)
    {
      get_water.value++;
      message.text = "水を手に入れた！\n";
      b1.isRun = false;
      b1.isValueChanged = false;
    }

    b1 = ctrl.getButton("nabe");
    if (b1.isValueChanged)
    {
      get_nabe.value++;
      message.text = "鍋を手に入れた！\n";
      b1.isRun = false;
      b1.isValueChanged = false;
    }

    b1 = ctrl.getButton("konro");
    if (b1.isValueChangedTrue)
    {
      if (ctrl.getFlag("have_key").value > 0)
      {
        f1 = ctrl.getFlag("open_tre");
        if (f1.value > 0)
        {
          get_konro.value++;
          b1.isRun = false;
          b1.isValueChanged = false;
          message.text = "コンロを手に入れた！\n";
        } else
        {
          b1.images[0].img = Images.get("konro").copy();
          b1.images[0].resize();
          f1.value++;
        }
      } else
      {
        message.text = "鍵がかかっていいる\n何かの裏に隠れていたりしないかな？\n";
      }
    }

    break;

    // stage 2
  case 102:

    if (eventRun(-2) != 0)
      return 1;

    /*i1 = ctrl.getImage("treasure");
     if (key == 'q')
     {
     i1.pos.x = mouseX;
     i1.pos.y = mouseY;
     }
     println(i1.pos.x, i1.pos.y);*/
    b1 = ctrl.getButton("donut");
    if (b1.isValueChangedTrue && !ctrl.getImage("stars").isRun)
    {
      get_nabe.value++;
      message.text = "鍋を手に入れた！\n";
      b1.isRun = false;
      b1.isValueChangedTrue = false;
    }

    b1 = ctrl.getButton("door1");
    b2 = ctrl.getButton("dragon");
    if (b2.isValueChangedTrue && !b1.isRun && !ctrl.getImage("stars").isRun)
    {
      b2.isRun = false;
      b2.isValueChangedTrue = false;
      ctrl.getFlag("haveKey").value++;
      message.text = "鍵を手に入れた！";
    }
    if (b1.isValueChanged)
    {
      b1.isRun = false;
      b1.isValueChanged = false;

      b2.anmsPos = new PVector[]{new PVector(140, 70), new PVector(450-80, 350-10)};
      b2.anmsWeitTime = new int[]{ 50 };
      b2.anmRepeatTime = 1;
      b2.anmReset();
    }

    b1 = ctrl.getButton("door2");
    b2 = ctrl.getButton("treasure");
    if (b2.isValueChangedTrue && !b1.isRun)
    {
      if (ctrl.getFlag("openTre").value > 0)
      {
        get_konro.value++;
        message.text = "コンロを手に入れた！\n";
        b2.isRun = false;
        b2.isValueChangedTrue = false;
      } else
      {
        f1 = ctrl.getFlag("haveKey");
        if (f1.value > 0)
        {
          b2.images[0].img = Images.get("nabe").copy();
          b2.images[0].resize();
          b2.copyImage(0);
          ctrl.getFlag("openTre").value++;
        } else
        {
          message.text = "鍵がかかっている・・・\n";
        }
      }
    }
    if (b1.isValueChanged)
    {
      b1.isRun = false;
      b1.isValueChanged = false;
    }

    b1 = ctrl.getButton("door3");
    if (b1.isValueChanged)
    {
      b1.isRun = false;
      b1.isValueChanged = false;

      i1 = ctrl.getImage("pegasus");
      i1.anmsPos = new PVector[]{new PVector(560, 100), new PVector(width+150, 100)};
      i1.anmsWeitTime = new int[]{ 100 };
      i1.anmRepeatTime = 1;
      i1.anmReset();

      b1 = ctrl.getButton("water");
      b1.isRun = false;

      i1 = ctrl.getImage("stars");
      i1.anmsPos = new PVector[]{new PVector(520, 30), new PVector(450-35, 350-55)};
      i1.anmsWeitTime = new int[]{ 100 };
      i1.anmRepeatTime = 1;
      i1.anmReset();
    }

    b1 = ctrl.getButton("door4");
    b2 = ctrl.getButton("water");
    if (b2.isValueChangedTrue && !b1.isRun)
    {
      get_water.value++;
      message.text = "水を手に入れた！\n";
      b2.isRun = false;
      b2.isValueChangedTrue = false;
    }
    if (b1.isValueChanged)
    {
      b1.isRun = false;
      b1.isValueChanged = false;
    }

    i1 = ctrl.getImage("stars");
    if (i1.pos.x < 450-35+5)
    {
      i1.isRun = false;

      b1 = ctrl.getButton("donut");
      b1.images[0].img = Images.get("konro").copy();
      b1.images[0].resize();
      b1.copyImage(0);

      b1 = ctrl.getButton("door1");
      if (!b1.isRun)
      {
        b2 = ctrl.getButton("dragon");
        b2.images[0].img = Images.get("key").copy();
        b2.images[0].resize();
        b2.copyImage(0);
      }
    }

    break;

    // stage 5
  case 105:

    if (eventRun(-2) != 0)
      return 1;

    break;


  default:
    stage = 0;
    eventPut(stage);
    return 1;
  }

  return 0;
}
