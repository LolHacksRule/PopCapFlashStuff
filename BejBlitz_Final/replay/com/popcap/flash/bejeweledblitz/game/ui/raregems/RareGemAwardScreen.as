package com.popcap.flash.bejeweledblitz.game.ui.raregems
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.IRareGemManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidgetDouble;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.MediumCoinLabel;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.LargeDialog;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGem;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class RareGemAwardScreen extends Sprite implements IRareGemManagerHandler, IRareGemAwardScreen, IUserDataHandler
   {
      
      protected static const FILTERS:Dictionary = new Dictionary();
      
      {
         FILTERS[MoonstoneRGLogic.ID] = [new GlowFilter(3381708,1,33.7,33.7,1.33,1,true),new BevelFilter(6.7,45,51,0.58,16777215,0.73,5,5,0.82,1,"inner"),new GlowFilter(0,0.49,4,4,20)];
         FILTERS[CatseyeRGLogic.ID] = [new GlowFilter(16737792,1,23.4,23.4,2,1,true),new BevelFilter(6.7,45,6684672,0.58,16777215,0.53,5,5,0.82,1,"inner"),new GlowFilter(0,0.49,4,4,20)];
         FILTERS[PhoenixPrismRGLogic.ID] = [new GlowFilter(1816850,1,23.4,23.4,2,1,true),new BevelFilter(6.7,45,15727926,1,1235711,1,5,5,0.82,1,"inner"),new GlowFilter(0,0.49,4,4,20)];
      }
      
      private var m_App:Blitz3App;
      
      private var m_Handlers:Vector.<IRareGemDialogHandler>;
      
      private var m_Images:Vector.<BitmapData>;
      
      private var m_Background:LargeDialog;
      
      private var m_CoinBalance:MediumCoinLabel;
      
      private var m_AddCoinsButton:SkinButton;
      
      private var m_RareGemImage:Bitmap;
      
      private var m_RareGemTitle:TextField;
      
      private var m_Header:TextField;
      
      private var m_Copy:TextField;
      
      private var m_CostText:TextField;
      
      private var m_PriceText:TextField;
      
      private var m_CoinImage:Bitmap;
      
      private var m_Buttons:ButtonWidgetDouble;
      
      private var m_StreakCostText:TextField;
      
      private var m_StreakPriceText:TextField;
      
      private var m_StreakCoinImage:Bitmap;
      
      private var m_StreakStrike:Shape;
      
      private var m_RareGemCosts:Dictionary;
      
      public function RareGemAwardScreen(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IRareGemDialogHandler>();
         this.m_Images = new Vector.<BitmapData>();
         this.m_Images[MoonstoneRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_MOONSTONE);
         this.m_Images[CatseyeRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_CATSEYE);
         this.m_Images[PhoenixPrismRGLogic.ORDERING_ID] = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_PHOENIXPRISM);
         this.m_Background = new LargeDialog(this.m_App,true);
         this.m_CoinBalance = new MediumCoinLabel(app);
         this.m_AddCoinsButton = new SkinButton(app);
         this.m_AddCoinsButton.background.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS)));
         this.m_AddCoinsButton.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS_OVER)));
         this.m_RareGemImage = new Bitmap();
         this.m_RareGemTitle = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,46,14021887);
         format.align = TextFormatAlign.CENTER;
         this.m_RareGemTitle.defaultTextFormat = format;
         this.m_RareGemTitle.selectable = false;
         this.m_RareGemTitle.mouseEnabled = false;
         this.m_RareGemTitle.embedFonts = true;
         this.m_RareGemTitle.multiline = false;
         this.m_RareGemTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_RareGemTitle.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_MOONSTONE);
         this.m_RareGemTitle.filters = FILTERS[MoonstoneRGLogic.ID];
         this.m_RareGemTitle.cacheAsBitmap = true;
         this.m_Header = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16252614);
         format.align = TextFormatAlign.CENTER;
         this.m_Header.defaultTextFormat = format;
         this.m_Header.selectable = false;
         this.m_Header.mouseEnabled = false;
         this.m_Header.embedFonts = true;
         this.m_Header.multiline = false;
         this.m_Header.autoSize = TextFieldAutoSize.CENTER;
         this.m_Header.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_TITLE);
         this.m_Header.filters = [new GlowFilter(0,0.25,4,4,1000)];
         this.m_Header.cacheAsBitmap = true;
         var textFilters:Array = [new GlowFilter(0,1,2,2,4)];
         this.m_Copy = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,12,16777215);
         format.align = TextFormatAlign.CENTER;
         this.m_Copy.defaultTextFormat = format;
         this.m_Copy.selectable = false;
         this.m_Copy.mouseEnabled = false;
         this.m_Copy.embedFonts = true;
         this.m_Copy.multiline = true;
         this.m_Copy.wordWrap = true;
         this.m_Copy.autoSize = TextFieldAutoSize.CENTER;
         this.m_Copy.width = Dimensions.GAME_WIDTH * 0.72;
         this.m_Copy.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COPY_MOONSTONE);
         this.m_Copy.filters = textFilters;
         this.m_Copy.cacheAsBitmap = true;
         this.m_CostText = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16767036);
         format.align = TextFormatAlign.LEFT;
         this.m_CostText.defaultTextFormat = format;
         this.m_CostText.selectable = false;
         this.m_CostText.mouseEnabled = false;
         this.m_CostText.embedFonts = true;
         this.m_CostText.multiline = false;
         this.m_CostText.wordWrap = false;
         this.m_CostText.autoSize = TextFieldAutoSize.LEFT;
         this.m_CostText.width = Dimensions.GAME_WIDTH * 0.5;
         this.m_CostText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT);
         this.m_CostText.filters = textFilters;
         this.m_CostText.cacheAsBitmap = true;
         this.m_PriceText = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16767036);
         format.align = TextFormatAlign.RIGHT;
         this.m_PriceText.defaultTextFormat = format;
         this.m_PriceText.selectable = false;
         this.m_PriceText.mouseEnabled = false;
         this.m_PriceText.embedFonts = true;
         this.m_PriceText.multiline = false;
         this.m_PriceText.wordWrap = false;
         this.m_PriceText.autoSize = TextFieldAutoSize.RIGHT;
         this.m_PriceText.width = Dimensions.GAME_WIDTH * 0.5;
         this.m_PriceText.htmlText = StringUtils.InsertNumberCommas(25000);
         this.m_PriceText.filters = textFilters;
         this.m_PriceText.cacheAsBitmap = true;
         this.m_StreakCostText = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16767036);
         format.align = TextFormatAlign.LEFT;
         this.m_StreakCostText.defaultTextFormat = format;
         this.m_StreakCostText.selectable = false;
         this.m_StreakCostText.mouseEnabled = false;
         this.m_StreakCostText.embedFonts = true;
         this.m_StreakCostText.multiline = false;
         this.m_StreakCostText.wordWrap = false;
         this.m_StreakCostText.autoSize = TextFieldAutoSize.LEFT;
         this.m_StreakCostText.width = Dimensions.GAME_WIDTH * 0.5;
         this.m_StreakCostText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT);
         this.m_StreakCostText.filters = textFilters;
         this.m_StreakCostText.cacheAsBitmap = true;
         this.m_StreakPriceText = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,18,16767036);
         format.align = TextFormatAlign.RIGHT;
         this.m_StreakPriceText.defaultTextFormat = format;
         this.m_StreakPriceText.selectable = false;
         this.m_StreakPriceText.mouseEnabled = false;
         this.m_StreakPriceText.embedFonts = true;
         this.m_StreakPriceText.multiline = false;
         this.m_StreakPriceText.wordWrap = false;
         this.m_StreakPriceText.autoSize = TextFieldAutoSize.RIGHT;
         this.m_StreakPriceText.width = Dimensions.GAME_WIDTH * 0.5;
         this.m_StreakPriceText.htmlText = StringUtils.InsertNumberCommas(25000);
         this.m_StreakPriceText.filters = textFilters;
         this.m_StreakPriceText.cacheAsBitmap = true;
         this.m_CoinImage = new Bitmap();
         this.m_StreakCoinImage = new Bitmap();
         this.m_StreakStrike = new Shape();
         this.m_Buttons = new ButtonWidgetDouble(app);
         this.m_Buttons.SetLabels(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_BTN_ACCEPT),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_BTN_DECLINE));
         this.m_Buttons.SetHandlers(this.HandleAcceptClicked,this.HandleDeclineClicked);
         this.m_App.sessionData.rareGemManager.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
      }
      
      public function Init() : void
      {
         addChild(this.m_Background);
         addChild(this.m_CoinBalance);
         addChild(this.m_AddCoinsButton);
         addChild(this.m_RareGemImage);
         addChild(this.m_RareGemTitle);
         addChild(this.m_Header);
         addChild(this.m_Copy);
         addChild(this.m_CostText);
         addChild(this.m_PriceText);
         addChild(this.m_CoinImage);
         addChild(this.m_Buttons);
         this.m_App.sessionData.rareGemManager.ForceDispatchRareGemInfo();
         var content:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_BTN_ACCEPT);
         var cost:int = 0;
         if(this.m_RareGemCosts)
         {
            cost = this.m_RareGemCosts[MoonstoneRGLogic.ID];
         }
         this.m_Copy.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COPY_MOONSTONE);
         this.m_Header.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_TITLE);
         this.m_CoinImage.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN);
         this.m_CoinImage.smoothing = true;
         this.m_CoinImage.width = 18;
         this.m_CoinImage.height = 18;
         this.m_StreakCoinImage.bitmapData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_COIN);
         this.m_StreakCoinImage.smoothing = true;
         this.m_StreakCoinImage.width = 18;
         this.m_StreakCoinImage.height = 18;
         this.m_CoinBalance.SetSize(110,26);
         this.m_CoinBalance.x = 136;
         this.m_CoinBalance.y = 34;
         this.m_AddCoinsButton.x = 250;
         this.m_AddCoinsButton.y = 33;
         this.m_Buttons.x = (Dimensions.GAME_WIDTH - Dimensions.LEFT_BORDER_WIDTH - this.m_Buttons.width) * 0.5;
         this.m_Buttons.y = 360;
         this.m_AddCoinsButton.addEventListener(MouseEvent.CLICK,this.HandleAddCoinsClick);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.Hide();
         this.m_Buttons.Reset();
      }
      
      public function Show() : void
      {
         visible = true;
         var offer:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var curRGID:String = offer.GetID();
         this.m_RareGemImage.bitmapData = null;
         var rgLogic:IRareGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(curRGID);
         if(rgLogic != null)
         {
            this.m_RareGemImage.bitmapData = this.m_Images[rgLogic.GetOrderingID()];
         }
         this.m_AddCoinsButton.SetEnabled(!this.m_App.network.isOffline && this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_BUY_COINS));
         if(contains(this.m_StreakCostText))
         {
            removeChild(this.m_StreakCostText);
            removeChild(this.m_StreakPriceText);
            removeChild(this.m_StreakCoinImage);
            removeChild(this.m_StreakStrike);
         }
         this.DoLayout(curRGID);
         var soundName:String = "SOUND_BLITZ3GAME_RG_APPEAR_" + curRGID.toUpperCase();
         this.m_App.SoundManager.playSound(soundName);
      }
      
      public function Hide() : void
      {
         visible = false;
      }
      
      public function Update() : void
      {
      }
      
      public function AddHandler(handler:IRareGemDialogHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleRareGemCatalogChanged(boostCatalog:Dictionary) : void
      {
         var name:* = null;
         this.m_RareGemCosts = new Dictionary();
         for(name in boostCatalog)
         {
            this.m_RareGemCosts[name] = boostCatalog[name];
         }
      }
      
      public function HandleActiveRareGemChanged(activeRareGem:String) : void
      {
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.m_CoinBalance.SetText(StringUtils.InsertNumberCommas(balance));
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
      
      protected function DispatchContinueClicked(offerAccepted:Boolean) : void
      {
         var handler:IRareGemDialogHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleRareGemContinueClicked(offerAccepted);
         }
      }
      
      protected function DoLayout(curRGID:String) : void
      {
         var streakLineWidth:Number = NaN;
         this.m_Header.x = Dimensions.GAME_WIDTH * 0.5 - this.m_Header.width * 0.5;
         this.m_Header.y = 40 + this.m_Header.height;
         this.m_RareGemTitle.x = Dimensions.GAME_WIDTH * 0.5 - this.m_RareGemTitle.width * 0.5;
         this.m_RareGemTitle.y = -10 + this.m_Header.y + this.m_Header.height;
         this.m_RareGemImage.x = Dimensions.GAME_WIDTH * 0.5 - this.m_RareGemImage.width * 0.5;
         this.m_RareGemImage.y = -10 + this.m_RareGemTitle.y + this.m_RareGemTitle.height;
         var streakMod:String = "";
         var streakNum:int = this.m_App.sessionData.rareGemManager.GetStreakNum();
         if(streakNum > 0)
         {
            streakMod = "_STREAK" + streakNum;
         }
         this.m_Header.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_TITLE + streakMod);
         this.m_Copy.htmlText = this.m_App.TextManager.GetLocString("LOC_BLITZ3GAME_RG_COPY_" + curRGID.toUpperCase() + streakMod);
         this.m_RareGemTitle.htmlText = this.m_App.TextManager.GetLocString("LOC_BLITZ3GAME_RG_" + curRGID.toUpperCase());
         this.m_RareGemTitle.filters = FILTERS[curRGID];
         this.m_Copy.x = Dimensions.GAME_WIDTH * 0.5 - this.m_Copy.width * 0.5;
         this.m_Copy.y = this.m_RareGemImage.y + this.m_RareGemImage.height;
         this.m_CostText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT);
         this.m_PriceText.htmlText = StringUtils.InsertNumberCommas(this.m_RareGemCosts[curRGID]);
         var costLineWidth:Number = this.m_CostText.textWidth + this.m_PriceText.textWidth + this.m_CoinImage.width;
         this.m_CostText.x = Dimensions.GAME_WIDTH * 0.5 - costLineWidth * 0.5;
         this.m_CostText.y = this.m_Copy.y + this.m_Copy.textHeight;
         this.m_CoinImage.x = this.m_CostText.x + this.m_CostText.textWidth;
         this.m_CoinImage.y = this.m_CostText.y + this.m_CostText.textHeight * 0.5 - this.m_CoinImage.height * 0.5;
         this.m_PriceText.x = this.m_CoinImage.x + this.m_CoinImage.width;
         this.m_PriceText.y = this.m_CostText.y;
         if(streakNum > 0)
         {
            addChild(this.m_StreakCostText);
            addChild(this.m_StreakCoinImage);
            addChild(this.m_StreakPriceText);
            addChild(this.m_StreakStrike);
            this.m_StreakCostText.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_COST_TEXT + streakMod);
            this.m_StreakPriceText.htmlText = StringUtils.InsertNumberCommas(this.m_RareGemCosts[curRGID] - this.m_App.sessionData.rareGemManager.GetStreakDiscount());
            streakLineWidth = this.m_StreakCostText.textWidth + this.m_StreakPriceText.textWidth + this.m_StreakCoinImage.width;
            this.m_StreakCostText.x = Dimensions.GAME_WIDTH * 0.5 - streakLineWidth * 0.5;
            this.m_StreakCostText.y = 24 + this.m_Copy.y + this.m_Copy.textHeight;
            this.m_StreakCoinImage.x = this.m_StreakCostText.x + this.m_StreakCostText.textWidth;
            this.m_StreakCoinImage.y = this.m_StreakCostText.y + this.m_StreakCostText.textHeight * 0.5 - this.m_StreakCoinImage.height * 0.5;
            this.m_StreakPriceText.x = this.m_StreakCoinImage.x + this.m_StreakCoinImage.width;
            this.m_StreakPriceText.y = this.m_StreakCostText.y;
            this.m_StreakStrike.graphics.clear();
            this.m_StreakStrike.graphics.lineStyle(3,16711680);
            this.m_StreakStrike.graphics.moveTo(this.m_CostText.x - 10,this.m_CostText.y + this.m_CostText.height * 0.45);
            this.m_StreakStrike.graphics.lineTo(this.m_CostText.x + costLineWidth + 10,this.m_CostText.y + this.m_CostText.height * 0.45);
         }
      }
      
      protected function HandleAcceptClicked(event:MouseEvent) : void
      {
         var offer:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var soundName:String = "SOUND_BLITZ3GAME_RG_HARVEST_" + offer.GetID().toUpperCase();
         this.m_App.SoundManager.playSound(soundName);
         this.m_App.sessionData.rareGemManager.BuyRareGem();
         this.Hide();
         this.DispatchContinueClicked(true);
      }
      
      protected function HandleDeclineClicked(event:MouseEvent) : void
      {
         this.m_App.sessionData.rareGemManager.EndStreak();
         this.Hide();
         this.DispatchContinueClicked(false);
      }
      
      protected function HandleAddCoinsClick(event:MouseEvent) : void
      {
         if(!this.m_AddCoinsButton.IsEnabled())
         {
            return;
         }
         this.m_App.network.ReportEvent("AddCoinsClick/RareGemMenu");
         this.m_App.network.ShowCart();
      }
   }
}
