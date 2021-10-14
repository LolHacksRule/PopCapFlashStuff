package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.endgamepopups.JSPopUpController;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameFrame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.PauseMenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.RareGemAwardScreen;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MainWidgetGame extends MainWidget
   {
       
      
      private var m_GameApp:Blitz3Game;
      
      public var menu:MenuWidget;
      
      public var game:GameWidget;
      
      public var boostDialog:BoostDialog;
      
      public var rareGemDialog:RareGemAwardScreen;
      
      public var pause:PauseMenuWidget;
      
      public var networkWait:NetworkWaitWidget;
      
      private var messageContainer:Sprite;
      
      private var gamePopUps:JSPopUpController;
      
      public var frame:GameFrame;
      
      private var m_MessageQueue:Vector.<DisplayObject>;
      
      public function MainWidgetGame(param1:Blitz3Game)
      {
         this.m_GameApp = param1;
         super(param1);
         this.menu = new MenuWidget(param1);
         this.boostDialog = new BoostDialog(param1);
         this.rareGemDialog = new RareGemAwardScreen(param1);
         this.game = new GameWidget(param1);
         this.pause = new PauseMenuWidget(param1);
         this.networkWait = new NetworkWaitWidget(param1);
         this.messageContainer = new Sprite();
         this.gamePopUps = new JSPopUpController(param1);
         this.frame = new GameFrame(param1);
         this.m_MessageQueue = new Vector.<DisplayObject>();
      }
      
      override public function PlayMode(param1:Boolean) : void
      {
         if(param1)
         {
            this.ShowPlaying();
         }
         else
         {
            this.HidePlaying();
         }
      }
      
      override public function MessageMode(param1:Boolean, param2:Sprite) : void
      {
         if(param1)
         {
            this.ShowMessage(param2);
            if(this.menu.leftPanel)
            {
               this.menu.leftPanel.showAll(false,true);
            }
         }
         else
         {
            this.HideMessage(param2);
         }
      }
      
      override public function ClearMessages() : void
      {
         this.MessageMode(false,null);
         this.m_GameApp.metaUI.questReward.Hide();
      }
      
      private function ShowPlaying() : void
      {
         if(contains(this.menu))
         {
            this.menu.BoostLoadOutPlaceHolder.removeChild(this.boostDialog);
            this.menu.HarvestPlaceHolder.removeChild(this.rareGemDialog);
            removeChild(this.menu);
            this.m_GameApp.networkPopupContainer.removeChild(this.networkWait);
         }
      }
      
      private function HidePlaying() : void
      {
         this.AddChildren();
      }
      
      private function ShowMessage(param1:DisplayObject) : void
      {
         if(this.m_MessageQueue.indexOf(param1) >= 0)
         {
            return;
         }
         this.m_MessageQueue.push(param1);
         if(this.messageContainer.numChildren <= 0)
         {
            if(contains(this.game))
            {
               removeChild(this.game);
            }
            this.PlayMode(true);
            SpinBoardUIController.GetInstance().CloseSpinBoard();
            this.ShowNextMessage();
         }
      }
      
      private function HideMessage(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            this.m_MessageQueue.length = 0;
            this.ClearMessageContainer();
            this.AddChildren();
            return;
         }
         var _loc2_:int = this.m_MessageQueue.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.m_MessageQueue.splice(_loc2_,1);
         }
         else if(this.messageContainer.contains(param1))
         {
            this.ClearMessageContainer();
            if(this.m_MessageQueue.length > 0)
            {
               this.ShowNextMessage();
            }
            else
            {
               this.AddChildren();
            }
         }
      }
      
      private function ClearMessageContainer() : void
      {
         while(this.messageContainer.numChildren > 0)
         {
            this.messageContainer.removeChildAt(0);
         }
      }
      
      private function ShowNextMessage() : void
      {
         this.messageContainer.addChild(this.m_MessageQueue.shift());
      }
      
      public function IsMessageShowing() : Boolean
      {
         return this.messageContainer.numChildren > 0;
      }
      
      override protected function AddChildren() : void
      {
         super.AddChildren();
         addChild(this.menu);
         this.menu.BoostLoadOutPlaceHolder.addChild(this.boostDialog);
         addChild(this.game);
         this.m_GameApp.networkPopupContainer.addChild(this.networkWait);
         m_App.topLayer.addChild(this.messageContainer);
         this.menu.HarvestPlaceHolder.addChild(this.rareGemDialog);
      }
      
      override protected function InitChildren() : void
      {
         super.InitChildren();
         this.menu.Init();
         this.game.init();
         this.boostDialog.Init();
         this.rareGemDialog.Init();
         this.pause.Init();
         this.networkWait.Init();
         this.frame.Init(Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH + 1,Dimensions.GAME_HEIGHT + 1);
         this.game.laserCat.x = 84;
         this.game.phoenixPrism.x = this.game.board.x;
         this.game.phoenixPrism.y = this.game.board.y;
      }
      
      private function HandleOptionsClicked(param1:MouseEvent) : void
      {
      }
      
      public function OnReplayStateEnter() : void
      {
         this.PlayMode(true);
         this.game.OnReplayEnter();
      }
      
      public function OnReplayStateExit() : void
      {
         this.PlayMode(false);
         this.game.OnReplayExit();
      }
   }
}
