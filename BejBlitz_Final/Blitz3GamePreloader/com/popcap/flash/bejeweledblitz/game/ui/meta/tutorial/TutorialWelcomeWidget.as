package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.TutorialFramedButton;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   
   public class TutorialWelcomeWidget extends TutorialSplashScreenWidget
   {
      
      private static const DEFAULT_BG_WIDTH:Number = Dimensions.PRELOADER_WIDTH;
      
      private static const DEFAULT_BG_HEIGHT:Number = Dimensions.PRELOADER_HEIGHT;
       
      
      private var m_App:Blitz3Game;
      
      private var m_ButtonPlay:TutorialFramedButton;
      
      private var m_ButtonSkip:TutorialFramedButton;
      
      public function TutorialWelcomeWidget(param1:Blitz3Game)
      {
         super(param1,DEFAULT_BG_WIDTH,DEFAULT_BG_HEIGHT);
         this.m_App = param1;
         this.m_ButtonPlay = new TutorialFramedButton(this.m_App,Blitz3GameImages.IMAGE_WELCOME_CAP_VIOLET,Blitz3GameImages.IMAGE_WELCOME_CAP_VIOLET_FILL);
         this.m_ButtonPlay.Init();
         this.m_ButtonPlay.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_START));
         this.m_ButtonSkip = new TutorialFramedButton(this.m_App,Blitz3GameImages.IMAGE_WELCOME_CAP_PINK,Blitz3GameImages.IMAGE_WELCOME_CAP_PINK_FILL);
         this.m_ButtonSkip.Init();
         this.m_ButtonSkip.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_SKIP));
      }
      
      override public function Init() : void
      {
         super.Init();
         addChild(this.m_ButtonPlay);
         addChild(this.m_ButtonSkip);
      }
      
      override public function Show() : void
      {
         super.Show();
         this.m_App.metaUI.tutorial.banner.WelcomeShown();
      }
      
      override public function Hide() : void
      {
         super.Hide();
         this.m_App.metaUI.tutorial.banner.WelcomeHidden();
      }
      
      public function AddPlayButtonHandler(param1:Function) : void
      {
         this.m_ButtonPlay.addEventListener(MouseEvent.CLICK,param1);
      }
      
      public function AddSkipButtonHandler(param1:Function) : void
      {
         this.m_ButtonSkip.addEventListener(MouseEvent.CLICK,param1);
      }
      
      override protected function DoLayout() : void
      {
         super.DoLayout();
         this.m_ButtonPlay.x = width * 0.5 + this.m_ButtonPlay.width - this.m_ButtonPlay.width * 0.75;
         this.m_ButtonPlay.y = y + height * 0.77;
         this.m_ButtonSkip.x = width * 0.5 - (this.m_ButtonSkip.width + this.m_ButtonSkip.width * 0.25);
         this.m_ButtonSkip.y = y + height * 0.77;
      }
   }
}
