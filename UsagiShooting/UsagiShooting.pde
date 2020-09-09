
/** ★★★うさぎシューティング★★★ **/

//モード
int mode = Const.MODE_DEV;
//int mode = Const.MODE_PRO;

//シーン番号
int sceneNo = Const.SCENE_NO_TITLE;

//オブジェクト
Opening op;
Player player;
ArrayList<Chapter> chapterList;


void setup(){
  
  size(600,750);
  
  op = new Opening();
  
  /*自機生成*/
  player = new Player(width/2,height*4/5);
  
  /*チャプターリスト生成*/
  chapterList = new ArrayList<Chapter>();
  //chapterList.add(new Chapter1());
  //chapterList.add(new Chapter2());
  chapterList.add(new Chapter3());
  
  /*初回チャプターのみ、先に敵リストを生成する*/
  Chapter ch = chapterList.get(0);
  ch.createEnemy(player);

}

void draw(){
  background(0);
  
  switch(sceneNo){
  
     case Const.SCENE_NO_TITLE:
       /*タイトル画面*/
       drawTitle();
       break;
    
     case Const.SCENE_NO_OPENING:
       /*オープニング画面(カウントダウン)を描画*/
       int count = op.drawOpening();
       if(count == 0){
         sceneNo = Const.SCENE_NO_STAGE;
       }
       break;

     case Const.SCENE_NO_STAGE:
       /*ゲーム(道中)画面*/
       execGame();
       
       break;

     case Const.SCENE_NO_PRE_BOSS:
       break;

     case Const.SCENE_NO_BOSS:
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
void execGame(){
  
  /*上部情報画面描画*/
  fill(127);
  rect(0,0,width,Const.HEIGHT_INFO);
  
  /*チャプターを実行準備*/
  Chapter ch = chapterList.get(0);
  
  //チャプター終了判定
  if(ch.isChapterEnd()){
    
    println("chapter end");

    //終了したチャプターはリストから削除
    chapterList.remove(0);
   
    //全てのチャプターが終了した場合はゲームクリア
    if(chapterList.size() == 0){
      println("game clear");
      sceneNo = Const.SCENE_NO_PRE_BOSS;
      return;
    }
    
    //次のチャプターの敵インスタンスの準備
    ch = chapterList.get(0);
    ch.createEnemy(player);
    
  }
  
  /*チャプターを実行*/
  ch.exec(player);

  /*自機を描画*/
  player.draw();

  /*ゲームオーバー判定*/
  if(mode == Const.MODE_PRO && player.getZanki() <= -1){
    sceneNo = Const.SCENE_NO_GAMEOVER;
  }
  
}
