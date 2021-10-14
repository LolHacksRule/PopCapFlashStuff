package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.CheckBox;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TwoButtonCheckBoxDialog extends TwoButtonDialog
   {
       
      
      private var _checkBox:CheckBox;
      
      private var _checkBoxText:TextField;
      
      public function TwoButtonCheckBoxDialog(param1:Blitz3App, param2:int = 18)
      {
         super(param1,param2);
         this._checkBox = new CheckBox(param1);
         this._checkBoxText = new TextField();
         this._checkBoxText.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,15,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this._checkBoxText.autoSize = TextFieldAutoSize.LEFT;
         this._checkBoxText.embedFonts = true;
         this._checkBoxText.multiline = false;
         this._checkBoxText.selectable = false;
         this._checkBoxText.mouseEnabled = false;
         this._checkBoxText.filters = [new GlowFilter(0,1,2,2,4)];
      }
      
      override public function SetContent(param1:String, param2:String, param3:String, param4:String) : void
      {
         var _loc5_:int = 0;
         super.SetContent(param1,param2,param3,param4);
         _loc5_ = 7;
         addChild(this._checkBox);
         addChild(this._checkBoxText);
         this._checkBoxText.x = m_Background.x + m_Background.width * 0.2;
         this._checkBoxText.y = super.m_TxtBody.y + m_TxtBody.height + _loc5_;
         this._checkBoxText.htmlText = super.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_DIALOG_DONT_SHOW_AGAIN);
         this._checkBox.x = this._checkBoxText.x + this._checkBoxText.textWidth + 20;
         this._checkBox.y = this._checkBoxText.y + this._checkBoxText.height * 0.5 - this._checkBoxText.textHeight * 0.5;
         m_ButtonDecline.y = m_ButtonAccept.y = this._checkBoxText.y + this._checkBoxText.textHeight + 20;
      }
      
      public function get isChecked() : Boolean
      {
         return this._checkBox.IsChecked();
      }
   }
}
