package com.popcap.flash.bejeweledblitz.game.states
{
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.IRareGemDialogHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PreGameMenuRareGemState extends Sprite implements IAppState, IRareGemDialogHandler, IBlitzLogicHandler
   {
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_HasReportedRareGemOffer:Boolean = false;
      
      public function PreGameMenuRareGemState(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         (this.m_App.ui as MainWidgetGame).rareGemDialog.AddHandler(this);
         this.m_App.logic.AddHandler(this);
      }
      
      public function update() : void
      {
         (this.m_App.ui as MainWidgetGame).rareGemDialog.Update();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         (this.m_App.ui as MainWidgetGame).rareGemDialog.Show();
         if(this.m_HasReportedRareGemOffer)
         {
            return;
         }
         var offer:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var eventString:String = "RareGem/";
         var streakNum:int = this.m_App.sessionData.rareGemManager.GetStreakNum();
         if(streakNum > 0)
         {
            eventString += "Streak" + streakNum + "/";
         }
         else if(offer.IsViral())
         {
            eventString += "Viral/";
         }
         else
         {
            eventString += "Random/";
         }
         eventString += offer.GetID() + "/";
         this.m_App.network.ReportEvent(eventString + "Offered");
         this.m_HasReportedRareGemOffer = streakNum == 0;
      }
      
      public function onExit() : void
      {
         (this.m_App.ui as MainWidgetGame).rareGemDialog.Hide();
      }
      
      public function onKeyUp(keyCode:int) : void
      {
      }
      
      public function onKeyDown(keyCode:int) : void
      {
      }
      
      public function HandleRareGemContinueClicked(offerAccepted:Boolean) : void
      {
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_RARE_GEM_CONTINUE));
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.m_HasReportedRareGemOffer = false;
      }
      
      public function HandleGameAbort() : void
      {
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
   }
}
