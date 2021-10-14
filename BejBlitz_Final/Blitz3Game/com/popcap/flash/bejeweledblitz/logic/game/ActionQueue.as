package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class ActionQueue
   {
      
      public static const QUEUE_CHANGE_TYPE:int = 0;
      
      public static const QUEUE_CHANGE_COLOR:int = 1;
      
      public static const QUEUE_SPAWN_TOKEN_GEM:int = 2;
      
      public static const QUEUE_GENERATE_HIGHLIGHT_ON_BOARD:int = 3;
      
      public static const SHOW_BLAZING_SPEED_FEEDBACK:int = 4;
      
      public static const HIDE_BLAZING_SPEED_FEEDBACK:int = 5;
      
      public static const MODIFY_SCORE_BONUS_DURING_GAME:int = 6;
      
      public static const SHOW_UNSCRAMBLE_FEEDBACK:int = 7;
      
      public static const SHOW_CROSSCOLLECTOR_FEEDBACK:int = 8;
       
      
      public var mGem:Gem = null;
      
      public var col:int = -1;
      
      public var row:int = -1;
      
      public var mQueueType:int = -1;
      
      public var mValue1:int = -1;
      
      public var mValue2:int = -1;
      
      public function ActionQueue(param1:Gem, param2:int, param3:int, param4:int)
      {
         super();
         this.mGem = param1;
         if(param1 != null)
         {
            this.col = this.mGem.col;
            this.row = this.mGem.row;
         }
         this.mQueueType = param2;
         this.mValue1 = param3;
         this.mValue2 = param4;
      }
   }
}
