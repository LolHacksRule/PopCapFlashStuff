package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismCreateEvent;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.geom.Point;
   
   public class PhoenixPrismCreateEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var mEvent:PhoenixPrismCreateEvent;
      
      private var mLocus:Gem;
      
      private var mInitialPos:Vector.<Point>;
      
      private var mFinalPos:Point;
      
      private var mIsDone:Boolean = false;
      
      private var mFirstUpdate:Boolean = true;
      
      public function PhoenixPrismCreateEffect(param1:Blitz3App, param2:PhoenixPrismCreateEvent)
      {
         super();
         this.m_App = param1;
         this.mEvent = param2;
         this.mLocus = param2.GetLocus();
         this.init();
      }
      
      private function init() : void
      {
         this.mFinalPos = new Point(this.mLocus.x,this.mLocus.y);
         this.mInitialPos = new Vector.<Point>();
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var _loc4_:Gem = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(this.mIsDone == true)
         {
            return;
         }
         var _loc1_:Number = this.mEvent.GetPercent();
         if(_loc1_ >= 1)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_PHOENIXPRISM_WINK);
            this.mIsDone = true;
            return;
         }
         var _loc2_:Vector.<Gem> = this.mEvent.GetGems();
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc5_:int = _loc2_.length;
         if(this.mFirstUpdate)
         {
            this.mFirstUpdate = false;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc4_ = _loc2_[_loc3_];
               this.mInitialPos[_loc3_] = new Point(_loc4_.x,_loc4_.y);
               _loc3_++;
            }
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc6_ = (_loc6_ = this.mInitialPos[_loc3_].x) + (this.mFinalPos.x - this.mInitialPos[_loc3_].x) * _loc1_;
            _loc7_ = (_loc7_ = this.mInitialPos[_loc3_].y) + (this.mFinalPos.y - this.mInitialPos[_loc3_].y) * _loc1_;
            _loc4_.x = _loc6_;
            _loc4_.y = _loc7_;
            _loc3_++;
         }
      }
   }
}
