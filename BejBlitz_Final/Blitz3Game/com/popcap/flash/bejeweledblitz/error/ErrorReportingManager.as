package com.popcap.flash.bejeweledblitz.error
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import flash.events.MouseEvent;
   
   public class ErrorReportingManager
   {
       
      
      private var _errorPopup:SingleButtonDialog;
      
      private var _app:Blitz3Game;
      
      public function ErrorReportingManager(param1:Blitz3Game)
      {
         super();
         this._app = param1;
      }
      
      public function sendError(param1:String, param2:String, param3:String, param4:String = "") : void
      {
         ErrorReporting.sendError(param1,param2,param3);
         Utils.log(this,"<<< ERROR >>> : " + param4);
         if(param4)
         {
            this._errorPopup = new SingleButtonDialog(this._app,16);
            this._errorPopup.Init();
            this._errorPopup.SetDimensions(420,200);
            this._errorPopup.SetContent("AN ERROR OCCURED!",param4,"CLOSE");
            this._errorPopup.AddContinueButtonHandler(this.closeButtonHandler);
            this._errorPopup.x = Dimensions.GAME_WIDTH / 2 - this._errorPopup.width / 2;
            this._errorPopup.y = Dimensions.GAME_HEIGHT / 2 - this._errorPopup.height / 2 + 12;
            this._app.metaUI.highlight.showPopUp(this._errorPopup,true,false,0.55);
         }
      }
      
      private function closeButtonHandler(param1:MouseEvent) : void
      {
         this._app.metaUI.highlight.hidePopUp();
      }
   }
}
