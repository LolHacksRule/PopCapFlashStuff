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
      
      private var m_MainWidget:MainWidgetGame;
      
      public function PreGameMenuRareGemState(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_MainWidget = this.m_App.ui as MainWidgetGame;
         this.m_MainWidget.rareGemDialog.AddHandler(this);
         this.m_App.logic.AddHandler(this);
      }
      
      public function update() : void
      {
         this.m_MainWidget.rareGemDialog.Update();
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function onEnter() : void
      {
         (this.m_App.ui as MainWidgetGame).rareGemDialog.Show();
         if(this.m_HasReportedRareGemOffer)
         {
            return;
         }
         var _loc1_:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var _loc2_:String = "RareGem/";
         var _loc3_:String = "";
         var _loc4_:String = "";
         var _loc5_:int = this.m_App.sessionData.rareGemManager.GetStreakNum();
         if(this.m_App.sessionData.rareGemManager.isDiscounted)
         {
            _loc3_ = "discount";
         }
         else if(_loc5_ > 0)
         {
            _loc3_ = "Streak" + _loc5_;
         }
         else if(this.m_App.sessionData.rareGemManager.DailySpinAwardId)
         {
            _loc3_ = "Earned";
         }
         else if(_loc1_.IsViral())
         {
            _loc3_ = "Viral";
         }
         else
         {
            _loc3_ = "Random";
         }
         _loc2_ += _loc3_ + "/";
         _loc4_ = _loc1_.GetID();
         _loc2_ += _loc4_ + "/";
         this.m_HasReportedRareGemOffer = _loc5_ == 0;
      }
      
      public function onExit() : void
      {
         (this.m_App.ui as MainWidgetGame).rareGemDialog.Hide();
      }
      
      public function HandleRareGemShown(param1:String) : void
      {
      }
      
      public function HandleRareGemContinueClicked(param1:Boolean) : void
      {
         dispatchEvent(new Event(PreGameMenuState.SIGNAL_PREGAME_RARE_GEM_CONTINUE));
      }
      
      public function HandleGameLoad() : void
      {
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
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
