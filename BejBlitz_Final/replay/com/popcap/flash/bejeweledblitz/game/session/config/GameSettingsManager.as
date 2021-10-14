package com.popcap.flash.bejeweledblitz.game.session.config
{
   import flash.utils.Dictionary;
   
   public class GameSettingsManager extends ServerSettingsManager
   {
      
      private static const FUNC_GET:String = "getGameSettings";
      
      private static const FUNC_SET:String = "setGameSettings";
      
      private static const FLAG_IS_ENABLED:String = "serverGameSettings";
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
      
      {
         SUPPORTED_KEYS.push(ConfigManager.FLAG_AUTO_RENEW);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_AUTO_HINT);
         SUPPORTED_KEYS.push(ConfigManager.INT_VOLUME);
         DEFAULTS[ConfigManager.FLAG_AUTO_RENEW] = true;
         DEFAULTS[ConfigManager.FLAG_AUTO_HINT] = true;
         DEFAULTS[ConfigManager.INT_VOLUME] = 75;
      }
      
      public function GameSettingsManager()
      {
         super(FUNC_GET,FUNC_SET,SUPPORTED_KEYS,DEFAULTS);
      }
      
      override protected function IsEnabled() : Boolean
      {
         if(!HasObject(FLAG_IS_ENABLED))
         {
            return true;
         }
         return GetObject(FLAG_IS_ENABLED,null) as Boolean;
      }
   }
}
