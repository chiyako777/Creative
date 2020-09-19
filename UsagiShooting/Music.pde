/*BGM,SE*/
import processing.sound.*;
class Music{
  
  SoundFile bgm1;    
  SoundFile hitPlayer;  //被弾時SE
  SoundFile defeteEnemy;  //敵機撃破SE
  SoundFile graze;  //グレイズSE
  
  Music(PApplet sketch){
    
    //遊び
    int i = int(random(1,7));
    switch(i){
      case 1:
        bgm1 = new SoundFile(sketch,"ビーストメトロポリス.mp3");
        break;
      case 2:
        bgm1 = new SoundFile(sketch,"忘れがたき、よすがの緑.mp3");
        break;
      case 3:
        bgm1 = new SoundFile(sketch,"夜雀の歌声　～ Night Bird.mp3");
        break;
      case 4:
        bgm1 = new SoundFile(sketch,"ハートフェルトファンシー.mp3");
        break;
      case 5:
        bgm1 = new SoundFile(sketch,"狂気の瞳　～ Invisible Full Moon.mp3");
        break;
      case 6:
        bgm1 = new SoundFile(sketch,"魔法少女達の百年祭.mp3");
        break;
      case 7:
        //レア！！
        bgm1 = new SoundFile(sketch,"野良猫は宇宙を目指した_2.mp3");
        break;        
    }
    
    //bgm1 = new SoundFile(sketch,"狂気の瞳　～ Invisible Full Moon.mp3");
    //bgm1 = new SoundFile(sketch,"野良猫は宇宙を目指した_2.mp3");
    hitPlayer = new SoundFile(sketch,"se_maoudamashii_magical19.mp3");
    defeteEnemy = new SoundFile(sketch,"se_maoudamashii_battle09.mp3");
    graze = new SoundFile(sketch,"firecracker1.mp3");
    //graze = new SoundFile(sketch,"free_sound34.mp3");
  }
  
  void playBGM(){
    if(!bgm1.isPlaying()){
      bgm1.loop();
    }
  }
  
  void playHitPlayer(){
    hitPlayer.amp(0.3);
    hitPlayer.play();
  }

  void playDefeteEnemy(){
    defeteEnemy.amp(0.7);
    defeteEnemy.play();
  }

  void playGraze(){
    if(!graze.isPlaying()){
      graze.amp(2.5);
      graze.play();
    }
  }
  
}
