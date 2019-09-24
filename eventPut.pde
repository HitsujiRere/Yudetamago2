// よく使うもののショートカット
Textbox message;
Flag time, timeMax;
Flag get_nabe, get_water, get_konro;
int endMessageNum = 0;

void playBGM(String name)
{
  if (BGM_loop == null)
  {
    BGMs.get(name).loop();
    BGM_loop = name;
  } else if (!name.equals(BGM_loop))
  {
    BGMs.get(BGM_loop).pause();
    BGMs.get(BGM_loop).rewind();
    BGMs.get(name).loop();
    BGM_loop = name;
  }
}

int eventPut(int num)
{
  Textbox t1;
  Button b1, b2;
  Image i1;
  Rect r1;
  Flag f1;

  //AudioPlayer nextMusic;

  switch (num)
  {
    // 初期化
  case -1:
    ctrl.reset();

    backcolor = #000000;

    /*nextMusic = BGMs.get(BGM_loop);
     for (AudioPlayer a : BGMs.values())
     {
     if (a != nextMusic)
     {
     a.pause();
     a.rewind();
     }
     }*/

    isGetKonro = false;
    isGetNabe = false;
    isGetWater = false;

    message = null;
    time    = null;
    timeMax = null;
    get_nabe  = null;
    get_water = null;
    get_konro = null;

    break;

    // プレイ化
  case -2:

    // ステージの制限時間
    time = new Flag("time", ctrl);
    timeMax = new Flag("timeMax", ctrl);

    // アイテムの取得数
    get_nabe  = new Flag("get_nabe", ctrl);
    get_water = new Flag("get_water", ctrl);
    get_konro = new Flag("get_konro", ctrl);

    r1 = new Rect("timerOut", ctrl, 0);
    r1.pos = new PVector(16, 16);
    r1.scl = new PVector(96, 640-16*2-128);
    r1.clr_fill = #000000;
    r1.weight_stroke = 4;

    r1 = new Rect("timerIn", ctrl, 1);
    r1.pos = new PVector(16, 16);
    r1.scl = new PVector(96, 640-16*2-128);
    r1.clr_fill = #EFEFEF;
    r1.weight_stroke = 4;

    i1 = new Image("timerEgg", ctrl, 2);
    i1.parent = r1;
    i1.img = Images.get("egg").copy();
    i1.img.resize(64, 64);
    i1.pos = new PVector(16, -32);

    r1 = new Rect("messageBox", ctrl, 0);
    r1.pos = new PVector(16+96+16, height-16-128);
    r1.scl = new PVector(width-16-96-16-16, 128);
    r1.clr_fill = #EFEFEF;
    r1.weight_stroke = 4;

    message = new Textbox("message", ctrl, 1);
    message.parent = r1;
    //t1.text = "This is message box.\nHello World!";
    if (stage >= 100)
      message.text = "Stage " + (stage-100) + " - " + stageTitles[stage-100] + "\n";
    message.isIncParentGetScl = false;
    message.pos = new PVector(8, 8);
    message.scl = new PVector(0, 32);
    message.clr = #000000;

    i1 = new Image("icon_nabe", ctrl, 0);
    i1.img = Images.get("nabe").copy();
    i1.pos = new PVector(960-150, 0);
    i1.scl = new PVector(50, 50);
    i1.resize();
    i1.isDisplay = false;

    i1 = new Image("icon_water", ctrl, 0);
    i1.img = Images.get("water").copy();
    i1.pos = new PVector(960-100, 0);
    i1.scl = new PVector(50, 50);
    i1.resize();
    i1.isDisplay = false;

    i1 = new Image("icon_konro", ctrl, 0);
    i1.img = Images.get("konro").copy();
    i1.pos = new PVector(960- 50, 0);
    i1.scl = new PVector(50, 50);
    i1.resize();
    i1.isDisplay = false;

    b1 = new Button("menu", ctrl, 1);
    b1.pos = new PVector(16, height-128);
    b1.scl = new PVector(96, 96);
    b1.displayMode = 2;
    b1.images[0].img = Images.get("buttonResetOff").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    t1 = new Textbox("menuTxt", ctrl, 1);
    t1.parent = b1;
    t1.pos = new PVector(96/2, 96-16);
    t1.isIncParentGetScl = false;
    t1.scl.y = 32;
    t1.text = "Menu";
    t1.alignX = CENTER;

    break;

    // クリア
  case -3:
    // アウト
  case -4:

    playBGM(num == -3 ? "clear" : "broken");
    eventPut(-1);
    eventPut(-2);

    backcolor = #98BBDB;

    ctrl.getRect ("timerIn" ).isRun = false;
    ctrl.getRect ("timerOut").isRun = false;
    ctrl.getImage("timerEgg").isRun = false;

    switch (endMessageNum)
    {
    case 0:
      message.text = num == -3 ? "ゆでたまごが完成した！\n" :
        "生卵はぐちゃぐちゃになってしまった...\n";
      break;

    case 1:
      message.text = num == -3 ? "\n" :
        "生卵は壊されてしまった...\n";
      break;
    }
    endMessageNum = 0;
    message.text += num == -3 ? "ＳＴＡＧＥ　ＣＬＥＡＲ\n" : 
      "ＳＴＡＧＥ　ＦＡＩＬＵＲＥ\n";

    i1 = new Image("egg", ctrl, 1);
    i1.pos = new PVector(300, 100);
    i1.scl = new PVector(300, 300);
    i1.img = Images.get(num == -3 ? "eggBoil" : "eggBroken").copy();
    i1.resize();

    f1 = new Flag("eggNum", ctrl);
    f1.value = 20;
    for (int i = 0; i < f1.value; i++)
    {
      i1 = new Image("egg_"+i, ctrl, 0);
      i1.img = Images.get(num == -3 ? "eggBoil" : "eggBroken").copy();
      i1.img.resize(64, 64);
      i1.drawMode = CENTER;
      i1.pos = new PVector(random(0, width), random(-width, 0));
    }

    b1 = new Button("menu", ctrl, 1);
    b1.pos = new PVector(800, 350);
    b1.scl = new PVector(100, 100);
    b1.displayMode = 2;
    b1.images[0].img = Images.get("buttonResetOff").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    t1 = new Textbox("menuTxt", ctrl, 1);
    t1.parent = b1;
    t1.pos = new PVector(50, 100);
    t1.isIncParentGetScl = false;
    t1.scl.y = 32;
    t1.text = "Menuに戻る";
    t1.alignX = CENTER;

    break;

    // タイトル
  case 0:

    playBGM("op");
    eventPut(-1);

    backcolor = #98BBDB;

    t1 = new Textbox("title1", ctrl, 1);
    t1.text = "親方ぁ！空から";
    t1.pos = new PVector(16, 16);
    t1.scl = new PVector(0, 128);

    t1 = new Textbox("title2", ctrl, 1);
    t1.text = "生卵が！！ ②";
    t1.alignX = RIGHT;
    t1.pos = new PVector(width-16, 16+128+16);
    t1.scl = new PVector(0, 128);

    b1 = new Button("startButton", ctrl, 1);
    b1.pos = new PVector(64, 16+128+16+64+128);
    b1.scl = new PVector(width/2 - 64 - 32, height-16-128-16-64-128-64);

    t1 = new Textbox("startText", ctrl, 2);
    t1.parent = b1;
    t1.text = "Play Start!";
    t1.alignX = CENTER;
    t1.alignY = CENTER;
    t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
    t1.isIncParentGetScl = false;
    t1.scl = new PVector(0, 64);

    b1 = new Button("howButton", ctrl, 1);
    b1.pos = new PVector(width/2 + 32, 16+128+16+64+128);
    b1.scl = new PVector(width/2 - 64 - 32, height-16-128-16-64-128-64);

    t1 = new Textbox("howText", ctrl, 2);
    t1.parent = b1;
    t1.text = "How to Play";
    t1.alignX = CENTER;
    t1.alignY = CENTER;
    t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
    t1.isIncParentGetScl = false;
    t1.scl = new PVector(0, 64);

    f1 = new Flag("eggNum", ctrl);
    f1.value = 20;
    for (int i = 0; i < f1.value; i++)
    {
      i1 = new Image("egg_"+i, ctrl, 0);
      i1.img = Images.get("egg").copy();
      i1.img.resize(64, 64);
      i1.drawMode = CENTER;
      i1.pos = new PVector(random(0, width), random(-width, 0));
    }

    break;

    // メニュー
  case 1:

    playBGM("menu");
    eventPut(-1);

    backcolor = #98BBDB;

    t1 = new Textbox("menu", ctrl, 1);
    t1.text = "Menu";
    t1.pos = new PVector(32, 32);
    t1.scl = new PVector(0, 64);

    b1 = new Button("backButton", ctrl, 1);
    b1.pos = new PVector(256, 32);
    b1.scl = new PVector(64*5+32, 64);

    t1 = new Textbox("backText", ctrl, 2);
    t1.parent = b1;
    t1.text = "Back to Title";
    t1.alignX = CENTER;
    t1.alignY = CENTER;
    t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
    t1.isIncParentGetScl = false;
    t1.scl = new PVector(0, 32);

    for (int i = 0; i < stageMax; i++)
    {
      b1 = new Button("stage"+(i)+"Button", ctrl, 1);
      b1.pos = new PVector(i%2==0 ? 64 : width/2 + 32, 
        128+(128+32)*(i/2));
      b1.scl = new PVector(width/2 - 64 - 32, 128);

      t1 = new Textbox("stage"+(i)+"Text", ctrl, 2);
      t1.parent = b1;
      t1.text = "Stage "+i+"\n"+
        (stageTitles[i] == null ? "未実装" : stageTitles[i]);
      t1.alignX = CENTER;
      t1.alignY = CENTER;
      t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
      t1.isIncParentGetScl = false;
      t1.scl = new PVector(0, 32);
    }

    break;

    // How to
  case 2:

    playBGM("op");
    eventPut(-1);

    backcolor = #98BBDB;

    b1 = new Button("closeButton", ctrl, 1);
    b1.pos = new PVector(32, 32);
    b1.scl = new PVector(64*3, 64);

    t1 = new Textbox("closeText", ctrl, 2);
    t1.parent = b1;
    t1.text = "Close";
    t1.alignX = CENTER;
    t1.alignY = CENTER;
    t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
    t1.isIncParentGetScl = false;
    t1.scl = new PVector(0, 32);

    //i1 = new Image("expImage", ctrl, 1);
    //i1.img = Images.get("exp");
    //i1.pos = new PVector(32*17, 32*10);
    //i1.img.resize(32*3*3, 32*2*3);

    {
      int w = 32;
      String[] texts = loadStrings("howtoplay_exp.txt");
      for (int i = 0; i < texts.length; i++)
      {
        t1 = new Textbox("expText_"+i, ctrl, 2);
        t1.pos = new PVector(64, w+64+w + (w+10)*i);
        t1.scl = new PVector(0, w);

        if (debugMode)
        {
          println(texts[i]);
        }

        if (texts[i].length() >= 2 && texts[i].substring(0, 1).equals("\\"))
        {
          t1.text = texts[i].substring(1);
          t1.font = "name";
        } else
        {
          t1.text = texts[i];
        }
      }
    }
    
    b1 = new Button("openButton", ctrl, 1);
    b1.pos = new PVector(width-32-64*3, height-32^64);
    b1.scl = new PVector(64*3, 64);

    t1 = new Textbox("openText", ctrl, 2);
    t1.parent = b1;
    t1.text = "ライセンス";
    t1.alignX = CENTER;
    t1.alignY = CENTER;
    t1.pos = new PVector(b1.scl.x/2, b1.scl.y/2); 
    t1.isIncParentGetScl = false;
    t1.scl = new PVector(0, 32);

    break;

    // stage 0
  case 100:

    playBGM("play");
    eventPut(-1);
    eventPut(-2);

    backcolor = #98BBDB;

    time.value = timeMax.value = 60*60*2;

    message.text += "\nまずは左上の「水」をクリックで取ってみよう！";

    b1 = new Button("water", ctrl, 0);
    b1.displayMode = 2;
    b1.pos = new PVector(200, 100);
    b1.scl = new PVector(100, 100);
    b1.images[0] = new Image("water_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("water").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    b1 = new Button("konro", ctrl, 0);
    b1.displayMode = 2;
    b1.pos = new PVector(700, 200);
    b1.scl = new PVector(100, 100);
    b1.images[0] = new Image("konro_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("konro").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    b1 = new Button("nabe", ctrl, 0);
    b1.displayMode = 2;
    b1.pos = new PVector(350, 380);
    b1.scl = new PVector(100, 100);
    b1.images[0] = new Image("nabe_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("treasure").copy();
    b1.images[0].resize();
    b1.onTimeMax = 10;
    b1.copyImage(0);

    b1 = new Button("key", ctrl, 0);
    b1.displayMode = 2;
    b1.pos = new PVector(500, 300);
    b1.scl = new PVector(100, 100);
    b1.images[0] = new Image("key_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("key").copy();
    b1.images[0].resize();
    b1.copyImage(0);
    b1.isRun = false;

    f1 = new Flag("get_key", ctrl);
    f1 = new Flag("open_tre", ctrl);

    break;

    // stage 1
  case 101:

    playBGM("play");
    eventPut(-1);
    eventPut(-2);

    backcolor = #98BBDB;

    time.value = timeMax.value = 60*60*1;

    message.text += "\n敵をクリックするとゲームオーバーになるよ！\n";

    r1 = new Rect("hebi_back", ctrl, 0);
    r1.pos = new PVector(200, 80);
    r1.scl = new PVector(150, 150);
    r1.clr_stroke = #e7bd2c;
    r1.weight_stroke = 10;

    b1 = new Button("hebi", ctrl, 1);
    b1.parent = r1;
    b1.displayMode = 2;
    b1.images[0] = new Image("hebi_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("hebi").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    b1 = new Button("water_back", ctrl, 0);
    b1.pos = new PVector(500, 80);
    b1.scl = new PVector(150, 150);
    b1.rects[0] = new Rect("water_back_rect", null, 0);
    b1.rects[0].parent = b1;
    b1.rects[0].clr_stroke = #e7bd2c;
    b1.rects[0].weight_stroke = 10;
    b1.copyRect(0);
    b1.onTimeMax = 5;

    b2 = new Button("water", ctrl, 1);
    b2.parent = b1;
    b2.displayMode = 2;
    b2.images[0] = new Image("water_img", null, 0);
    b2.images[0].parent = b1;
    b2.images[0].img = Images.get("water").copy();
    b2.images[0].resize();
    b2.copyImage(0);

    b1 = new Button("nabe", ctrl, 0);
    b1.pos = new PVector(350, 330);
    b1.scl = new PVector(100, 100);
    b1.displayMode = 2;
    b1.images[0] = new Image("nabe_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("nabe").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    b1 = new Button("dra", ctrl, 1);
    b1.pos = new PVector(350-25, 330-25);
    b1.scl = new PVector(150, 150);
    b1.anmsPos = new PVector[]{new PVector(350-25-150, 330-25), 
      new PVector(350-25+150, 330-25), new PVector(350-25-150, 330-25)};
    b1.anmsWeitTime = new int[]{100, 100};
    b1.anmRepeatTime = -1;
    b1.anmReset();
    b1.displayMode = 2;
    b1.images[0] = new Image("dra_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("dragonGreen").copy();
    b1.images[0].resize();
    b1.copyImage(0);

    b1 = new Button("konro", ctrl, 0);
    b1.pos = new PVector(750, 350);
    b1.scl = new PVector(120, 120);
    b1.displayMode = 2;
    b1.images[0] = new Image("dra_img", null, 0);
    b1.images[0].parent = b1;
    b1.images[0].img = Images.get("treasure").copy();
    b1.images[0].resize();
    b1.copyImage(0);
    b1.onTimeMax = 5;

    f1 = new Flag("show_key", ctrl);
    f1 = new Flag("have_key", ctrl);
    f1 = new Flag("open_tre", ctrl);

    break;

    // stage 2
  case 102:

    playBGM("play");
    eventPut(-1);
    eventPut(-2);

    backcolor = #98BBDB;

    time.value = timeMax.value = 60*60;

    b1 = new Button("", ctrl, 0);

    break;

    // stage 5
  case 105:

    playBGM("play");
    eventPut(-1);
    eventPut(-2);

    backcolor = #98BBDB;

    time.value = timeMax.value = 60;

    break;
  }

  return 0;
}
