/** ★★★うさぎシューティング★★★ **/

//モード
int mode = Const.MODE_DEV;
//int mode = Const.MODE_PRO;

//シーン番号
int sceneNo = Const.SCENE_NO_TITLE;

//オブジェクト
Opening op;
Player player;
ArrayList<Stage> stageList;
Music music;

void setup(){
  
  size(600,750);
  
  op = new Opening();
  music = new Music(this);
  
  /*自機生成*/
  player = new Player(width/2,height*4/5);
  
  /*ステージリスト生成*/
  stageList = new ArrayList<Stage>();
  stageList.add(new Stage1());
  
}

void draw(){
  background(0);
  
  switch(sceneNo){
  
     case Const.SCENE_NO_TITLE:
       /*タイトル*/
       drawTitle();
       break;
    
     case Const.SCENE_NO_OPENING:
       /*オープニング*/
       int count = op.drawOpening();
       if(count == 0){
         sceneNo = Const.SCENE_NO_STAGE1;
       }
       break;

     case Const.SCENE_NO_STAGE1:
       /*ステージ1(道中)*/
       music.playBGM();
       Stage stage1 = stageList.get(0);
       execGame(stage1,music);
       
       break;

     case Const.SCENE_NO_PRE_BOSS:
       /*ボス前シーン*/
       sceneNo += 1;  //skip
       break;

     case Const.SCENE_NO_BOSS:
       /*ボス戦*/
       music.playBGM();
       
       break;

     case Const.SCENE_NO_CLEAR:
       break;
       
     case Const.SCENE_NO_GAMEOVER:
       break;
  }
}

void keyPressed(){
  /* 自機移動方向制御 */
  player.pushDirect();
  /* 自機ステータス制御 */
  player.updateStatusByKey(key,Const.KEY_FLG_PRESS);  
}

void keyReleased(){
  /* 自機移動方向制御 */
  player.popDirect();
  /* 自機ステータス制御 */
  player.updateStatusByKey(key,Const.KEY_FLG_RELEASE);
}


//**タイトル画面を描画
void drawTitle(){
  textSize(30);
  text("pless any key...",50,370);
  
  if(keyPressed){
    sceneNo = Const.SCENE_NO_OPENING;
  }
}

//**ゲームを実行
void execGame(Stage stage,Music music){

  /*上部情報画面描画*/
  fill(127);
  rect(0,0,width,Const.HEIGHT_INFO);
  
  /*未初期化の場合、ステージ初期化*/
  if(!stage.getInitFlg()){
    stage.init();
  }
  
  /*チャプターリストを読み込み*/
  ArrayList<Chapter> chapterList = stage.getChapterList();
  
  /*チャプターを実行準備*/
  Chapter ch = chapterList.get(0);
  
  //チャプター終了判定
  if(ch.isChapterEnd()){
    
    println("chapter end");

    //終了したチャプターはリストから削除
    chapterList.remove(0);
   
    //全てのチャプターが終了した場合は次のシーンに進む
    if(chapterList.size() == 0){
      println("全チャプター終了");
      sceneNo += 1;
      return;
    }
    
    //次のチャプターの敵インスタンスの準備
    ch = chapterList.get(0);
    ch.createEnemy(player);
    
  }
  
  /*チャプターを実行*/
  ch.exec(player,music);

  /*自機を描画*/
  player.draw();

  /*ゲームオーバー判定*/
  if(mode == Const.MODE_PRO && player.getZanki() <= -1){
    sceneNo = Const.SCENE_NO_GAMEOVER;
  }
 
}
