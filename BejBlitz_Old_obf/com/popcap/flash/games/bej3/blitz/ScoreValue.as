package com.popcap.flash.games.bej3.blitz
{
   public class ScoreValue
   {
       
      
      private var §_-Wv§:Array;
      
      private var §_-06§:int = 0;
      
      private var §_-cJ§:int = 0;
      
      public function ScoreValue(param1:int, param2:int, param3:Array)
      {
         this.§_-Wv§ = [];
         super();
         this.§_-cJ§ = param1;
         this.§_-06§ = param2;
         this.§_-Wv§ = param3;
      }
      
      public function §_-3j§(param1:Object) : Boolean
      {
         var _loc2_:int = this.§_-Wv§.indexOf(param1);
         return _loc2_ >= 0;
      }
      
      public function §_-bg§() : int
      {
         return this.§_-cJ§;
      }
      
      public function §_-6Q§() : int
      {
         return this.§_-06§;
      }
   }
}
