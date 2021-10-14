package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.session.SessionData;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.StarMedalFactory;
   import com.popcap.flash.bejeweledblitz.game.ui.UIFactory;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.BaseApp;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class Blitz3App extends BaseApp
   {
      
      public static const HELP_LOAD_FAILED:int = 1;
      
      public static const GAMEOVER_LOAD_FAILED:int = 2;
       
      
      public var logic:BlitzLogic;
      
      public var network:Blitz3Network;
      
      public var sessionData:SessionData;
      
      private var logicAdapter:BlitzLogicAdapter;
      
      public var ui:MainWidget;
      
      public var uiFactory:UIFactory;
      
      public var starMedalTable:StarMedalFactory;
      
      public var isReplayer:Boolean = false;
      
      public var tester:LogicTester;
      
      public function Blitz3App(versionName:String)
      {
         super(versionName);
      }
      
      public function Init() : void
      {
         StringUtils.thousandsSeparator = TextManager.GetLocString(Blitz3GameLoc.LOC_THOUSAND_SEP);
         this.logic = new BlitzLogic();
         this.network = new Blitz3Network(this);
         this.sessionData = new SessionData(this);
         this.logicAdapter = new BlitzLogicAdapter(this);
         this.network.Init(stage.loaderInfo.parameters);
         this.sessionData.Init();
         this.logicAdapter.Init();
         this.tester = new LogicTester(this.logic);
      }
   }
}
