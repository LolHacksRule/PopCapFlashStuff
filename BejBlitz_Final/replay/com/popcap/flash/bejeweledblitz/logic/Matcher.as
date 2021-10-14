package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class Matcher
   {
      
      public static const MIN_MATCH:int = 3;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Color:int;
      
      private var m_Gems:Vector.<Gem>;
      
      private var m_TmpGems:Vector.<Gem>;
      
      private var m_Colors:Vector.<int>;
      
      private var m_Last:Gem;
      
      private var m_Size:int;
      
      private var m_Start:int;
      
      private var m_Index:int;
      
      private var m_NextStart:int;
      
      public function Matcher(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Color = Gem.COLOR_NONE;
         this.m_Size = 0;
         this.m_Start = 0;
         this.m_Index = 0;
         this.m_NextStart = 0;
         this.m_Gems = new Vector.<Gem>();
         this.m_TmpGems = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this.m_Gems.length = 0;
         this.m_Last = null;
         this.m_Size = 0;
         this.m_Start = 0;
         this.m_Index = 0;
         this.m_NextStart = 0;
      }
      
      public function Start(newGem:Gem, overrideColor:int) : void
      {
         var color:int = Gem.COLOR_NONE;
         if(newGem != null)
         {
            color = newGem.color;
         }
         if(overrideColor != Gem.COLOR_NONE)
         {
            color = overrideColor;
         }
         if(newGem == null || color == Gem.COLOR_NONE || newGem.type == Gem.TYPE_HYPERCUBE)
         {
            this.m_Last = null;
            this.m_Color = Gem.COLOR_NONE;
            this.m_Size = 0;
            this.m_Start = 0;
            this.m_Index = 0;
            this.m_NextStart = 0;
            return;
         }
         this.m_Color = color;
         if(this.m_Gems.length <= this.m_Index)
         {
            this.m_Gems.length = this.m_Index + 1;
         }
         this.m_Gems[this.m_Index] = newGem;
         this.m_Last = newGem;
         ++this.m_Index;
         ++this.m_Size;
      }
      
      public function Push(newGem:Gem, overrideColor:int) : Match
      {
         var color:int = Gem.COLOR_NONE;
         if(newGem != null)
         {
            color = newGem.color;
         }
         if(overrideColor != Gem.COLOR_NONE)
         {
            color = overrideColor;
         }
         var match:Match = null;
         if(newGem == null || color == Gem.COLOR_NONE || !newGem.canMatch())
         {
            match = this.End();
            this.Start(null,Gem.COLOR_NONE);
            return match;
         }
         if(this.m_Last == null)
         {
            this.Start(newGem,overrideColor);
            return null;
         }
         if(this.m_Color == Gem.COLOR_ANY)
         {
            this.m_Color = color;
         }
         else if(color == this.m_Color)
         {
            this.m_NextStart = this.m_Start;
         }
         else if(color == Gem.COLOR_ANY)
         {
            if(this.m_NextStart == this.m_Start)
            {
               this.m_NextStart = this.m_Index;
            }
         }
         else if(color != this.m_Color)
         {
            if(this.m_NextStart == this.m_Start)
            {
               match = this.End();
               this.Start(newGem,overrideColor);
               return match;
            }
            match = this.GetCurrentMatch();
            this.m_Start = this.m_NextStart;
            this.m_Size = this.m_Index - this.m_Start;
            this.m_Color = color;
         }
         if(this.m_Gems.length <= this.m_Index)
         {
            this.m_Gems.length = this.m_Index + 1;
         }
         this.m_Gems[this.m_Index] = newGem;
         this.m_Last = newGem;
         ++this.m_Index;
         ++this.m_Size;
         return match;
      }
      
      public function End() : Match
      {
         var match:Match = this.GetCurrentMatch();
         this.m_Size = 0;
         this.m_Index = 0;
         this.m_Start = 0;
         this.m_NextStart = 0;
         return match;
      }
      
      private function GetCurrentMatch() : Match
      {
         if(this.m_Size < MIN_MATCH)
         {
            return null;
         }
         this.m_TmpGems.length = 0;
         for(var i:int = this.m_Start; i < this.m_Start + this.m_Size; i++)
         {
            this.m_TmpGems.push(this.m_Gems[i]);
         }
         return this.m_Logic.matchPool.GetNextMatch(this.m_TmpGems,this.m_Color);
      }
   }
}
