package com.popcap.flash.bejeweledblitz.game.ui.raregems.lasercat
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
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
      
      protected var _app:Blitz3App;
      
      protected var _anim:LaserCatAnim;
      
      protected var _laserSources:Vector.<Point>;
      
      protected var _multExplosion:Bitmap;
      
      protected var _multExplosionAnim:AnimatedSprite;
      
      protected var _multExplosionContainer:Sprite;
      
      protected var _txtExplosionMult:TextField;
      
      protected var _lasers:Vector.<Laser>;
      
      protected var _curLaser:int;
      
      protected var _isActive:Boolean;
      
      protected var _meowTimer:int;
      
      protected var _multExplosionTimer:int;
      
      public function LaserCatWidget(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._anim = new LaserCatAnim(param1);
         this._lasers = new Vector.<Laser>(this._app.logic.config.catseyeRGLogicNumLasers);
         var _loc2_:int = 0;
         while(_loc2_ < this._app.logic.config.catseyeRGLogicNumLasers)
         {
            this._lasers[_loc2_] = new Laser(param1);
            _loc2_++;
         }
         this._curLaser = 0;
         this._multExplosionContainer = new Sprite();
         this._multExplosionAnim = new AnimatedSprite();
         this._multExplosion = new Bitmap();
         this._txtExplosionMult = new TextField();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function init() : void
      {
         var _loc1_:Laser = null;
         var _loc2_:CatseyeRGLogic = null;
         this._multExplosionAnim.addChild(this._multExplosion);
         this._multExplosionAnim.addChild(this._txtExplosionMult);
         this._multExplosionContainer.addChild(this._multExplosionAnim);
         addChild(this._multExplosionContainer);
         addChild(this._anim);
         this._anim.x = (this._app.ui as MainWidgetGame).game.AlignmentAnchor.x;
         this._anim.y = (this._app.ui as MainWidgetGame).game.AlignmentAnchor.y;
         for each(_loc1_ in this._lasers)
         {
            addChild(_loc1_);
            _loc1_.Init();
         }
         this._anim.Init();
         this.FindLaserSources();
         _loc2_ = this._app.logic.rareGemsLogic.GetRareGemByStringID(CatseyeRGLogic.ID) as CatseyeRGLogic;
         if(_loc2_)
         {
            _loc2_.AddHandler(this);
         }
         this._multExplosion.bitmapData = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LASER_CAT_EXPLOSION);
         var _loc3_:TextField = (this._app.ui as MainWidgetGame).game.multiplierWidget.getMultiplierLabel();
         var _loc4_:TextFormat;
         (_loc4_ = new TextFormat()).align = _loc3_.defaultTextFormat.align;
         _loc4_.font = _loc3_.defaultTextFormat.font;
         _loc4_.size = _loc3_.defaultTextFormat.size;
         _loc4_.color = 16711680;
         this._txtExplosionMult.defaultTextFormat = _loc4_;
         this._txtExplosionMult.embedFonts = true;
         this._txtExplosionMult.selectable = false;
         this._txtExplosionMult.filters = [new GlowFilter(16776960)];
         this._txtExplosionMult.autoSize = TextFieldAutoSize.CENTER;
         this._txtExplosionMult.htmlText = "x1";
         this._multExplosion.x = -this._multExplosion.width * 0.5;
         this._multExplosion.y = -this._multExplosion.height * 0.5;
         this._txtExplosionMult.x = -this._txtExplosionMult.width * 0.5;
         this._txtExplosionMult.y = -this._txtExplosionMult.height * 0.5;
         this._multExplosionAnim.AddAnimation(ANIM_NAME_EXPLOSION_INTRO,ANIM_DATA_EXPLOSION_INTRO);
         this._multExplosionAnim.AddAnimation(ANIM_NAME_EXPLOSION_OUTRO,ANIM_DATA_EXPLOSION_OUTRO);
         this._multExplosionAnim.addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
         this.reset();
      }
      
      public function reset() : void
      {
         var _loc1_:Laser = null;
         this._curLaser = 0;
         this._isActive = false;
         visible = false;
         for each(_loc1_ in this._lasers)
         {
            _loc1_.Reset();
         }
         this._anim.Reset();
         this._meowTimer = -1;
         this._multExplosionAnim.visible = false;
         this._multExplosionTimer = -1;
      }
      
      public function Update() : void
      {
         var _loc1_:Laser = null;
         if(!this._isActive)
         {
            return;
         }
         if(this._meowTimer >= 0)
         {
            --this._meowTimer;
            if(this._meowTimer < 0)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_CAT_MEOW);
            }
         }
         if(this._multExplosionTimer >= 0)
         {
            --this._multExplosionTimer;
            if(this._multExplosionTimer < 0)
            {
               this._multExplosionAnim.visible = true;
               this._multExplosionAnim.PlayAnimation(ANIM_NAME_EXPLOSION_INTRO);
            }
         }
         for each(_loc1_ in this._lasers)
         {
            _loc1_.Update();
         }
         this._multExplosionAnim.Update();
         this._anim.Update();
      }
      
      public function HandleLaserCatBegin() : void
      {
         this._isActive = true;
         visible = true;
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_CAT_ENTER);
         this._anim.PlayIntroAnim();
         this._txtExplosionMult.htmlText = "x" + this._app.logic.multiLogic.multiplier;
         var _loc1_:Rectangle = (this._app.ui as MainWidgetGame).game.multiplierWidget.getRect(this);
         this._multExplosionContainer.x = _loc1_.x + _loc1_.width * 0.5;
         this._multExplosionContainer.y = _loc1_.y + _loc1_.height * 0.5;
         this.FireLaserAt(_loc1_.x + _loc1_.width * 0.5,_loc1_.y + _loc1_.height * 0.5,this._app.logic.config.catseyeRGLogicExplosionDelay);
         this._multExplosionTimer = this._app.logic.config.catseyeRGLogicExplosionDelay;
      }
      
      public function HandleLaserCatEnd() : void
      {
         this._meowTimer = MEOW_DELAY;
         this._anim.FinishIdleAnim();
         this._multExplosionAnim.PlayAnimation(ANIM_NAME_EXPLOSION_OUTRO);
      }
      
      public function HandleLaserCatDestroyedGem(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:BoardWidget;
         if(!(_loc5_ = (this._app.ui as MainWidgetGame).game.board))
         {
            return;
         }
         var _loc6_:Point = new Point((param2 + 0.5) * GemSprite.GEM_SIZE,(param1 + 0.5) * GemSprite.GEM_SIZE);
         var _loc7_:Number = (_loc6_ = this.globalToLocal(_loc5_.gemLayer.localToGlobal(_loc6_))).x;
         var _loc8_:Number = _loc6_.y;
         this.FireLaserAt(_loc7_,_loc8_,param3);
         this._anim.StartRecoil(param4);
      }
      
      protected function FireLaserAt(param1:Number, param2:Number, param3:int) : void
      {
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_LASER_FIRE);
         this._curLaser %= this._app.logic.config.catseyeRGLogicNumLasers;
         var _loc4_:Point = this._laserSources[int(Math.random() * this._laserSources.length)];
         var _loc5_:Point = new Point(_loc4_.x,_loc4_.y);
         _loc5_ = this.globalToLocal(this._anim.catHead.localToGlobal(_loc5_));
         var _loc6_:Laser;
         (_loc6_ = this._lasers[this._curLaser]).CreateAnim(_loc5_.x,_loc5_.y,param1,param2,param3);
         ++this._curLaser;
      }
      
      protected function FindLaserSources() : void
      {
         if(this._laserSources)
         {
            return;
         }
         this._laserSources = this._anim.GetLaserSources();
      }
      
      protected function HandleAnimComplete(param1:AnimationEvent) : void
      {
         if(param1.animationName == ANIM_NAME_EXPLOSION_OUTRO)
         {
            this._multExplosionAnim.visible = false;
         }
      }
   }
}
