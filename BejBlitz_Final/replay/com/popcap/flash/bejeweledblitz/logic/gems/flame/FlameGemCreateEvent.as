package com.popcap.flash.bejeweledblitz.logic.gems.flame
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class FlameGemCreateEvent implements IBlitzEvent
   {
      
      public static const DURATION:Number = 30;
       
      
      private var m_Locus:Gem;
      
      private var m_Match:Match;
      
      private var m_Gems:Vector.<Gem>;
      
      private var m_Time:Number;
      
      private var m_IsDone:Boolean;
      
      public function FlameGemCreateEvent()
      {
         super();
         this.m_Gems = new Vector.<Gem>();
      }
      
      public function GetPercent() : Number
      {
         return this.m_Time / DURATION;
      }
      
      public function GetLocus() : Gem
      {
         return this.m_Locus;
      }
      
      public function GetGems() : Vector.<Gem>
      {
         return this.m_Gems;
      }
      
      public function GetTime() : Number
      {
         return this.m_Time;
      }
      
      public function Set(locus:Gem, match:Match) : void
      {
         this.m_Locus = locus;
         this.m_Match = match;
      }
      
      public function Init() : void
      {
         var gem:Gem = null;
         this.m_Gems.length = 0;
         if(this.m_Match == null)
         {
            return;
         }
         for each(gem in this.m_Match.matchGems)
         {
            if(!(gem == null || gem == this.m_Locus || !gem.IsMatching() || gem.IsElectric()))
            {
               gem.Flush();
               this.m_Gems.push(gem);
            }
         }
      }
      
      public function Reset() : void
      {
         this.m_Time = 0;
         this.m_IsDone = false;
         this.m_Locus = null;
         this.m_Match = null;
         this.m_Gems.length = 0;
      }
      
      public function Update(speed:Number) : void
      {
         if(this.m_IsDone)
         {
            return;
         }
         this.m_Time += speed;
         if(this.m_Time >= DURATION)
         {
            this.m_Time = DURATION;
            this.m_IsDone = true;
            this.OnDone();
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
      
      private function OnDone() : void
      {
         var gem:Gem = null;
         var numGems:int = this.m_Gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.m_Gems[i];
            gem.SetDead(true);
         }
      }
   }
}
