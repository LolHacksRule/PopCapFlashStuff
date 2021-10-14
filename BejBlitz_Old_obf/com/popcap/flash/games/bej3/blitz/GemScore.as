package com.popcap.flash.games.bej3.blitz
{
   public class GemScore
   {
       
      
      private var §_-9r§:Vector.<ScoreSlice>;
      
      private var §_-69§:Array;
      
      private var §_-p2§:int = 1;
      
      private var §_-m1§:int = 0;
      
      public var §_-fN§:Boolean = false;
      
      public function GemScore()
      {
         super();
         this.§_-69§ = new Array();
         this.§_-9r§ = new Vector.<ScoreSlice>();
      }
      
      public function §_-Ka§(param1:int, param2:int) : void
      {
         this.§_-p2§ = param1;
      }
      
      public function get §_-Pg§() : Number
      {
         return this.§_-m1§;
      }
      
      public function §_-GU§(param1:int, param2:int, param3:Array) : ScoreValue
      {
         if(this.§_-69§[param2] == undefined)
         {
            this.§_-69§[param2] = new ScoreSlice();
         }
         var _loc4_:int = param1;
         if(param3.indexOf("Multiplied") >= 0)
         {
            _loc4_ = param1 * this.§_-p2§;
         }
         var _loc5_:ScoreSlice = this.§_-69§[param2];
         var _loc6_:ScoreValue = new ScoreValue(_loc4_,param2,param3);
         _loc5_.§_-E§(_loc6_);
         this.§_-m1§ += _loc4_;
         return _loc6_;
      }
      
      public function §_-D-§(param1:Vector.<ScoreSlice>, param2:int, param3:int = 1) : Vector.<ScoreSlice>
      {
         var _loc8_:ScoreSlice = null;
         var _loc4_:int = Math.max(0,param2);
         var _loc5_:int = Math.min(this.§_-69§.length,param2 + param3);
         var _loc6_:Vector.<ScoreSlice>;
         if((_loc6_ = param1) == null)
         {
            _loc6_ = new Vector.<ScoreSlice>();
         }
         var _loc7_:int = _loc4_;
         while(_loc7_ < _loc5_)
         {
            if((_loc8_ = this.§_-69§[_loc7_]) != null)
            {
               _loc6_.push(_loc8_);
            }
            _loc7_++;
         }
         return _loc6_;
      }
   }
}
