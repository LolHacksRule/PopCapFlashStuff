package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class TutorialSettingsProvider extends BaseServerSettingsProvider
   {
      
      private static const FUNC_GET:String = "getTutorial";
      
      private static const FUNC_SET:String = "setTutorial";
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
      
      {
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TUTORIAL_COMPLETE);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIPS_ENABLED);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_ALLOW_DISABLE_TIPS);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_FINISHED_FIRST_GAME);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_FINISHED_SECOND_GAME);
         SUPPORTED_KEYS.push(ConfigManager.INT_TIP_KANGA_RUBY_END);
         SUPPORTED_KEYS.push(ConfigManager.INT_FIRST_GAME_TIME);
         SUPPORTED_KEYS.push(ConfigManager.INT_LAST_GAME_TIME);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_NEW_USER_ENROLLED);
         SUPPORTED_KEYS.push(ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_SHARE_BLITZ_PARTY);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_FTUE_NEW_USER);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_FTUE_FLAGS);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_FTUE_GRANT);
         DEFAULTS[ConfigManager.FLAG_TUTORIAL_COMPLETE] = false;
         DEFAULTS[ConfigManager.FLAG_TIPS_ENABLED] = false;
         DEFAULTS[ConfigManager.FLAG_ALLOW_DISABLE_TIPS] = true;
         DEFAULTS[ConfigManager.FLAG_FINISHED_FIRST_GAME] = false;
         DEFAULTS[ConfigManager.FLAG_FINISHED_SECOND_GAME] = false;
         DEFAULTS[ConfigManager.INT_TIP_KANGA_RUBY_END] = 0;
         DEFAULTS[ConfigManager.INT_FIRST_GAME_TIME] = -1;
         DEFAULTS[ConfigManager.INT_LAST_GAME_TIME] = -1;
         DEFAULTS[ConfigManager.FLAG_NEW_USER_ENROLLED] = false;
         DEFAULTS[ConfigManager.INT_FINISHED_BLITZ_PARTY_TUTORIAL] = 4;
         DEFAULTS[ConfigManager.FLAG_SHARE_BLITZ_PARTY] = true;
         DEFAULTS[ConfigManager.FLAG_FTUE_NEW_USER] = false;
         DEFAULTS[ConfigManager.FLAG_FTUE_FLAGS] = "";
         DEFAULTS[ConfigManager.FLAG_FTUE_GRANT] = 0;
      }
      
      private var _app:Blitz3App;
      
      public function TutorialSettingsProvider(param1:Blitz3App)
      {
         this._app = param1;
         super(FUNC_GET,FUNC_SET,SUPPORTED_KEYS,DEFAULTS);
      }
      
      override public function Init() : void
      {
         super.Init();
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      override public function OnConfigFetchSucess(param1:Object) : void
      {
         this._app.sessionData.ftueManager.syncWithServerData(param1);
      }
      
      override public function OnConfigFetchFailure() : void
      {
      }
   }
}
