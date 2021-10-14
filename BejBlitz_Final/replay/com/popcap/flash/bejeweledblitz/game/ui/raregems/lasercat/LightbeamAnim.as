package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   
   public class LightbeamAnim extends AnimatedSprite
   {
      
      public static const ANIM_TICKS_INTRO:int = 50;
      
      public static const ANIM_TICKS_OUTRO:int = 120;
      
      protected static const ANIM_NAME_INTRO:String = "INTRO";
      
      protected static const ANIM_NAME_OUTRO:String = "OUTRO";
      
      protected static const STATE_INACTIVE:int = 0;
      
      protected static const STATE_INTRO:int = 1;
      
      protected static const STATE_OUTRO:int = 2;
      
      protected static const ANIM_DATA_INTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      protected static const ANIM_DATA_OUTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      {
         ANIM_DATA_INTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,-340,0.25,1));
         ANIM_DATA_INTRO.push(new KeyframeData(0.781 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,-10.95,0.25,1));
         ANIM_DATA_INTRO.push(new KeyframeData(ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,-10.95,1,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,-10.95,1,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.316 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,-10.95,0.25,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.724 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,-340,0.25,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,-340,0.25,1));
      }
      
      protected var m_App:Blitz3App;
      
      protected var m_Spotlight:Bitmap;
      
      public function LightbeamAnim(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Spotlight = new Bitmap();
      }
      
      public function Init() : void
      {
         this.m_Spotlight.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_SPOTLIGHT);
         this.m_Spotlight.x = -this.m_Spotlight.width * 0.5;
         addChild(this.m_Spotlight);
         this.CreateAnims();
         addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      public function PlayIntroAnim() : void
      {
         visible = true;
         PlayAnimation(ANIM_NAME_INTRO);
      }
      
      public function PlayOutroAnim() : void
      {
         visible = true;
         PlayAnimation(ANIM_NAME_OUTRO);
      }
      
      protected function CreateAnims() : void
      {
         AddAnimation(ANIM_NAME_INTRO,ANIM_DATA_INTRO);
         AddAnimation(ANIM_NAME_OUTRO,ANIM_DATA_OUTRO);
      }
      
      public function HandleAnimComplete(event:AnimationEvent) : void
      {
         if(event.animationName == ANIM_NAME_OUTRO)
         {
            visible = false;
         }
      }
   }
}
