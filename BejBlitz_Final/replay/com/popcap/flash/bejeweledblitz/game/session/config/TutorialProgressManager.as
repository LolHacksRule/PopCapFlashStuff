package com.popcap.flash.bejeweledblitz.game.session.config
{
   import flash.utils.Dictionary;
   
   public class TutorialProgressManager extends ServerSettingsManager
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
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_FLAME_GEM_CREATED);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_STAR_GEM_CREATED);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_HYPERCUBE_CREATED);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_MULTIPLIER_APPEARS);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_COIN_APPEARS);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_MOONSTONE_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_CATSEYE_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_PHOENIX_PRISM_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_BOOST_DETONATOR_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_BOOST_SCRAMBLER_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_BOOST_MYSTERY_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_BOOST_MULTIPLIER_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.FLAG_TIP_BOOST_BONUS_TIME_BEGIN);
         SUPPORTED_KEYS.push(ConfigManager.INT_FIRST_GAME_TIME);
         SUPPORTED_KEYS.push(ConfigManager.INT_LAST_GAME_TIME);
         DEFAULTS[ConfigManager.FLAG_TUTORIAL_COMPLETE] = false;
         DEFAULTS[ConfigManager.FLAG_TIPS_ENABLED] = true;
         DEFAULTS[ConfigManager.FLAG_ALLOW_DISABLE_TIPS] = false;
         DEFAULTS[ConfigManager.FLAG_FINISHED_FIRST_GAME] = false;
         DEFAULTS[ConfigManager.FLAG_FINISHED_SECOND_GAME] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_FLAME_GEM_CREATED] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_STAR_GEM_CREATED] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_HYPERCUBE_CREATED] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_MULTIPLIER_APPEARS] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_COIN_APPEARS] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_MOONSTONE_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_CATSEYE_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_PHOENIX_PRISM_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_BOOST_DETONATOR_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_BOOST_SCRAMBLER_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_BOOST_MYSTERY_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_BOOST_MULTIPLIER_BEGIN] = false;
         DEFAULTS[ConfigManager.FLAG_TIP_BOOST_BONUS_TIME_BEGIN] = false;
         DEFAULTS[ConfigManager.INT_FIRST_GAME_TIME] = -1;
         DEFAULTS[ConfigManager.INT_LAST_GAME_TIME] = -1;
      }
      
      public function TutorialProgressManager()
      {
         super(FUNC_GET,FUNC_SET,SUPPORTED_KEYS,DEFAULTS);
      }
   }
}
