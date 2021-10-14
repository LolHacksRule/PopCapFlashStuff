package com.popcap.flash.bejeweledblitz.game.quests
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class QuestConstants
   {
      
      public static const KEY_IS_COMPLETE:String = "complete";
      
      public static const KEY_COMPLETION:String = "goal";
      
      public static const KEY_COMPLETION_TYPE:String = "name";
      
      public static const KEY_COMPLETION_VAL1:String = "goal1";
      
      public static const KEY_COMPLETION_VAL2:String = "goal2";
      
      public static const KEY_COMPLETION_VAL3:String = "goal3";
      
      public static const KEY_PROGRESS:String = "progress";
      
      public static const KEY_REWARD:String = "reward";
      
      public static const KEY_REWARD_TYPE:String = "type";
      
      public static const KEY_REWARD_VAL1:String = "context1";
      
      public static const KEY_REWARD_VAL2:String = "context2";
      
      public static const KEY_REWARD_VAL3:String = "context3";
      
      public static const KEY_EXPIRARY:String = "goal";
      
      public static const KEY_EXPIRARY_TIME:String = "expires";
      
      public static const KEY_EXPIRARY_TIME_REMAINING:String = "timeRemaining";
      
      public static const QUEST_REWARD_TYPE_COIN:String = "coin";
      
      public static const QUEST_REWARD_TYPE_TOKENS:String = "token";
      
      public static const QUEST_REWARD_TYPE_XP:String = "xp";
      
      public static const QUEST_REWARD_TYPE_MYSTERY_TREASURE:String = "mystery";
      
      public static const QUEST_REWARD_TYPE_SPIN:String = "freeSpin";
      
      public static const QUEST_REWARD_TYPE_CONFIG:String = "config";
      
      public static const QUEST_REWARD_TYPE_COMPOUND:String = "compound";
      
      public static const QUEST_REWARD_TYPE_FEATURE:String = "feature";
      
      public static const QUEST_REWARD_TYPE_NULL:String = "null";
      
      public static const QUEST_REWARD_TYPE_SETTINGS:String = "settings";
       
      
      public function QuestConstants()
      {
         super();
      }
      
      public static function SanitizeQuestObject(param1:Object) : Object
      {
         if(param1 == null)
         {
            param1 = new Object();
         }
         if(!(KEY_COMPLETION in param1) || !isNaN(parseInt(param1[KEY_COMPLETION])))
         {
            param1[KEY_COMPLETION] = new Object();
         }
         if(!(KEY_PROGRESS in param1))
         {
            param1[KEY_PROGRESS] = "0";
         }
         if(!(KEY_COMPLETION_TYPE in param1[KEY_COMPLETION]))
         {
            param1[KEY_COMPLETION][KEY_COMPLETION_TYPE] = "";
         }
         if(!(KEY_EXPIRARY in param1))
         {
            param1[KEY_EXPIRARY] = new Object();
         }
         if(!(KEY_EXPIRARY_TIME in param1[KEY_EXPIRARY]))
         {
            param1[KEY_EXPIRARY][KEY_EXPIRARY_TIME] = new Date().time;
         }
         if(!(KEY_REWARD in param1) || param1[KEY_REWARD] == null)
         {
            param1[KEY_REWARD] = new Object();
         }
         if(!(KEY_REWARD_TYPE in param1[KEY_REWARD]))
         {
            param1[KEY_REWARD][KEY_REWARD_TYPE] = new Object();
         }
         return param1;
      }
      
      public static function gemColorAsInt(param1:String) : int
      {
         switch(param1)
         {
            case "orange":
               return Gem.COLOR_ORANGE;
            case "blue":
               return Gem.COLOR_BLUE;
            case "red":
               return Gem.COLOR_RED;
            case "yellow":
               return Gem.COLOR_YELLOW;
            case "purple":
               return Gem.COLOR_PURPLE;
            case "green":
               return Gem.COLOR_GREEN;
            case "white":
               return Gem.COLOR_WHITE;
            default:
               return Gem.COLOR_NONE;
         }
      }
   }
}
