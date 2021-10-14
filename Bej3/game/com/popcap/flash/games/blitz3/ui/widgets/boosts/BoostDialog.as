package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.session.BoostManager;
   import com.popcap.flash.games.blitz3.session.IBoostManagerHandler;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import com.popcap.flash.games.blitz3.ui.sprites.GenericButton;
   import com.popcap.flash.games.blitz3.ui.sprites.ResizableButton;
   import com.popcap.flash.games.blitz3.ui.widgets.univdialog.TwoButtonDialog;
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
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_Background:Bitmap;
      
      protected var m_BackgroundRG:Bitmap;
      
      protected var m_BtnContinue:ResizableButton;
      
      protected var m_Balance:MediumCoinLabel;
      
      protected var m_BtnAddCoins:FadeButton;
      
      protected var m_TxtRareGem:TextField;
      
      protected var m_TxtHeader:TextField;
      
      protected var m_TxtSubHeader:TextField;
      
      protected var m_NegativeBalanceDialog:TwoButtonDialog;
      
      protected var m_FadeLayer:Sprite;
      
      public var boostSelector:BoostSelectionWidget;
      
      protected var m_Handlers:Vector.<IBoostDialogHandler>;
      
      public function BoostDialog(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_BtnContinue = new GenericButton(app,18);
         this.m_Balance = new MediumCoinLabel();
         this.m_BtnAddCoins = new FadeButton(app);
         this.m_TxtRareGem = new TextField();
         var format:TextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,22,16774202);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtRareGem.defaultTextFormat = format;
         this.m_TxtRareGem.selectable = false;
         this.m_TxtRareGem.mouseEnabled = false;
         this.m_TxtRareGem.embedFonts = true;
         this.m_TxtRareGem.multiline = false;
         this.m_TxtRareGem.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtRareGem.htmlText = this.m_App.locManager.GetLocString("RG_ACTIVATED_MOONSTONE");
         this.m_TxtRareGem.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_TxtRareGem.cacheAsBitmap = true;
         this.m_TxtHeader = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,24,16774202);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtHeader.defaultTextFormat = format;
         this.m_TxtHeader.selectable = false;
         this.m_TxtHeader.mouseEnabled = false;
         this.m_TxtHeader.embedFonts = true;
         this.m_TxtHeader.multiline = false;
         this.m_TxtHeader.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtHeader.htmlText = this.m_App.locManager.GetLocString("BOOST_MENU_HEADER");
         this.m_TxtHeader.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_TxtHeader.cacheAsBitmap = true;
         this.m_TxtSubHeader = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,16,16774202);
         format.align = TextFormatAlign.CENTER;
         this.m_TxtSubHeader.defaultTextFormat = format;
         this.m_TxtSubHeader.selectable = false;
         this.m_TxtSubHeader.mouseEnabled = false;
         this.m_TxtSubHeader.embedFonts = true;
         this.m_TxtSubHeader.multiline = false;
         this.m_TxtSubHeader.autoSize = TextFieldAutoSize.CENTER;
         this.m_TxtSubHeader.htmlText = "";
         this.m_TxtSubHeader.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_TxtSubHeader.cacheAsBitmap = true;
         this.m_NegativeBalanceDialog = new TwoButtonDialog(app);
         this.m_FadeLayer = new Sprite();
         this.m_FadeLayer.graphics.beginFill(0,0.3);
         this.m_FadeLayer.graphics.drawRect(0,0,Blitz3Game.SCREEN_WIDTH,Blitz3Game.SCREEN_WIDTH);
         this.m_FadeLayer.graphics.endFill();
         this.m_FadeLayer.mouseEnabled = true;
         this.m_FadeLayer.mouseChildren = true;
         this.m_FadeLayer.visible = false;
         this.m_Handlers = new Vector.<IBoostDialogHandler>();
         visible = false;
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.m_NegativeBalanceDialog.Reset();
      }
      
      public function Update() : void
      {
         this.m_NegativeBalanceDialog.Update();
         this.m_BtnContinue.SetDisabled(this.boostSelector.IsAutoRenewing());
      }
      
      public function AddHandler(handler:IBoostDialogHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Show() : void
      {
         var rareGem:String = null;
         visible = true;
         this.m_App.ui.optionsButton.visible = true;
         this.m_BackgroundRG.visible = false;
         this.m_Background.visible = true;
         this.m_TxtRareGem.visible = false;
         this.m_BtnAddCoins.SetEnabled(!this.m_App.network.isOffline);
         var background:Bitmap = this.m_Background;
         var hasRareGem:Boolean = this.m_App.sessionData.rareGemManager.HasCurRareGem();
         if(hasRareGem)
         {
            trace("displaying boost dialog, has rare gem? " + hasRareGem);
            rareGem = this.m_App.sessionData.rareGemManager.GetActiveRareGem();
            this.m_TxtRareGem.htmlText = "";
            if(rareGem)
            {
               this.m_TxtRareGem.htmlText = this.m_App.locManager.GetLocString("RG_ACTIVATED_" + rareGem.toUpperCase());
            }
            this.m_BackgroundRG.visible = true;
            this.m_Background.visible = false;
            this.m_TxtRareGem.visible = true;
            background = this.m_BackgroundRG;
         }
         this.m_Balance.SetSize(110,26);
         this.m_Balance.x = background.x + background.width * 0.2;
         this.m_Balance.y = background.y + background.height * 0.016;
         this.m_BtnAddCoins.x = background.x + background.width * 0.66 - this.m_BtnAddCoins.width * 0.5;
         this.m_BtnAddCoins.y = background.y + background.height * 0.05 - this.m_BtnAddCoins.height * 0.5;
         this.m_BtnContinue.x = background.x + background.width * 0.5 - this.m_BtnContinue.width * 0.5;
         this.m_BtnContinue.y = background.y + background.height * 0.96 - this.m_BtnContinue.height;
         this.boostSelector.x = background.x + background.width * 0.5;
         this.boostSelector.y = background.y;
         this.m_TxtHeader.x = background.x + background.width * 0.5 - this.m_TxtHeader.width * 0.5;
         this.m_TxtHeader.y = background.y + background.height * 0.09;
         if(hasRareGem)
         {
            this.m_Balance.y = background.y + background.height * 0.0145;
            this.m_BtnAddCoins.y = background.y + background.height * 0.045 - this.m_BtnAddCoins.height * 0.5;
            this.m_BtnContinue.y = background.y + background.height * 0.96 - this.m_BtnContinue.height;
            this.m_TxtHeader.y = background.y + background.height * 0.08;
            this.m_TxtRareGem.x = background.x + background.width * 0.5 - this.m_TxtRareGem.width * 0.5;
            this.m_TxtRareGem.y = background.y + background.height * 0.78 - this.m_TxtRareGem.height * 0.5;
         }
         this.m_TxtSubHeader.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtSubHeader.width * 0.5;
         this.m_TxtSubHeader.y = this.m_TxtHeader.y + this.m_TxtHeader.height * 0.75;
         this.m_NegativeBalanceDialog.x = background.x + background.width * 0.5 - this.m_NegativeBalanceDialog.width * 0.5;
         this.m_NegativeBalanceDialog.y = background.y + background.height * 0.5 - this.m_NegativeBalanceDialog.height * 0.5;
         if(this.m_App.network.isOffline && this.m_App.sessionData.userData.GetCoins() < 0)
         {
            this.m_App.sessionData.boostManager.SellAllBoosts();
         }
      }
      
      public function Hide() : void
      {
         visible = false;
         this.m_App.ui.optionsButton.visible = false;
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
         this.m_TxtSubHeader.htmlText = this.m_App.locManager.GetLocString("BOOST_MENU_SUBTITLE_CHOOSE_" + (BoostManager.MAX_ACTIVE_BOOSTS - this.m_App.sessionData.boostManager.GetNumActiveBoosts()));
         this.m_TxtSubHeader.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_TxtSubHeader.width * 0.5;
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
         this.m_TxtSubHeader.htmlText = this.m_App.locManager.GetLocString("BOOST_MENU_SUBTITLE_AUTORENEWED");
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
         if(this.m_BtnContinue.IsDisabled())
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
