package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.geom.ColorTransform;
   
   public class CheckerboardWidget extends Bitmap
   {
       
      
      private var m_App:Blitz3App;
      
      private var mOldTrans:ColorTransform;
      
      private var mTransSwitch:Boolean = false;
      
      public function CheckerboardWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         cacheAsBitmap = true;
      }
      
      public function Init() : void
      {
         var _loc1_:BaseImageManager = this.m_App.ImageManager;
         bitmapData = _loc1_.getBitmapData(Blitz3GameImages.IMAGE_CHECKERBOARD);
         this.mOldTrans = transform.colorTransform;
      }
      
      public function Reset() : void
      {
         this.mTransSwitch = false;
         transform.colorTransform = this.mOldTrans;
      }
      
      public function Update() : void
      {
         var _loc2_:ColorTransform = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.m_App.isLQMode)
         {
            return;
         }
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         var _loc3_:Number = this.m_App.logic.blazingSpeedLogic.GetTimeLeft();
         if(_loc3_ > 0 || (this.m_App.ui as MainWidgetGame).game.board.forceBlazingSpeedEffects)
         {
            this.mTransSwitch = true;
            _loc4_ = _loc3_ / this.m_App.logic.blazingSpeedLogic.GetDuration() * 0.5;
            _loc5_ = 4 * Math.max(_loc4_,0.25);
            _loc6_ = _loc3_ / 50 * Math.PI;
            _loc7_ = 1 + (1 - Math.cos(_loc6_)) * 0.5 * (_loc5_ + 1);
            _loc2_ = transform.colorTransform;
            _loc2_.redMultiplier = _loc7_;
            if(_loc2_.redOffset < 128 * 0.08)
            {
               _loc2_.redOffset += 2;
            }
            _loc2_.greenMultiplier = _loc7_ * 0.5;
            if(_loc2_.greenOffset < 64 * 0.08)
            {
               _loc2_.greenOffset += 1;
            }
            transform.colorTransform = _loc2_;
         }
         else if(this.mTransSwitch == true)
         {
            this.mTransSwitch = false;
            transform.colorTransform = this.mOldTrans;
         }
      }
   }
}
