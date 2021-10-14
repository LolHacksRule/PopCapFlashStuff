package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButton;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
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
      
      public var m_ButtonSkip:DeclineButton;
      
      private var m_ReShowArrowAfterPause:Boolean;
      
      public function TutorialWidget(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.arrow = new ArrowPointer(param1);
         this.infoBox = new TutorialMessageBox(param1);
         this.banner = new TutorialBanner(param1);
         this.m_ReShowArrowAfterPause = false;
         this.m_ButtonSkip = new DeclineButton(this.m_App);
      }
      
      public function Init() : void
      {
         this.arrow.Init();
         this.infoBox.Init();
         this.banner.Init();
         var _loc1_:Number = Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH;
         var _loc3_:Number = Dimensions.PRELOADER_WIDTH - Dimensions.GAME_WIDTH;
         var _loc4_:Number = Dimensions.GAME_HEIGHT;
         this.infoBox.x = Dimensions.PRELOADER_WIDTH - Dimensions.GAME_BOARD_X - this.infoBox.width * 0.5;
         this.infoBox.y = Dimensions.PRELOADER_HEIGHT * 0.5 - this.infoBox.height * 0.5;
         this.banner.x = Dimensions.QUEST_X - Dimensions.LEFT_BORDER_WIDTH;
         this.banner.y = Dimensions.QUEST_Y;
         var _loc5_:MainWidgetGame;
         if((_loc5_ = this.m_App.ui as MainWidgetGame) != null)
         {
            _loc5_.pause.AddHandler(this);
         }
         this.m_ButtonSkip.Init();
         this.m_ButtonSkip.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SKIP));
         this.m_ButtonSkip.x = Dimensions.PRELOADER_WIDTH - this.m_ButtonSkip.width - 10;
         this.m_ButtonSkip.y = Dimensions.PRELOADER_HEIGHT - this.m_ButtonSkip.height - 10;
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
      }
      
      public function ShowArrow(param1:Point, param2:Number) : void
      {
         this.ReShowArrow();
         this.arrow.x = param1.x;
         this.arrow.y = param1.y;
         this.arrow.rotation = param2;
      }
      
      public function HideArrow() : void
      {
         this.arrow.visible = false;
         if(this.arrow.parent != null)
         {
            this.arrow.parent.removeChild(this.arrow);
         }
      }
      
      public function ShowInfoBox(param1:String, param2:String, param3:String = "") : void
      {
         if(this.infoBox.parent == null)
         {
            addChild(this.infoBox);
         }
         this.infoBox.visible = true;
         this.infoBox.SetContent(param1,param2,param3);
         if(this.m_ButtonSkip.parent == null)
         {
            addChild(this.m_ButtonSkip);
         }
         this.m_ButtonSkip.visible = true;
      }
      
      public function HideInfoBox() : void
      {
         this.infoBox.visible = false;
         if(this.infoBox.parent != null)
         {
            this.infoBox.parent.removeChild(this.infoBox);
         }
         this.m_ButtonSkip.visible = false;
         if(this.m_ButtonSkip.parent != null)
         {
            this.m_ButtonSkip.parent.removeChild(this.m_ButtonSkip);
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
      
      public function isVisible() : Boolean
      {
         return this.infoBox.visible;
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
         this.InfoBoxSetVisibility(false);
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
         if(this.m_ReShowArrowAfterPause)
         {
            this.ReShowArrow();
         }
         this.m_ReShowArrowAfterPause = false;
         this.InfoBoxSetVisibility(true);
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         this.m_ReShowArrowAfterPause = false;
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
         this.m_ReShowArrowAfterPause = false;
      }
      
      public function AddSkipButtonHandler(param1:Function) : void
      {
         this.m_ButtonSkip.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function RemoveSkipButtonHandler(param1:Function) : void
      {
         this.m_ButtonSkip.removeEventListener(MouseEvent.CLICK,param1);
      }
      
      private function ReShowArrow() : void
      {
         if(this.arrow.parent == null)
         {
            addChild(this.arrow);
         }
         this.arrow.visible = true;
      }
      
      private function InfoBoxSetVisibility(param1:Boolean) : void
      {
         if(this.infoBox.parent != null)
         {
            this.infoBox.visible = param1;
            this.m_ButtonSkip.visible = param1;
         }
      }
   }
}
