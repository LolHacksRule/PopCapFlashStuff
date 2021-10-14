package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   
   public class StarMedalPopUp extends GenericPopUp
   {
       
      
      private const TRACKING_ID_CANCEL:String = "Achievement/Cancel";
      
      private const TRACKING_ID_SHARE:String = "Achievement/Share";
      
      private var _userSettings:ReplaySharingCheckBoxWidget;
      
      public function StarMedalPopUp(param1:Blitz3App, param2:String, param3:Function, param4:Object)
      {
         super(param1,param2,param3,param4);
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false,0,true);
         this.initAssets();
      }
      
      override protected function initAssets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:Shape = null;
         super.initAssets();
         _loc1_ = _responseDataObject.score;
         _loc2_ = 112;
         _messageHeader = new PopUpMessageTextfields();
         _messageHeader.makeHeaderText("<p align=\'center\'><font size=\'40\'>YOU WON A</font><br/><font size=\'40\'>%s STAR MEDAL!</font></p>");
         _messageHeader.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _messageHeader.width);
         _messageHeader.y = 46 + _loc2_;
         var _loc3_:String = _app.starMedalFactory.GetThreshold(_loc1_) * 0.001 + _app.TextManager.GetLocString(Blitz3GameLoc.LOC_UI_THOUSANDS);
         _messageHeader.htmlText = _messageHeader.htmlText.replace("%s",_loc3_);
         addChild(_messageHeader);
         _iconBM = new StarMedalMessagesIconBlitzking();
         _iconBM.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _iconBM.width);
         _iconBM.y = _messageHeader.y + _messageHeader.height + 4;
         _iconBM.filters = [new GlowFilter(16777113,1,4,4,2)];
         addChild(_iconBM);
         this.setStarMedalIcon(_loc1_);
         this._userSettings = new ReplaySharingCheckBoxWidget(_app);
         this._userSettings.x = 0.5 * (Dimensions.PRELOADER_WIDTH - this._userSettings.width);
         this._userSettings.y = 340 + _loc2_;
         this._userSettings.Reset(_responseDataObject.showOneClick);
         this._userSettings.setViewingBounds(new Rectangle(this._userSettings.x,340 + _loc2_,this._userSettings.width,402));
         (_loc4_ = new Shape()).graphics.beginFill(16711680);
         _loc4_.graphics.drawRect(0,0,this._userSettings.width,this._userSettings.height);
         _loc4_.x = this._userSettings.x;
         _loc4_.y = 230 + _loc2_;
         _loc4_.cacheAsBitmap = true;
         this._userSettings.mask = _loc4_;
         _buttons = new ButtonWidgetDouble(_app);
         _buttons.SetLabels("<font size=\'16\'>SHARE</font>","<font size=\'16\'>CANCEL</font>");
         _buttons.SetEvents("EVENT_CLOSE_SHARE","EVENT_CLOSE_CANCEL");
         _buttons.SetTracking("TRACKING_ID_SHARE","TRACKING_ID_CANCEL");
         _buttons.x = (Dimensions.PRELOADER_WIDTH - _buttons.width) * 0.5;
         _buttons.y = 360 + _loc2_;
         addChild(this._userSettings);
         addChild(_buttons);
         addChild(_loc4_);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         this._userSettings.Show(true);
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         this._userSettings.Show(false);
      }
      
      override protected function onCloseCancel(param1:Event) : void
      {
         _responseDataObject.post = false;
         super.onCloseCancel(param1);
      }
      
      override protected function onCloseShare(param1:Event) : void
      {
         _responseDataObject.includeReplay = this._userSettings.replay;
         _responseDataObject.showOneClick = this._userSettings.autoPublish;
         _responseDataObject.post = true;
         super.onCloseCancel(param1);
      }
      
      public function setStarMedalIcon(param1:int) : void
      {
         _iconBM.bitmapData = _app.starMedalFactory.GetMedal(param1);
         _iconBM.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _iconBM.width);
      }
      
      private function colorBackgroundAnim(param1:MovieClip) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redOffset = -102;
         param1.transform.colorTransform = _loc2_;
      }
   }
}
