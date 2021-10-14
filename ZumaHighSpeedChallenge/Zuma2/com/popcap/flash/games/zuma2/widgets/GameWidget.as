package com.popcap.flash.games.zuma2.widgets
{
   import com.popcap.flash.framework.widgets.Widget;
   import com.popcap.flash.framework.widgets.WidgetContainer;
   import com.popcap.flash.games.zuma2.logic.LevelMgr;
   import com.popcap.flash.games.zuma2.logic.MainMenu;
   
   public class GameWidget extends WidgetContainer implements Widget
   {
       
      
      public var board:GameBoardWidget;
      
      public var mIsInited:Boolean;
      
      public var mApp:Zuma2App;
      
      public var menu:MainMenu;
      
      public function GameWidget(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
         this.mIsInited = false;
      }
      
      override public function onKeyUp(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < mChildren.length)
         {
            mChildren[_loc2_].onKeyUp(param1);
            _loc2_++;
         }
      }
      
      public function Reset() : void
      {
         this.Clear();
         this.mApp.mLevelMgr = new LevelMgr(this.mApp);
         this.mApp.mLevelMgr.LoadXML("levels.xml");
      }
      
      public function init() : void
      {
         this.mIsInited = true;
         this.ShowMainMenu();
      }
      
      override public function onKeyDown(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < mChildren.length)
         {
            mChildren[_loc2_].onKeyDown(param1);
            _loc2_++;
         }
      }
      
      public function StartNewGame() : void
      {
         this.CloseMainMenu();
         this.Reset();
         this.board = new GameBoardWidget(this.mApp);
         addChild(this.board);
      }
      
      public function ShowMainMenu() : void
      {
         if(this.board != null)
         {
            removeChild(this.board);
            this.board = null;
         }
         this.menu = new MainMenu(this.mApp,this);
      }
      
      public function CloseMainMenu() : void
      {
         this.menu = null;
      }
      
      override public function update() : void
      {
         if(!this.mIsInited)
         {
            this.init();
         }
         if(this.mApp.mLevelMgr != null)
         {
            if(this.mApp.mLevelMgr.mReady)
            {
               super.update();
            }
         }
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mApp.mLayers.length)
         {
            this.mApp.mLayers[_loc1_].Clear();
            _loc1_++;
         }
      }
   }
}
