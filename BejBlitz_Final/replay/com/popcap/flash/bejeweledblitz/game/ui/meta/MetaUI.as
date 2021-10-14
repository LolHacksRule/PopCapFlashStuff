package com.popcap.flash.bejeweledblitz.game.ui.meta
{
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.TutorialCompleteWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.TutorialWelcomeWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.TutorialWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight.HighlightWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips.TutorialTipBox;
   import flash.display.Sprite;
   
   public class MetaUI extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      public var tutorial:TutorialWidget;
      
      public var tipBox:TutorialTipBox;
      
      public var highlight:HighlightWidget;
      
      public var tutorialWelcome:TutorialWelcomeWidget;
      
      public var tutorialComplete:TutorialCompleteWidget;
      
      public function MetaUI(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.tutorial = new TutorialWidget(app);
         this.tipBox = new TutorialTipBox(app);
         this.highlight = new HighlightWidget(app);
         this.tutorialWelcome = new TutorialWelcomeWidget(app);
         this.tutorialComplete = new TutorialCompleteWidget(app);
         mouseEnabled = false;
      }
      
      public function Init() : void
      {
         addChild(this.tutorial);
         this.tutorial.Init();
         this.tipBox.Init();
         this.highlight.Init();
         this.tutorialWelcome.Init();
         this.tutorialComplete.Init();
      }
      
      public function Reset() : void
      {
         this.tutorial.Reset();
         this.tipBox.Reset();
         this.highlight.Reset();
         this.tutorialWelcome.Reset();
         this.tutorialComplete.Reset();
      }
      
      public function Update() : void
      {
         this.tutorial.Update();
         this.tipBox.Update();
         this.highlight.Update();
         this.tutorialWelcome.Update();
         this.tutorialComplete.Update();
      }
   }
}
