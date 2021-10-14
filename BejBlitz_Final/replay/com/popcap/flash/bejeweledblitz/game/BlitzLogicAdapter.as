package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.IRareGemManagerHandler;
   import com.popcap.flash.bejeweledblitz.logic.boosts.IBoostLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IAutoHintLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGemLogicHandler;
   import flash.utils.Dictionary;
   
   public class BlitzLogicAdapter implements IAutoHintLogicHandler, IBoostLogicHandler, IBoostManagerHandler, IRareGemLogicHandler, IRareGemManagerHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_NextBoosts:Vector.<String>;
      
      private var m_NextRareGem:String;
      
      public function BlitzLogicAdapter(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_NextBoosts = new Vector.<String>();
         this.m_NextRareGem = "";
      }
      
      public function Init() : void
      {
         this.m_App.logic.autoHintLogic.AddHandler(this);
         if(Blitz3Game.AUTOPLAY)
         {
            this.m_App.logic.boostLogic.SetHandler(this.m_App.tester);
            this.m_App.logic.rareGemLogic.SetHandler(this.m_App.tester);
         }
         else
         {
            this.m_App.logic.boostLogic.SetHandler(this);
            this.m_App.logic.rareGemLogic.SetHandler(this);
         }
         this.m_App.sessionData.boostManager.AddHandler(this);
         this.m_App.sessionData.rareGemManager.AddHandler(this);
      }
      
      public function AllowAutoHint() : Boolean
      {
         return this.m_App.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT);
      }
      
      public function GetActiveBoostList(boosts:Vector.<String>) : void
      {
         boosts.length = 0;
         var gameApp:Blitz3Game = this.m_App as Blitz3Game;
         if(gameApp != null && gameApp.tutorial.IsEnabled())
         {
            return;
         }
         var numBoosts:int = this.m_NextBoosts.length;
         boosts.length = numBoosts;
         for(var i:int = 0; i < numBoosts; i++)
         {
            boosts[i] = this.m_NextBoosts[i];
         }
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
         var key:* = null;
         this.m_NextBoosts.length = 0;
         for(key in activeBoosts)
         {
            this.m_NextBoosts.push(key);
         }
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
      }
      
      public function GetActiveRareGem() : String
      {
         var gameApp:Blitz3Game = this.m_App as Blitz3Game;
         if(gameApp != null && gameApp.tutorial.IsEnabled())
         {
            return "";
         }
         return this.m_NextRareGem;
      }
      
      public function HandleRareGemCatalogChanged(rareGemCatalog:Dictionary) : void
      {
      }
      
      public function HandleActiveRareGemChanged(activeRareGem:String) : void
      {
         this.m_NextRareGem = "";
         if(activeRareGem == "")
         {
            return;
         }
         this.m_NextRareGem = activeRareGem;
      }
   }
}
