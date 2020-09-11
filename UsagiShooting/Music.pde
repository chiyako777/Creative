/*BGM,SE*/
import processing.sound.*;
class Music{
  
  SoundFile bgm1;    
  SoundFile hitPlayer;  //被弾時SE
  SoundFile defeteEnemy;  //敵機撃破SE
  
  Music(PApplet sketch){
    //bgm1 = new SoundFile(sketch,"野良猫は宇宙を目指した_2.mp3");
    bgm1 = new SoundFile(sketch,"ビーストメトロポリス.mp3");
    hitPlayer = new SoundFile(sketch,"se_maoudamashii_magical19.mp3");
    defeteEnemy = new SoundFile(sketch,"se_maoudamashii_battle09.mp3");
  }
  
  void playBGM(){
    if(!bgm1.isPlaying()){
      bgm1.loop();
    }
  }
  
  void playHitPlayer(){
    hitPlayer.amp(0.2);
    hitPlayer.play();
  }

  void playDefeteEnemy(){
    defeteEnemy.amp(0.5);
    defeteEnemy.play();
  }
  
}
