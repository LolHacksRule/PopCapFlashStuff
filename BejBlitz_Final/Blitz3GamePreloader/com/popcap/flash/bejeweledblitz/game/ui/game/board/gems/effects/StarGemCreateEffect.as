package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.geom.Point;
   
   public class StarGemCreateEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var mEvent:StarGemCreateEvent;
      
      private var mLocus:Gem;
      
      private var mInitialPos:Vector.<Point>;
      
      private var mFinalPos:Point;
      
      private var mIsDone:Boolean = false;
      
      private var mFirstUpdate:Boolean = true;
      
      public function StarGemCreateEffect(param1:Blitz3App, param2:StarGemCreateEvent)
      {
         super();
         this.m_App = param1;
         this.mEvent = param2;
         this.mLocus = this.mEvent.GetLocus();
         this.init();
      }
      
      private function init() : void
      {
         this.mFinalPos = new Point(this.mLocus.x,this.mLocus.y);
         this.mInitialPos = new Vector.<Point>();
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_APPEAR);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var _loc4_:Point = null;
         var _loc6_:Gem = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(this.mIsDone == true)
         {
            return;
         }
         var _loc1_:Number = this.mEvent.GetPercent();
         if(_loc1_ >= 1)
         {
            this.mIsDone = true;
            return;
         }
         var _loc2_:Vector.<Gem> = this.mEvent.GetGems();
         var _loc3_:int = _loc2_.length;
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc5_:int = 0;
         if(this.mFirstUpdate)
         {
            this.mFirstUpdate = false;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = _loc2_[_loc5_];
               this.mInitialPos[_loc5_] = new Point(_loc6_.x,_loc6_.y);
               _loc5_++;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc7_ = (_loc7_ = (_loc4_ = this.mInitialPos[_loc5_]).x) + (this.mFinalPos.x - _loc4_.x) * _loc1_;
            _loc8_ = (_loc8_ = _loc4_.y) + (this.mFinalPos.y - _loc4_.y) * _loc1_;
            _loc6_.x = _loc7_;
            _loc6_.y = _loc8_;
            _loc5_++;
         }
      }
   }
}
