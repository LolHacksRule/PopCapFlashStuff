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
      
      public function FlameGemExplodeEvent(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function Set(locus:Gem) : void
      {
         this.m_Locus = locus;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_Locus = null;
         this.m_IsDone = false;
      }
      
      public function Update(gameSpeed:Number) : void
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
   }
}
