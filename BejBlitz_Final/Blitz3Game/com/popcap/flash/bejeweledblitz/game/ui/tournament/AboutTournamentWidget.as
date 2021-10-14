package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3.TournamentWhatsNew;
   import flash.display.MovieClip;
   
   public class AboutTournamentWidget extends MovieClip
   {
       
      
      private var _btnClose:GenericButtonClip;
      
      private var _btnGetStarted:GenericButtonClip;
      
      private var _tournamentWhatsNew:TournamentWhatsNew;
      
      private var _app:Blitz3Game;
      
      public function AboutTournamentWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._tournamentWhatsNew = new TournamentWhatsNew();
         this._btnClose = new GenericButtonClip(this._app,this._tournamentWhatsNew.WhatsNewCloseButton,true);
         this._btnClose.setRelease(this.closeBtnPress);
         this._btnGetStarted = new GenericButtonClip(this._app,this._tournamentWhatsNew.getStartedButton,true);
         this._btnGetStarted.setRelease(this.getStartedPress);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         visible = param1;
         if(param1)
         {
            this._app.metaUI.highlight.showPopUp(this._tournamentWhatsNew,true,true,0.55);
         }
      }
      
      public function setVisiblityOfGetStartedButton(param1:Boolean) : void
      {
         this._tournamentWhatsNew.getStartedButton.visible = param1;
      }
      
      public function setVisiblityOfCloseButton(param1:Boolean) : void
      {
         this._tournamentWhatsNew.WhatsNewCloseButton.visible = param1;
      }
      
      private function closeBtnPress() : void
      {
         this.setVisible(false);
         this._app.metaUI.highlight.hidePopUp();
      }
      
      private function getStartedPress() : void
      {
         this.setVisible(false);
         this._app.metaUI.highlight.hidePopUp();
      }
   }
}
