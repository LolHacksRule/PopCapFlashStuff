package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   
   public class CatHeadAnim extends AnimatedSprite
   {
      
      public static const ANIM_TICKS_INTRO:int = 225;
      
      public static const ANIM_TICKS_IDLE:int = 100;
      
      public static const ANIM_TICKS_OUTRO:int = 150;
      
      public static const ANIM_NAME_INTRO:String = "INTRO";
      
      public static const ANIM_NAME_IDLE:String = "IDLE";
      
      public static const ANIM_NAME_OUTRO:String = "OUTRO";
      
      protected static const STATE_INACTIVE:int = 0;
      
      protected static const STATE_INTRO:int = 1;
      
      protected static const STATE_IDLE:int = 2;
      
      protected static const STATE_OUTRO:int = 3;
      
      protected static const ANIM_DATA_INTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      protected static const ANIM_DATA_IDLE:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      protected static const ANIM_DATA_OUTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      {
         ANIM_DATA_INTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,-60.5,1,1));
         ANIM_DATA_INTRO.push(new KeyframeData(0.175 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,-60.5,1,1));
         ANIM_DATA_INTRO.push(new KeyframeData(0.426 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,214.9,1,1));
         ANIM_DATA_INTRO.push(new KeyframeData(0.545 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,335.75,0.915,1.255));
         ANIM_DATA_INTRO.push(new KeyframeData(0.566 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,364.8,0.9,1.3));
         ANIM_DATA_INTRO.push(new KeyframeData(0.685 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,196.05,1.2,0.85));
         ANIM_DATA_INTRO.push(new KeyframeData(0.706 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,185.05,1.3,0.75));
         ANIM_DATA_INTRO.push(new KeyframeData(0.79 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,334.75,1,1.3));
         ANIM_DATA_INTRO.push(new KeyframeData(0.881 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,196.05,1.2,0.75));
         ANIM_DATA_INTRO.push(new KeyframeData(0.909 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,187.35,1.1,0.75));
         ANIM_DATA_INTRO.push(new KeyframeData(0.972 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,198.2,1,1));
         ANIM_DATA_INTRO.push(new KeyframeData(0.986 * ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,203.6,1,1));
         ANIM_DATA_INTRO.push(new KeyframeData(ANIM_TICKS_INTRO,KeyframeData.IGNORE_VALUE,206.3,1,1));
         ANIM_DATA_IDLE.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,206.3,1,1));
         ANIM_DATA_IDLE.push(new KeyframeData(0.524 * ANIM_TICKS_IDLE,KeyframeData.IGNORE_VALUE,189.5,1,1));
         ANIM_DATA_IDLE.push(new KeyframeData(0.825 * ANIM_TICKS_IDLE,KeyframeData.IGNORE_VALUE,201.35,1,1));
         ANIM_DATA_IDLE.push(new KeyframeData(ANIM_TICKS_IDLE,KeyframeData.IGNORE_VALUE,206.3,1,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,206.3,1,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.011 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,209.5,1,1));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.042 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,201.5,1.3,0.9));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.084 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,204.3,1.5,0.5));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.168 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,176.95,0.4,1.6));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.337 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,97.3,0.5,1.5));
         ANIM_DATA_OUTRO.push(new KeyframeData(0.568 * ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,6.9,0.9,1.3));
         ANIM_DATA_OUTRO.push(new KeyframeData(ANIM_TICKS_OUTRO,KeyframeData.IGNORE_VALUE,-60.5,1,1));
      }
      
      protected var m_App:Blitz3App;
      
      protected var m_CatHead:Bitmap;
      
      protected var m_LaserSources:Vector.<Point>;
      
      protected var m_Eyes:Vector.<LaserCatEye>;
      
      protected var m_CurState:int;
      
      protected var m_AllowOutro:Boolean;
      
      public function CatHeadAnim(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_CatHead = new Bitmap();
         this.m_LaserSources = new Vector.<Point>();
         this.m_Eyes = new Vector.<LaserCatEye>();
         filters = [new GlowFilter(16777164,1,18,18,3.33,1)];
      }
      
      public function Init() : void
      {
         var eye:LaserCatEye = null;
         this.m_CatHead.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_HEAD);
         this.m_CatHead.x = -this.m_CatHead.width * 0.5;
         this.m_CatHead.y = -this.m_CatHead.height * 0.5;
         addChild(this.m_CatHead);
         addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
         this.CreateEyes();
         this.CreateAnims();
         for each(eye in this.m_Eyes)
         {
            eye.Init();
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         var eye:LaserCatEye = null;
         this.m_CurState = STATE_INACTIVE;
         visible = false;
         this.m_AllowOutro = false;
         for each(eye in this.m_Eyes)
         {
            eye.Reset();
         }
      }
      
      override public function Update() : void
      {
         var eye:LaserCatEye = null;
         super.Update();
         var eyesVisible:Boolean = false;
         if(this.m_CurState == STATE_INTRO && GetCurrentAnimPos() >= 0.727 * ANIM_TICKS_INTRO)
         {
            eyesVisible = true;
         }
         else if(this.m_CurState == STATE_IDLE)
         {
            eyesVisible = true;
         }
         else if(this.m_CurState == STATE_OUTRO && GetCurrentAnimPos() <= 0.302 * ANIM_TICKS_INTRO)
         {
            eyesVisible = true;
         }
         for each(eye in this.m_Eyes)
         {
            eye.Update();
            eye.visible = eyesVisible;
         }
      }
      
      public function PlayIntroAnim() : void
      {
         visible = true;
         PlayAnimation(ANIM_NAME_INTRO);
         this.m_CurState = STATE_INTRO;
      }
      
      public function FinishIdleAnim() : void
      {
         this.m_AllowOutro = true;
      }
      
      public function GetLaserSources() : Vector.<Point>
      {
         return this.m_LaserSources;
      }
      
      protected function CreateEyes() : void
      {
         var point:Point = null;
         var eye:LaserCatEye = null;
         this.m_LaserSources.push(new Point(-17,6));
         this.m_LaserSources.push(new Point(30.35,3.5));
         for each(point in this.m_LaserSources)
         {
            eye = new LaserCatEye(this.m_App);
            eye.x = point.x;
            eye.y = point.y;
            addChild(eye);
            this.m_Eyes.push(eye);
         }
      }
      
      protected function CreateAnims() : void
      {
         AddAnimation(ANIM_NAME_INTRO,ANIM_DATA_INTRO);
         AddAnimation(ANIM_NAME_IDLE,ANIM_DATA_IDLE);
         AddAnimation(ANIM_NAME_OUTRO,ANIM_DATA_OUTRO);
      }
      
      protected function PlayIdleAnim() : void
      {
         visible = true;
         PlayAnimation(ANIM_NAME_IDLE);
         this.m_CurState = STATE_IDLE;
      }
      
      protected function PlayOutroAnim() : void
      {
         visible = true;
         PlayAnimation(ANIM_NAME_OUTRO);
         this.m_CurState = STATE_OUTRO;
      }
      
      protected function HandleAnimComplete(event:AnimationEvent) : void
      {
         if(this.m_CurState == STATE_INTRO)
         {
            this.PlayIdleAnim();
         }
         else if(this.m_CurState == STATE_IDLE)
         {
            if(this.m_AllowOutro)
            {
               this.PlayOutroAnim();
            }
            else
            {
               this.PlayIdleAnim();
            }
         }
         else if(this.m_CurState == STATE_OUTRO)
         {
            this.m_CurState = STATE_INACTIVE;
            visible = false;
         }
      }
   }
}
