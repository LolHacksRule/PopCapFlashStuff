package com.popcap.flash.bejeweledblitz.game.ui.meta
{
   import com.popcap.flash.bejeweledblitz.game.ui.meta.quests.FeatureLockWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.quests.FeatureUnlockSkipWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.quests.QuestRewardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.PurpleToolTip;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.TutorialWelcomeWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.TutorialWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.highlight.HighlightWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips.TutorialTipBox;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class MetaUI extends Sprite
   {
       
      
      private var m_App:Blitz3Game;
      
      public var tutorial:TutorialWidget;
      
      public var tipBox:TutorialTipBox;
      
      public var highlight:HighlightWidget;
      
      public var tutorialWelcome:TutorialWelcomeWidget;
      
      public var questReward:QuestRewardWidget;
      
      public var featureLock:FeatureLockWidget;
      
      public var featureUnlockSkip:FeatureUnlockSkipWidget;
      
      public var plainText:TextField;
      
      public var purplePartyTipBox:PurpleToolTip;
      
      public function MetaUI(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.tutorial = new TutorialWidget(param1);
         this.tipBox = new TutorialTipBox(param1);
         this.highlight = new HighlightWidget(param1);
         this.tutorialWelcome = new TutorialWelcomeWidget(param1);
         this.questReward = new QuestRewardWidget(param1);
         this.featureLock = new FeatureLockWidget(param1);
         this.featureUnlockSkip = new FeatureUnlockSkipWidget(param1);
         mouseEnabled = false;
         this.purplePartyTipBox = new PurpleToolTip(param1);
      }
      
      public function Init() : void
      {
         addChild(this.featureLock);
         addChild(this.tutorial);
         this.tutorial.Init();
         this.tipBox.Init();
         this.highlight.Init();
         this.tutorialWelcome.Init();
         this.questReward.Init();
         this.featureLock.Init();
         this.featureUnlockSkip.Init();
         addChild(this.purplePartyTipBox);
         this.purplePartyTipBox.init();
      }
      
      public function getHighlightDepth() : int
      {
         return getChildIndex(this.tutorial);
      }
      
      public function Reset() : void
      {
         this.tutorial.Reset();
         this.tipBox.Reset();
         this.highlight.Reset();
         this.tutorialWelcome.Reset();
         this.questReward.Reset();
         this.featureUnlockSkip.Reset();
         this.purplePartyTipBox.reset();
      }
      
      public function Update() : void
      {
         this.tutorial.Update();
         this.tipBox.Update();
         this.highlight.Update();
         this.tutorialWelcome.Update();
         this.questReward.Update();
      }
   }
}
