package com.popcap.flash.bejeweledblitz.game.dialogs
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.SingleButtonDialog;
   import flash.events.MouseEvent;
   
   public class RequiresUpdateDialog
   {
      
      private static var updateDialogue:SingleButtonDialog;
      
      private static var canShowUpdateDialog:Boolean = false;
       
      
      public function RequiresUpdateDialog()
      {
         super();
      }
      
      public static function show() : void
      {
         if(updateDialogue)
         {
            return;
         }
         updateDialogue = new SingleButtonDialog(Blitz3App.app,16);
         updateDialogue.Init();
         updateDialogue.SetDimensions(420,200);
         updateDialogue.SetContent("Update Required","A newer version of the game is available","Refresh");
         updateDialogue.AddContinueButtonHandler(closeButtonHandler);
         updateDialogue.x = Dimensions.GAME_WIDTH / 2 - updateDialogue.width / 2;
         updateDialogue.y = Dimensions.GAME_HEIGHT / 2 - updateDialogue.height / 2 + 12;
         Blitz3Game(Blitz3App.app).metaUI.highlight.showPopUp(updateDialogue,true,true,0.55);
      }
      
      private static function closeButtonHandler(param1:MouseEvent) : void
      {
         canShowUpdateDialog = false;
         Blitz3App.app.network.Refresh();
      }
      
      public static function IsForceUpdateRequired() : Boolean
      {
         return canShowUpdateDialog;
      }
      
      public static function SetForceUpdateRequired(param1:Boolean) : void
      {
         canShowUpdateDialog = param1;
      }
   }
}
