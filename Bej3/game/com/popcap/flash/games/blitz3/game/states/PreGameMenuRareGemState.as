package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.blitz3.session.DataStore;
   import com.popcap.flash.games.blitz3.ui.widgets.game.raregems.IRareGemDialogHandler;
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
         this.m_App.ui.rareGemDialog.AddHandler(this);
         this.m_App.logic.AddBlitzLogicHandler(this);
      }
      
      public function update() : void
      {
         this.m_App.ui.rareGemDialog.Update();
      }
      
      public function draw(elapsed:int) : void
      {
      }
      
      public function onEnter() : void
      {
         this.m_App.sessionData.rareGemManager.UndoHarvestGem();
         this.m_App.ui.rareGemDialog.Show();
         this.m_App.sessionData.dataStore.SetFlag(DataStore.FLAG_HAS_SEEN_RARE_GEM_OFFER,true);
         if(this.m_HasReportedRareGemOffer)
         {
            return;
         }
         this.m_App.network.ReportEvent("RareGemOffered");
         this.m_HasReportedRareGemOffer = true;
      }
      
      public function onExit() : void
      {
      }
      
      public function onPush() : void
      {
      }
      
      public function onPop() : void
      {
      }
      
      public function onMouseUp(x:Number, y:Number) : void
      {
      }
      
      public function onMouseDown(x:Number, y:Number) : void
      {
      }
      
      public function onMouseMove(x:Number, y:Number) : void
      {
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
      
      public function HandleGameEnd() : void
      {
         this.m_HasReportedRareGemOffer = false;
      }
      
      public function HandleGameAbort() : void
      {
      }
   }
}
