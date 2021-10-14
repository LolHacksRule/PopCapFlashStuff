package com.popcap.flash.games.blitz3.ui.widgets.game.raregems
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.raregems.CatseyeRGLogic;
   import com.popcap.flash.games.bej3.raregems.IRareGem;
   import com.popcap.flash.games.bej3.raregems.MoonstoneRGLogic;
   import com.popcap.flash.games.blitz3.session.IRareGemManagerHandler;
   import com.popcap.flash.games.blitz3.session.IUserDataHandler;
   import com.popcap.flash.games.blitz3.ui.sprites.AcceptButton;
   import com.popcap.flash.games.blitz3.ui.sprites.DeclineButton;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.MediumCoinLabel;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class RareGemAwardScreen extends Sprite implements IRareGemManagerHandler, IUserDataHandler
   {
      
      protected static const FILTERS:Dictionary = new Dictionary();
      
      {
         FILTERS[MoonstoneRGLogic.ID] = [new BevelFilter(3,45,16777215,1,5118617,1,5,5,2,BitmapFilterQuality.HIGH),new BevelFilter(4,45,16777215,1,9214144,1,5,5,2),new GlowFilter(5118134,1,7,7,10)];
         FILTERS[CatseyeRGLogic.ID] = [new BevelFilter(3,45,13369395,1,16777215,1,5,5,1,BitmapFilterQuality.HIGH),new BevelFilter(4,45,10040064,1,16777215,1,5,5,1.37),new GlowFilter(4721954,1,7,7,20)];
      }
      
      protected var m_App:Blitz3Game;
      
      protected var m_Handlers:Vector.<IRareGemDialogHandler>;
      
      protected var m_Images:Vector.<BitmapData>;
      
      protected var m_Background:DisplayObject;
      
      protected var m_AcceptBtn:AcceptButton;
      
      protected var m_DeclineBtn:DeclineButton;
      
      protected var m_RareGemImage:Bitmap;
      
      protected var m_RareGemTitle:TextField;
      
      protected var m_Header:TextField;
      
      protected var m_Copy:TextField;
      
      protected var m_Balance:MediumCoinLabel;
      
      protected var m_BtnAddCoins:FadeButton;
      
      protected var m_RareGemCosts:Dictionary;
      
      public function RareGemAwardScreen(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.m_Handlers = new Vector.<IRareGemDialogHandler>();
         this.m_Images = new Vector.<BitmapData>();
         var textFilters:Array = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.m_AcceptBtn = new AcceptButton(app);
         this.m_DeclineBtn = new DeclineButton(app);
         this.m_RareGemImage = new Bitmap();
         this.m_RareGemTitle = new TextField();
         var format:TextFormat = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,46,14021887);
         format.align = TextFormatAlign.CENTER;
         this.m_RareGemTitle.defaultTextFormat = format;
         this.m_RareGemTitle.selectable = false;
         this.m_RareGemTitle.mouseEnabled = false;
         this.m_RareGemTitle.embedFonts = true;
         this.m_RareGemTitle.multiline = false;
         this.m_RareGemTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_RareGemTitle.htmlText = this.m_App.locManager.GetLocString("RG_MOONSTONE");
         this.m_RareGemTitle.filters = FILTERS[MoonstoneRGLogic.ID];
         this.m_RareGemTitle.cacheAsBitmap = true;
         this.m_Header = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,26,16774202);
         format.align = TextFormatAlign.CENTER;
         this.m_Header.defaultTextFormat = format;
         this.m_Header.selectable = false;
         this.m_Header.mouseEnabled = false;
         this.m_Header.embedFonts = true;
         this.m_Header.multiline = false;
         this.m_Header.autoSize = TextFieldAutoSize.CENTER;
         this.m_Header.htmlText = this.m_App.locManager.GetLocString("RG_TITLE");
         this.m_Header.filters = textFilters;
         this.m_Header.cacheAsBitmap = true;
         this.m_Copy = new TextField();
         format = new TextFormat(Blitz3Fonts.BLITZ_STANDARD,12,16777215);
         format.align = TextFormatAlign.LEFT;
         this.m_Copy.defaultTextFormat = format;
         this.m_Copy.selectable = false;
         this.m_Copy.mouseEnabled = false;
         this.m_Copy.embedFonts = true;
         this.m_Copy.multiline = true;
         this.m_Copy.wordWrap = true;
         this.m_Copy.autoSize = TextFieldAutoSize.LEFT;
         this.m_Copy.htmlText = this.m_App.locManager.GetLocString("RG_COPY_MOONSTONE");
         this.m_Copy.filters = textFilters;
         this.m_Copy.cacheAsBitmap = true;
         this.m_Balance = new MediumCoinLabel();
         this.m_BtnAddCoins = new FadeButton(app);
         this.m_App.sessionData.rareGemManager.AddHandler(this);
         this.m_App.sessionData.userData.AddHandler(this);
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         visible = false;
         this.m_AcceptBtn.Reset();
         this.m_DeclineBtn.Reset();
      }
      
      public function Show() : void
      {
         visible = true;
         var curRGID:String = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         this.m_RareGemImage.bitmapData = null;
         var rgLogic:IRareGem = this.m_App.logic.rareGemLogic.GetRareGemByStringID(curRGID);
         if(rgLogic)
         {
            this.m_RareGemImage.bitmapData = this.m_Images[rgLogic.GetOrderingID()];
         }
         this.m_BtnAddCoins.SetEnabled(!this.m_App.network.isOffline);
         var content:String = this.m_App.locManager.GetLocString("RG_BTN_ACCEPT");
         content = content.replace("%s",StringUtils.InsertNumberCommas(this.m_RareGemCosts[curRGID]));
         this.m_AcceptBtn.SetText(content);
         var locID:String = "RG_COPY_" + curRGID.toUpperCase();
         this.m_Copy.htmlText = this.m_App.locManager.GetLocString(locID);
         locID = "RG_" + curRGID.toUpperCase();
         this.m_RareGemTitle.htmlText = this.m_App.locManager.GetLocString(locID);
         this.m_RareGemTitle.filters = FILTERS[curRGID];
         this.DoLayout();
         var soundName:String = "SOUND_RG_APPEAR_" + curRGID.toUpperCase();
         this.m_App.soundManager.playSound(soundName);
      }
      
      public function Update() : void
      {
      }
      
      public function AddHandler(handler:IRareGemDialogHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function HandleCoinBalanceChanged(balance:int) : void
      {
         this.m_Balance.SetText(StringUtils.InsertNumberCommas(balance));
      }
      
      public function HandleXPTotalChanged(xp:Number, level:int) : void
      {
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
      
      protected function DispatchContinueClicked(offerAccepted:Boolean) : void
      {
         var handler:IRareGemDialogHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleRareGemContinueClicked(offerAccepted);
         }
      }
      
      protected function DoLayout() : void
      {
         this.m_Header.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_Header.width * 0.5;
         this.m_Header.y = this.m_Background.y + this.m_Background.height * 0.15 - this.m_Header.height * 0.5;
         this.m_RareGemTitle.x = this.m_Background.x + this.m_Background.width * 0.5 - this.m_RareGemTitle.width * 0.5;
         this.m_RareGemTitle.y = this.m_Background.y + this.m_Background.height * 0.26 - this.m_RareGemTitle.height * 0.5;
         this.m_RareGemImage.x = this.m_Background.x + this.m_Background.width * 0.25 - this.m_RareGemImage.width * 0.5;
         this.m_RareGemImage.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_RareGemImage.height * 0.5;
         this.m_Copy.x = this.m_Background.x + this.m_Background.width * 0.7 - this.m_Copy.width * 0.5;
         this.m_Copy.y = this.m_Background.y + this.m_Background.height * 0.5 - this.m_Copy.height * 0.5;
         var usedWidth:Number = this.m_DeclineBtn.width + this.m_AcceptBtn.width;
         var bufferSpace:Number = this.m_Background.width - usedWidth;
         this.m_AcceptBtn.x = this.m_Background.x + bufferSpace * 0.33;
         this.m_AcceptBtn.y = this.m_Background.y + this.m_Background.height * 0.8 - this.m_AcceptBtn.height * 0.5;
         this.m_DeclineBtn.x = this.m_AcceptBtn.x + this.m_AcceptBtn.width + bufferSpace * 0.33;
         this.m_DeclineBtn.y = this.m_Background.y + this.m_Background.height * 0.8 - this.m_DeclineBtn.height * 0.5;
      }
      
      protected function OnAcceptClicked(event:MouseEvent) : void
      {
         var curRGID:String = this.m_App.sessionData.rareGemManager.GetCurrentOffer();
         var soundName:String = "SOUND_RG_HARVEST_" + curRGID.toUpperCase();
         this.m_App.soundManager.playSound(soundName);
         visible = false;
         this.m_App.sessionData.rareGemManager.OnRareGemAwarded(true);
         this.DispatchContinueClicked(true);
      }
      
      protected function OnDeclineClicked(event:MouseEvent) : void
      {
         visible = false;
         this.m_App.sessionData.rareGemManager.OnRareGemAwarded(false);
         this.DispatchContinueClicked(false);
      }
      
      protected function HandleAddCoinsClick(event:MouseEvent) : void
      {
         this.m_App.network.ReportEvent("AddCoinsClick/RareGemMenu");
         this.m_App.network.ShowCart();
      }
   }
}
