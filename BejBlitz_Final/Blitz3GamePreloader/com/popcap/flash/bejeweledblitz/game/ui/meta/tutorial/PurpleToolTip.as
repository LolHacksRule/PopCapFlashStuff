package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.framework.utils.TextFieldUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class PurpleToolTip extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _continueButton:GenericButton;
      
      private var _bodyText:TextField;
      
      private var _background:Shape;
      
      private var _continueCallBack:Function;
      
      public function PurpleToolTip(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._continueButton = new GenericButton(param1,12);
      }
      
      public function init() : void
      {
         this._background = new Shape();
         addChild(this._background);
         this._bodyText = TextFieldUtils.BuildLabel(TextFieldUtils.BuildTextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,10,16777215,TextFormatAlign.CENTER),TextFieldAutoSize.CENTER);
         this._bodyText.width = 500;
         addChild(this._bodyText);
         this._continueButton.Init();
         this._continueButton.SetText(this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_CONTINUE));
         this._continueButton.addEventListener(MouseEvent.MOUSE_UP,this.handleContinueClicked,false,0,true);
         this._continueButton.visible = false;
         addChild(this._continueButton);
      }
      
      public function reset() : void
      {
         this.visible = false;
      }
      
      public function showText(param1:Number, param2:Number, param3:String, param4:String = "", param5:Function = null, param6:Boolean = false) : void
      {
         this._continueButton.visible = param5 != null ? true : false;
         this._continueCallBack = param5;
         this._bodyText.htmlText = param3;
         this.x = param1;
         this.y = param2;
         this.visible = true;
         this.doLayout();
         this._background.visible = param6;
      }
      
      private function doLayout() : void
      {
         var _loc1_:Number = this._bodyText.textHeight + 10;
         if(this._continueButton.visible)
         {
            _loc1_ += this._continueButton.height + 10;
         }
         var _loc2_:Number = this._bodyText.textWidth + 20;
         this.drawBackground(_loc2_,_loc1_);
         this._bodyText.x = this._background.x + this._background.width * 0.5 - this._bodyText.width * 0.5;
         this._bodyText.y = this._background.y + 5;
         this._continueButton.x = this._background.x + this._background.width * 0.5 - this._continueButton.width * 0.5;
         this._continueButton.y = this._background.y + this._background.height - this._continueButton.height - 5;
         this.x -= this._background.width * 0.5;
      }
      
      private function drawBackground(param1:Number, param2:Number) : void
      {
         this._background.graphics.clear();
         this._background.graphics.lineStyle(1,9008019,0.6);
         this._background.graphics.beginFill(5055590,0.6);
         this._background.graphics.drawRoundRect(0,0,param1,param2,24);
         this._background.graphics.endFill();
      }
      
      private function handleContinueClicked(param1:MouseEvent) : void
      {
         this._continueCallBack();
      }
   }
}
