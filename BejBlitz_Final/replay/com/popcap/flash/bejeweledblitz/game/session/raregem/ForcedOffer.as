package com.popcap.flash.bejeweledblitz.game.session.raregem
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   
   public class ForcedOffer extends RareGemOffer implements IBlitzLogicHandler
   {
       
      
      private var m_App:Blitz3App;
      
      public function ForcedOffer(app:Blitz3App)
      {
         this.m_App = app;
         super(app);
         state = STATE_AVAILABLE;
         this.m_App.logic.AddHandler(this);
      }
      
      override public function Destroy() : void
      {
         this.m_App.logic.RemoveHandler(this);
         super.Destroy();
      }
      
      override function LoadState() : void
      {
         var orderingId:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_STORED_RARE_GEM_OFFER);
         var gemLogic:IRareGem = this.m_App.logic.rareGemLogic.GetRareGemByOrderingID(orderingId);
         if(gemLogic == null)
         {
            return;
         }
         gemId = gemLogic.GetStringID();
      }
      
      override function SaveState() : void
      {
         var orderingId:int = -1;
         var gemLogic:IRareGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(gemId);
         if(gemLogic != null)
         {
            orderingId = gemLogic.GetOrderingID();
         }
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_STORED_RARE_GEM_OFFER,orderingId);
         this.m_App.sessionData.configManager.CommitChanges();
      }
      
      override function Clear() : void
      {
         this.m_App.sessionData.configManager.SetInt(ConfigManager.INT_STORED_RARE_GEM_OFFER,-1);
         gemId = "";
      }
      
      public function HandleGameBegin() : void
      {
         this.UpdateStateGameBegin();
      }
      
      public function HandleGameEnd() : void
      {
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
      
      private function UpdateStateGameBegin() : void
      {
         if(state == STATE_WAITING)
         {
            SetState(STATE_AVAILABLE);
         }
         else if(state == STATE_HARVESTED || state == STATE_AVAILABLE)
         {
            SetState(STATE_CONSUMED);
         }
      }
   }
}
