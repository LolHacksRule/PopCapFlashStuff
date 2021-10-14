package com.popcap.flash.games.bej3.gems
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class MatchEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "MatchEvent";
      
      public static const MATCH_TIME:Number = 25;
       
      
      private var mGem:Gem;
      
      private var mMatchTime:Number = 25;
      
      private var mIsDone:Boolean = false;
      
      public function MatchEvent(gem:Gem)
      {
         super(ID);
         this.mGem = gem;
      }
      
      public function Init() : void
      {
      }
      
      public function Update(gameSpeed:Number) : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(this.mGem.isShattering || this.mGem.isDead)
         {
            this.mIsDone = true;
            return;
         }
         this.mMatchTime -= 1 * gameSpeed;
         this.mGem.scale = this.mMatchTime / MATCH_TIME;
         if(this.mMatchTime <= 0)
         {
            this.mGem.isDead = true;
            this.mIsDone = true;
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
