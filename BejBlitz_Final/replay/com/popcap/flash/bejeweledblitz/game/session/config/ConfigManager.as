package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class ConfigManager
   {
      
      public static const FLAG_MUTE:String = "isMuted";
      
      public static const FLAG_AUTO_RENEW:String = "boostAutoRenew";
      
      public static const FLAG_AUTO_HINT:String = "autoHint";
      
      public static const FLAG_TIPS_ENABLED:String = "tipsEnabled";
      
      public static const FLAG_TUTORIAL_COMPLETE:String = "tutorialComplete";
      
      public static const FLAG_ALLOW_DISABLE_TIPS:String = "allowDisableTips";
      
      public static const FLAG_FINISHED_FIRST_GAME:String = "finishedFirstGame";
      
      public static const FLAG_FINISHED_SECOND_GAME:String = "finishedSecondGame";
      
      public static const FLAG_TIP_FLAME_GEM_CREATED:String = "tipFlameGemCreated";
      
      public static const FLAG_TIP_STAR_GEM_CREATED:String = "tipStarGemCreated";
      
      public static const FLAG_TIP_HYPERCUBE_CREATED:String = "tipHypercubeCreated";
      
      public static const FLAG_TIP_MULTIPLIER_APPEARS:String = "tipMultiplierCreated";
      
      public static const FLAG_TIP_COIN_APPEARS:String = "tipCoinAppears";
      
      public static const FLAG_TIP_MOONSTONE_BEGIN:String = "tipMoonstoneBegin";
      
      public static const FLAG_TIP_CATSEYE_BEGIN:String = "tipCatseyeBegin";
      
      public static const FLAG_TIP_PHOENIX_PRISM_BEGIN:String = "tipPhoenixPrismBegin";
      
      public static const FLAG_TIP_BOOST_DETONATOR_BEGIN:String = "tipBoostDetonatorBegin";
      
      public static const FLAG_TIP_BOOST_SCRAMBLER_BEGIN:String = "tipBoostScramblerBegin";
      
      public static const FLAG_TIP_BOOST_MYSTERY_BEGIN:String = "tipBoostMysteryBegin";
      
      public static const FLAG_TIP_BOOST_MULTIPLIER_BEGIN:String = "tipBoostMultiplierBegin";
      
      public static const FLAG_TIP_BOOST_BONUS_TIME_BEGIN:String = "tipBoostBonusTimeBegin";
      
      public static const INT_VOLUME:String = "volume";
      
      public static const INT_RARE_GEM_COUNTER:String = "rareGemCountup";
      
      public static const INT_RARE_GEM_TARGET:String = "rareGemTarget";
      
      public static const INT_STORED_RARE_GEM_OFFER:String = "storedRGOffer";
      
      public static const INT_RARE_GEM_MIN_DELAY:String = "minRareGemDelay";
      
      public static const INT_RARE_GEM_MAX_DELAY:String = "maxRareGemDelay";
      
      public static const INT_PHOENIX_PAYOUT_INDEX:String = "actualPhoenixPayout";
      
      public static const INT_FIRST_GAME_TIME:String = "firstGameTime";
      
      public static const INT_LAST_GAME_TIME:String = "lastGameTime";
      
      public static const NUMBER_LAST_POKE_CLICK:String = "lastPokeClickDate";
      
      public static const DICT_RARE_GEM_WEIGHTS:String = "rareGemWeights";
      
      public static const ARRAY_PHOENIX_PAYOUTS:String = "phoenixPayouts";
       
      
      private var m_App:Blitz3App;
      
      private var m_ConfigProviders:Vector.<IConfigProvider>;
      
      public function ConfigManager(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_ConfigProviders = new Vector.<IConfigProvider>();
         this.m_ConfigProviders.push(new GameSettingsManager());
         this.m_ConfigProviders.push(new TutorialProgressManager());
         this.m_ConfigProviders.push(new DataStore(app));
         this.m_ConfigProviders.push(new ServerResponseData(app));
         this.m_ConfigProviders.push(new DummyConfig());
      }
      
      public function Init() : void
      {
         var provider:IConfigProvider = null;
         for each(provider in this.m_ConfigProviders)
         {
            provider.Init();
         }
      }
      
      public function CommitChanges(force:Boolean = false) : void
      {
         var provider:IConfigProvider = null;
         for each(provider in this.m_ConfigProviders)
         {
            provider.CommitChanges(force);
         }
      }
      
      public function GetFlag(key:String) : Boolean
      {
         return this.GetObject(key) as Boolean;
      }
      
      public function GetFlagWithDefault(key:String, defaultVal:Boolean = false) : Boolean
      {
         return this.GetObject(key,defaultVal) as Boolean;
      }
      
      public function SetFlag(key:String, value:Boolean) : void
      {
         this.SetObject(key,value);
      }
      
      public function GetInt(key:String) : int
      {
         return this.GetObject(key) as int;
      }
      
      public function GetIntWithDefault(key:String, defaultVal:int = -1) : int
      {
         return this.GetObject(key,defaultVal) as int;
      }
      
      public function SetInt(key:String, value:int) : void
      {
         this.SetObject(key,value);
      }
      
      public function GetNumber(key:String) : Number
      {
         return this.GetObject(key) as Number;
      }
      
      public function GetNumberWithDefault(key:String, defaultVal:Number = -1) : Number
      {
         return this.GetObject(key,defaultVal) as Number;
      }
      
      public function SetNumber(key:String, value:Number) : void
      {
         this.SetObject(key,value);
      }
      
      public function GetString(key:String) : String
      {
         return this.GetObject(key) as String;
      }
      
      public function GetStringWithDefault(key:String, defaultVal:String = "") : String
      {
         return this.GetObject(key,defaultVal) as String;
      }
      
      public function SetString(key:String, value:String) : void
      {
         this.SetObject(key,value);
      }
      
      public function GetDictionary(key:String) : Dictionary
      {
         return this.GetObject(key) as Dictionary;
      }
      
      public function GetDictionaryWithDefault(key:String, defaultVal:Dictionary = null) : Dictionary
      {
         return this.GetObject(key,defaultVal) as Dictionary;
      }
      
      public function SetDictionary(key:String, value:Dictionary) : void
      {
         this.SetObject(key,value);
      }
      
      public function GetArray(key:String) : Array
      {
         return this.GetObject(key) as Array;
      }
      
      public function GetArrayWithDefault(key:String, defaultVal:Array = null) : Array
      {
         return this.GetObject(key,defaultVal) as Array;
      }
      
      public function SetArray(key:String, value:Array) : void
      {
         this.SetObject(key,value);
      }
      
      public function HasKey(key:String) : Boolean
      {
         var provider:IConfigProvider = this.GetProvider(key);
         if(provider == null)
         {
            return false;
         }
         return provider.HasObject(key);
      }
      
      private function GetObject(key:String, defaultVal:Object = null) : Object
      {
         var provider:IConfigProvider = this.GetProvider(key);
         if(provider == null)
         {
            return defaultVal;
         }
         var defVal:Object = defaultVal;
         if(defaultVal == null)
         {
            defVal = provider.GetDefault(key);
         }
         return provider.GetObject(key,defVal);
      }
      
      private function SetObject(key:String, value:Object) : void
      {
         var provider:IConfigProvider = this.GetProvider(key);
         if(provider == null)
         {
            return;
         }
         provider.SetObject(key,value);
      }
      
      private function GetProvider(key:String) : IConfigProvider
      {
         var provider:IConfigProvider = null;
         for each(provider in this.m_ConfigProviders)
         {
            if(provider.IsKeySupported(key))
            {
               return provider;
            }
         }
         return null;
      }
   }
}
