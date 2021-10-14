package com.popcap.flash.bejeweledblitz.endgamepopups.view
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.AcceptButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.DeclineButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.ResizableDialog;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelCrestCache;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.levels.LevelView;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class LevelUpPopUp extends GenericPopUp
   {
      
      private static const TEXT_Y_PLACEMENTS:Vector.<Number> = new Vector.<Number>(8);
      
      private static const REWARD_MEGA_MYSTERY_GIFT:String = "megaMystery";
      
      private static const REWARD_SUPER_MYSTERY_GIFT:String = "superMystery";
      
      {
         TEXT_Y_PLACEMENTS[0] = 0.35;
         TEXT_Y_PLACEMENTS[1] = 0.37;
         TEXT_Y_PLACEMENTS[2] = 0.45;
         TEXT_Y_PLACEMENTS[3] = 0.37;
         TEXT_Y_PLACEMENTS[4] = 0.34;
         TEXT_Y_PLACEMENTS[5] = 0.37;
         TEXT_Y_PLACEMENTS[6] = 0.22;
         TEXT_Y_PLACEMENTS[7] = 0.35;
      }
      
      private const TRACKING_ID_CANCEL:String = "Achievement/Cancel";
      
      private const TRACKING_ID_SHARE:String = "Achievement/Share";
      
      private var _fadeLayer:Shape;
      
      private var _background:ResizableDialog;
      
      private var _buttonClaim:AcceptButtonFramed;
      
      private var _buttonContinue:DeclineButtonFramed;
      
      private var _crestCache:LevelCrestCache;
      
      private var _crest:DisplayObject;
      
      private var _crestWidth:Number = 109;
      
      private var _crestHeight:Number = 135;
      
      private var _rankNameT:PopUpMessageTextfields;
      
      private var _levelNameT:PopUpMessageTextfields;
      
      private var _messageCenterT:PopUpMessageTextfields;
      
      private var _rewardT:PopUpMessageTextfields;
      
      public function LevelUpPopUp(param1:Blitz3App, param2:String, param3:Function, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.initAssets();
      }
      
      override protected function initAssets() : void
      {
         var _loc1_:int = 0;
         _loc1_ = _responseDataObject.level;
         this._fadeLayer = new Shape();
         this._fadeLayer.graphics.clear();
         this._fadeLayer.graphics.beginFill(0,0.5);
         this._fadeLayer.graphics.drawRect(0,0,Dimensions.PRELOADER_WIDTH,Dimensions.PRELOADER_HEIGHT);
         this._fadeLayer.graphics.endFill();
         addChild(this._fadeLayer);
         this._background = new ResizableDialog(_app);
         this._background.SetDimensions(360,350);
         this._background.x = this._fadeLayer.width * 0.5 - this._background.width * 0.5;
         this._background.y = this._fadeLayer.height * 0.5 - this._background.height * 0.5 - 20;
         addChild(this._background);
         var _loc2_:int = this._background.x + this._background.width * 0.5;
         _backgroundAnim = new MessagesBackground();
         _backgroundAnim.x = 0.5 * (Dimensions.PRELOADER_WIDTH - _backgroundAnim.width);
         _backgroundAnim.y = 0.5 * (Dimensions.PRELOADER_HEIGHT - _backgroundAnim.height) - 40;
         addChild(_backgroundAnim);
         this._crestCache = new LevelCrestCache(_app);
         this._crestCache.SetNextLevel(_loc1_ + 1);
         this._crest = this._crestCache.GetCrest(_loc1_);
         if(this._crest)
         {
            this._crest.x = _loc2_ - this._crestWidth * 0.5;
            this._crest.y = this._background.y + this._background.height * 0.45 - this._crestHeight * 0.55;
            addChild(this._crest);
         }
         this.placeTextFields(_loc1_);
         this._buttonClaim = new AcceptButtonFramed(_app,18);
         this._buttonClaim.SetText(_app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_BTN_CLAIM));
         this._buttonClaim.addEventListener(MouseEvent.CLICK,this.onCloseShare);
         this._buttonClaim.Init();
         addChild(this._buttonClaim);
         this._buttonContinue = new DeclineButtonFramed(_app,18);
         this._buttonContinue.SetText(_app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_BTN_CONTINUE));
         this._buttonContinue.addEventListener(MouseEvent.CLICK,this.onCloseCancel);
         this._buttonContinue.Init();
         addChild(this._buttonContinue);
         var _loc3_:int = (this._buttonClaim.width - this._buttonContinue.width) / 2;
         this._buttonClaim.x = _loc2_ - this._buttonClaim.width + _loc3_ - 2;
         this._buttonContinue.x = _loc2_ + _loc3_ + 2;
         this._buttonContinue.y = this._buttonClaim.y = this._messageCenterT.y + this._messageCenterT.height + 5;
         _app.SoundManager.playSound(Blitz3GameSounds.SOUND_POST_GAME_CELEBRATORY_RANK_UP);
         _app.network.RefreshMessageCenter();
      }
      
      override protected function onCloseCancel(param1:Event) : void
      {
         _responseDataObject.openMessageCenter = false;
         super.onCloseCancel(param1);
      }
      
      override protected function onCloseShare(param1:Event) : void
      {
         _responseDataObject.openMessageCenter = true;
         super.onCloseShare(param1);
      }
      
      private function colorBackgroundAnim(param1:MovieClip) : void
      {
         var _loc2_:ColorTransform = new ColorTransform();
         _loc2_.redOffset = -102;
         param1.transform.colorTransform = _loc2_;
      }
      
      private function placeTextFields(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = this._background.x + this._background.width * 0.5;
         var _loc3_:int = Math.max(Math.min(param1 - 1,LevelView.MAX_LEVEL - 1),0);
         this._levelNameT = new PopUpMessageTextfields();
         this._levelNameT.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,36,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this._levelNameT.filters = [new GlowFilter(0,1,2,2,4)];
         this._levelNameT.makeGenericText(param1.toString());
         addChild(this._levelNameT);
         _messageHeader = new PopUpMessageTextfields();
         _messageHeader.makeGenericText();
         _messageHeader.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,28,16764239,true,null,null,null,null,TextFormatAlign.CENTER);
         _messageHeader.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         _loc4_ = Math.min(Math.max(int(param1 / 10),0),TEXT_Y_PLACEMENTS.length - 1);
         if(param1 % 10 == 0 && param1 < 100)
         {
            _messageHeader.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_TITLE_10);
            this._levelNameT.x = this._crest.x + this._crestWidth * 0.5 - this._levelNameT.width * 0.5;
            this._levelNameT.y = this._crest.y + this._crestHeight * 0.5 - this._levelNameT.height * 0.5;
         }
         else
         {
            _messageHeader.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_TITLE);
            this._levelNameT.x = this._crest.x + this._crestWidth * 0.51 - this._levelNameT.width * 0.5;
            this._levelNameT.y = this._crest.y + this._crestHeight * TEXT_Y_PLACEMENTS[_loc4_] - this._levelNameT.height * 0.5;
         }
         _messageHeader.x = _loc2_ - _messageHeader.width * 0.5;
         _messageHeader.y = this._background.y + 8;
         addChild(_messageHeader);
         this._rankNameT = new PopUpMessageTextfields();
         var _loc5_:* = Constants.LEVEL_NAMES[_loc3_];
         _loc5_ = "\"" + _loc5_.toUpperCase() + "\"";
         this._rankNameT.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,22,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this._rankNameT.filters = [new GlowFilter(0,1,4,4,2)];
         this._rankNameT.makeGenericText("" + _loc5_);
         this._rankNameT.x = _loc2_ - this._rankNameT.width * 0.5;
         this._rankNameT.y = _messageHeader.y + 30;
         addChild(this._rankNameT);
         var _loc6_:String = _responseDataObject.reward;
         this._rewardT = new PopUpMessageTextfields();
         this._rewardT.makeGenericText();
         this._rewardT.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,20,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         this._rewardT.filters = [new GlowFilter(0,1,4,4,2)];
         if(_loc6_ == REWARD_MEGA_MYSTERY_GIFT)
         {
            this._rewardT.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_REWARD_LEGENDARY_TREASURE);
         }
         else if(_loc6_ == REWARD_SUPER_MYSTERY_GIFT)
         {
            this._rewardT.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_REWARD_GRAND_TREASURE);
         }
         this._rewardT.x = _loc2_ - this._rewardT.width * 0.5;
         this._rewardT.y = this._crest.y + this._crestHeight + 5;
         addChild(this._rewardT);
         this._messageCenterT = new PopUpMessageTextfields();
         this._messageCenterT.makeGenericText();
         this._messageCenterT.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,14,16777215,null,null,null,null,null,TextFormatAlign.CENTER);
         this._messageCenterT.filters = [new GlowFilter(0,1,4,4,2)];
         this._messageCenterT.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_UP_BODY_MYSTERY_TREASURE);
         this._messageCenterT.x = _loc2_ - this._messageCenterT.width * 0.5;
         this._messageCenterT.y = this._rewardT.y + this._rewardT.height;
         addChild(this._messageCenterT);
      }
   }
}
