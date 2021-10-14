package com.popcap.flash.bejeweledblitz.game.ui
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.BoostDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GraphicalButton;
   import com.popcap.flash.bejeweledblitz.game.ui.game.GameFrame;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.GameOverWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.XPCheatWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.menu.MenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.options.OptionMenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.PauseMenuWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.RareGemAwardScreen;
   import com.popcap.flash.bejeweledblitz.messages.friendscore.FriendscoreMessages;
   import com.popcap.flash.bejeweledblitz.messages.newuser.NewUserMessages;
   import com.popcap.flash.bejeweledblitz.messages.raregems.RareGemMessages;
   import com.popcap.flash.bejeweledblitz.messages.starmedals.StarMedalMessages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class MainWidgetGame extends MainWidget
   {
       
      
      public var menu:MenuWidget;
      
      public var gameOver:GameOverWidget;
      
      public var optionsButton:GraphicalButton;
      
      public var boostDialog:BoostDialog;
      
      public var rareGemDialog:RareGemAwardScreen;
      
      public var pause:PauseMenuWidget;
      
      public var options:OptionMenuWidget;
      
      public var networkWait:NetworkWaitWidget;
      
      private var messageContainer:Sprite;
      
      public var friendscoreMessages:FriendscoreMessages;
      
      public var newUserMessages:NewUserMessages;
      
      public var rareGemMessages:RareGemMessages;
      
      public var starMedalMessages:StarMedalMessages;
      
      public var frame:GameFrame;
      
      private var xpCheat:XPCheatWidget;
      
      public function MainWidgetGame(app:Blitz3Game)
      {
         super(app);
         this.menu = new MenuWidget(app);
         this.gameOver = new GameOverWidget(app);
         this.optionsButton = new GraphicalButton(app,m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_OPTIONS_BUTTON));
         this.boostDialog = new BoostDialog(app);
         this.rareGemDialog = new RareGemAwardScreen(app);
         this.pause = new PauseMenuWidget(app);
         this.options = new OptionMenuWidget(app);
         this.networkWait = new NetworkWaitWidget(app);
         this.messageContainer = new Sprite();
         this.friendscoreMessages = new FriendscoreMessages(app);
         this.newUserMessages = new NewUserMessages(app);
         this.rareGemMessages = new RareGemMessages(app);
         this.starMedalMessages = new StarMedalMessages(app);
         this.frame = new GameFrame(app);
         this.xpCheat = new XPCheatWidget(app);
         m_App.RegisterCommand("FriendscoreMessageCheat",this.FriendscoreMessageCheat);
         m_App.RegisterCommand("NewUserMessageCheat",this.NewUserMessageCheat);
         m_App.RegisterCommand("RareGemMessageCheat",this.RareGemMessageCheat);
         m_App.RegisterCommand("StarMedalMessageCheat",this.StarMedalMessageCheat);
         scrollRect = new Rectangle(0,0,Dimensions.GAME_WIDTH,Dimensions.GAME_HEIGHT);
      }
      
      override public function PlayMode(playing:Boolean) : void
      {
         if(playing)
         {
            if(contains(this.menu))
            {
               removeChild(this.menu);
               removeChild(this.gameOver);
               removeChild(this.boostDialog);
               removeChild(this.rareGemDialog);
               removeChild(this.pause);
               removeChild(this.options);
               removeChild(this.optionsButton);
               removeChild(this.networkWait);
            }
         }
         else
         {
            this.AddChildren();
         }
      }
      
      override public function MessageMode(messaging:Boolean, message:Sprite = null) : void
      {
         if(messaging)
         {
            if(contains(game))
            {
               removeChild(game);
            }
            this.PlayMode(true);
            if(this.messageContainer.numChildren > 0)
            {
               this.messageContainer.removeChildAt(0);
            }
            if(message)
            {
               this.messageContainer.addChild(message);
            }
         }
         else
         {
            this.AddChildren();
         }
      }
      
      override protected function AddChildren() : void
      {
         super.AddChildren();
         addChild(this.menu);
         addChild(this.gameOver);
         addChild(this.boostDialog);
         addChild(this.rareGemDialog);
         addChild(this.pause);
         addChild(this.options);
         addChild(this.optionsButton);
         addChild(this.networkWait);
         addChild(this.messageContainer);
         if(this.messageContainer.numChildren > 0)
         {
            this.messageContainer.removeChildAt(0);
         }
         addChild(this.frame);
         addChild(this.xpCheat);
      }
      
      override protected function InitChildren() : void
      {
         game.board.x = 168;
         game.board.y = 49;
         super.InitChildren();
         this.menu.Init();
         this.gameOver.Init();
         this.boostDialog.Init();
         this.rareGemDialog.Init();
         this.pause.Init();
         this.options.Init();
         this.networkWait.Init();
         this.frame.Init(Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH,Dimensions.GAME_HEIGHT);
         game.laserCat.x = 84;
         game.phoenixPrism.x = game.board.x;
         game.phoenixPrism.y = game.board.y;
         this.optionsButton.x = 2;
         this.optionsButton.y = Dimensions.GAME_HEIGHT - this.optionsButton.height - 2;
         this.optionsButton.addEventListener(MouseEvent.CLICK,this.HandleOptionsClicked);
         this.xpCheat.Init();
         this.xpCheat.x = 10;
         this.xpCheat.y = 10;
      }
      
      private function HandleOptionsClicked(event:MouseEvent) : void
      {
         if(this.options.visible)
         {
            this.options.Hide();
            return;
         }
         this.options.Show();
      }
      
      private function FriendscoreMessageCheat(args:Array = null) : void
      {
         this.friendscoreMessages.RotateMessage();
      }
      
      private function NewUserMessageCheat(args:Array = null) : void
      {
         this.newUserMessages.RotateMessage();
      }
      
      private function RareGemMessageCheat(args:Array = null) : void
      {
         this.rareGemMessages.RotateMessage();
      }
      
      private function StarMedalMessageCheat(args:Array = null) : void
      {
         this.starMedalMessages.RotateMessage();
      }
   }
}
