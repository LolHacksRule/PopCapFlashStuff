package com.popcap.flash.bejeweledblitz.game.finisher
{
   import com.popcap.flash.bejeweledblitz.Globals;
   import com.popcap.flash.bejeweledblitz.UrlParameters;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.finisher.inventory.FinisherInventory;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherFacade;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherPopupHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.states.FinisherPlayState;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class FinisherManager implements ITimerLogicTimeChangeHandler, IFinisherPopupHandler
   {
      
      private static var FINISHER_URL:String = "/bej/facebook/getFinishers.php";
      
      private static var CHARACTER_URL:String = "/bej/facebook/getGemCharacters.php";
       
      
      protected var finishers:Vector.<FinisherFacade>;
      
      private var pendingUrls:Vector.<String>;
      
      private var activeFinishers:Vector.<FinisherFacade>;
      
      private var finisherMap:Dictionary;
      
      private var offers:FinisherInventory = null;
      
      private var globalProperty:FinisherGlobalProperties;
      
      private var currentConfigUrl:String = "";
      
      private var handlers:Vector.<Function>;
      
      private var isPlayingFinisher:Boolean = false;
      
      private var replayFinisher:FinisherFacade;
      
      public function FinisherManager()
      {
         super();
      }
      
      public function GetConfigFor(param1:String) : FinisherConfig
      {
         if(this.finisherMap.hasOwnProperty(param1))
         {
            return this.finisherMap[param1];
         }
         return null;
      }
      
      public function AddHandler(param1:Function) : void
      {
         if(this.handlers == null)
         {
            this.handlers = new Vector.<Function>();
         }
         this.handlers.push(param1);
      }
      
      public function Init() : void
      {
         this.finisherMap = new Dictionary();
         this.pendingUrls = new Vector.<String>();
         this.activeFinishers = new Vector.<FinisherFacade>();
         this.pendingUrls.push(CHARACTER_URL);
         if(Blitz3App.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_FINISHER))
         {
            this.pendingUrls.push(FINISHER_URL);
         }
         this.FetchConfig();
         this.isPlayingFinisher = false;
         Blitz3App.app.logic.timerLogic.AddTimeChangeHandler(this);
      }
      
      public function FetchConfig() : void
      {
         var _loc1_:String = this.pendingUrls.pop();
         this.currentConfigUrl = _loc1_;
         var _loc2_:URLRequest = new URLRequest(Globals.labsPath + _loc1_);
         _loc2_.method = URLRequestMethod.POST;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.userId = Blitz3App.app.sessionData.userData.GetFUID();
         UrlParameters.Get().InjectParams(_loc3_);
         _loc2_.data = _loc3_;
         var _loc4_:URLLoader;
         (_loc4_ = new URLLoader()).addEventListener(Event.COMPLETE,this.handleComplete,false,0,true);
         _loc4_.addEventListener(IOErrorEvent.IO_ERROR,this.handleError,false,0,true);
         _loc4_.load(_loc2_);
      }
      
      public function Reset() : void
      {
         this.ResetActiveCharacter();
      }
      
      public function ResetActiveCharacter() : void
      {
         var _loc1_:FinisherFacade = null;
         for each(_loc1_ in this.finishers)
         {
            _loc1_.Reset();
         }
         this.activeFinishers.splice(0,this.activeFinishers.length);
         this.isPlayingFinisher = false;
      }
      
      public function ConsumeActiveFinisher(param1:FinisherConfig) : void
      {
         this.offers.Consume(param1.GetID());
      }
      
      public function SetActiveFinisherId(param1:String) : void
      {
         var _loc2_:FinisherFacade = null;
         this.activeFinishers.splice(0,this.activeFinishers.length);
         for each(_loc2_ in this.finishers)
         {
            if(_loc2_.GetFinisherConfig().GetID() == param1)
            {
               this.activeFinishers[0] = _loc2_;
               this.activeFinishers[0].ResetCharacterConfig();
               return;
            }
         }
      }
      
      public function GetActiveFinishers(param1:Boolean = false) : Vector.<FinisherFacade>
      {
         var _loc3_:FinisherFacade = null;
         if(Blitz3App.app.mIsReplay && (Blitz3App.app.ui as MainWidgetGame).game.encoreForReplay != "")
         {
            if(this.replayFinisher != null)
            {
               this.activeFinishers.push(this.replayFinisher);
               return this.activeFinishers;
            }
            return null;
         }
         if(this.activeFinishers.length > 0)
         {
            return this.activeFinishers;
         }
         var _loc2_:FinisherFacade = this.GetOfferFinisher();
         if(_loc2_ != null)
         {
            this.activeFinishers.push(_loc2_);
         }
         for each(_loc3_ in this.finishers)
         {
            if(_loc3_.IsLoaded() && _loc3_.ShouldShowFinisher())
            {
               if(this.activeFinishers.indexOf(_loc2_) == -1)
               {
                  this.activeFinishers.push(_loc3_);
               }
            }
         }
         if(this.activeFinishers.length > 0)
         {
            return this.activeFinishers;
         }
         for each(_loc3_ in this.finishers)
         {
            if(_loc3_.IsLoaded() && _loc3_.ShouldShowFinisher(param1))
            {
               this.activeFinishers.push(_loc3_);
            }
         }
         return this.activeFinishers;
      }
      
      public function TryShowFinisher(param1:Boolean = false) : *
      {
         var _loc2_:Boolean = false;
         var _loc3_:FinisherFacade = null;
         if(this.activeFinishers.length == 0)
         {
            this.activeFinishers = this.GetActiveFinishers(param1);
            _loc2_ = true;
            if(this.activeFinishers.length > 0)
            {
               for each(_loc3_ in this.activeFinishers)
               {
                  _loc3_.ShowFinisher(null,_loc2_,this);
                  this.isPlayingFinisher = true;
                  _loc2_ = false;
               }
            }
         }
      }
      
      public function LoadFinisherGraphics() : void
      {
         var _loc1_:* = null;
         var _loc2_:FinisherFacade = null;
         var _loc3_:FinisherConfig = null;
         this.finishers = new Vector.<FinisherFacade>();
         for(_loc1_ in this.finisherMap)
         {
            _loc2_ = new FinisherFacade(Blitz3App.app);
            _loc3_ = this.GetConfigFor(_loc1_);
            _loc2_.LoadFinisher(_loc1_,_loc3_.GetAssetID());
            this.finishers.push(_loc2_);
         }
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         var _loc2_:TournamentRuntimeEntity = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:FinisherFacade = null;
         if(!Blitz3App.app.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE))
         {
            return;
         }
         if(!this.isPlayingFinisher && param1 <= 0)
         {
            _loc2_ = Blitz3App.app.sessionData.tournamentController.getCurrentTournament();
            _loc3_ = false;
            if(_loc2_ != null && _loc2_.Data.RuleSet.ShowEncore)
            {
               _loc3_ = true;
            }
            if(this.activeFinishers.length == 0)
            {
               this.activeFinishers = this.GetActiveFinishers(_loc3_);
               _loc4_ = true;
               if(this.activeFinishers.length > 0 && Blitz3App.app.logic.swaps.length == 0)
               {
                  for each(_loc5_ in this.activeFinishers)
                  {
                     _loc5_.ShowFinisher(null,_loc4_,this);
                     this.isPlayingFinisher = true;
                     _loc4_ = false;
                  }
               }
            }
            else if(Blitz3App.app.logic.rareGemsLogic != null && Blitz3App.app.logic.rareGemsLogic.hasCurrentRareGem() && Blitz3App.app.logic.rareGemsLogic.currentRareGem.IsCharacterPlaying())
            {
               this.activeFinishers[0].SetEndCallBackForCharacterEvent(this.CharacterAnimBeforePrePrestigeComplete);
            }
            else if(this.activeFinishers[0].SetConfigForPrePrestigeAnimation())
            {
               this.activeFinishers[0].ShowFinisher(this.CharacterPrePrestigeComplete);
               this.activeFinishers[0].SetFinisherState(FinisherPlayState.GetStateName());
            }
         }
      }
      
      private function CharacterPrePrestigeComplete() : void
      {
         if(this.activeFinishers[0].GetFinisherConfig().AllowFinisher())
         {
            Blitz3App.app.logic.rareGemsLogic.currentRareGem.PrePrestigeAnimComplete();
            this.ResetActiveCharacter();
            this.TryShowFinisher();
         }
      }
      
      private function CharacterAnimBeforePrePrestigeComplete() : void
      {
         if(this.activeFinishers[0].SetConfigForPrePrestigeAnimation())
         {
            this.activeFinishers[0].ShowFinisher(this.CharacterPrePrestigeComplete);
            this.activeFinishers[0].SetFinisherState(FinisherPlayState.GetStateName());
         }
      }
      
      public function GetOfferFinisher() : FinisherFacade
      {
         var _loc2_:FinisherFacade = null;
         var _loc1_:String = this.offers.GetAvailableFinisher();
         if(_loc1_.length == 0)
         {
            return null;
         }
         for each(_loc2_ in this.finishers)
         {
            if(_loc2_.IsLoaded() && _loc2_.GetFinisherConfig().GetID() == _loc1_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function IsOfferActive(param1:String) : Boolean
      {
         return this.GetOfferFinisher() && this.GetOfferFinisher().GetFinisherConfig().GetID() == param1;
      }
      
      private function handleComplete(param1:Event) : void
      {
         var jsonObj:Object = null;
         var finisherArray:Array = null;
         var i:int = 0;
         var finisherObject:FinisherConfig = null;
         var e:Event = param1;
         var loader:URLLoader = e.target as URLLoader;
         loader.removeEventListener(Event.COMPLETE,this.handleComplete);
         var data:String = loader.data;
         try
         {
            jsonObj = JSON.parse(data);
            if(this.currentConfigUrl != CHARACTER_URL)
            {
               this.offers = new FinisherInventory(jsonObj);
            }
            this.globalProperty = new FinisherGlobalProperties(jsonObj.globalProperties);
            finisherArray = jsonObj.configs as Array;
            i = finisherArray.length - 1;
            while(i >= 0)
            {
               finisherObject = new FinisherConfig(finisherArray[i]);
               this.finisherMap[finisherObject.GetID()] = finisherObject;
               i--;
            }
            if(this.pendingUrls.length > 0)
            {
               this.FetchConfig();
            }
            else
            {
               this.executeHandlers();
            }
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Unable to parse finisher Data: " + e.message);
         }
      }
      
      private function executeHandlers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Function = null;
         if(this.handlers != null)
         {
            _loc1_ = this.handlers.length - 1;
            while(_loc1_ >= 0)
            {
               _loc2_ = this.handlers[_loc1_];
               _loc2_();
               _loc1_--;
            }
         }
      }
      
      private function handleError(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.target as URLLoader;
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_COMMUNICATION_PHP,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"NetworkError: " + param1 + " on Get finisher Data");
      }
      
      public function SetReplayFinisherId(param1:String) : void
      {
         var _loc2_:FinisherFacade = null;
         for each(_loc2_ in this.finishers)
         {
            if(_loc2_.GetFinisherConfig().GetID() == param1)
            {
               this.replayFinisher = _loc2_;
               this.replayFinisher.ResetCharacterConfig();
               return;
            }
         }
         this.replayFinisher = null;
      }
      
      public function GetReplayFinisherId() : FinisherFacade
      {
         return this.replayFinisher;
      }
      
      public function GetFinisherForReplayById(param1:String) : FinisherFacade
      {
         var _loc3_:FinisherFacade = null;
         var _loc2_:FinisherFacade = null;
         for each(_loc3_ in this.finishers)
         {
            if(_loc3_.GetFinisherConfig().GetID() == param1)
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      public function GetCurrentFinisherFromSessionData() : FinisherFacade
      {
         var _loc3_:FinisherFacade = null;
         var _loc1_:FinisherFacade = null;
         var _loc2_:String = Blitz3App.app.sessionData.finisherSessionData.GetFinisherName();
         if(_loc2_ != "")
         {
            for each(_loc3_ in this.activeFinishers)
            {
               if(_loc3_.GetFinisherConfig().GetID() == _loc2_)
               {
                  _loc1_ = _loc3_;
               }
            }
         }
         return _loc1_;
      }
      
      public function onReplayAborted() : void
      {
         if(this.activeFinishers.length > 0)
         {
            this.activeFinishers[0].ResetInGame();
         }
      }
      
      public function OnFinisherPopupAnimationComplete() : void
      {
      }
      
      public function OnFinisherPopupConfirm() : void
      {
         var _loc1_:FinisherFacade = null;
         for each(_loc1_ in this.activeFinishers)
         {
            _loc1_.getPopupWidget().onPopupClose();
         }
      }
      
      public function OnFinisherPopupCancel() : void
      {
         var _loc1_:FinisherFacade = null;
         for each(_loc1_ in this.activeFinishers)
         {
            _loc1_.getPopupWidget().onPopupClose();
         }
      }
      
      public function BlockFinisherPopupTimerAnimation(param1:Boolean) : void
      {
         var _loc2_:FinisherFacade = null;
         for each(_loc2_ in this.activeFinishers)
         {
            _loc2_.getPopupWidget().BlockTimerAnimation(param1);
         }
      }
   }
}
