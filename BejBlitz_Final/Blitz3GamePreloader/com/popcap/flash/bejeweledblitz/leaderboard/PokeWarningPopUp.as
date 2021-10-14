package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import flash.text.TextFieldAutoSize;
   
   public class PokeWarningPopUp extends Leaderboardpopup_poke
   {
       
      
      private var _isConfirmationalDialogue:Boolean;
      
      public var buttonYes:GenericButtonClip;
      
      public var buttonNo:GenericButtonClip;
      
      public var buttonClose:GenericButtonClip;
      
      private var _app:Blitz3Game;
      
      public function PokeWarningPopUp(param1:Boolean, param2:Blitz3Game)
      {
         super();
         param1 = param1;
         this._app = param2;
         this.buttonYes = new GenericButtonClip(this._app,btnYes,true);
         this.buttonYes.setShowGraphics(true);
         this.buttonNo = new GenericButtonClip(this._app,btnNo,true);
         this.buttonNo.setShowGraphics(true);
         this.buttonClose = new GenericButtonClip(this._app,btnX,true,false);
         this.buttonClose.setShowGraphics(true);
         this.buttonYes.activate();
         this.buttonNo.activate();
         this.buttonClose.activate();
         TxtPopup.textColor = 16777215;
         TxtPopup.autoSize = TextFieldAutoSize.CENTER;
      }
      
      public function get isConfirmationalDialogue() : Boolean
      {
         return this._isConfirmationalDialogue;
      }
      
      public function setUpConfirmationalDialogue(param1:String) : void
      {
         this._isConfirmationalDialogue = true;
         btnYes.visible = true;
         btnNo.visible = true;
         btnX.visible = false;
      }
      
      public function setUpInformativeDialogue(param1:String) : void
      {
         this._isConfirmationalDialogue = false;
         btnYes.visible = false;
         btnNo.visible = false;
         btnX.visible = true;
      }
      
      public function setText(param1:String) : void
      {
         TxtPopup.text = param1;
      }
      
      public function show() : void
      {
         this._app.metaUI.highlight.showPopUp(this,true,true,0.5);
         btnX.gotoAndPlay("out");
      }
      
      public function hide() : void
      {
         this._app.metaUI.highlight.hidePopUp();
      }
   }
}
