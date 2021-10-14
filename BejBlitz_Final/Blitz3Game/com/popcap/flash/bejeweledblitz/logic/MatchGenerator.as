package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class MatchGenerator
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Matcher:Matcher;
      
      private var m_TmpMatches:Vector.<Match>;
      
      private var m_MatchQueue:Vector.<Match>;
      
      public function MatchGenerator(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.m_Matcher = new Matcher(param1);
         this.m_TmpMatches = new Vector.<Match>();
         this.m_MatchQueue = new Vector.<Match>();
      }
      
      public function Reset() : void
      {
         this.m_Matcher.Reset();
      }
      
      public function FindMatches(param1:Vector.<Gem>, param2:Vector.<int>, param3:Vector.<MatchSet>) : void
      {
         var _loc8_:Gem = null;
         var _loc12_:Match = null;
         var _loc13_:MatchSet = null;
         var _loc14_:Match = null;
         var _loc15_:Vector.<Match> = null;
         var _loc16_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Match = null;
         this.m_TmpMatches.length = 0;
         for each(_loc8_ in param1)
         {
            if(_loc8_ != null)
            {
               _loc8_.hasMatch = false;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < Board.WIDTH)
         {
            this.m_Matcher.Start(param1[_loc5_],this.GetColor(param2,0,_loc5_));
            _loc4_ = Board.WIDTH;
            while(_loc4_ < Board.NUM_GEMS)
            {
               _loc6_ = _loc4_ + _loc5_;
               if((_loc7_ = this.m_Matcher.Push(param1[_loc6_],this.GetColor(param2,_loc4_,_loc5_))) != null)
               {
                  this.m_TmpMatches.push(_loc7_);
                  for each(_loc8_ in _loc7_.matchGems)
                  {
                     _loc8_.hasMatch = true;
                  }
               }
               _loc4_ += Board.WIDTH;
            }
            if((_loc7_ = this.m_Matcher.End()) != null)
            {
               this.m_TmpMatches.push(_loc7_);
            }
            _loc5_++;
         }
         _loc4_ = 0;
         while(_loc4_ < Board.NUM_GEMS)
         {
            this.m_Matcher.Start(param1[_loc4_],this.GetColor(param2,_loc4_,0));
            _loc5_ = 1;
            while(_loc5_ < Board.WIDTH)
            {
               _loc6_ = _loc4_ + _loc5_;
               if((_loc7_ = this.m_Matcher.Push(param1[_loc6_],this.GetColor(param2,_loc4_,_loc5_))) != null)
               {
                  this.m_TmpMatches.push(_loc7_);
                  for each(_loc8_ in _loc7_.matchGems)
                  {
                     _loc8_.hasMatch = true;
                  }
               }
               _loc5_++;
            }
            if((_loc7_ = this.m_Matcher.End()) != null)
            {
               this.m_TmpMatches.push(_loc7_);
            }
            _loc4_ += Board.WIDTH;
         }
         var _loc9_:int = this.m_TmpMatches.length;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            _loc7_ = this.m_TmpMatches[_loc10_];
            _loc11_ = _loc10_ + 1;
            while(_loc11_ < _loc9_)
            {
               _loc12_ = this.m_TmpMatches[_loc11_];
               if(_loc7_.IsOverlapping(_loc12_))
               {
                  _loc7_.overlaps.push(_loc12_);
                  _loc12_.overlaps.push(_loc7_);
               }
               _loc11_++;
            }
            _loc10_++;
         }
         param3.length = 0;
         this.m_MatchQueue.length = 0;
         _loc10_ = 0;
         while(_loc10_ < _loc9_)
         {
            if((_loc7_ = this.m_TmpMatches[_loc10_]).matchSet == null)
            {
               _loc13_ = this.m_Logic.matchSetPool.GetNextMatchSet();
               this.m_MatchQueue.length = 0;
               this.m_MatchQueue.push(_loc7_);
               while(this.m_MatchQueue.length > 0)
               {
                  if((_loc14_ = this.m_MatchQueue.shift() as Match).matchSet == null)
                  {
                     _loc13_.mMatches.push(_loc14_);
                     _loc14_.matchSet = _loc13_;
                     _loc16_ = (_loc15_ = _loc14_.overlaps).length;
                     _loc11_ = 0;
                     while(_loc11_ < _loc16_)
                     {
                        this.m_MatchQueue.push(_loc15_[_loc11_]);
                        _loc11_++;
                     }
                  }
               }
               _loc13_.Resolve();
               param3.push(_loc13_);
            }
            _loc10_++;
         }
      }
      
      private function GetColor(param1:Vector.<int>, param2:int, param3:int) : int
      {
         var _loc4_:int = param2 + param3;
         if(param1.length <= 0 || _loc4_ < 0 || _loc4_ >= param1.length)
         {
            return Gem.COLOR_NONE;
         }
         return param1[_loc4_];
      }
   }
}
