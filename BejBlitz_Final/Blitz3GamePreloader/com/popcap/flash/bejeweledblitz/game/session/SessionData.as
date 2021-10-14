package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.GameBoardSeed;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2Manager;
   import com.popcap.flash.bejeweledblitz.game.finisher.FinisherManager;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.replay.ReplayDataManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.controllers.TournamentController;
   
   public class SessionData implements ISessionData, IHandleNetworkGameStart
   {
       
      
      private var _app:Blitz3App;
      
      private var _userData:UserData;
      
      private var _finisherSessionData:FinisherSessionData;
      
      private var _gameSessionID:String;
      
      public var throttleManager:ThrottleManager;
      
      public var configManager:ConfigManager;
      
      public var featureManager:FeatureManager;
      
      private var _rareGemManager:RareGemManager;
      
      public var finisherManager:FinisherManager;
      
      private var _boostV2Manager:BoostV2Manager;
      
      public var ftueManager:FTUEManager;
      
      public var replayManager:ReplayDataManager;
      
      private var _tournamentController:TournamentController;
      
      public function SessionData(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this.throttleManager = new ThrottleManager(this._app);
         this._gameSessionID = "";
         if(this.finisherManager == null)
         {
            this.finisherManager = new FinisherManager();
         }
         this._boostV2Manager = new BoostV2Manager(this._app);
         this.ftueManager = new FTUEManager(this._app);
         this.configManager = new ConfigManager(this._app);
         this.featureManager = new FeatureManager(this._app);
         this._userData = new UserData(this._app);
         this._rareGemManager = new RareGemManager(this._app);
         this._finisherSessionData = new FinisherSessionData();
         this.replayManager = new ReplayDataManager(this._app);
         this._tournamentController = new TournamentController(this._app as Blitz3Game);
      }
      
      public function get finisherSessionData() : FinisherSessionData
      {
         return this._finisherSessionData;
      }
      
      public function getValidatedSessionID(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._gameSessionID.length == param1)
         {
            return this._gameSessionID;
         }
         var _loc2_:* = "";
         if(this._gameSessionID.length < param1)
         {
            _loc2_ += this._gameSessionID;
            _loc3_ = param1 - this._gameSessionID.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ += "0";
               _loc4_++;
            }
         }
         else
         {
            _loc2_ = this._gameSessionID.substring(0,param1 - 1);
         }
         return _loc2_;
      }
      
      public function setGameSeedData(param1:String) : void
      {
         GameBoardSeed.SetSeed(parseInt(param1));
         this._app.logic.mGameSeed = param1;
      }
      
      public function setGameSessionID(param1:String) : void
      {
         this._gameSessionID = param1;
      }
      
      public function getGameSessionID() : String
      {
         return this._gameSessionID;
      }
      
      public function get userData() : UserData
      {
         return this._userData;
      }
      
      public function get rareGemManager() : RareGemManager
      {
         return this._rareGemManager;
      }
      
      public function get boostV2Manager() : BoostV2Manager
      {
         return this._boostV2Manager;
      }
      
      public function get tournamentController() : TournamentController
      {
         return this._tournamentController;
      }
      
      public function Init() : void
      {
         if("fb_user" in this._app.network.parameters)
         {
            this.userData.SetFUID(this._app.network.parameters.fb_user);
         }
         this._gameSessionID = "";
         this.userData.SetLocale("en-US");
         this.throttleManager.Init();
         this.configManager.Init();
         this.featureManager.Init();
         this.finisherManager.Init();
         this._boostV2Manager.Init();
         this.ftueManager.Init();
         this.userData.Init();
         this.rareGemManager.Init();
         SpinBoardController.GetInstance().Init();
         this._app.network.AddNetworkStartHandler(this);
      }
      
      public function ForceDispatchSessionData() : void
      {
         this.userData.ForceDispatchUserInfo();
         this.rareGemManager.ForceDispatchRareGemInfo();
      }
      
      public function AbortGame() : void
      {
         this.rareGemManager.EndStreak();
         this.rareGemManager.ForceDispatchRareGemInfo();
      }
      
      public function HandleNetworkGameStart() : void
      {
         this.finisherSessionData.Reset();
         this.userData.HandleGameStart();
      }
   }
}
