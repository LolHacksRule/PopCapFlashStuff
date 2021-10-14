package com.popcap.flash.bejeweledblitz.logic.gems
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class ShatterEvent implements IBlitzEvent
   {
       
      
      private var mGem:Gem;
      
      private var mIsDone:Boolean;
      
      public function ShatterEvent()
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
         this.mGem = null;
         this.mIsDone = false;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         if(this.mIsDone)
         {
            return;
         }
         this.mGem.SetDead(true);
         this.mIsDone = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
