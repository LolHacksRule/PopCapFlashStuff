package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class FlameGemExplodeEvent implements IBlitzEvent
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Locus:Gem;
      
      private var m_IsDone:Boolean;
      
      public function FlameGemExplodeEvent(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function Set(param1:Gem) : void
      {
         this.m_Locus = param1;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_Locus = null;
         this.m_IsDone = false;
      }
      
      public function Update(param1:Number) : void
      {
         if(this.m_IsDone)
         {
            return;
         }
         this.m_IsDone = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      public function isDarkEnabled() : Boolean
      {
         return false;
      }
   }
}
