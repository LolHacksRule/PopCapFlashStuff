package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import flash.utils.Dictionary;
   
   public class QuestSettingsProvider extends ReadOnlyServerSettingsProvider implements IBlitz3NetworkHandler
   {
      
      private static const FUNC_GET:String = "getQuests";
      
      private static const FUNC_SET:String = "setQuests";
      
      private static const DATA_ID:String = "quests";
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
      
      {
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_QUEST_WIDGET);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_LEADERBOARD_BASIC);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_BOOSTS);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_FRIENDSCORE);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_FIND_RARE_GEM);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_STAR_MEDALS);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_MULTIPLAYER);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_UNLOCK_LEVELS);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_LEVEL_UP);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_DYNAMIC_EASY);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_DYNAMIC_MEDIUM);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_DYNAMIC_HARD);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_WEAK_MILESTONE);
         SUPPORTED_KEYS.push(ConfigManager.OBJ_QUEST_STRONG_MILESTONE);
      }
      
      public function QuestSettingsProvider(param1:Blitz3App)
      {
         var _loc2_:Object = new Object();
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_QUEST_WIDGET] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_LEADERBOARD_BASIC] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_BOOSTS] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_FRIENDSCORE] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_FIND_RARE_GEM] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_STAR_MEDALS] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_MULTIPLAYER] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_UNLOCK_LEVELS] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_LEVEL_UP] = {
            "complete":false,
            "goal":_loc2_,
            "progress":"0"
         };
         DEFAULTS[ConfigManager.OBJ_QUEST_DYNAMIC_EASY] = {};
         DEFAULTS[ConfigManager.OBJ_QUEST_DYNAMIC_MEDIUM] = {};
         DEFAULTS[ConfigManager.OBJ_QUEST_DYNAMIC_HARD] = {};
         DEFAULTS[ConfigManager.OBJ_QUEST_DYNAMIC_EASY] = {};
         DEFAULTS[ConfigManager.OBJ_QUEST_WEAK_MILESTONE] = {};
         DEFAULTS[ConfigManager.OBJ_QUEST_STRONG_MILESTONE] = {};
         super(param1,FUNC_GET,SUPPORTED_KEYS,DEFAULTS,DATA_ID,true);
      }
      
      override public function Init() : void
      {
         super.Init();
         m_App.network.AddHandler(this);
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         this.ParseXML(param1);
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      public function dumpQuestData() : Dictionary
      {
         return m_Values;
      }
      
      private function ParseXML(param1:XML) : void
      {
         var _loc4_:* = null;
         var _loc2_:String = param1["quest_data"];
         if(_loc2_ == "")
         {
            return;
         }
         var _loc3_:Object = JSON.parse(_loc2_);
         for(_loc4_ in _loc3_)
         {
            if(IsKeySupported(_loc4_))
            {
               SetObject(_loc4_,_loc3_[_loc4_]);
            }
         }
      }
   }
}
