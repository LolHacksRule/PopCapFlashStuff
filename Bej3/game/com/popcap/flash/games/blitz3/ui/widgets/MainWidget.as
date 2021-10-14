package com.popcap.flash.games.blitz3.ui.widgets
{
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.BoostDialog;
   import com.popcap.flash.games.blitz3.ui.widgets.game.pause.PauseMenuWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.raregems.RareGemAwardScreen;
   import com.popcap.flash.games.blitz3.ui.widgets.game.stats.PostGameStatsWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.options.OptionMenuWidget;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MainWidget extends Sprite
   {
       
      
      public var menu:MenuWidget;
      
      public var game:GameWidget;
      
      public var help:HelpWidget;
      
      public var stats:PostGameStatsWidget;
      
      public var optionsButton:FadeButton;
      
      public var boostDialog:BoostDialog;
      
      public var rareGemDialog:RareGemAwardScreen;
      
      public var pause:PauseMenuWidget;
      
      public var options:OptionMenuWidget;
      
      public var networkWait:NetworkWaitWidget;
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      public function MainWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.game = new GameWidget(app);
         this.menu = new MenuWidget(app);
         this.help = new HelpWidget(app);
         this.help.x = 15;
         this.stats = new PostGameStatsWidget(app);
         this.optionsButton = new FadeButton(app);
         this.boostDialog = new BoostDialog(app);
         this.rareGemDialog = new RareGemAwardScreen(app);
         this.pause = new PauseMenuWidget(app);
         this.options = new OptionMenuWidget(app);
         this.networkWait = new NetworkWaitWidget(app);
      }
      
      public function Init() : void
      {
         addChild(this.game);
         addChild(this.menu);
         addChild(this.stats);
         addChild(this.boostDialog);
         addChild(this.rareGemDialog);
         addChild(this.pause);
         addChild(this.options);
         addChild(this.optionsButton);
         addChild(this.help);
         addChild(this.networkWait);
         this.game.Init();
         this.menu.Init();
         this.stats.Init();
         this.boostDialog.Init();
         this.rareGemDialog.Init();
         this.pause.Init();
         this.options.Init();
         this.networkWait.Init();
         this.stats.visible = false;
         this.optionsButton.x = Blitz3Game.SCREEN_WIDTH * 0.05 - this.optionsButton.width * 0.5;
         this.optionsButton.y = Blitz3Game.SCREEN_HEIGHT * 0.95 - this.optionsButton.height * 0.5;
         this.optionsButton.addEventListener(MouseEvent.CLICK,this.HandleOptionsClicked);
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.menu.Reset();
         this.game.Reset();
         this.stats.Reset();
         this.boostDialog.Reset();
         this.rareGemDialog.Reset();
         this.pause.Reset();
         this.options.Reset();
         this.networkWait.Reset();
      }
      
      public function Update() : void
      {
         this.boostDialog.Update();
         this.rareGemDialog.Update();
         this.pause.Update();
         this.options.Update();
         this.networkWait.Update();
      }
      
      public function Draw() : void
      {
      }
      
      private function HandleOptionsClicked(event:MouseEvent) : void
      {
         if(this.options.visible)
         {
            trace("Hiding options");
            this.options.Hide();
            return;
         }
         this.options.Show();
      }
   }
}
