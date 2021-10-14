package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class RareGemPopUp extends GenericPopUp
   {
       
      
      private const TRACKING_ID_CANCEL:String = "Achievement/Cancel";
      
      private const TRACKING_ID_SHARE:String = "Achievement/Share";
      
      private var _messagesObj:Object;
      
      public function RareGemPopUp(param1:Blitz3App, param2:String, param3:Function, param4:Object)
      {
         this._messagesObj = new Object();
         super(param1,param2,param3,param4);
         this.addMessage("catseye","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>CAT\'S EYE</font></p>");
         this.addMessage("moonstone","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>MOONSTONE</font></p>");
         this.addMessage("phoenixprism","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>PHOENIX PRISM</font></p>");
         this.addMessage("blazingsteed","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>BLAZING STEED</font></p>");
         this.addMessage("kangaruby","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>KANGA RUBY 1</font></p>");
         this.addMessage("kangaruby2","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>KANGA RUBY 2</font></p>");
         this.addMessage("kangaruby3","<p align=\'center\'><font size=\'32\'>YOU USED A</font><br/><font size=\'50\'>KANGA RUBY 3</font></p>");
         this.initAssets();
      }
      
      private function addMessage(param1:String, param2:String) : void
      {
         this._messagesObj[param1] = param2;
      }
      
      override protected function initAssets() : void
      {
         var _loc1_:int = 0;
         super.initAssets();
         _loc1_ = -8;
         var _loc2_:int = _responseDataObject.score;
         var _loc3_:String = _responseDataObject.rareGemId;
         var _loc4_:String = _loc3_.toUpperCase();
         _messageHeader = new PopUpMessageTextfields();
         _messageHeader.makeHeaderText(this._messagesObj[_loc3_.toLowerCase()]);
         _messageHeader.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _messageHeader.width);
         _messageHeader.y = 160 + _loc1_;
         addChild(_messageHeader);
         _messageBody = new PopUpMessageTextfields();
         _messageBody.makeBodyText("<p align=\'center\'>Share this Rare Gem with up to 10 friends!<br/>Your gem has fractured into pieces which friends can<br/>redeem for Rare Gems of their own!</p>");
         _messageBody.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _messageBody.width);
         _messageBody.y = 405 + _loc1_;
         addChild(_messageBody);
         var _loc5_:Bitmap = new Bitmap(_app.ImageManager.getBitmapData(Blitz3GameImages["IMAGE_RG_" + _loc4_]));
         _iconBM = new MovieClip();
         _iconBM.addChild(_loc5_);
         _iconBM.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _iconBM.width);
         _iconBM.y = _messageHeader.y + _messageHeader.height + 4;
         _iconBM.filters = [new GlowFilter(16777215,1,4,4,2)];
         addChild(_iconBM);
         _buttons = new ButtonWidgetDouble(_app);
         _buttons.SetLabels("<font size=\'16\'>SHARE</font>","<font size=\'16\'>CANCEL</font>");
         _buttons.SetEvents("EVENT_CLOSE_SHARE","EVENT_CLOSE_CANCEL");
         _buttons.x = (Dimensions.PRELOADER_WIDTH - _buttons.width) * 0.5;
         _buttons.y = 480 + _loc1_;
         addChild(_buttons);
      }
      
      override protected function onCloseCancel(param1:Event) : void
      {
         _responseDataObject.post = false;
         super.onCloseCancel(param1);
      }
      
      override protected function onCloseShare(param1:Event) : void
      {
         _responseDataObject.post = true;
         super.onCloseShare(param1);
      }
      
      private function colorBackgroundAnim(param1:MovieClip) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redOffset = -102;
         param1.transform.colorTransform = _loc2_;
      }
   }
}
