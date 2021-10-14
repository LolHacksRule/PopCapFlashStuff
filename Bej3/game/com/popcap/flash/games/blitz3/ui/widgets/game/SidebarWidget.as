package com.popcap.flash.games.blitz3.ui.widgets.game
{
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.BoostIconBarWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.ButtonPanelWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.CoinBankWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.HighScoreWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.LaserCatWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.RareGemWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.ScoreWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.SpeedBonusWidget;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.StarMedalWidget;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class SidebarWidget extends Sprite
   {
       
      
      public var speed:SpeedBonusWidget;
      
      public var score:ScoreWidget;
      
      public var boostIcons:BoostIconBarWidget;
      
      public var starMedal:StarMedalWidget;
      
      public var highScore:HighScoreWidget;
      
      public var buttons:ButtonPanelWidget;
      
      public var laserCat:LaserCatWidget;
      
      public var coinBank:CoinBankWidget;
      
      public var rareGem:RareGemWidget;
      
      private var mApp:Blitz3Game;
      
      private var mIsInited:Boolean = false;
      
      public function SidebarWidget(app:Blitz3Game)
      {
         super();
         this.mApp = app;
         this.speed = new SpeedBonusWidget(app);
         this.score = new ScoreWidget(app);
         this.boostIcons = new BoostIconBarWidget(app);
         this.starMedal = new StarMedalWidget(app);
         this.highScore = new HighScoreWidget(app);
         this.buttons = new ButtonPanelWidget(app);
         this.laserCat = new LaserCatWidget(app);
         this.coinBank = new CoinBankWidget(app);
         this.rareGem = new RareGemWidget(app);
      }
      
      public function Init() : void
      {
         addChild(this.speed);
         addChild(this.score);
         addChild(this.starMedal);
         addChild(this.boostIcons);
         addChild(this.rareGem);
         addChild(this.highScore);
         addChild(this.coinBank);
         addChild(this.buttons);
         addChild(this.laserCat);
         this.speed.Init();
         this.score.Init();
         this.boostIcons.Init();
         this.starMedal.Init();
         this.highScore.Init();
         this.laserCat.Init();
         this.coinBank.Init();
         this.buttons.Init();
         this.rareGem.Init();
         this.SetLayout(84,10,3);
         this.starMedal.visible = this.mApp.network.isOffline;
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         this.speed.Reset();
         this.score.Reset();
         this.boostIcons.Reset();
         this.starMedal.Reset();
         this.highScore.Reset();
         this.laserCat.Reset();
         this.coinBank.Reset();
         this.buttons.Reset();
         this.rareGem.Reset();
      }
      
      public function Update() : void
      {
         this.laserCat.Update();
      }
      
      public function Draw() : void
      {
      }
      
      private function SetLayout(xPos:int, yPos:int, elementSpacing:int) : void
      {
         var elements:Array = new Array(this.speed,this.score,this.boostIcons,this.rareGem);
         this.SetYPosLayout(yPos,elementSpacing,elements);
         elements = [this.starMedal,this.highScore,this.buttons];
         this.SetYPosLayout(this.rareGem.y + 5,elementSpacing,elements);
         this.boostIcons.Clear();
         this.SetXPosLayout(xPos);
         this.coinBank.y = this.highScore.y - 7;
         this.buttons.y = 260;
      }
      
      public function SetXPosLayout(xPos:int) : void
      {
         var obj:DisplayObject = null;
         for(var i:int = 0; i < numChildren; i++)
         {
            obj = getChildAt(i);
            obj.x = xPos - 0.5 * obj.getRect(this).width;
         }
      }
      
      public function SetYPosLayout(initY:int, elementSpacing:int, elements:Array) : void
      {
         var visibleHeight:int = 0;
         var yStride:int = initY;
         for(var i:int = 0; i < elements.length; i++)
         {
            elements[i].y = yStride;
            visibleHeight = (elements[i] as DisplayObject).getRect(this).height;
            yStride = visibleHeight > 0 ? int(visibleHeight + yStride + elementSpacing) : int(yStride + elementSpacing);
         }
      }
   }
}
