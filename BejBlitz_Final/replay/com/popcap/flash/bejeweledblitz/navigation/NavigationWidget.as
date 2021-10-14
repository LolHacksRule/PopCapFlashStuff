package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GraphicalButton;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.MediumCoinLabel;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3navigation.resources.Blitz3NavigationImages;
   import com.popcap.flash.games.blitz3navigation.resources.Blitz3NavigationLoc;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.StageDisplayState;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.filters.DropShadowFilter;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class NavigationWidget extends Sprite implements IUserDataHandler, IBlitzLogicHandler
   {
      
      public static const COINS_ANIM_TIME:int = 50;
      
      public static const NAVIGATION_LOGO:String = "blitzLogo";
      
      public static const NAVIGATION_MESSAGE_CENTER:String = "messageCenter";
      
      public static const NAVIGATION_SPIN:String = "spin";
      
      public static const NAVIGATION_GIFT:String = "gift";
      
      public static const NAVIGATION_INVITE:String = "invite";
      
      public static const NAVIGATION_CREDITS:String = "credits";
      
      public static const NAVIGATION_HELP:String = "help";
      
      public static const JS_NAVIGATION_CONFIG:String = "getNorthNavConfig";
      
      public static const JS_NAVIGATION_GET_COUNT:String = "getNorthNavBadgeCount";
      
      public static const JS_NAVIGATION_SET_COUNT:String = "setNorthNavBadgeCount";
       
      
      private var m_App:Blitz3Game;
      
      private var m_IsGameActive:Boolean;
      
      private var m_BackgroundLeftCap:Bitmap;
      
      private var m_BackgroundRightCap:Bitmap;
      
      private var m_BackgroundFill:Bitmap;
      
      private var m_LogoButton:GraphicalButton;
      
      private var m_CoinBoxLeftCap:Bitmap;
      
      private var m_CoinBoxRightCap:Bitmap;
      
      private var m_CoinBoxFill:Bitmap;
      
      private var m_AddCoinsButton:GenericButton;
      
      private var m_CoinsLabel:MediumCoinLabel;
      
      private var m_NavContainer:Sprite;
      
      private var m_NavButtonsLeftCap:Bitmap;
      
      private var m_NavButtonsRightCap:Bitmap;
      
      private var m_NavButtonsFill:Bitmap;
      
      private var m_NavButtons:Object;
      
      private var m_LogoURL:String;
      
      private var m_HelpURL:String;
      
      private var m_LastCoins:int = 0;
      
      private var m_TargetCoins:int = -1;
      
      private var m_CoinRoll:int = 0;
      
      private var m_CoinRollTimer:int = 0;
      
      public function NavigationWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_IsGameActive = false;
      }
      
      public function Init() : void
      {
         this.m_BackgroundFill = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BACKGROUND_FILL));
         this.m_BackgroundFill.width = Dimensions.NAVIGATION_WIDTH;
         this.m_BackgroundLeftCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BACKGROUND_LEFT_CAP));
         this.m_BackgroundRightCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BACKGROUND_RIGHT_CAP));
         this.m_BackgroundRightCap.x = Dimensions.NAVIGATION_WIDTH - this.m_BackgroundRightCap.width;
         this.m_LogoButton = new GraphicalButton(this.m_App,this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_LOGO));
         this.m_LogoButton.addEventListener(MouseEvent.CLICK,this.HandleLogoClick);
         this.m_LogoButton.x = 10;
         this.m_LogoButton.y = 5;
         this.GetLogoConfig();
         this.m_CoinBoxFill = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_COIN_BOX_FILL));
         this.m_CoinBoxFill.x = 166;
         this.m_CoinBoxFill.y = 11;
         this.m_CoinBoxFill.width = 152;
         this.m_CoinBoxLeftCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_COIN_BOX_CAP));
         this.m_CoinBoxLeftCap.x = this.m_CoinBoxFill.x - this.m_CoinBoxLeftCap.width;
         this.m_CoinBoxLeftCap.y = this.m_CoinBoxFill.y;
         this.m_CoinBoxRightCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_COIN_BOX_CAP));
         this.m_CoinBoxRightCap.scaleX = -1;
         this.m_CoinBoxRightCap.x = this.m_CoinBoxFill.x + this.m_CoinBoxFill.width + this.m_CoinBoxRightCap.width;
         this.m_CoinBoxRightCap.y = this.m_CoinBoxFill.y;
         this.m_AddCoinsButton = new GenericButton(this.m_App);
         this.m_AddCoinsButton.SetText(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_ADD_COINS));
         this.m_AddCoinsButton.SetDimensions(0,30);
         this.m_AddCoinsButton.CenterText();
         this.m_AddCoinsButton.x = this.m_CoinBoxFill.x + this.m_CoinBoxFill.width - this.m_AddCoinsButton.width + 7;
         this.m_AddCoinsButton.y = this.m_CoinBoxFill.y + 1;
         if(this.m_App.network.isOffline || !this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_BUY_COINS))
         {
            this.m_AddCoinsButton.SetDisabled(true);
         }
         else
         {
            this.m_AddCoinsButton.addEventListener(MouseEvent.CLICK,this.HandleAddCoins);
         }
         this.m_CoinsLabel = new MediumCoinLabel(this.m_App,18);
         this.m_CoinsLabel.SetSize(110,26);
         this.m_CoinsLabel.x = this.m_CoinBoxFill.x - 3;
         this.m_CoinsLabel.y = this.m_CoinBoxFill.y + 3;
         this.m_NavButtonsFill = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BUTTON_FILL));
         this.m_NavButtonsLeftCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BUTTON_CAP));
         this.m_NavButtonsRightCap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3NavigationImages.IMAGE_NAV_BUTTON_CAP));
         this.m_NavButtonsRightCap.scaleX = -1;
         addChild(this.m_BackgroundFill);
         addChild(this.m_BackgroundLeftCap);
         addChild(this.m_BackgroundRightCap);
         addChild(this.m_LogoButton);
         addChild(this.m_CoinBoxFill);
         addChild(this.m_CoinBoxLeftCap);
         addChild(this.m_CoinBoxRightCap);
         addChild(this.m_AddCoinsButton);
         addChild(this.m_CoinsLabel);
         this.Reset();
         this.m_App.sessionData.userData.AddHandler(this);
         this.m_App.network.AddExternalCallback(JS_NAVIGATION_SET_COUNT,this.HandleSetCounter);
         this.m_App.logic.AddHandler(this);
         x = -Dimensions.LEFT_BORDER_WIDTH;
         y = -Dimensions.NAVIGATION_HEIGHT;
      }
      
      public function Update() : void
      {
         var percent:Number = NaN;
         if(this.m_CoinRoll != this.m_TargetCoins)
         {
            ++this.m_CoinRollTimer;
            percent = Math.min(this.m_CoinRollTimer / COINS_ANIM_TIME,1);
            this.m_CoinRoll = (this.m_TargetCoins - this.m_LastCoins) * percent + this.m_LastCoins;
            this.m_CoinsLabel.SetText(StringUtils.InsertNumberCommas(this.m_CoinRoll));
         }
      }
      
      public function Reset() : void
      {
         if(this.m_NavContainer && contains(this.m_NavContainer))
         {
            removeChild(this.m_NavContainer);
         }
         this.m_NavContainer = new Sprite();
         this.m_NavContainer.addChild(this.m_NavButtonsFill);
         this.m_NavContainer.addChild(this.m_NavButtonsLeftCap);
         this.m_NavContainer.addChild(this.m_NavButtonsRightCap);
         addChild(this.m_NavContainer);
         this.m_NavButtonsFill.x = 350;
         this.m_NavButtonsFill.y = 10;
         this.m_NavButtonsFill.width = 394;
         this.m_NavButtonsLeftCap.x = this.m_NavButtonsFill.x - this.m_NavButtonsLeftCap.width;
         this.m_NavButtonsLeftCap.y = this.m_NavButtonsFill.y;
         this.m_NavButtonsRightCap.x = this.m_NavButtonsFill.x + this.m_NavButtonsFill.width + this.m_NavButtonsRightCap.width;
         this.m_NavButtonsRightCap.y = this.m_NavButtonsFill.y;
         this.m_NavButtons = new Object();
         this.BuildNavButtons();
      }
      
      public function get CoinsLabel() : MediumCoinLabel
      {
         return this.m_CoinsLabel;
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         if(this.m_TargetCoins != balance)
         {
            this.m_TargetCoins = balance;
            this.m_LastCoins = this.m_CoinRoll;
            this.m_CoinRollTimer = 0;
         }
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         this.m_IsGameActive = true;
         this.Reset();
         this.m_AddCoinsButton.SetDisabled(true);
      }
      
      public function HandleGameEnd() : void
      {
         this.m_IsGameActive = false;
         this.Reset();
         this.m_AddCoinsButton.SetDisabled(false);
      }
      
      public function HandleGameAbort() : void
      {
         this.m_IsGameActive = false;
         this.Reset();
         this.m_AddCoinsButton.SetDisabled(false);
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      private function BuildNavButtons() : void
      {
         var counter:NavigationCounter = null;
         var label:String = null;
         var adjustment:int = 0;
         var textField:TextField = null;
         var format:TextFormat = null;
         var boxWidth:int = 0;
         var hitBox:Sprite = null;
         var buttonLabels:Vector.<String> = new Vector.<String>();
         var buttonFunctions:Vector.<Function> = new Vector.<Function>();
         var buttonCounters:Vector.<NavigationCounter> = new Vector.<NavigationCounter>();
         if(this.HasNavigationItem(NAVIGATION_MESSAGE_CENTER))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_MESSAGE_CENTER));
            buttonFunctions.push(this.HandleMessageCenter);
            buttonCounters.push(this.GetCounter(NAVIGATION_MESSAGE_CENTER));
         }
         if(this.HasNavigationItem(NAVIGATION_SPIN))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_DAILY_SPIN));
            buttonFunctions.push(this.HandleDailySpin);
            buttonCounters.push(this.GetCounter(NAVIGATION_SPIN));
         }
         if(this.HasNavigationItem(NAVIGATION_GIFT))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_SEND_GIFT));
            buttonFunctions.push(this.HandleSendGift);
            buttonCounters.push(this.GetCounter(NAVIGATION_GIFT));
         }
         if(this.HasNavigationItem(NAVIGATION_INVITE))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_INVITE_FRIENDS));
            buttonFunctions.push(this.HandleInviteFriends);
            buttonCounters.push(this.GetCounter(NAVIGATION_INVITE));
         }
         if(this.HasNavigationItem(NAVIGATION_CREDITS))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_EARN_CREDITS));
            buttonFunctions.push(this.HandleEarnCredits);
            buttonCounters.push(this.GetCounter(NAVIGATION_CREDITS));
         }
         if(this.HasNavigationItem(NAVIGATION_HELP))
         {
            buttonLabels.push(this.m_App.TextManager.GetLocString(Blitz3NavigationLoc.LOC_NAV_HELP));
            buttonFunctions.push(this.HandleHelp);
            buttonCounters.push(this.GetCounter(NAVIGATION_HELP));
            this.GetHelpConfig();
         }
         var separators:Shape = new Shape();
         separators.cacheAsBitmap = true;
         this.m_NavContainer.addChild(separators);
         var boxFilters:Array = [new BlurFilter()];
         var labelFilters:Array = [new DropShadowFilter(0.5,90,16631453,1,2,2,2)];
         var xPos:int = this.m_NavButtonsFill.x + 4;
         var i:int = 0;
         for each(label in buttonLabels)
         {
            textField = new TextField();
            format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,6173185);
            format.align = TextFormatAlign.CENTER;
            format.leading = -4;
            textField.defaultTextFormat = format;
            textField.autoSize = TextFieldAutoSize.CENTER;
            textField.multiline = true;
            textField.embedFonts = true;
            textField.selectable = false;
            textField.mouseEnabled = false;
            textField.filters = labelFilters;
            textField.htmlText = label;
            textField.x = xPos;
            textField.y = this.m_NavButtonsFill.y + 8;
            if(textField.numLines > 1)
            {
               textField.y -= 6;
            }
            boxWidth = textField.textWidth + 18 - 2;
            if(i == buttonLabels.length - 1)
            {
               boxWidth += this.m_NavButtonsRightCap.width - 2;
            }
            hitBox = new Sprite();
            hitBox.graphics.beginFill(16777215,0.5);
            hitBox.graphics.drawRect(1,1,boxWidth,this.m_NavButtonsFill.height - 8);
            hitBox.cacheAsBitmap = true;
            hitBox.filters = boxFilters;
            hitBox.buttonMode = true;
            hitBox.useHandCursor = true;
            hitBox.x = textField.x - 18 * 0.5;
            hitBox.y = this.m_NavButtonsFill.y + 3;
            hitBox.alpha = 0;
            hitBox.addEventListener(MouseEvent.ROLL_OVER,this.HighlightButton);
            hitBox.addEventListener(MouseEvent.ROLL_OUT,this.UnHighlightButton);
            hitBox.addEventListener(MouseEvent.CLICK,buttonFunctions[i]);
            this.m_NavContainer.addChild(hitBox);
            this.m_NavContainer.addChild(textField);
            counter = buttonCounters[i];
            if(counter)
            {
               counter.x = textField.x + textField.width - counter.width;
               counter.y = textField.y - 16;
               this.m_NavContainer.addChild(counter);
            }
            if(i < buttonLabels.length - 1)
            {
               separators.graphics.lineStyle(1,0,0.3);
               separators.graphics.moveTo(textField.x + textField.textWidth + 18 * 0.5,this.m_NavButtonsFill.y + 3);
               separators.graphics.lineTo(textField.x + textField.textWidth + 18 * 0.5,this.m_NavButtonsFill.y + this.m_NavButtonsFill.height - 3);
               separators.graphics.lineStyle(1,16777215,0.3);
               separators.graphics.moveTo(textField.x + textField.textWidth + 18 * 0.5 + 1,this.m_NavButtonsFill.y + 3);
               separators.graphics.lineTo(textField.x + textField.textWidth + 18 * 0.5 + 1,this.m_NavButtonsFill.y + this.m_NavButtonsFill.height - 3);
            }
            xPos += textField.textWidth + 18;
            i++;
         }
         adjustment = this.m_NavButtonsFill.width + this.m_NavButtonsFill.x + this.m_NavButtonsRightCap.width - xPos;
         this.m_NavButtonsFill.width -= adjustment;
         this.m_NavButtonsRightCap.x -= adjustment;
         this.m_NavContainer.x += adjustment;
      }
      
      private function ToggleFullScreen() : void
      {
         if(stage.displayState == StageDisplayState.NORMAL)
         {
            stage.displayState = StageDisplayState.FULL_SCREEN;
         }
         else
         {
            stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      private function HighlightButton(event:MouseEvent) : void
      {
         (event.target as Sprite).alpha = 1;
      }
      
      private function UnHighlightButton(event:MouseEvent) : void
      {
         (event.target as Sprite).alpha = 0;
      }
      
      protected function HandleAddCoins(event:MouseEvent) : void
      {
         if(!this.m_AddCoinsButton.IsDisabled())
         {
            this.m_App.network.ReportEvent("NavBar/AddCoinsClick");
            this.m_App.network.ReportEvent("AddCoinsClick/NavBar");
            this.m_App.network.ShowCart();
         }
      }
      
      private function HandleLogoClick(event:MouseEvent) : void
      {
         if(this.m_LogoURL)
         {
            this.m_App.network.ReportEvent("NavBar/LogoClick");
            navigateToURL(new URLRequest(this.m_LogoURL),"LogoWindow");
         }
      }
      
      private function HandleDailySpin(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("NavBar/DailySpinClick");
         this.m_App.network.ExternalCall("showSpin");
      }
      
      private function HandleMessageCenter(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("NavBar/MessageCenterClick");
         this.m_App.network.ExternalCall("showMessageCenter");
      }
      
      private function HandleSendGift(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("NavBar/GiftClick");
         this.m_App.network.ExternalCall("createMysteryTreasure",{"origin":"nav"});
      }
      
      private function HandleInviteFriends(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("NavBar/InviteClick");
         this.m_App.network.ExternalCall("inviteLink");
      }
      
      private function HandleEarnCredits(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("NavBar/EarnCreditsClick");
         this.m_App.network.ExternalCall("trialpayClick");
      }
      
      private function HandleHelp(event:MouseEvent) : void
      {
         if(this.m_HelpURL)
         {
            this.m_App.network.ReportEvent("NavBar/HelpClick");
            navigateToURL(new URLRequest(this.m_HelpURL),"HelpWindow");
         }
      }
      
      private function HasNavigationItem(key:String) : Boolean
      {
         if((this.m_App.tutorial.IsEnabled() || this.m_IsGameActive) && key != NAVIGATION_HELP)
         {
            return false;
         }
         return this.m_App.sessionData.featureManager.NavigationItems.indexOf(key) != -1;
      }
      
      private function GetCounter(key:String) : NavigationCounter
      {
         var count:int = 0;
         var counter:NavigationCounter = null;
         var config:Object = this.m_App.network.ExternalCall(JS_NAVIGATION_GET_COUNT,key);
         if(config)
         {
            count = parseInt(config.toString());
            if(count)
            {
               counter = new NavigationCounter(this.m_App,count);
               this.m_NavButtons[key] = counter;
               return counter;
            }
         }
         return null;
      }
      
      private function HandleSetCounter(result:Object) : void
      {
         var key:* = null;
         for(key in result)
         {
            this.SetCounter(key,parseInt(result[key]));
         }
      }
      
      private function SetCounter(key:String, value:int) : void
      {
         if(this.m_NavButtons[key])
         {
            (this.m_NavButtons[key] as NavigationCounter).Value = value;
         }
      }
      
      private function GetLogoConfig() : void
      {
         var config:Object = this.m_App.network.ExternalCall(JS_NAVIGATION_CONFIG,NAVIGATION_LOGO);
         if(config)
         {
            this.m_LogoURL = config.url;
         }
      }
      
      private function GetHelpConfig() : void
      {
         var config:Object = this.m_App.network.ExternalCall(JS_NAVIGATION_CONFIG,NAVIGATION_HELP);
         if(config)
         {
            this.m_HelpURL = config.url;
         }
      }
   }
}
