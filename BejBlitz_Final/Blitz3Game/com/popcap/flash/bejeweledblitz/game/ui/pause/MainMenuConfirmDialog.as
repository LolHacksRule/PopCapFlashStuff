package com.popcap.flash.bejeweledblitz.game.ui.pause
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   
   public class MainMenuConfirmDialog extends TwoButtonDialog
   {
       
      
      private var _buttonFontSize:int;
      
      public function MainMenuConfirmDialog(param1:Blitz3App, param2:int = 18)
      {
         super(param1,param2);
         this._buttonFontSize = param2;
      }
      
      override public function SetContent(param1:String, param2:String, param3:String, param4:String) : void
      {
         super.SetContent(param1,param2,param3,param4);
         m_TxtBody.y -= this._buttonFontSize;
         m_ButtonDecline.y = m_TxtBody.y + m_TxtBody.height + 12;
         m_ButtonAccept.y = m_TxtBody.y + m_TxtBody.height + 12;
      }
   }
}
