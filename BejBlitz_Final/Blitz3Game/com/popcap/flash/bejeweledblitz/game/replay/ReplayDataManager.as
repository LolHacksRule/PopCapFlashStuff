package com.popcap.flash.bejeweledblitz.game.replay
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character.CharacterConfig;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class ReplayDataManager
   {
      
      public static const RAREGEM_NOT_AVAILABLE:int = 0;
      
      public static const ENCORE_NOT_AVAILABLE:int = 1;
      
      public static const BOOST_NOT_AVAILABLE:int = 2;
      
      public static const REPLAY_AVAILABLE:int = 3;
      
      public static const REPLAY_LOGIC_VERSION_MISMATCH:int = 4;
      
      public static const REPLAY_MOVES_COUNT_ZERO:int = 5;
       
      
      private var mReplayCheckSumServerData:ReplayAssetChecksumData;
      
      private var mApp:Blitz3App;
      
      private var currPlayerData:PlayerData;
      
      private var replayNetworkErrorDialog:SingleButtonDialog;
      
      private var _currentTournamentId:String;
      
      public function ReplayDataManager(param1:Blitz3App)
      {
         super();
         this.mApp = param1;
         this.mReplayCheckSumServerData = new ReplayAssetChecksumData();
         this._currentTournamentId = "";
         this.CreateErrorPopup();
      }
      
      private function ShouldCacheReplayForRG(param1:String) : Boolean
      {
         var _loc2_:Boolean = true;
         if(param1 == KangaRubyFirstRGLogic.ID || param1 == KangaRubySecondRGLogic.ID || param1 == KangaRubyThirdRGLogic.ID)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function CacheCurrentGameReplay() : Object
      {
         var _loc1_:Object = new Object();
         if(this.PopulateAssetDependencyFromCurrentGame())
         {
            _loc1_ = this.GetJSONReplayData();
         }
         return _loc1_;
      }
      
      public function LoadLastGameReplay() : Boolean
      {
         return false;
      }
      
      public function GetReplayAssetDependency() : ReplayAssetDependency
      {
         return this.currPlayerData.mReplayAssetDependency;
      }
      
      public function LoadReplayFromServer(param1:PlayerData, param2:Boolean) : void
      {
         this.currPlayerData = param1;
         (this.mApp as Blitz3Game).metaUI.highlight.showLoadingWheel();
         (this.mApp as Blitz3Game).metaUI.highlight.stopNetworkTimeoutDialog();
         var _loc3_:URLRequest = new URLRequest(Globals.labsPath + "/facebook/bj2/replay_data.php");
         _loc3_.method = URLRequestMethod.POST;
         var _loc4_:URLVariables;
         (_loc4_ = new URLVariables()).replay_user_id = param1.playerFuid;
         _loc4_.tour_id = "";
         this._currentTournamentId = "";
         if(param2)
         {
            this._currentTournamentId = param1.currentChampionshipData.id;
            _loc4_.tour_id = this._currentTournamentId;
         }
         UrlParameters.Get().InjectParams(_loc4_);
         _loc3_.data = _loc4_;
         var _loc5_:URLLoader;
         (_loc5_ = new URLLoader()).addEventListener(Event.COMPLETE,this.OnReplayFetchComplete,false,0,true);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.OnReplayFetchError,false,0,true);
         _loc5_.load(_loc3_);
      }
      
      private function LoadReplayFromJSONData(param1:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:ReplayData = null;
         var _loc5_:String = null;
         var _loc2_:Array = Utils.getArrayFromObjectKey(param1.replay_data,"replay_moves");
         for each(_loc3_ in _loc2_)
         {
            _loc4_ = this.mApp.logic.replayDataPool.GetNextReplayData();
            for each(_loc5_ in _loc3_)
            {
               _loc4_.commandArray.push(_loc5_);
            }
            this.mApp.logic.replayMoves.push(_loc4_);
         }
         return this.mApp.logic.replayMoves.length > 0 ? true : false;
      }
      
      public function LoadAssetDependencyFromJSONData(param1:Object, param2:ReplayAssetDependency) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Array = null;
         var _loc7_:Object = null;
         var _loc8_:BoostReplayData = null;
         param2.CleanUp();
         var _loc3_:Object = param1.replay_asset_dependency;
         if(_loc3_)
         {
            _loc4_ = param1.replay_asset_dependency.raregem_data;
            param2._rareGemData._name = Utils.getStringFromObjectKey(_loc4_,"name","");
            param2._rareGemData._checkSum = Utils.getStringFromObjectKey(_loc4_,"checksum","");
            param2._rareGemData._characterConfigName = Utils.getStringFromObjectKey(_loc4_,"character_config_name","");
            param2._rareGemData._characterConfigCheckSum = Utils.getStringFromObjectKey(_loc4_,"character_config_checksum","");
            param2._rareGemData._characterAssetName = Utils.getStringFromObjectKey(_loc4_,"character_asset_name","");
            param2._rareGemData._characterAssetCheckSum = Utils.getStringFromObjectKey(_loc4_,"character_asset_checksum","");
            _loc5_ = param1.replay_asset_dependency.encore_data;
            param2._encoreData._configName = Utils.getStringFromObjectKey(_loc5_,"config_name","");
            param2._encoreData._configCheckSum = Utils.getStringFromObjectKey(_loc5_,"config_checksum","");
            param2._encoreData._assetName = Utils.getStringFromObjectKey(_loc5_,"asset_name","");
            param2._encoreData._assetCheckSum = Utils.getStringFromObjectKey(_loc5_,"asset_checksum","");
            if(_loc6_ = Utils.getArrayFromObjectKey(param1.replay_asset_dependency,"boosts_data"))
            {
               for each(_loc7_ in _loc6_)
               {
                  (_loc8_ = new BoostReplayData())._name = Utils.getStringFromObjectKey(_loc7_,"name","");
                  _loc8_._level = Utils.getIntFromObjectKey(_loc7_,"level",0);
                  _loc8_._checkSum = Utils.getStringFromObjectKey(_loc7_,"checksum","");
                  param2._boostsData.push(_loc8_);
               }
            }
            param2._moveCount = Utils.getIntFromObjectKey(_loc3_,"moves_count",0);
            param2._logicVersion = Utils.getIntFromObjectKey(_loc3_,"logic_version",0);
            param2._score = Utils.getIntFromObjectKey(_loc3_,"score",0);
         }
      }
      
      public function GetReplayDependencyStatusUsingAssetDependency(param1:ReplayAssetDependency) : int
      {
         var _loc3_:BoostReplayData = null;
         var _loc2_:int = REPLAY_AVAILABLE;
         if(param1._rareGemData._name.length > 0)
         {
            if(this.mApp.logic.rareGemsLogic.isDynamicID(param1._rareGemData._name))
            {
               if(DynamicRareGemWidget.isValidGemId(param1._rareGemData._name))
               {
                  if(this.mReplayCheckSumServerData.rgChecksumData[param1._rareGemData._name] != param1._rareGemData._checkSum)
                  {
                     _loc2_ = RAREGEM_NOT_AVAILABLE;
                  }
                  else if(param1._rareGemData._characterConfigName.length > 0)
                  {
                     if(this.mReplayCheckSumServerData.encoreChecksumData[param1._rareGemData._characterConfigName] != param1._rareGemData._characterConfigCheckSum)
                     {
                        _loc2_ = RAREGEM_NOT_AVAILABLE;
                     }
                  }
               }
               else
               {
                  _loc2_ = RAREGEM_NOT_AVAILABLE;
               }
            }
         }
         if(_loc2_ == REPLAY_AVAILABLE && param1._encoreData._configName.length > 0)
         {
            if(this.mReplayCheckSumServerData.encoreChecksumData[param1._encoreData._configName] != param1._encoreData._configCheckSum)
            {
               _loc2_ = RAREGEM_NOT_AVAILABLE;
            }
         }
         if(_loc2_ == REPLAY_AVAILABLE && param1._boostsData.length > 0)
         {
            for each(_loc3_ in param1._boostsData)
            {
               if(_loc3_._name.length > 0)
               {
                  if(this.mReplayCheckSumServerData.boostChecksumData[_loc3_._name] != _loc3_._checkSum)
                  {
                     _loc2_ = RAREGEM_NOT_AVAILABLE;
                  }
               }
            }
         }
         if(_loc2_ == REPLAY_AVAILABLE && param1._logicVersion != this.mApp.logic.config.version)
         {
            _loc2_ = REPLAY_LOGIC_VERSION_MISMATCH;
         }
         if(_loc2_ == REPLAY_AVAILABLE && param1._moveCount == 0)
         {
            _loc2_ = REPLAY_MOVES_COUNT_ZERO;
         }
         return _loc2_;
      }
      
      public function GetRareGemForReplay() : String
      {
         return this.currPlayerData.mReplayAssetDependency._rareGemData._name;
      }
      
      public function GetBoostsForReplay() : Vector.<Object>
      {
         var _loc2_:BoostReplayData = null;
         var _loc3_:Object = null;
         var _loc1_:Vector.<Object> = new Vector.<Object>();
         for each(_loc2_ in this.currPlayerData.mReplayAssetDependency._boostsData)
         {
            _loc3_ = {};
            _loc3_[_loc2_._name] = _loc2_._level;
            _loc1_.push(_loc3_);
         }
         return _loc1_;
      }
      
      private function PopulateAssetDependencyFromCurrentGame() : Boolean
      {
         var _loc6_:CharacterConfig = null;
         var _loc7_:BoostV2 = null;
         var _loc8_:BoostReplayData = null;
         var _loc1_:Boolean = true;
         var _loc2_:String = "";
         if(this.mApp.logic.rareGemsLogic.currentRareGem != null)
         {
            _loc2_ = this.mApp.logic.rareGemsLogic.currentRareGem.getStringID();
         }
         this.currPlayerData = PlayersData.getPlayerData(this.mApp.sessionData.userData.GetFUID());
         var _loc3_:ReplayAssetDependency = this.currPlayerData.mReplayAssetDependency;
         _loc3_.CleanUp();
         _loc1_ = this.ShouldCacheReplayForRG(_loc2_);
         if(_loc1_ && _loc2_.length > 0)
         {
            _loc3_._rareGemData._name = _loc2_;
            if(this.mApp.logic.rareGemsLogic.isDynamicID(_loc2_))
            {
               if(DynamicRareGemWidget.isValidGemId(_loc2_))
               {
                  _loc3_._rareGemData._checkSum = this.mReplayCheckSumServerData.rgChecksumData[_loc2_];
               }
               else
               {
                  _loc1_ = false;
               }
            }
            if(_loc1_)
            {
               if(this.mApp.logic.rareGemsLogic.currentRareGem.hasLinkedCharacter())
               {
                  if((_loc6_ = this.mApp.logic.rareGemsLogic.currentRareGem.getLinkedCharacter().GetCharacterConfig() as CharacterConfig) == null)
                  {
                     _loc1_ = false;
                  }
                  else
                  {
                     _loc3_._rareGemData._characterConfigName = _loc6_.GetID();
                     _loc3_._rareGemData._characterConfigCheckSum = this.mReplayCheckSumServerData.encoreChecksumData[_loc3_._rareGemData._characterConfigName];
                  }
               }
            }
         }
         var _loc4_:String = this.mApp.sessionData.finisherSessionData.GetFinisherName();
         if(_loc1_ && _loc4_.length > 0)
         {
            _loc3_._encoreData._configName = _loc4_;
            _loc3_._encoreData._configCheckSum = this.mReplayCheckSumServerData.encoreChecksumData[_loc4_];
         }
         var _loc5_:Vector.<BoostV2> = this.mApp.sessionData.boostV2Manager.getEquippedBoosts();
         if(_loc1_ && _loc5_ != null)
         {
            for each(_loc7_ in _loc5_)
            {
               (_loc8_ = new BoostReplayData())._name = _loc7_.getId();
               _loc8_._level = _loc7_.GetUpgradeLevel() + 1;
               _loc8_._checkSum = this.mReplayCheckSumServerData.boostChecksumData[_loc7_.getId()];
               _loc3_._boostsData.push(_loc8_);
            }
         }
         _loc3_._logicVersion = this.mApp.logic.config.version;
         _loc3_._moveCount = this.mApp.logic.replayMoves.length;
         _loc3_._score = this.mApp.logic.GetScoreKeeper().GetScore();
         return _loc1_;
      }
      
      public function LoadReplayChecksumData(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         if(param1 != null)
         {
            _loc2_ = JSON.parse(param1);
            _loc3_ = Utils.getArrayFromObjectKey(_loc2_,"raregems_data");
            if(_loc3_ != null)
            {
               for each(_loc6_ in _loc3_)
               {
                  _loc7_ = (_loc7_ = _loc6_["name"]).slice(0,_loc7_.indexOf("Assets"));
                  this.mReplayCheckSumServerData.rgChecksumData[_loc7_] = _loc6_["checksum"];
               }
            }
            _loc3_ = null;
            if((_loc4_ = Utils.getArrayFromObjectKey(_loc2_,"encores_data")) != null)
            {
               for each(_loc8_ in _loc4_)
               {
                  this.mReplayCheckSumServerData.encoreChecksumData[_loc8_["name"]] = _loc8_["checksum"];
               }
            }
            _loc4_ = null;
            if((_loc5_ = Utils.getArrayFromObjectKey(_loc2_,"boosts_data")) != null)
            {
               for each(_loc9_ in _loc5_)
               {
                  this.mReplayCheckSumServerData.boostChecksumData[_loc9_["name"]] = _loc9_["checksum"];
               }
            }
            _loc5_ = null;
            _loc2_ = null;
         }
      }
      
      private function GetJSONReplayData() : Object
      {
         var _loc7_:BoostReplayData = null;
         var _loc8_:Array = null;
         var _loc9_:ReplayData = null;
         var _loc10_:Object = null;
         var _loc11_:Array = null;
         var _loc12_:String = null;
         var _loc1_:Object = new Object();
         var _loc2_:Object = new Object();
         _loc1_["replay_asset_dependency"] = _loc2_;
         var _loc3_:ReplayAssetDependency = this.currPlayerData.mReplayAssetDependency;
         var _loc4_:Object = new Object();
         _loc2_["raregem_data"] = _loc4_;
         _loc4_["name"] = _loc3_._rareGemData._name;
         _loc4_["checksum"] = _loc3_._rareGemData._checkSum;
         _loc4_["character_config_name"] = _loc3_._rareGemData._characterConfigName;
         _loc4_["character_config_checksum"] = _loc3_._rareGemData._characterConfigCheckSum;
         _loc4_["character_asset_name"] = _loc3_._rareGemData._characterAssetName;
         _loc4_["character_asset_checksum"] = _loc3_._rareGemData._characterAssetCheckSum;
         var _loc5_:Object = new Object();
         _loc2_["encore_data"] = _loc5_;
         _loc5_["config_name"] = _loc3_._encoreData._configName;
         _loc5_["config_checksum"] = _loc3_._encoreData._configCheckSum;
         _loc5_["asset_name"] = _loc3_._encoreData._assetName;
         _loc5_["asset_checksum"] = _loc3_._encoreData._assetCheckSum;
         var _loc6_:Array = new Array();
         for each(_loc7_ in _loc3_._boostsData)
         {
            (_loc10_ = new Object())["name"] = _loc7_._name;
            _loc10_["level"] = _loc7_._level;
            _loc10_["checksum"] = _loc7_._checkSum;
            _loc6_.push(_loc10_);
         }
         _loc2_["boosts_data"] = _loc6_;
         _loc2_["moves_count"] = _loc3_._moveCount;
         _loc2_["logic_version"] = _loc3_._logicVersion;
         _loc2_["score"] = _loc3_._score;
         _loc8_ = new Array();
         _loc1_["replay_moves"] = _loc8_;
         for each(_loc9_ in this.mApp.logic.replayMoves)
         {
            _loc11_ = new Array();
            for each(_loc12_ in _loc9_.commandArray)
            {
               _loc11_.push(_loc12_);
            }
            _loc8_.push(_loc11_);
         }
         return _loc1_;
      }
      
      public function SendReplayTAPIEvent(param1:String, param2:Boolean, param3:Boolean = false) : void
      {
         this.mApp.network.SendReplayMetrics(param1,param2,this.currPlayerData,param3);
      }
      
      private function hasReplayDataChanged(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:Object = param1.replay_data.replay_asset_dependency;
         if(_loc2_)
         {
            _loc3_ = Utils.getIntFromObjectKey(_loc2_,"score",0);
            if(_loc3_ == this.currPlayerData.mReplayAssetDependency._score)
            {
               return false;
            }
         }
         return true;
      }
      
      private function OnReplayFetchComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.OnReplayFetchComplete);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.OnReplayFetchError);
         var _loc3_:String = _loc2_.data;
         var _loc4_:Object = JSON.parse(_loc3_);
         this.mApp.logic.ResetMoveObjectPools();
         if(!this.hasReplayDataChanged(_loc4_))
         {
            if(this.LoadReplayFromJSONData(_loc4_))
            {
               (this.mApp as Blitz3Game).mIsReplay = true;
               (this.mApp as Blitz3Game).mainState.GotoReplay();
               (this.mApp as Blitz3Game).metaUI.highlight.Hide(true);
            }
            else
            {
               this.OnReplayDataParseError();
            }
         }
         else
         {
            this.OnReplayDataMismatchError();
         }
      }
      
      private function OnReplayFetchError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(Event.COMPLETE,this.OnReplayFetchComplete);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.OnReplayFetchError);
         this.refreshLeaderboardButtonsForCurrentPlayer();
      }
      
      private function OnReplayDataParseError() : void
      {
         this.replayNetworkErrorDialog.SetContent("Replay Not Available!","Replay data might be unavailable, try refreshing the page.","CLOSE");
         (this.mApp as Blitz3Game).metaUI.highlight.showPopUp(this.replayNetworkErrorDialog,true,true,0.5);
         this.refreshLeaderboardButtonsForCurrentPlayer();
      }
      
      private function OnReplayDataMismatchError() : void
      {
         this.replayNetworkErrorDialog.SetContent("Replay Not Available!","Replay data might be outdated, try refreshing the page.","CLOSE");
         (this.mApp as Blitz3Game).metaUI.highlight.showPopUp(this.replayNetworkErrorDialog,true,true,0.5);
      }
      
      private function refreshLeaderboardButtonsForCurrentPlayer() : void
      {
         (this.mApp as Blitz3Game).DispatchValidatePokeAndFlagButtonsForPlayer(this.currPlayerData);
         this.currPlayerData = null;
         (this.mApp.ui as MainWidgetGame).menu.leftPanel.showAll(true,false);
      }
      
      private function CreateErrorPopup() : void
      {
         this.replayNetworkErrorDialog = new SingleButtonDialog(this.mApp,16);
         this.replayNetworkErrorDialog.Init();
         this.replayNetworkErrorDialog.SetDimensions(420,200);
         this.replayNetworkErrorDialog.SetContent("Replay Not Available!","Replay data might be unavailable, try refreshing the page.","CLOSE");
         this.replayNetworkErrorDialog.AddContinueButtonHandler(this.errorPopupCloseButtonHandler);
         this.replayNetworkErrorDialog.x = Dimensions.PRELOADER_WIDTH / 2 - this.replayNetworkErrorDialog.width / 2;
         this.replayNetworkErrorDialog.y = Dimensions.PRELOADER_HEIGHT / 2 - this.replayNetworkErrorDialog.height / 2 + 12;
      }
      
      private function errorPopupCloseButtonHandler(param1:MouseEvent) : void
      {
         (this.mApp as Blitz3Game).metaUI.highlight.hidePopUp();
      }
      
      public function get tournamentId() : String
      {
         return this._currentTournamentId;
      }
   }
}
