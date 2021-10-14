package com.popcap.flash.bejeweledblitz.logic.finisher
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   
   public class FinisherProp
   {
       
      
      private var gem:Gem;
      
      private var speed:Number;
      
      private var finisherUIInterface:IFinisherUI = null;
      
      public var actor:FinisherActor = null;
      
      public function FinisherProp(param1:IFinisherUI, param2:FinisherActor)
      {
         super();
         this.finisherUIInterface = param1;
         this.actor = param2;
      }
      
      public function Update(param1:Number) : void
      {
         var _loc2_:Number = param1 / 100;
         this.finisherUIInterface.updatePropPosition(this,this.gem,this.speed,_loc2_);
      }
      
      public function MoveTo(param1:Gem, param2:Number) : void
      {
         this.gem = param1;
         this.speed = param2;
      }
      
      public function GetGem() : Gem
      {
         return this.gem;
      }
      
      public function RemoveProp() : void
      {
         this.finisherUIInterface.destroyProp(this);
      }
      
      public function SetVisible() : void
      {
      }
   }
}
