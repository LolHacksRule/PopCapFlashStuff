package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class MatchEvent implements IBlitzEvent
   {
      
      public static const MATCH_TIME:Number = 25;
       
      
      private var mGem:Gem;
      
      private var mMatchTime:Number;
      
      private var mIsDone:Boolean;
      
      public function MatchEvent()
      {
         super();
         this.Reset();
      }
      
      public function Set(gem:Gem) : void
      {
         this.mGem = gem;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.mMatchTime = MATCH_TIME;
         this.mIsDone = false;
         this.mGem = null;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(this.mGem.IsShattering() || this.mGem.IsDead())
         {
            this.mIsDone = true;
            return;
         }
         this.mMatchTime -= 1 * gameSpeed;
         this.mGem.scale = this.mMatchTime / MATCH_TIME;
         if(this.mMatchTime <= 0)
         {
            this.mGem.SetDead(true);
            this.mIsDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
