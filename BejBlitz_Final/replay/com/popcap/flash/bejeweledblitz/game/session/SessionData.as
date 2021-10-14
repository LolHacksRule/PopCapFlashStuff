package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.achievement.AchievementManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   
   public class SessionData implements IBlitz3NetworkHandler
   {
       
      
      private var m_App:Blitz3App;
      
      public var featureManager:FeatureManager;
      
      public var configManager:ConfigManager;
      
      public var userData:UserData;
      
      public var boostManager:BoostManager;
      
      public var rareGemManager:RareGemManager;
      
      public var achievementManager:AchievementManager;
      
      public function SessionData(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.featureManager = new FeatureManager(this.m_App);
         this.configManager = new ConfigManager(this.m_App);
         this.userData = new UserData(this.m_App);
         this.boostManager = new BoostManager(this.m_App);
         this.rareGemManager = new RareGemManager(this.m_App);
         this.achievementManager = new AchievementManager(this.m_App);
      }
      
      public function Init() : void
      {
         if("fb_user" in this.m_App.network.parameters)
         {
            this.userData.SetFUID(this.m_App.network.parameters.fb_user);
         }
         if("locale" in this.m_App.network.parameters)
         {
            this.userData.SetLocale(this.m_App.network.parameters.locale);
         }
         this.featureManager.Init();
         this.configManager.Init();
         this.userData.Init();
         this.boostManager.Init();
         this.rareGemManager.Init();
         this.achievementManager.Init();
         this.m_App.network.AddHandler(this);
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
      
      public function HandleNetworkSuccess(response:XML) : void
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
