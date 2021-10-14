package com.popcap.flash.games.blitz3.session
{
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.utils.Dictionary;
   
   public class SessionData implements IBlitz3NetworkHandler
   {
       
      
      protected var m_App:Blitz3App;
      
      public var userData:UserData;
      
      public var boostManager:BoostManager;
      
      public var rareGemManager:RareGemManager;
      
      public var featureManager:FeatureManager;
      
      public var dataStore:DataStore;
      
      public function SessionData(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.rareGemManager = new RareGemManager(app);
         this.featureManager = new FeatureManager();
         this.userData = new UserData(app);
         this.boostManager = new BoostManager(app);
      }
      
      public function Init() : void
      {
         var params:Dictionary = new Dictionary();
         if(this.m_App.network)
         {
            params = this.m_App.network.parameters;
         }
         this.dataStore = new DataStore(params["fb_user"]);
         this.rareGemManager.Init();
         this.featureManager.Init(params);
         this.userData.Init();
         this.boostManager.Init();
         if(this.m_App.network)
         {
            this.m_App.network.AddHandler(this);
         }
      }
      
      public function ForceDispatchSessionData() : void
      {
         this.userData.ForceDispatchUserInfo();
         this.boostManager.ForceDispatchBoostInfo();
         this.rareGemManager.ForceDispatchRareGemInfo();
      }
      
      public function HandleNetworkError() : void
      {
      }
      
      public function HandleNetworkSuccess() : void
      {
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
         this.userData.HandleGameStart();
         this.boostManager.HandleGameStart();
      }
   }
}
