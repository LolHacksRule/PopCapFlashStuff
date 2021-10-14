package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class TutorialWidget extends Sprite implements IPauseMenuHandler
   {
      
      public static const ARROW_FROM_RIGHT:int = 0;
      
      public static const ARROW_FROM_BOTTOM:int = 90;
      
      public static const ARROW_FROM_LEFT:int = 180;
      
      public static const ARROW_FROM_TOP:int = 270;
       
      
      private var m_App:Blitz3Game;
      
      public var arrow:ArrowPointer;
      
      public var infoBox:TutorialMessageBox;
      
      public var banner:TutorialBanner;
      
      private var m_ReShowArrowAfterPause:Boolean;
      
      public function TutorialWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.arrow = new ArrowPointer(app);
         this.infoBox = new TutorialMessageBox(app);
         this.banner = new TutorialBanner(app);
         this.m_ReShowArrowAfterPause = false;
         this.m_App.RegisterCommand("ForceTutorialCheat",this.ForceTutorialCheat);
      }
      
      public function Init() : void
      {
         this.arrow.Init();
         this.infoBox.Init();
         this.banner.Init();
         var leaderboardWidth:Number = Dimensions.PRELOADER_WIDTH - Dimensions.GAME_WIDTH;
         var leaderboardHeight:Number = Dimensions.GAME_HEIGHT;
         this.infoBox.x = this.m_App.leaderboard.x + leaderboardWidth * 0.5 - this.infoBox.width * 0.5;
         this.infoBox.y = this.m_App.leaderboard.y + 5;
         this.banner.x = this.m_App.friendscore.x;
         this.banner.y = this.m_App.friendscore.y;
         var gameWidget:MainWidgetGame = this.m_App.ui as MainWidgetGame;
         if(gameWidget != null)
         {
            gameWidget.pause.AddHandler(this);
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.arrow.Reset();
         this.infoBox.Reset();
         this.banner.Reset();
         this.HideAll();
         this.m_ReShowArrowAfterPause = false;
      }
      
      public function Update() : void
      {
         this.arrow.Update();
         this.infoBox.Update();
         this.banner.Update();
      }
      
      public function HideAll() : void
      {
         this.HideArrow();
         this.HideInfoBox();
         this.HideBanner();
      }
      
      public function ShowArrow(target:Point, pointFrom:Number) : void
      {
         this.ReShowArrow();
         this.arrow.x = target.x;
         this.arrow.y = target.y;
         this.arrow.rotation = pointFrom;
      }
      
      public function HideArrow() : void
      {
         this.arrow.visible = false;
         if(this.arrow.parent != null)
         {
            this.arrow.parent.removeChild(this.arrow);
         }
      }
      
      public function ShowInfoBox(title:String, message:String, buttonLabel:String = "") : void
      {
         if(this.infoBox.parent == null)
         {
            addChild(this.infoBox);
         }
         this.infoBox.visible = true;
         this.infoBox.SetContent(title,message,buttonLabel);
      }
      
      public function HideInfoBox() : void
      {
         this.infoBox.visible = false;
         if(this.infoBox.parent != null)
         {
            this.infoBox.parent.removeChild(this.infoBox);
         }
      }
      
      public function ShowBanner() : void
      {
         if(this.banner.parent == null)
         {
            addChild(this.banner);
         }
         this.banner.visible = true;
         this.banner.DoLayout();
      }
      
      public function HideBanner() : void
      {
         this.banner.visible = false;
         if(this.banner.parent != null)
         {
            this.banner.parent.removeChild(this.banner);
         }
      }
      
      public function HandlePauseMenuOpened() : void
      {
         this.m_ReShowArrowAfterPause = this.arrow.visible;
         this.HideArrow();
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
         if(this.m_ReShowArrowAfterPause)
         {
            this.ReShowArrow();
         }
         this.m_ReShowArrowAfterPause = false;
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         this.m_ReShowArrowAfterPause = false;
      }
      
      private function ReShowArrow() : void
      {
         if(this.arrow.parent == null)
         {
            addChild(this.arrow);
         }
         this.arrow.visible = true;
      }
      
      private function ForceTutorialCheat() : void
      {
         this.m_App.sessionData.featureManager.SetEnabled(FeatureManager.FEATURE_TUTORIAL);
         this.m_App.sessionData.configManager.SetFlag(ConfigManager.FLAG_TIPS_ENABLED,true);
      }
   }
}
