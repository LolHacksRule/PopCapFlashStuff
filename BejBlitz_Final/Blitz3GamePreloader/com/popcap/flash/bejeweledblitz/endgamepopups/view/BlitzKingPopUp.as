package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class BlitzKingPopUp extends GenericPopUp
   {
       
      
      private const TRACKING_ID_CANCEL:String = "Achievement/Cancel";
      
      private const TRACKING_ID_SHARE:String = "Achievement/Share";
      
      public function BlitzKingPopUp(param1:Blitz3App, param2:String, param3:Function, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.initAssets();
      }
      
      override protected function initAssets() : void
      {
         var _loc1_:int = 0;
         super.initAssets();
         _loc1_ = 112;
         _messageHeader = new PopUpMessageTextfields();
         _messageHeader.makeHeaderText("<p align=\'center\'><font size=\'50\'>GOOD JOB!</font><br/><font size=\'30\'>YOU\'RE AT THE TOP<br/>OF YOUR LEADERBOARD!</font></p>");
         _messageHeader.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _messageHeader.width);
         _messageHeader.y = 46 + _loc1_;
         addChild(_messageHeader);
         _iconBM = new StarMedalMessagesIconBlitzking();
         _iconBM.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _iconBM.width);
         _iconBM.y = _messageHeader.y + _messageHeader.height + 4;
         _iconBM.filters = [new GlowFilter(10092543,1,4,4,2)];
         addChild(_iconBM);
         _buttons = new ButtonWidgetDouble(_app);
         _buttons.SetLabels("<font size=\'16\'>SHARE</font>","<font size=\'16\'>CANCEL</font>");
         _buttons.SetEvents("EVENT_CLOSE_SHARE","EVENT_CLOSE_CANCEL");
         _buttons.SetTracking("TRACKING_ID_SHARE","TRACKING_ID_CANCEL");
         _buttons.x = (Dimensions.PRELOADER_WIDTH - _buttons.width) * 0.5;
         _buttons.y = 360 + _loc1_;
         addChild(_buttons);
      }
      
      override protected function onCloseCancel(param1:Event) : void
      {
         _responseDataObject.post = false;
         super.onCloseCancel(param1);
      }
      
      override protected function onCloseShare(param1:Event) : void
      {
         _responseDataObject.includeReplay = false;
         _responseDataObject.showOneClick = false;
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
