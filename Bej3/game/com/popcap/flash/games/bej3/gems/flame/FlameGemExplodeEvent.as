package com.popcap.flash.games.bej3.gems.flame
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.events.Event;
   
   public class FlameGemExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "FlameGemExplodeEvent";
       
      
      private var mLocus:Gem;
      
      private var mLogic:BlitzLogic;
      
      private var mIsDone:Boolean = false;
      
      public function FlameGemExplodeEvent(locus:Gem, logic:BlitzLogic)
      {
         super(ID,bubbles,cancelable);
         this.mLocus = locus;
         this.mLogic = logic;
      }
      
      public function get locus() : Gem
      {
         return this.mLocus;
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
         this.mIsDone = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
   }
}
