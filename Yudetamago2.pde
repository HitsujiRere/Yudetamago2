// ゆでたまご２  ver.0.1.3
// Yudetamago2 
//  maked by 陽辻怜玲@HitsujiRere

// 音楽用ライブラリをインポート
import ddf.minim.*;
Minim minim;
// BGMのデータ
HashMap<String, AudioPlayer> BGMs = new HashMap();
// BGMのloop()の可否
String BGM_loop = null;
// 音楽の有無
boolean isPlayBGM = false;

// 画像のデータ
HashMap<String, PImage> Images = new HashMap();

// デバッグモード
boolean debugMode = false;

// ステージ番号
//    -1:初期化
//    -2:プレイ
//    -3:クリア
//    -4:アウト
//     0:タイトル
//     1:メニュー
//     2:How to Play
//     3:使用素材
// 100+n:nステージ
int stage = 0;
// ステージ数
int stageMax = 6;
// ステージのタイトル
String[] stageTitles = new String[100];

// コントローラー
ItemCtrl ctrl;

// アイテムの入手の判定
boolean isGetKonro = false, isGetNabe = false, isGetWater = false;

// 背景色
color backcolor = #000000;


void setup()
{
  // 3:2
  size(960, 640);

  fill(#000000);
  textSize(64);
  textAlign(CENTER, CENTER);
  text("Now Loading...", width/2, height/2);

  // 5枚のディスプレイシート
  ctrl = new ItemCtrl(5);

  // フォントのロードと設定
  String[] fontList = loadStrings("fonts\\font_datas.txt");
  if (debugMode)
  {
    println("in  >> fonts\\font_datas.txt");
  }
  for (String a : fontList)
  {
    String[] sp = a.split(":");
    ctrl.fonts.put(sp[0], createFont(sp[1], 128, true));
    stageTitles[parseInt(sp[0])] = sp[1];
  }

  String path = sketchPath();
  File[] files;

  // 音楽のロード
  minim = new Minim(this);
  files = listFiles(path + "\\data\\musics");
  for (File a : files)
  {
    BGMs.put(a.getName().substring(0, a.getName().lastIndexOf('.')), 
      minim.loadFile(a.getPath()));
    if (debugMode)
    {
      println("in  >> musics\\" + a.getName());
      //println("        " + a.getName().substring(0, a.getName().lastIndexOf('.')));
    }
  }

  // 画像のロード
  minim = new Minim(this);
  files = listFiles(path + "\\data\\images");
  for (File a : files)
  {
    if (a.getName().equals("no use"))
      continue;

    Images.put(a.getName().substring(0, a.getName().lastIndexOf('.')), 
      loadImage(a.getPath()));
    if (debugMode)
    {
      println("in  >> images\\" + a.getName());
    }
  }

  // 音量設定
  for (AudioPlayer a : BGMs.values())
  {
    if (isPlayBGM)
      a.unmute();
    else
      a.mute();
  }

  // タイトルのロード
  String[] titles = loadStrings("stage_titles.txt");
  if (debugMode)
  {
    println("in  >> stage_titles.txt");
  }
  for (String a : titles)
  {
    String[] sp = a.split(":");
    stageTitles[parseInt(sp[0])] = sp[1];
  }

  eventPut(stage);
}

void draw()
{
  background(backcolor);

  ctrl.run();

  eventRun(stage);

  if (debugMode)
  {
    // 情報
    println();
    println("frameCount:" + frameCount);
    println("frameRate " + frameRate);
    println("mouseX:"+mouseX);
    println("mouseY:"+mouseY);
    println("key:"+key);
    println("keyCode:"+keyCode);
  }
}

void keyPressed()
{
  switch (key)
  {
  case 's':
  case 'S':
    String name = "" + year() + "" + month() + "" + day() + "" +
      hour() + "" + minute() + ""+second();
    save("saveFrames\\" + name + ".png");
    if (debugMode)
    {
      println("out << saveFrames\\_" + name + ".png");
    }
    break;

  case 'd':
  case 'D':
    debugMode ^= true;
    break;

  case 'm':
  case 'M':
    isPlayBGM ^= true;
    for (AudioPlayer a : BGMs.values())
    {
      if (isPlayBGM)
        a.unmute();
      else
        a.mute();
    }
    break;
  }
}
