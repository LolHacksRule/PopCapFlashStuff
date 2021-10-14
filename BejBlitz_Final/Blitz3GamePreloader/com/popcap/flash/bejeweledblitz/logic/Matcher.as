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
      
      public function Matcher(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
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
      
      public function Start(param1:Gem, param2:int) : void
      {
         var _loc3_:int = Gem.COLOR_NONE;
         if(param1 != null)
         {
            _loc3_ = param1.color;
         }
         if(param2 != Gem.COLOR_NONE)
         {
            _loc3_ = param2;
         }
         if(param1 == null || _loc3_ == Gem.COLOR_NONE || param1.type == Gem.TYPE_HYPERCUBE)
         {
            this.m_Last = null;
            this.m_Color = Gem.COLOR_NONE;
            this.m_Size = 0;
            this.m_Start = 0;
            this.m_Index = 0;
            this.m_NextStart = 0;
            return;
         }
         this.m_Color = _loc3_;
         if(this.m_Gems.length <= this.m_Index)
         {
            this.m_Gems.length = this.m_Index + 1;
         }
         this.m_Gems[this.m_Index] = param1;
         this.m_Last = param1;
         ++this.m_Index;
         ++this.m_Size;
      }
      
      public function Push(param1:Gem, param2:int) : Match
      {
         var _loc3_:int = Gem.COLOR_NONE;
         if(param1 != null)
         {
            _loc3_ = param1.color;
         }
         if(param2 != Gem.COLOR_NONE)
         {
            _loc3_ = param2;
         }
         var _loc4_:Match = null;
         if(param1 == null || _loc3_ == Gem.COLOR_NONE || !param1.canMatch())
         {
            _loc4_ = this.End();
            this.Start(null,Gem.COLOR_NONE);
            return _loc4_;
         }
         if(this.m_Last == null)
         {
            this.Start(param1,param2);
            return null;
         }
         if(this.m_Color == Gem.COLOR_ANY)
         {
            this.m_Color = _loc3_;
         }
         else if(_loc3_ == this.m_Color)
         {
            this.m_NextStart = this.m_Start;
         }
         else if(_loc3_ == Gem.COLOR_ANY)
         {
            if(this.m_NextStart == this.m_Start)
            {
               this.m_NextStart = this.m_Index;
            }
         }
         else if(_loc3_ != this.m_Color)
         {
            if(this.m_NextStart == this.m_Start)
            {
               _loc4_ = this.End();
               this.Start(param1,param2);
               return _loc4_;
            }
            _loc4_ = this.GetCurrentMatch();
            this.m_Start = this.m_NextStart;
            this.m_Size = this.m_Index - this.m_Start;
            this.m_Color = _loc3_;
         }
         if(this.m_Gems.length <= this.m_Index)
         {
            this.m_Gems.length = this.m_Index + 1;
         }
         this.m_Gems[this.m_Index] = param1;
         this.m_Last = param1;
         ++this.m_Index;
         ++this.m_Size;
         return _loc4_;
      }
      
      public function End() : Match
      {
         var _loc1_:Match = this.GetCurrentMatch();
         this.m_Size = 0;
         this.m_Index = 0;
         this.m_Start = 0;
         this.m_NextStart = 0;
         return _loc1_;
      }
      
      private function GetCurrentMatch() : Match
      {
         if(this.m_Size < MIN_MATCH)
         {
            return null;
         }
         this.m_TmpGems.length = 0;
         var _loc1_:int = this.m_Start + this.m_Size;
         var _loc2_:int = this.m_Start;
         while(_loc2_ < _loc1_)
         {
            this.m_TmpGems.push(this.m_Gems[_loc2_]);
            _loc2_++;
         }
         return this.m_Logic.matchPool.GetNextMatch(this.m_TmpGems,this.m_Color);
      }
   }
}
