package com.popcap.flash.games.bej3.blitz
{
   public class ScoreSlice
   {
       
      
      private var §_-Mp§:Vector.<ScoreValue>;
      
      public function ScoreSlice()
      {
         super();
         this.§_-Mp§ = new Vector.<ScoreValue>();
      }
      
      public function §_-E§(param1:ScoreValue) : void
      {
         this.§_-Mp§.push(param1);
      }
      
      public function §_-L1§() : Vector.<ScoreValue>
      {
         return this.§_-Mp§;
      }
      
      public function §_-ee§(param1:Vector.<ScoreValue>, ... rest) : Vector.<ScoreValue>
      {
         var _loc4_:ScoreValue = null;
         var _loc5_:Boolean = false;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc3_:Vector.<ScoreValue> = param1;
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<ScoreValue>();
         }
         for each(_loc4_ in this.§_-Mp§)
         {
            _loc5_ = true;
            for each(_loc6_ in rest)
            {
               if(_loc7_ = _loc4_.§_-3j§(_loc6_))
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function §_-Zn§(param1:Vector.<ScoreValue>, ... rest) : Vector.<ScoreValue>
      {
         var _loc4_:ScoreValue = null;
         var _loc5_:Boolean = false;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc3_:Vector.<ScoreValue> = param1;
         if(_loc3_ == null)
         {
            _loc3_ = new Vector.<ScoreValue>();
         }
         for each(_loc4_ in this.§_-Mp§)
         {
            _loc5_ = true;
            for each(_loc6_ in rest)
            {
               if(!(_loc7_ = _loc4_.§_-3j§(_loc6_)))
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function §_-Nw§(param1:Vector.<ScoreValue> = null) : Vector.<ScoreValue>
      {
         var _loc3_:ScoreValue = null;
         var _loc2_:Vector.<ScoreValue> = param1;
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<ScoreValue>();
         }
         for each(_loc3_ in this.§_-Mp§)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
   }
}
