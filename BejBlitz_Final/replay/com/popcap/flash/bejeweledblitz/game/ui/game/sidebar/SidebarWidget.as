package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Sprite;
   
   public class SidebarWidget extends Sprite
   {
       
      
      public var score:ScoreWidget;
      
      public var speed:SpeedBonusWidget;
      
      public var boostIcons:BoostIconBarWidget;
      
      public var rareGem:RareGemWidget;
      
      public var starMedal:StarMedalWidget;
      
      public var highScore:HighScoreWidget;
      
      public var buttons:ButtonPanelWidget;
      
      protected var app:Blitz3App;
      
      public function SidebarWidget(app:Blitz3App)
      {
         super();
         this.app = app;
         this.score = new ScoreWidget(app);
         this.speed = new SpeedBonusWidget(app);
         this.boostIcons = new BoostIconBarWidget(app);
         this.rareGem = new RareGemWidget(app);
      }
      
      public function Init() : void
      {
         this.AddChildren();
         this.InitChildren();
         visible = false;
      }
      
      public function Reset() : void
      {
         this.score.Reset();
         this.speed.Reset();
         this.boostIcons.Reset();
         this.rareGem.Reset();
      }
      
      protected function AddChildren() : void
      {
         addChild(this.score);
         addChild(this.speed);
         addChild(this.boostIcons);
         addChild(this.rareGem);
      }
      
      protected function InitChildren() : void
      {
         this.score.Init();
         this.speed.Init();
         this.boostIcons.Init();
         this.rareGem.Init();
         this.score.x = 22;
         this.score.y = 1;
         this.speed.x = 144;
         this.speed.y = 20;
         this.boostIcons.x = 280;
         this.boostIcons.y = 20;
         this.rareGem.x = 335;
         this.rareGem.y = 20;
      }
   }
}
