package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.BoardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.ICatseyeRGLogicHandler;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class LaserCatWidget extends Sprite implements ICatseyeRGLogicHandler
   {
      
      protected static const MEOW_DELAY:int = 150;
      
      protected static const ANIM_TICKS_EXPLOSION_INTRO:int = 35;
      
      protected static const ANIM_TICKS_EXPLOSION_OUTRO:int = 25;
      
      protected static const ANIM_NAME_EXPLOSION_INTRO:String = "EXPLOSION_INTRO";
      
      protected static const ANIM_NAME_EXPLOSION_OUTRO:String = "EXPLOSION_OUTRO";
      
      protected static const ANIM_DATA_EXPLOSION_INTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      protected static const ANIM_DATA_EXPLOSION_OUTRO:Vector.<KeyframeData> = new Vector.<KeyframeData>();
      
      {
         ANIM_DATA_EXPLOSION_INTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,0.01,0.01));
         ANIM_DATA_EXPLOSION_INTRO.push(new KeyframeData(0.6 * ANIM_TICKS_EXPLOSION_INTRO,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,1,1));
         ANIM_DATA_EXPLOSION_INTRO.push(new KeyframeData(0.8 * ANIM_TICKS_EXPLOSION_INTRO,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,1.4,1.4));
         ANIM_DATA_EXPLOSION_INTRO.push(new KeyframeData(ANIM_TICKS_EXPLOSION_INTRO,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,1,1));
         ANIM_DATA_EXPLOSION_OUTRO.push(new KeyframeData(0,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,1,1));
         ANIM_DATA_EXPLOSION_OUTRO.push(new KeyframeData(ANIM_TICKS_EXPLOSION_OUTRO,KeyframeData.IGNORE_VALUE,KeyframeData.IGNORE_VALUE,0.01,0.01));
      }
      
      protected var m_App:Blitz3App;
      
      protected var m_Anim:LaserCatAnim;
      
      protected var m_LaserSources:Vector.<Point>;
      
      protected var m_MultExplosion:Bitmap;
      
      protected var m_MultExplosionAnim:AnimatedSprite;
      
      protected var m_MultExplosionContainer:Sprite;
      
      protected var m_TxtExplosionMult:TextField;
      
      protected var m_Lasers:Vector.<Laser>;
      
      protected var m_CurLaser:int;
      
      protected var m_IsActive:Boolean;
      
      protected var m_MeowTimer:int;
      
      protected var m_MultExplosionTimer:int;
      
      public function LaserCatWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Anim = new LaserCatAnim(app);
         this.m_Lasers = new Vector.<Laser>(CatseyeRGLogic.NUM_LASERS);
         for(var i:int = 0; i < CatseyeRGLogic.NUM_LASERS; i++)
         {
            this.m_Lasers[i] = new Laser(app);
         }
         this.m_CurLaser = 0;
         this.m_MultExplosionContainer = new Sprite();
         this.m_MultExplosionAnim = new AnimatedSprite();
         this.m_MultExplosion = new Bitmap();
         this.m_TxtExplosionMult = new TextField();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function Init() : void
      {
         var laser:Laser = null;
         var catGem:CatseyeRGLogic = null;
         this.m_MultExplosionAnim.addChild(this.m_MultExplosion);
         this.m_MultExplosionAnim.addChild(this.m_TxtExplosionMult);
         this.m_MultExplosionContainer.addChild(this.m_MultExplosionAnim);
         addChild(this.m_MultExplosionContainer);
         addChild(this.m_Anim);
         for each(laser in this.m_Lasers)
         {
            addChild(laser);
            laser.Init();
         }
         this.m_Anim.Init();
         this.FindLaserSources();
         catGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(CatseyeRGLogic.ID) as CatseyeRGLogic;
         if(catGem)
         {
            catGem.AddHandler(this);
         }
         this.m_MultExplosion.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_EXPLOSION);
         var baseText:TextField = this.m_App.ui.game.sidebar.score.multiText;
         var format:TextFormat = new TextFormat();
         format.align = baseText.defaultTextFormat.align;
         format.font = baseText.defaultTextFormat.font;
         format.size = baseText.defaultTextFormat.size;
         format.color = 16711680;
         this.m_TxtExplosionMult.defaultTextFormat = format;
         this.m_TxtExplosionMult.embedFonts = true;
         this.m_TxtExplosionMult.selectable = false;
         this.m_TxtExplosionMult.filters = [new GlowFilter(16776960)];
         this.m_TxtExplosionMult.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtExplosionMult.htmlText = "x1";
         this.m_MultExplosion.x = -this.m_MultExplosion.width * 0.5;
         this.m_MultExplosion.y = -this.m_MultExplosion.height * 0.5;
         this.m_TxtExplosionMult.x = -this.m_TxtExplosionMult.width * 0.5;
         this.m_TxtExplosionMult.y = -this.m_TxtExplosionMult.height * 0.5;
         this.m_MultExplosionAnim.AddAnimation(ANIM_NAME_EXPLOSION_INTRO,ANIM_DATA_EXPLOSION_INTRO);
         this.m_MultExplosionAnim.AddAnimation(ANIM_NAME_EXPLOSION_OUTRO,ANIM_DATA_EXPLOSION_OUTRO);
         this.m_MultExplosionAnim.addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
      }
      
      public function Reset() : void
      {
         var laser:Laser = null;
         this.m_CurLaser = 0;
         this.m_IsActive = false;
         visible = false;
         for each(laser in this.m_Lasers)
         {
            laser.Reset();
         }
         this.m_Anim.Reset();
         this.m_MeowTimer = -1;
         this.m_MultExplosionAnim.visible = false;
         this.m_MultExplosionTimer = -1;
      }
      
      public function Update() : void
      {
         var laser:Laser = null;
         if(!this.m_IsActive)
         {
            return;
         }
         if(this.m_MeowTimer >= 0)
         {
            --this.m_MeowTimer;
            if(this.m_MeowTimer < 0)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_CAT_MEOW);
            }
         }
         if(this.m_MultExplosionTimer >= 0)
         {
            --this.m_MultExplosionTimer;
            if(this.m_MultExplosionTimer < 0)
            {
               this.m_MultExplosionAnim.visible = true;
               this.m_MultExplosionAnim.PlayAnimation(ANIM_NAME_EXPLOSION_INTRO);
            }
         }
         for each(laser in this.m_Lasers)
         {
            laser.Update();
         }
         this.m_MultExplosionAnim.Update();
         this.m_Anim.Update();
      }
      
      public function HandleLaserCatBegin() : void
      {
         this.m_IsActive = true;
         visible = true;
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_CAT_ENTER);
         this.m_Anim.PlayIntroAnim();
         this.m_TxtExplosionMult.htmlText = "x" + this.m_App.logic.multiLogic.multiplier;
         var rect:Rectangle = this.m_App.ui.game.sidebar.score.multiText.getRect(this);
         this.m_MultExplosionContainer.x = rect.x + rect.width * 0.5;
         this.m_MultExplosionContainer.y = rect.y + rect.height * 0.5;
         this.FireLaserAt(rect.x + rect.width * 0.5,rect.y + rect.height * 0.5,CatseyeRGLogic.EXPLOSION_DELAY);
         this.m_MultExplosionTimer = CatseyeRGLogic.EXPLOSION_DELAY;
      }
      
      public function HandleLaserCatEnd() : void
      {
         this.m_MeowTimer = MEOW_DELAY;
         this.m_Anim.FinishIdleAnim();
         this.m_MultExplosionAnim.PlayAnimation(ANIM_NAME_EXPLOSION_OUTRO);
      }
      
      public function HandleLaserCatDestroyedGem(row:int, col:int, delayTicks:int, firingDelay:int) : void
      {
         var board:BoardWidget = this.m_App.ui.game.board;
         if(!board)
         {
            return;
         }
         var point:Point = new Point((col + 0.5) * GemSprite.GEM_SIZE,(row + 0.5) * GemSprite.GEM_SIZE);
         point = this.globalToLocal(board.gemLayer.localToGlobal(point));
         var targetX:Number = point.x;
         var targetY:Number = point.y;
         this.FireLaserAt(targetX,targetY,delayTicks);
         this.m_Anim.StartRecoil(firingDelay);
      }
      
      protected function FireLaserAt(targetX:Number, targetY:Number, animTime:int) : void
      {
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_FIRE);
         this.m_CurLaser %= CatseyeRGLogic.NUM_LASERS;
         var source:Point = this.m_LaserSources[int(Math.random() * this.m_LaserSources.length)];
         var point:Point = new Point(source.x,source.y);
         point = this.globalToLocal(this.m_Anim.catHead.localToGlobal(point));
         var laser:Laser = this.m_Lasers[this.m_CurLaser];
         laser.CreateAnim(point.x,point.y,targetX,targetY,animTime);
         ++this.m_CurLaser;
      }
      
      protected function FindLaserSources() : void
      {
         if(this.m_LaserSources)
         {
            return;
         }
         this.m_LaserSources = this.m_Anim.GetLaserSources();
      }
      
      protected function HandleAnimComplete(event:AnimationEvent) : void
      {
         if(event.animationName == ANIM_NAME_EXPLOSION_OUTRO)
         {
            this.m_MultExplosionAnim.visible = false;
         }
      }
   }
}
