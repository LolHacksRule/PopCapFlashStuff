package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class GenericPopUp extends Sprite
   {
       
      
      protected var _messageHeader:PopUpMessageTextfields;
      
      protected var _messageBody:PopUpMessageTextfields;
      
      protected var _iconBM:MovieClip;
      
      protected var _app:Blitz3App;
      
      protected var _backgroundAnim:MessagesBackground;
      
      protected var _largeDialog:LargeDialog;
      
      protected var _buttons:ButtonWidget;
      
      protected var _responseCallback:Function;
      
      protected var _responseDataObject:Object;
      
      private var _jsCallbackName:String;
      
      public function GenericPopUp(param1:Blitz3App, param2:String, param3:Function, param4:Object)
      {
         super();
         this._app = param1;
         this._jsCallbackName = param2;
         this._responseCallback = param3;
         this._responseDataObject = param4;
      }
      
      protected function initAssets() : void
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(-50,-100,Dimensions.PRELOADER_WIDTH + 50,Dimensions.PRELOADER_HEIGHT + 150);
         _loc1_.alpha = 0.8;
         addChild(_loc1_);
         this._backgroundAnim = new MessagesBackground();
         this._backgroundAnim.x = 0.5 * (Dimensions.PRELOADER_WIDTH - this._backgroundAnim.width);
         this._backgroundAnim.y = 0.5 * (Dimensions.PRELOADER_HEIGHT - this._backgroundAnim.height);
         addChild(this._backgroundAnim);
         this._largeDialog = new LargeDialog(this._app);
         this._largeDialog.x = 0.5 * (Dimensions.PRELOADER_WIDTH - this._largeDialog.width) - 10;
         this._largeDialog.y = 0.5 * (Dimensions.PRELOADER_HEIGHT - this._largeDialog.height);
         addChild(this._largeDialog);
         addEventListener("EVENT_CLOSE_CANCEL",this.onCloseCancel,false,0,true);
         addEventListener("EVENT_CLOSE_SHARE",this.onCloseShare,false,0,true);
         this.y = -20;
      }
      
      protected function onCloseCancel(param1:Event) : void
      {
         this._responseCallback(this._responseDataObject);
      }
      
      protected function onCloseShare(param1:Event) : void
      {
         this._responseCallback(this._responseDataObject);
      }
      
      public function get JSCallbackName() : String
      {
         return this._jsCallbackName;
      }
      
      public function getHeaderText() : String
      {
         return this._messageHeader.htmlText;
      }
      
      public function getHeaderWidth() : Number
      {
         return this._messageHeader.getTextWidth();
      }
      
      public function destroy() : void
      {
         removeEventListener("EVENT_CLOSE_CANCEL",this.onCloseCancel);
         removeEventListener("EVENT_CLOSE_SHARE",this.onCloseShare);
         while(this.numChildren > 0)
         {
            this.removeChildAt(0);
         }
      }
   }
}
