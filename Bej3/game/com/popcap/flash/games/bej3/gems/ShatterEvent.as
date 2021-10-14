package com.popcap.flash.games.bej3.gems
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class ShatterEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "ShatterEvent";
       
      
      private var mGem:Gem;
      
      private var mIsDone:Boolean = false;
      
      public function ShatterEvent(gem:Gem)
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
         this.mGem.isDead = true;
         this.mIsDone = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
