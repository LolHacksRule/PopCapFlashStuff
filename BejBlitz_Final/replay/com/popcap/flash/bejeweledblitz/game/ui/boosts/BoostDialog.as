package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.BoostManager;
   import com.popcap.flash.bejeweledblitz.game.session.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.IUserDataHandler;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemOffer;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.boosts.selection.BoostSelector;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonFramed;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.MediumCoinLabel;
   import com.popcap.flash.bejeweledblitz.game.ui.dialogs.TwoButtonDialog;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class BoostDialog extends Sprite implements IBoostManagerHandler, IUserDataHandler
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Background:Bitmap;
      
      protected var m_BackgroundRG:Bitmap;
      
      protected var m_RareGems:Vector.<CornerGem>;
      
      protected var m_ButtonContinue:GenericButtonFramed;
      
      protected var m_Balance:MediumCoinLabel;
      
      protected var m_ButtonAddCoins:SkinButton;
      
      protected var m_TxtRareGem:TextField;
      
      protected var m_TxtHeader:TextField;
      
      protected var m_TxtSubHeader:TextField;
      
      protected var m_NegativeBalanceDialog:TwoButtonDialog;
      
      protected var m_FadeLayer:Sprite;
      
      public var selector:BoostSelector;
      
      protected var m_Handlers:Vector.<IBoostDialogHandler>;
      
      public function BoostDialog(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Background = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SELECT_BACKGROUND));
         this.m_BackgroundRG = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SELECT_BACKGROUND_RARE_GEM));
         this.m_RareGems = new Vector.<CornerGem>(2);
         for(var i:int = 0; i < 2; i++)
         {
            this.m_RareGems[i] = new CornerGem(this.m_App);
            this.m_RareGems[i].scaleY = 1.2;
            this.m_RareGems[i].scaleX = 1.2;
            this.m_RareGems[i].visible = false;
         }
         this.m_ButtonContinue = new GenericButtonFramed(this.m_App,20);
         this.m_Balance = new MediumCoinLabel(this.m_App);
         this.m_ButtonAddCoins = new SkinButton(this.m_App);
         this.selector = new BoostSelector(this.m_App);
         this.m_TxtRareGem = new TextField();
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,20,16767036);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtRareGem.defaultTextFormat = format;
         this.m_TxtRareGem.selectable = false;
         this.m_TxtRareGem.mouseEnabled = false;
         this.m_TxtRareGem.embedFonts = true;
         this.m_TxtRareGem.multiline = false;
         this.m_TxtRareGem.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtRareGem.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_RG_ACTIVATED_MOONSTONE);
         this.m_TxtRareGem.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_TxtHeader = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,20,16767036);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtHeader.defaultTextFormat = format;
         this.m_TxtHeader.selectable = false;
         this.m_TxtHeader.mouseEnabled = false;
         this.m_TxtHeader.embedFonts = true;
         this.m_TxtHeader.multiline = false;
         this.m_TxtHeader.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtHeader.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_MENU_HEADER);
         this.m_TxtHeader.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_TxtSubHeader = new TextField();
         format = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16767036);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtSubHeader.defaultTextFormat = format;
         this.m_TxtSubHeader.selectable = false;
         this.m_TxtSubHeader.mouseEnabled = false;
         this.m_TxtSubHeader.embedFonts = true;
         this.m_TxtSubHeader.multiline = false;
         this.m_TxtSubHeader.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtSubHeader.htmlText = "";
         this.m_TxtSubHeader.filters = [new GlowFilter(0,1,2,2,4)];
         this.m_NegativeBalanceDialog = new TwoButtonDialog(this.m_App,16);
         this.m_FadeLayer = new Sprite();
         this.m_FadeLayer.graphics.beginFill(0,0.3);
         this.m_FadeLayer.graphics.drawRect(0,0,this.m_App.uiFactory.GetGameWidth(),this.m_App.uiFactory.GetGameHeight());
         this.m_FadeLayer.graphics.endFill();
         this.m_FadeLayer.mouseEnabled = true;
         this.m_FadeLayer.mouseChildren = true;
         this.m_FadeLayer.visible = false;
         this.m_Handlers = new Vector.<IBoostDialogHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
         var gem:CornerGem = null;
         addChild(this.m_Background);
         addChild(this.m_BackgroundRG);
         for each(gem in this.m_RareGems)
         {
            addChild(gem);
         }
         addChild(this.m_TxtHeader);
         addChild(this.m_TxtSubHeader);
         addChild(this.m_TxtRareGem);
         addChild(this.m_Balance);
         addChild(this.m_ButtonAddCoins);
         addChild(this.m_ButtonContinue);
         addChild(this.selector);
         addChild(this.m_FadeLayer);
         addChild(this.m_NegativeBalanceDialog);
         this.selector.Init();
         this.m_NegativeBalanceDialog.Init();
         this.m_ButtonAddCoins.background.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS)));
         this.m_ButtonAddCoins.over.addChild(new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_ADD_COINS_OVER)));
         this.m_NegativeBalanceDialog.SetDimensions(420,130);
         this.m_NegativeBalanceDialog.SetContent(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_BODY),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_ACCEPT),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_NEG_BALANCE_DECLINE));
         this.m_NegativeBalanceDialog.AddAcceptButtonHandler(this.HandleNegBalanceAcceptClick);
         this.m_NegativeBalanceDialog.AddDeclineButtonHandler(this.HandleNegBalanceDeclineClick);
         this.m_NegativeBalanceDialog.visible = false;
         this.m_ButtonContinue.SetText(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_MENU_CONTINUE),this.m_Background.width * 0.65);
         this.m_Background.x = Dimensions.GAME_WIDTH * 0.5 - this.m_Background.width * 0.5;
         this.m_Background.y = Dimensions.GAME_HEIGHT * 0.5 - this.m_Background.height * 0.5;
         this.m_BackgroundRG.x = Dimensions.GAME_WIDTH * 0.5 - this.m_BackgroundRG.width * 0.5;
         this.m_BackgroundRG.y = Dimensions.GAME_HEIGHT * 0.5 - this.m_BackgroundRG.height * 0.5;
         this.m_BackgroundRG.visible = false;
         this.m_RareGems[0].x = this.m_BackgroundRG.x + this.m_BackgroundRG.width * 0.0633;
         this.m_RareGems[0].y = this.m_BackgroundRG.y + this.m_BackgroundRG.height * 0.772;
         this.m_RareGems[1].x = this.m_BackgroundRG.x + this.m_BackgroundRG.width * 0.935;
         this.m_RareGems[1].y = this.m_RareGems[0].y;
         this.m_App.sessionData.boostManager.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
         this.m_ButtonContinue.addEventListener(MouseEvent.CLICK,this.HandleContinueClick);
         this.m_ButtonAddCoins.addEventListener(MouseEvent.CLICK,this.HandleAddCoinsClick);
      }
      
      public function Reset() : void
      {
         this.selector.Reset();
         this.m_NegativeBalanceDialog.Reset();
      }
      
      public function Update() : void
      {
         this.selector.Update();
      }
      
      public function AddHandler(handler:IBoostDialogHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show() : void
      {
         var gem:CornerGem = null;
         var rareGemID:String = null;
         visible = true;
         (this.m_App.ui as MainWidgetGame).optionsButton.visible = true;
         this.m_BackgroundRG.visible = false;
         this.m_Background.visible = true;
         this.m_TxtRareGem.visible = false;
         this.m_ButtonAddCoins.SetEnabled(!this.m_App.network.isOffline && this.m_App.sessionData.featureManager.IsEnabled(FeatureManager.FEATURE_ALLOW_BUY_COINS));
         var background:Bitmap = this.m_Background;
         var rareGemOffer:RareGemOffer = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var hasRareGem:Boolean = rareGemOffer.IsHarvested();
         for each(gem in this.m_RareGems)
         {
            gem.visible = false;
         }
         if(hasRareGem)
         {
            rareGemID = rareGemOffer.GetID();
            this.m_TxtRareGem.htmlText = "";
            if(rareGemID)
            {
               this.m_TxtRareGem.htmlText = this.m_App.TextManager.GetLocString("LOC_BLITZ3GAME_RG_ACTIVATED_" + rareGemID.toUpperCase());
            }
            for each(gem in this.m_RareGems)
            {
               gem.visible = true;
               gem.SetGemType(rareGemID);
            }
            this.m_BackgroundRG.visible = true;
            this.m_Background.visible = false;
            this.m_TxtRareGem.visible = true;
            background = this.m_BackgroundRG;
         }
         this.m_Balance.SetSize(110,26);
         this.m_Balance.x = background.x + background.width * 0.2;
         this.m_Balance.y = background.y + background.height * 0.016;
         this.m_ButtonAddCoins.x = background.x + background.width * 0.66 - this.m_ButtonAddCoins.width * 0.5;
         this.m_ButtonAddCoins.y = background.y + background.height * 0.05 - this.m_ButtonAddCoins.height * 0.5;
         this.m_ButtonContinue.x = background.x + background.width * 0.5 - this.m_ButtonContinue.width * 0.5;
         this.m_ButtonContinue.y = background.y + background.height * 0.9574 - this.m_ButtonContinue.height;
         this.selector.x = background.x;
         this.selector.y = background.y;
         this.m_TxtHeader.x = background.x + background.width * 0.5 - this.m_TxtHeader.width * 0.5;
         this.m_TxtHeader.y = background.y + background.height * 0.1;
         if(hasRareGem)
         {
            this.m_Balance.y = background.y + background.height * 0.0145;
            this.m_ButtonAddCoins.y = background.y + background.height * 0.045 - this.m_ButtonAddCoins.height * 0.5;
            this.m_ButtonContinue.y = background.y + background.height * 0.96 - this.m_ButtonContinue.height;
            this.m_TxtHeader.y = background.y + background.height * 0.09;
            this.m_TxtRareGem.x = background.x + background.width * 0.5 - this.m_TxtRareGem.width * 0.5;
            this.m_TxtRareGem.y = background.y + background.height * 0.78 - this.m_TxtRareGem.height * 0.5;
         }
         this.m_TxtSubHeader.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtSubHeader.width * 0.5;
         this.m_TxtSubHeader.y = this.m_TxtHeader.y + this.m_TxtHeader.height * 0.75;
         this.m_NegativeBalanceDialog.x = background.x + background.width * 0.5 - this.m_NegativeBalanceDialog.width * 0.5;
         this.m_NegativeBalanceDialog.y = background.y + background.height * 0.5 - this.m_NegativeBalanceDialog.height * 0.5;
         this.selector.HandleShown();
         if(this.m_App.network.isOffline && this.m_App.sessionData.userData.GetCoins() < 0)
         {
            this.m_App.sessionData.boostManager.SellAllBoosts();
         }
      }
      
      public function Hide() : void
      {
         visible = false;
         (this.m_App.ui as MainWidgetGame).optionsButton.visible = false;
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.m_Balance.SetText(StringUtils.InsertNumberCommas(balance));
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
         this.m_TxtSubHeader.htmlText = this.m_App.TextManager.GetLocString("LOC_BLITZ3GAME_BOOST_MENU_SUBTITLE_CHOOSE_" + (BoostManager.MAX_ACTIVE_BOOSTS - this.m_App.sessionData.boostManager.GetNumActiveBoosts()));
         this.m_TxtSubHeader.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtSubHeader.width * 0.5;
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
         this.m_TxtSubHeader.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_BOOST_MENU_SUBTITLE_AUTORENEWED);
         this.m_TxtSubHeader.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtSubHeader.width * 0.5;
      }
      
      protected function DispatchContinueClicked() : void
      {
         var handler:IBoostDialogHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleBoostDialogContinueClicked();
         }
      }
      
      protected function HandleContinueClick(event:MouseEvent) : void
      {
         if(this.m_ButtonContinue.IsDisabled())
         {
            return;
         }
         if(this.m_App.sessionData.userData.GetCoins() < 0)
         {
            this.m_FadeLayer.visible = true;
            this.m_NegativeBalanceDialog.visible = true;
            this.m_App.network.ReportEvent("BoostLock/OutOfCoins");
            return;
         }
         this.Hide();
         this.DispatchContinueClicked();
      }
      
      protected function HandleNegBalanceAcceptClick(event:MouseEvent) : void
      {
         this.m_FadeLayer.visible = false;
         this.m_NegativeBalanceDialog.visible = false;
         this.Hide();
         this.DispatchContinueClicked();
      }
      
      protected function HandleNegBalanceDeclineClick(event:MouseEvent) : void
      {
         this.m_App.sessionData.boostManager.SellAllBoosts();
         this.m_FadeLayer.visible = false;
         this.m_NegativeBalanceDialog.visible = false;
      }
      
      protected function HandleAddCoinsClick(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("AddCoinsClick/BoostMenu");
         this.m_App.network.ShowCart();
      }
   }
}
