package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class MatchSet implements IPoolObject
   {
       
      
      public var mMatches:Vector.<Match>;
      
      public var mGems:Vector.<Gem>;
      
      public function MatchSet()
      {
         super();
         this.mMatches = new Vector.<Match>();
         this.mGems = new Vector.<Gem>();
      }
      
      public function Reset() : void
      {
         this.mMatches.length = 0;
         this.mGems.length = 0;
      }
      
      public function IsDeferred() : Boolean
      {
         var _loc3_:Gem = null;
         var _loc1_:int = this.mGems.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mGems[_loc2_];
            if(_loc3_.isFalling)
            {
               return true;
            }
            if(_loc3_.isUnswapping)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function Resolve() : void
      {
         var _loc3_:Match = null;
         var _loc4_:Vector.<Gem> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Gem = null;
         var _loc8_:int = 0;
         this.mGems.length = 0;
         var _loc1_:int = this.mMatches.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.mMatches[_loc2_];
            _loc5_ = (_loc4_ = _loc3_.matchGems).length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_];
               if((_loc8_ = this.mGems.indexOf(_loc7_)) < 0)
               {
                  this.mGems.push(_loc7_);
               }
               _loc6_++;
            }
            _loc2_++;
         }
      }
   }
}
