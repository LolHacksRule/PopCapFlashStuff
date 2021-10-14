package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherFrame;
   
   public class FinisherFrame implements IFinisherFrame
   {
       
      
      private var start:int;
      
      private var end:int;
      
      public function FinisherFrame(param1:String)
      {
         super();
         this.Parse(param1);
      }
      
      public function GetStart() : int
      {
         return this.start;
      }
      
      public function GetEnd() : int
      {
         return this.end;
      }
      
      private function Parse(param1:String) : void
      {
         var _loc2_:Array = param1.split("-");
         this.start = parseInt(_loc2_[0]);
         this.end = parseInt(_loc2_[1]);
      }
   }
}
