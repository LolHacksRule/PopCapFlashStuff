package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinBoardController;
   import com.popcap.flash.bejeweledblitz.dailyspin2.SpinsShareHandler;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   
   public class SpinShareInfoViewContainer
   {
       
      
      private var mSharePopup:SpinRewardSharePopup;
      
      private var mShareButton:GenericButtonClip;
      
      private var mNoThanksButton:GenericButtonClip;
      
      public function SpinShareInfoViewContainer()
      {
         super();
      }
      
      public function Reset() : void
      {
         if(this.mShareButton != null)
         {
            this.mShareButton.deactivate();
         }
         if(this.mNoThanksButton != null)
         {
            this.mNoThanksButton.deactivate();
         }
         if(this.mSharePopup != null)
         {
            this.mSharePopup.visible = false;
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.removeChild(this.mSharePopup);
         }
         this.mShareButton = null;
         this.mNoThanksButton = null;
         this.mSharePopup = null;
      }
      
      public function OpenSharePopup() : void
      {
         if(this.mSharePopup == null)
         {
            this.mSharePopup = new SpinRewardSharePopup();
            (Blitz3App.app as Blitz3Game).mDSPlaceholder.addChild(this.mSharePopup);
         }
         SpinBoardUIController.GetInstance().GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = false;
         var spinBoardController:SpinBoardController = SpinBoardController.GetInstance();
         var shareHandler:SpinsShareHandler = SpinBoardController.GetInstance().GetSpinsShareHandler();
         var regularTilesClaimed:int = shareHandler.GetNormalTilesClaimed();
         var specialTilesClaimed:int = shareHandler.GetSpecialTilesClaimed();
         var regularAmount:int = spinBoardController.GetCatalogue().GetNormalTileShareAmount();
         var specialAmount:int = spinBoardController.GetCatalogue().GetSpecialTileShareAmount();
         var totalRegularAmount:int = regularTilesClaimed * regularAmount;
         var totalSpecialAmount:int = specialTilesClaimed * specialAmount;
         this.mSharePopup.mSpinRewardBanner.mRegularRewardText.text = regularAmount.toString() + " X " + regularTilesClaimed.toString();
         this.mSharePopup.mSpinRewardBanner.mSpecialRewardText.text = specialAmount.toString() + " X " + specialTilesClaimed.toString();
         this.mSharePopup.mRewardCountClip.mRewardCountText.text = Utils.formatNumberToBJBNumberString(totalRegularAmount + totalSpecialAmount);
         this.mShareButton = new GenericButtonClip(Blitz3App.app,this.mSharePopup.mShareButton);
         this.mShareButton.setRelease(function():void
         {
            CloseSharePopup();
            SpinBoardController.GetInstance().GetSpinsShareHandler().OnShareButtonClicked();
         });
         this.mShareButton.activate();
         this.mShareButton.show();
         this.mNoThanksButton = new GenericButtonClip(Blitz3App.app,this.mSharePopup.mNoThanksButton);
         this.mNoThanksButton.setRelease(function():void
         {
            CloseSharePopup();
            SpinBoardController.GetInstance().GetSpinsShareHandler().OnShareCancelButtonClicked();
         });
         this.mNoThanksButton.activate();
         this.mNoThanksButton.show();
      }
      
      public function CloseSharePopup() : void
      {
         var _loc1_:SpinBoardUIController = SpinBoardUIController.GetInstance();
         _loc1_.GetSpinBoardContainer().GetOrCreateSpinBoardView().visible = true;
         _loc1_.OnSharePopupClosed();
      }
   }
}
