package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class FrameWidget extends Sprite
   {
      
      private static const WARNING_REPEAT_DELAY:int = 100;
      
      private static const START_WARNING_TIME:int = 1500;
      
      private static const STOP_WARNING_TIME:int = 0;
      
      private static const TIMER_BAR_WIDTH:int = 317;
       
      
      private var m_App:Blitz3App;
      
      private var mTimeLeft:int;
      
      private var mWarningTimer:int;
      
      private var mWarningDelay:int;
      
      private var mTopFrame:Bitmap;
      
      private var mBottomFrame:Sprite;
      
      private var mBottomFrameBack:Bitmap;
      
      private var mBottomFrameFront:Bitmap;
      
      private var mBottomFrameFlash:Bitmap;
      
      private var mTopFlamingAnimation:ImageInst;
      
      private var mBottomFlamingAnimation:ImageInst;
      
      private var mTopFlamingBitmap:Bitmap;
      
      private var mBottomFlamingBitmap:Bitmap;
      
      private var mFlameFrameNum:Number;
      
      private var mBottomFrameFill:Sprite;
      
      private var mFillTexture:BitmapData;
      
      private var mFillMatrix:Matrix;
      
      private var _tokenTimerEffectVec:Vector.<TokenTimerEffect>;
      
      private var mTopFinisherIndicatorHolder:Sprite;
      
      private var mBottomFinisherIndicatorHolder:Sprite;
      
      private var mForceFill:Number = -1;
      
      private var tokentimereffectLength:int;
      
      private var arrLength:int;
      
      public function FrameWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
      }
      
      public function Init() : void
      {
         var _loc1_:BaseImageManager = null;
         _loc1_ = this.m_App.ImageManager;
         this.mBottomFrame = new Sprite();
         this.mBottomFrameFill = new Sprite();
         this.mBottomFrameFill.x = 11;
         this.mBottomFrameFill.y = 7;
         this.mFillTexture = _loc1_.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FILL);
         this.mBottomFrameBack = new Bitmap(_loc1_.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_BACK));
         addChild(this.mBottomFrame);
         this.mTopFrame = new Bitmap(_loc1_.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_TOP));
         this.mBottomFrameFront = new Bitmap(_loc1_.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FRONT));
         this.mBottomFrameFlash = new Bitmap(_loc1_.getBitmapData(Blitz3GameImages.IMAGE_UI_FRAME_BOTTOM_FLASH));
         this.mBottomFrameBack.x = 9;
         this.mBottomFrameBack.y = 4;
         this.mBottomFrame.addChild(this.mBottomFrameBack);
         this.mBottomFrame.addChild(this.mBottomFrameFront);
         this.mTopFrame.x = -10;
         this.mTopFrame.y = -8;
         this.mBottomFrame.addChild(this.mBottomFrameFlash);
         this.mBottomFrameFlash.y = 2;
         addChild(this.mTopFrame);
         this.mTopFlamingAnimation = this.m_App.flameBordersFactory.TopFrameAnimation;
         this.mBottomFlamingAnimation = this.m_App.flameBordersFactory.BottomFrameAnimation;
         this.mBottomFrame.addChild(this.mBottomFrameFill);
         this.mBottomFrame.x = -10;
         this.mBottomFrame.y = 318;
         this.mTopFlamingBitmap = new Bitmap();
         this.mBottomFlamingBitmap = new Bitmap();
         this.mBottomFrame.addChild(this.mBottomFlamingBitmap);
         this.mBottomFinisherIndicatorHolder = new Sprite();
         this.mBottomFrame.addChild(this.mBottomFinisherIndicatorHolder);
         this.mTopFlamingBitmap.x = -20;
         this.mTopFlamingBitmap.y = -48;
         this.mBottomFlamingBitmap.x = -10;
         this.mBottomFlamingBitmap.y = -40;
         addChild(this.mTopFlamingBitmap);
         this.mTopFinisherIndicatorHolder = new Sprite();
         addChild(this.mTopFinisherIndicatorHolder);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.mTopFlamingBitmap.visible = false;
         this.mBottomFlamingBitmap.visible = false;
         this.mBottomFrameFlash.visible = false;
         this.mTimeLeft = this.m_App.logic.timerLogic.GetGameDuration();
         this.mFlameFrameNum = 0;
         this.mWarningTimer = 0;
         this.DrawFill(1);
         this._tokenTimerEffectVec = new Vector.<TokenTimerEffect>();
         this.mTopFinisherIndicatorHolder.visible = false;
         this.mBottomFinisherIndicatorHolder.visible = false;
      }
      
      private function CreateFrameIndicators(param1:BitmapData, param2:MovieClip, param3:Boolean) : void
      {
         var _loc8_:int = 0;
         var _loc9_:MovieClip = null;
         var _loc10_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Number = 0;
         var _loc7_:int = 0;
         while(_loc7_ < param1.width)
         {
            if(_loc7_ % 10 == 0)
            {
               _loc5_ = 0;
               _loc8_ = 0;
               while(_loc8_ < param1.height)
               {
                  _loc4_ = param1.getPixel(_loc7_,_loc8_);
                  if(_loc5_ == 0 && _loc4_ != 0)
                  {
                     (_loc9_ = this.duplicateObject(param2)).x = _loc7_;
                     _loc9_.y = _loc8_;
                     _loc10_ = parseInt((Math.random() * _loc9_.totalFrames).toString());
                     _loc9_.gotoAndPlay(_loc10_);
                     _loc9_.rotation = Math.random() * 360;
                     _loc6_ = Math.random() + 0.2;
                     _loc9_.scaleX = _loc6_;
                     _loc9_.scaleY = _loc6_;
                     if(param3)
                     {
                        this.mTopFinisherIndicatorHolder.addChild(_loc9_);
                     }
                     else
                     {
                        this.mBottomFinisherIndicatorHolder.addChild(_loc9_);
                     }
                  }
                  _loc5_ = _loc4_;
                  _loc8_++;
               }
            }
            _loc7_++;
         }
      }
      
      public function CreateFinisherFrameIndicators(param1:MovieClip) : void
      {
         var mc:MovieClip = param1;
         try
         {
            this.CreateFrameIndicators(this.mTopFrame.bitmapData,mc,true);
            this.CreateFrameIndicators(this.mBottomFrameFront.bitmapData,mc,false);
         }
         catch(e:Object)
         {
            trace("Error while creating indicators " + e.message);
         }
      }
      
      public function RemoveFinisherFrameIndicator() : void
      {
         while(this.mTopFinisherIndicatorHolder.numChildren > 0)
         {
            this.mTopFinisherIndicatorHolder.removeChildAt(0);
         }
         while(this.mBottomFinisherIndicatorHolder.numChildren > 0)
         {
            this.mBottomFinisherIndicatorHolder.removeChildAt(0);
         }
      }
      
      public function Update() : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:TokenTimerEffect = null;
         this.mTimeLeft = this.m_App.logic.timerLogic.GetTimeRemaining();
         if(this.mTimeLeft <= START_WARNING_TIME && this.mTimeLeft > STOP_WARNING_TIME)
         {
            --this.mWarningTimer;
            if(this.mWarningTimer <= 0)
            {
               this.mWarningTimer = WARNING_REPEAT_DELAY;
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_WARNING);
            }
         }
         if(this.m_App.logic.finisherIndicatorLogic.GetTimeLeft() > 0 || (this.m_App.ui as MainWidgetGame).game.board.forceFinisherIndiciatorEffects)
         {
            this.mTopFinisherIndicatorHolder.visible = true;
            this.mBottomFinisherIndicatorHolder.visible = true;
         }
         else
         {
            this.mTopFinisherIndicatorHolder.visible = false;
            this.mBottomFinisherIndicatorHolder.visible = false;
         }
         var _loc1_:Number = this.m_App.logic.blazingSpeedLogic.GetTimeLeft();
         if(_loc1_ > 0 || (this.m_App.ui as MainWidgetGame).game.board.forceBlazingSpeedEffects)
         {
            this.mTopFlamingBitmap.visible = true;
            this.mBottomFlamingBitmap.visible = true;
            if(!(this.m_App.ui as MainWidgetGame).game.board.forceBlazingSpeedEffects)
            {
               if(_loc1_ > 100)
               {
                  _loc2_ = this.mFlameFrameNum * 0.1;
                  if(_loc2_ > 1)
                  {
                     _loc2_ = 1;
                  }
               }
               else
               {
                  _loc2_ = _loc1_ * 0.01;
               }
               this.mTopFlamingBitmap.alpha = _loc2_;
               this.mBottomFlamingBitmap.alpha = _loc2_;
            }
            this.mTopFlamingAnimation.mFrame = this.mFlameFrameNum % this.mTopFlamingAnimation.mSource.mNumFrames;
            this.mBottomFlamingAnimation.mFrame = this.mFlameFrameNum % this.mBottomFlamingAnimation.mSource.mNumFrames;
            this.mTopFlamingBitmap.bitmapData = this.mTopFlamingAnimation.pixels;
            this.mBottomFlamingBitmap.bitmapData = this.mBottomFlamingAnimation.pixels;
            if(this.m_App.isLQMode)
            {
               this.mFlameFrameNum += 0.02;
            }
            else
            {
               this.mFlameFrameNum += 0.2;
            }
         }
         else
         {
            this.mTopFlamingBitmap.visible = false;
            this.mBottomFlamingBitmap.visible = false;
            this.mFlameFrameNum = 0;
         }
         this.arrLength = this._tokenTimerEffectVec.length;
         var _loc3_:int = 0;
         while(_loc3_ < this.arrLength)
         {
            if((_loc4_ = this._tokenTimerEffectVec[_loc3_]).currentFrame == _loc4_.totalFrames)
            {
               this._tokenTimerEffectVec.splice(_loc3_,1);
               this.mBottomFrameFill.removeChild(_loc4_);
               this.arrLength = this._tokenTimerEffectVec.length;
            }
            else
            {
               _loc3_++;
            }
         }
      }
      
      public function Draw() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:TokenTimerEffect = null;
         var _loc1_:Number = this.mTimeLeft / this.m_App.logic.timerLogic.GetGameDuration();
         if(_loc1_ > 1)
         {
            _loc1_ = 1;
         }
         this.DrawFill(_loc1_);
         if(this.mTimeLeft <= START_WARNING_TIME && this.mTimeLeft > STOP_WARNING_TIME)
         {
            this.mBottomFrameFlash.visible = true;
            _loc1_ = this.mWarningTimer / WARNING_REPEAT_DELAY;
            _loc3_ = _loc1_ * Math.PI;
            _loc4_ = 1 - Math.abs(Math.cos(_loc3_));
            this.mBottomFrameFlash.alpha = _loc4_;
         }
         else
         {
            this.mBottomFrameFlash.visible = false;
         }
         this.tokentimereffectLength = this._tokenTimerEffectVec.length;
         var _loc2_:int = 0;
         while(_loc2_ < this.tokentimereffectLength)
         {
            (_loc5_ = this._tokenTimerEffectVec[_loc2_]).timerBarMC.width = _loc1_ * TIMER_BAR_WIDTH;
            _loc2_++;
         }
      }
      
      public function flashTimerBar() : void
      {
         var _loc1_:TokenTimerEffect = new TokenTimerEffect();
         this._tokenTimerEffectVec.push(_loc1_);
         this.mBottomFrameFill.addChild(_loc1_);
      }
      
      private function DrawFill(param1:Number) : void
      {
         if(this.mForceFill > -1)
         {
            param1 = this.mForceFill;
         }
         this.mBottomFrameFill.graphics.clear();
         this.mBottomFrameFill.graphics.beginBitmapFill(this.mFillTexture);
         this.mBottomFrameFill.graphics.drawRoundRect(0,0,TIMER_BAR_WIDTH * param1,18,1,1);
         this.mBottomFrameFill.graphics.endFill();
      }
      
      private function duplicateObject(param1:MovieClip) : MovieClip
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Class = Object(param1).constructor;
         var _loc3_:MovieClip = new _loc2_();
         _loc3_.transform = param1.transform;
         _loc3_.filters = param1.filters;
         _loc3_.cacheAsBitmap = param1.cacheAsBitmap;
         _loc3_.opaqueBackground = param1.opaqueBackground;
         if(param1.scale9Grid)
         {
            _loc4_ = param1.scale9Grid;
            _loc3_.scale9Grid = _loc4_;
         }
         return _loc3_;
      }
      
      public function GetTimeBar() : Sprite
      {
         return this.mBottomFrameFill;
      }
      
      public function SetForceFill(param1:Number) : void
      {
         this.mForceFill = param1;
      }
   }
}
