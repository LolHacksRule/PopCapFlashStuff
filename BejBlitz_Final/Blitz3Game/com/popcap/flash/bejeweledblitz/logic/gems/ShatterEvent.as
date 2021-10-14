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
      
      public function Set(param1:Gem) : void
      {
         this.mGem = param1;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.mGem = null;
         this.mIsDone = false;
      }
      
      public function Update(param1:Number) : void
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
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
   }
}
