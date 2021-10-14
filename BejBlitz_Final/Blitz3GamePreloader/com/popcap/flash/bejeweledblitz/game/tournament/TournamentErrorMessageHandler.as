package com.popcap.flash.bejeweledblitz.game.tournament
{
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import flash.events.MouseEvent;
   
   public class TournamentErrorMessageHandler
   {
      
      public static const TOURNAMENT_INACTIVE:String = "INACTIVE_TOURNAMENT";
      
      public static const TOURNAMENT_INSUFFICIENT_FUNDS:String = "NOT_ENOUGH_CURRENCY";
      
      public static const TOURNAMENT_INACTIVE_MESSAGE:String = "Contest has ended. Please try a new contest.";
      
      public static const TOURNAMENT_INSUFFICIENT_FUNDS_MESSAGE:String = "Not enough currency.";
       
      
      private var _app:Blitz3Game = null;
      
      private var _errorDialog:SingleButtonDialog;
      
      private var _onClose:Function;
      
      public function TournamentErrorMessageHandler(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._errorDialog = new SingleButtonDialog(this._app,16);
         this._errorDialog.Init();
         this._errorDialog.SetDimensions(420,200);
         this._errorDialog.AddContinueButtonHandler(this.closeDialog);
      }
      
      public function setOnClose(param1:Function) : void
      {
         this._onClose = param1;
      }
      
      private function closeDialog(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
         if(this._onClose != null)
         {
            this._onClose();
         }
         this._onClose = null;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         this._errorDialog.SetDimensions(param1,param2);
      }
      
      public function showErrorDialog(param1:String, param2:String = "", param3:String = "", param4:String = "") : void
      {
         switch(param1)
         {
            case TOURNAMENT_INACTIVE:
               this._errorDialog.SetContent(param3 == "" ? "OOPS!" : param3,param2 == "" ? TOURNAMENT_INACTIVE_MESSAGE : param2,param4 == "" ? "OKAY" : param4);
               break;
            case TOURNAMENT_INSUFFICIENT_FUNDS:
               this._errorDialog.SetContent(param3 == "" ? "OOPS!" : param3,param2 == "" ? TOURNAMENT_INSUFFICIENT_FUNDS_MESSAGE : param2,param4 == "" ? "OKAY" : param4);
               break;
            default:
               this._errorDialog.SetContent(param3 == "" ? "OOPS!" : param3,param2,param4 == "" ? "OKAY" : param4);
         }
         this._app.metaUI.highlight.showPopUp(this._errorDialog,true,true,0.55);
      }
   }
}
