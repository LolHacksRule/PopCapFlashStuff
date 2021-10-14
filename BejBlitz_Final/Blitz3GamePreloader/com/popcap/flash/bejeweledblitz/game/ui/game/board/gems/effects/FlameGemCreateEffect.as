package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class FlameGemCreateEffect extends SpriteEffect
   {
       
      
      private var _app:Blitz3App;
      
      private var _event:FlameGemCreateEvent;
      
      private var _locus:Gem;
      
      private var _initialPos:Vector.<Point>;
      
      private var _finalPos:Point;
      
      private var _isDone:Boolean = false;
      
      private var _hasSoundPlayed:Boolean = false;
      
      private var _firstUpdate:Boolean = true;
      
      private var _appearSound:String = "";
      
      private var _clip:MovieClip;
      
      public function FlameGemCreateEffect(param1:Blitz3App, param2:FlameGemCreateEvent, param3:String = "SOUND_BLITZ3GAME_GEM_FLAME_APPEAR")
      {
         super();
         this._app = param1;
         this._event = param2;
         this._locus = param2.GetLocus();
         this._appearSound = param3;
         this._finalPos = new Point(this._locus.x,this._locus.y);
         this._initialPos = new Vector.<Point>();
         x = this._locus.x * 40 + 20;
         y = this._locus.y * 40 + 20;
         this._clip = new MovieClip();
         this.addChild(this._clip);
         if(this._appearSound != "")
         {
            this._app.SoundManager.playSound(this._appearSound);
         }
         if(param1.logic.rareGemsLogic.isDynamicGem() && this._locus.color == param1.logic.rareGemsLogic.currentRareGem.getFlameColor())
         {
            DynamicRGInterface.attachMovieClip(param1.logic.rareGemsLogic.currentRareGem.getStringID(),"Raregemcreation",this._clip);
         }
      }
      
      override public function IsDone() : Boolean
      {
         return this._isDone;
      }
      
      override public function Update() : void
      {
         var _loc5_:Point = null;
         var _loc6_:Gem = null;
         if(this._isDone)
         {
            return;
         }
         var _loc1_:Number = this._event.GetPercent();
         if(_loc1_ >= 1)
         {
            if(this._clip.numChildren > 0 && this._clip.getChildAt(0) != null)
            {
               if((this._clip.getChildAt(0) as MovieClip).currentFrame >= (this.getChildAt(0) as MovieClip).totalFrames)
               {
                  Utils.removeAllChildrenFrom(this._clip);
                  Utils.removeAllChildrenFrom(this);
                  this._clip = null;
                  this._isDone = true;
               }
            }
            return;
         }
         var _loc2_:Vector.<Gem> = this._event.GetGems();
         var _loc3_:int = _loc2_.length;
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc4_:int = 0;
         if(this._firstUpdate)
         {
            this._firstUpdate = false;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._initialPos[_loc4_] = new Point(_loc2_[_loc4_].x,_loc2_[_loc4_].y);
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = this._initialPos[_loc4_];
            (_loc6_ = _loc2_[_loc4_]).x = _loc5_.x + (this._finalPos.x - _loc5_.x) * _loc1_;
            _loc6_.y = _loc5_.y + (this._finalPos.y - _loc5_.y) * _loc1_;
            _loc4_++;
         }
      }
   }
}
