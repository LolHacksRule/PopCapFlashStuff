package com.popcap.flash.bejeweledblitz.game.quests
{
   import flash.display.DisplayObject;
   
   public class QuestData
   {
       
      
      public var id:String = "";
      
      public var rewardScreenTitle:String = "";
      
      public var rewardScreenVisual:DisplayObject = null;
      
      public var rewardScreenBody:String = "";
      
      public var highlightArea:Vector.<DisplayObject>;
      
      public var offsetY:Number = 0;
      
      public function QuestData(param1:String = "", param2:String = "", param3:DisplayObject = null, param4:String = "", param5:Number = 0)
      {
         this.highlightArea = new Vector.<DisplayObject>();
         super();
         this.id = param1;
         this.rewardScreenTitle = param2;
         this.rewardScreenVisual = param3;
         this.rewardScreenBody = param4;
         this.offsetY = param5;
      }
   }
}
