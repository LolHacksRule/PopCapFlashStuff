package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import flash.utils.Dictionary;
   
   public class ServerResponseData implements IConfigProvider, IBlitz3NetworkHandler
   {
      
      private static const SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const DEFAULTS:Dictionary = new Dictionary();
      
      {
         SUPPORTED_KEYS.push(ConfigManager.DICT_RARE_GEM_WEIGHTS);
         SUPPORTED_KEYS.push(ConfigManager.INT_RARE_GEM_MIN_DELAY);
         SUPPORTED_KEYS.push(ConfigManager.INT_RARE_GEM_MAX_DELAY);
         SUPPORTED_KEYS.push(ConfigManager.ARRAY_PHOENIX_PAYOUTS);
         SUPPORTED_KEYS.push(ConfigManager.INT_PHOENIX_PAYOUT_INDEX);
         DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS] = new Dictionary();
         DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS][MoonstoneRGLogic.ID] = 0;
         DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS][CatseyeRGLogic.ID] = 0;
         DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS][PhoenixPrismRGLogic.ID] = 0;
         DEFAULTS[ConfigManager.INT_RARE_GEM_MIN_DELAY] = 30;
         DEFAULTS[ConfigManager.INT_RARE_GEM_MAX_DELAY] = 70;
         DEFAULTS[ConfigManager.ARRAY_PHOENIX_PAYOUTS] = [1000,5000,10000,15000,40000,18000,0];
         DEFAULTS[ConfigManager.INT_PHOENIX_PAYOUT_INDEX] = -1;
      }
      
      private var m_App:Blitz3App;
      
      private var m_Data:Dictionary;
      
      public function ServerResponseData(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Data = new Dictionary();
      }
      
      public function Init() : void
      {
         if(this.m_App.network == null)
         {
            return;
         }
         this.ParseXML(this.m_App.network.userInfo);
         this.m_App.network.AddHandler(this);
      }
      
      public function GetSupportedKeys() : Vector.<String>
      {
         return SUPPORTED_KEYS;
      }
      
      public function IsKeySupported(key:String) : Boolean
      {
         return SUPPORTED_KEYS.indexOf(key) >= 0;
      }
      
      public function GetDefault(key:String) : Object
      {
         return DEFAULTS[key];
      }
      
      public function HasObject(key:String) : Boolean
      {
         return key in this.m_Data;
      }
      
      public function GetObject(key:String, defaultVal:Object) : Object
      {
         if(!(key in this.m_Data))
         {
            return defaultVal;
         }
         return this.m_Data[key];
      }
      
      public function SetObject(key:String, value:Object) : void
      {
         throw new Error("ServerResponseData is a read-only IConfigProvider");
      }
      
      public function CommitChanges(force:Boolean) : void
      {
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess(response:XML) : void
      {
         this.ParseXML(response);
      }
      
      public function HandleBuyCoinsCallback(success:Boolean) : void
      {
      }
      
      public function HandleExternalPause(isPaused:Boolean) : void
      {
      }
      
      public function HandleCartClosed(coinsPurchased:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
         trace("resetting phoenix payout id");
         this.m_Data[ConfigManager.INT_PHOENIX_PAYOUT_INDEX] = DEFAULTS[ConfigManager.INT_PHOENIX_PAYOUT_INDEX];
      }
      
      private function ParseXML(rootNode:XML) : void
      {
         var newWeights:Dictionary = null;
         var numPositiveWeights:int = 0;
         var rareGemEntry:XML = null;
         var gemId:String = null;
         var weight:int = 0;
         var minDelay:Number = NaN;
         var maxDelay:Number = NaN;
         var newPayouts:Array = null;
         var awardedIndex:int = 0;
         var payoutEntry:XML = null;
         var id:Number = NaN;
         var amount:Number = NaN;
         var tmpAwarded:Number = NaN;
         var rareGemRoot:XMLList = rootNode["rare_gems"];
         if(rareGemRoot != null && rareGemRoot.length() > 0)
         {
            newWeights = new Dictionary();
            numPositiveWeights = 0;
            for each(rareGemEntry in rareGemRoot.children())
            {
               gemId = rareGemEntry.attribute("id");
               weight = parseFloat(rareGemEntry.attribute("weight"));
               newWeights[gemId] = weight;
               if(weight > 0)
               {
                  numPositiveWeights++;
               }
            }
            if(numPositiveWeights > 0)
            {
               this.m_Data[ConfigManager.DICT_RARE_GEM_WEIGHTS] = newWeights;
            }
         }
         var delayTag:XMLList = rootNode["rare_gem_delay"];
         if(delayTag != null && delayTag.length() > 0)
         {
            minDelay = parseFloat(delayTag.attribute("min"));
            maxDelay = parseFloat(delayTag.attribute("max"));
            if(!isNaN(minDelay))
            {
               this.m_Data[ConfigManager.INT_RARE_GEM_MIN_DELAY] = int(minDelay);
            }
            if(!isNaN(maxDelay))
            {
               this.m_Data[ConfigManager.INT_RARE_GEM_MAX_DELAY] = int(maxDelay);
            }
         }
         this.m_Data[ConfigManager.INT_PHOENIX_PAYOUT_INDEX] = DEFAULTS[ConfigManager.INT_PHOENIX_PAYOUT_INDEX];
         var payoutRoot:XMLList = rootNode["payout_table"];
         if(payoutRoot != null && payoutRoot.length() > 0)
         {
            newPayouts = [];
            awardedIndex = -1;
            for each(payoutEntry in payoutRoot.children())
            {
               if(payoutEntry.name() == "phoenix")
               {
                  id = parseInt(payoutEntry.attribute("id"));
                  amount = parseInt(payoutEntry.attribute("payout"));
                  if(!isNaN(id) && !isNaN(amount))
                  {
                     newPayouts[int(id) - 1] = int(amount);
                  }
               }
               else if(payoutEntry.name() == "winner")
               {
                  tmpAwarded = parseInt(payoutEntry.attribute("id"));
                  if(!isNaN(tmpAwarded))
                  {
                     awardedIndex = int(tmpAwarded) - 1;
                  }
               }
            }
            if(awardedIndex >= 0 && awardedIndex < newPayouts.length)
            {
               this.m_Data[ConfigManager.ARRAY_PHOENIX_PAYOUTS] = newPayouts;
               this.m_Data[ConfigManager.INT_PHOENIX_PAYOUT_INDEX] = awardedIndex;
            }
         }
      }
   }
}
