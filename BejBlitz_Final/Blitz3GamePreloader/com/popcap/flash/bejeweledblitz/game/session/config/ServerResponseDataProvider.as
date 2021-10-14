package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.IBlitz3NetworkHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IHandleNetworkGameStart;
   import flash.utils.Dictionary;
   
   public class ServerResponseDataProvider implements IConfigProvider, IBlitz3NetworkHandler, IHandleNetworkGameStart
   {
      
      private static const _SUPPORTED_KEYS:Vector.<String> = new Vector.<String>();
      
      private static const _DEFAULTS:Dictionary = new Dictionary();
      
      {
         _SUPPORTED_KEYS.push(ConfigManager.DICT_RARE_GEM_WEIGHTS);
         _SUPPORTED_KEYS.push(ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
         _DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS] = new Dictionary();
         _DEFAULTS[ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY] = new Dictionary();
      }
      
      private var _app:Blitz3App;
      
      private var _data:Dictionary;
      
      public function ServerResponseDataProvider(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._data = new Dictionary();
      }
      
      public function Init() : void
      {
         if(this._app.network == null)
         {
            return;
         }
         this.ParseUberGemWeights(this._app.network.userInfo);
         this._app.network.AddHandler(this);
         this._app.network.AddNetworkStartHandler(this);
      }
      
      public function GetSupportedKeys() : Vector.<String>
      {
         return _SUPPORTED_KEYS;
      }
      
      public function IsKeySupported(param1:String) : Boolean
      {
         return _SUPPORTED_KEYS.indexOf(param1) >= 0;
      }
      
      public function GetDefault(param1:String) : Object
      {
         return _DEFAULTS[param1];
      }
      
      public function HasObject(param1:String) : Boolean
      {
         return param1 in this._data;
      }
      
      public function GetObject(param1:String, param2:Object) : Object
      {
         if(!(param1 in this._data))
         {
            return param2;
         }
         return this._data[param1];
      }
      
      public function SetObject(param1:String, param2:Object) : void
      {
      }
      
      public function CommitChanges(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function HandleNetworkSuccess(param1:XML) : void
      {
         this.ParseUberGemWeights(param1);
      }
      
      public function HandleCartClosed(param1:Boolean) : void
      {
      }
      
      public function HandleNetworkGameStart() : void
      {
      }
      
      private function parseWeights(param1:Object, param2:String) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(param1 != null)
         {
            _loc3_ = new Dictionary();
            _loc4_ = 0;
            for each(_loc5_ in param1)
            {
               _loc6_ = _loc5_.name;
               _loc7_ = parseFloat(_loc5_.weight);
               _loc3_[_loc6_] = _loc7_;
               if(_loc7_ > 0)
               {
                  _loc4_++;
               }
            }
            if(_loc4_ > 0)
            {
               this._data[param2] = _loc3_;
            }
         }
      }
      
      private function ParseUberGemWeights(param1:XML) : void
      {
         var _loc2_:Object = null;
         if(param1.child("uberGems") != null && param1.child("uberGems").toString() != "")
         {
            _loc2_ = JSON.parse(param1.child("uberGems").toString());
            this.parseWeights(_loc2_.uberGems.standard.gemConfig,ConfigManager.DICT_RARE_GEM_WEIGHTS);
            this.parseWeights(_loc2_.uberGems.party.gemConfig,ConfigManager.DICT_RARE_GEM_WEIGHTS_PARTY);
            this._app.sessionData.rareGemManager.parseDelays(_loc2_.uberGems.standard.delay,_loc2_.uberGems.party.delay);
         }
      }
      
      public function OnConfigFetchSucess(param1:Object) : void
      {
      }
      
      public function OnConfigFetchFailure() : void
      {
      }
   }
}
