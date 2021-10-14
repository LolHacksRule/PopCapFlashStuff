package com.popcap.flash.bejeweledblitz.game.boostV2
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostInGameInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostRootInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostUIInfo;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostV2Icons;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterHolderNode;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class BoostV2Manager
   {
      
      public static const CONFIG_URL:String = "/bej/facebook/getBoostV2.php";
      
      public static const TOTAL_EQUIPPED_BOOSTS:int = 3;
       
      
      public var boostV2Configs:Vector.<BoostRootInfo> = null;
      
      public var nodeManager:NodeManager = null;
      
      public var boostV2Icons:BoostV2Icons;
      
      public var boostEventDispatcher:BoostV2EventDispatcher;
      
      private var _equippedBoosts:Vector.<BoostV2>;
      
      private var _unlockManager:BoostUnlockManager;
      
      private var _upgradeManager:BoostUpgradeManager;
      
      private var _app:Blitz3App;
      
      public function BoostV2Manager(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function Init() : void
      {
         this.boostV2Configs = new Vector.<BoostRootInfo>();
         this.nodeManager = new NodeManager();
         this.boostEventDispatcher = new BoostV2EventDispatcher();
         this.boostV2Icons = new BoostV2Icons(this._app);
         this._unlockManager = new BoostUnlockManager(this._app);
         this._upgradeManager = new BoostUpgradeManager(this._app);
         this._app.sessionData.tournamentController.addConfigFetchListener();
         this.FetchConfig();
      }
      
      private function FetchConfig() : void
      {
         var _loc1_:URLRequest = new URLRequest(Globals.labsPath + CONFIG_URL);
         _loc1_.method = URLRequestMethod.POST;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.userId = Blitz3App.app.sessionData.userData.GetFUID();
         UrlParameters.Get().InjectParams(_loc2_);
         _loc1_.data = _loc2_;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         _loc3_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         _loc3_.load(_loc1_);
      }
      
      private function handleComplete(param1:Event) : void
      {
         var jsonObj:Object = null;
         var boostArray:Array = null;
         var boostArrayLength:int = 0;
         var i:int = 0;
         var boostRootInfo:BoostRootInfo = null;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.handleComplete);
         var data:String = loader.data;
         var scramblerBoostInfo:BoostRootInfo = null;
         try
         {
            jsonObj = JSON.parse(data);
            if(jsonObj.result == "success")
            {
               boostArray = jsonObj.boosts as Array;
               boostArrayLength = boostArray.length;
               i = 0;
               for(; i < boostArrayLength; i++)
               {
                  try
                  {
                     boostRootInfo = new BoostRootInfo(boostArray[i]);
                     if(boostRootInfo.getBoostUIConfig().getId() != "Scrambler")
                     {
                        this.boostV2Configs.push(boostRootInfo);
                     }
                     else
                     {
                        scramblerBoostInfo = boostRootInfo;
                     }
                  }
                  catch(e:Error)
                  {
                     ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,e.message);
                     continue;
                  }
               }
               this.boostV2Configs.unshift(scramblerBoostInfo);
            }
            else
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"boostV2 config returned false");
            }
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to parse boostV2 data: " + e.message);
         }
         this.boostEventDispatcher.sendEvent(BoostV2EventDispatcher.BOOST_CONFIG_FETCH_COMPLETE);
      }
      
      public function getBoostV2FromBoostId(param1:String, param2:Boolean = false) : BoostV2
      {
         var _loc5_:BoostInGameInfo = null;
         var _loc6_:Vector.<ParameterHolderNode> = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:int = this.boostV2Configs.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.boostV2Configs[_loc4_].getBoostInGameConfig().getId() == param1)
            {
               _loc5_ = this.boostV2Configs[_loc4_].getBoostInGameConfig();
               if(param2)
               {
                  _loc7_ = (_loc6_ = _loc5_.GetParams()).length;
                  _loc8_ = 0;
                  while(_loc8_ < _loc7_)
                  {
                     _loc6_[_loc8_].Reset();
                     _loc8_++;
                  }
               }
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getBoostUIConfigAndIndexFromBoostId(param1:String, param2:Object = null) : BoostUIInfo
      {
         var _loc3_:int = 0;
         while(_loc3_ < this.boostV2Configs.length)
         {
            if(this.boostV2Configs[_loc3_].getBoostInGameConfig().getId() == param1)
            {
               if(param2 != null)
               {
                  param2.indexValue = _loc3_;
               }
               return this.boostV2Configs[_loc3_].getBoostUIConfig();
            }
            _loc3_++;
         }
         return null;
      }
      
      public function GetLocalizedBoostName(param1:String) : String
      {
         var _loc2_:BaseLocalizationManager = this._app.TextManager;
         if(param1 == "5Sec")
         {
            return _loc2_.GetLocString(Blitz3GameLoc.LOC_BOOSTS_TIME_TITLE);
         }
         if(param1 == "Detonate")
         {
            return _loc2_.GetLocString(Blitz3GameLoc.LOC_BOOSTS_DETONATOR_TITLE);
         }
         if(param1 == "FreeMult")
         {
            return _loc2_.GetLocString(Blitz3GameLoc.LOC_BOOSTS_MULTIPLIER_TITLE);
         }
         if(param1 == "Mystery")
         {
            return _loc2_.GetLocString(Blitz3GameLoc.LOC_BOOSTS_GEM_TITLE);
         }
         if(param1 == "Scramble")
         {
            return _loc2_.GetLocString(Blitz3GameLoc.LOC_BOOSTS_SCRAMBLER_TITLE);
         }
         return param1;
      }
      
      public function setEquippedBoosts(param1:Vector.<BoostV2>) : void
      {
         this._equippedBoosts = param1;
      }
      
      public function getEquippedBoosts() : Vector.<BoostV2>
      {
         return this._equippedBoosts;
      }
      
      public function IsBoostActive(param1:String) : Boolean
      {
         if(this._equippedBoosts != null && param1 in this._equippedBoosts)
         {
            return true;
         }
         return false;
      }
      
      public function GetNumActiveBoosts() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for(_loc2_ in this._equippedBoosts)
         {
            _loc1_++;
         }
         return _loc1_;
      }
      
      private function handleError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on get boostV2 data");
      }
      
      public function startGameWithEquippedBoosts() : void
      {
         Blitz3App.app.logic.boostLogicV2.Init(this._equippedBoosts);
      }
      
      public function GetSkillProgressInPercentage(param1:String) : int
      {
         return this._unlockManager.GetSkillProgressInPercentage(param1);
      }
      
      public function GetSkillProgressString(param1:String) : String
      {
         return this._unlockManager.GetSkillProgressString(param1);
      }
      
      public function getBoostUIInfoFromBoostId(param1:String) : BoostUIInfo
      {
         var _loc2_:int = this.boostV2Configs.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.boostV2Configs[_loc3_].getBoostUIConfig().getId() == param1)
            {
               return this.boostV2Configs[_loc3_].getBoostUIConfig();
            }
            _loc3_++;
         }
         return null;
      }
      
      public function isBoostUnlocked(param1:String) : Boolean
      {
         if(this.GetSkillProgressInPercentage(param1) >= 100)
         {
            return true;
         }
         return false;
      }
      
      public function GetBoostV2String() : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:String = "";
         if(this._equippedBoosts != null)
         {
            _loc2_ = this._equippedBoosts.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ += this._equippedBoosts[_loc3_].getId() + "|";
               _loc3_++;
            }
            _loc1_ = _loc1_.substring(0,_loc1_.length - 1);
         }
         return _loc1_;
      }
      
      public function IsAnyBoostEquipped() : Boolean
      {
         return this.getEquippedBoosts().length > 0;
      }
   }
}
