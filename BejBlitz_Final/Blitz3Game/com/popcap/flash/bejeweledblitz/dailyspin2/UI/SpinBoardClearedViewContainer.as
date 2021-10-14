package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardState;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.events.MouseEvent;
   
   public class SpinBoardClearedViewContainer
   {
       
      
      private var mSpinBoardClearedView:SpinBoardCompletePopup;
      
      public function SpinBoardClearedViewContainer()
      {
         super();
      }
      
      public function CloseSpinBoardClearedPopup() : void
      {
         SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = true;
         if(this.mSpinBoardClearedView != null)
         {
            this.mSpinBoardClearedView.visible = false;
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.removeChild(this.mSpinBoardClearedView);
            this.mSpinBoardClearedView = null;
         }
      }
      
      public function OnClicked(param1:MouseEvent) : void
      {
         this.mSpinBoardClearedView.removeEventListener(MouseEvent.CLICK,this.OnClicked);
         this.CloseSpinBoardClearedPopup();
         SpinBoardController.GetInstance().GetStateHandler().SetState(SpinBoardState.RewardShare);
      }
      
      public function OpenSpinBoardClearedPopup() : void
      {
         if(this.mSpinBoardClearedView == null)
         {
            this.mSpinBoardClearedView = new SpinBoardCompletePopup();
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.addChild(this.mSpinBoardClearedView);
         }
         SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = false;
         Blitz3App.app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPINBOARD_CLEAR);
         this.mSpinBoardClearedView.addEventListener(MouseEvent.CLICK,this.OnClicked);
      }
   }
}
