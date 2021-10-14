package com.popcap.flash.bejeweledblitz.topHUD
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.currency.CurrencyManager;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.party.PartyServerIO;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.TooltipGeneric;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class HUDCurrencyContainer extends CurrencyContainer
   {
      
      public static const DEFAULT_COLOR:int = 16777215;
       
      
      public var currencyType:String;
      
      private var _enabled:Boolean;
      
      protected var _app:Blitz3Game;
      
      protected var _addCurrency:GenericButtonClip;
      
      private var _currencyImage:MovieClip;
      
      private var _addCurrencyTooltip:TooltipGeneric;
      
      protected var _currencyGained:Number = 0;
      
      public function HUDCurrencyContainer(param1:Blitz3Game, param2:String)
      {
         var _loc3_:CurrencyManager = null;
         super();
         this._app = param1;
         this.currencyType = param2;
         _loc3_ = this._app.sessionData.userData.currencyManager;
         var _loc4_:TextFormat;
         (_loc4_ = new TextFormat()).font = Blitz3GameFonts.FONT_BLITZ_STANDARD;
         _loc4_.size = 18;
         _loc4_.align = TextFormatAlign.LEFT;
         txtValue.setTextFormat(_loc4_);
         txtValue.textColor = DEFAULT_COLOR;
         txtValue.embedFonts = true;
         txtValue.selectable = false;
         txtValue.autoSize = TextFieldAutoSize.LEFT;
         txtValue.text = _loc3_.GetCurrencyByType(this.currencyType).toString();
         txtValue.mouseEnabled = false;
         this._addCurrency = new GenericButtonClip(this._app,CurrencyManager.getImageByType(this.currencyType,true));
         this._addCurrency.setPress(this.handleCartOpen);
         currencyAdd_placeholder.addChild(this._addCurrency.clipListener);
         this._currencyImage = CurrencyManager.getImageByType(this.currencyType,false);
         currencyImage_placeholder.addChild(this._currencyImage);
         this._addCurrencyTooltip = new TooltipGeneric();
         var _loc5_:* = "LOC_BLITZ3GAME_" + _loc3_.getCurrencyName(this.currencyType).toUpperCase() + "_TOOLTIP";
         this._addCurrencyTooltip.tooltipMC.txt.htmlText = this._app.TextManager.GetLocString(_loc5_);
         this._addCurrencyTooltip.visible = false;
         this.addEventListener(MouseEvent.MOUSE_OVER,this.handleCartOver);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.handleCartOut);
         this.buttonMode = true;
         this.useHandCursor = true;
         this.resetEnabledImages();
      }
      
      public function updateValue(param1:Number) : void
      {
         this.txtValue.text = Utils.commafy(param1);
         this._currencyGained = param1;
      }
      
      public function isEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setPurchaseDisabled() : void
      {
         this._addCurrency.SetDisabled(true);
         this._addCurrency.clipListener.alpha = 0.4;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this._enabled = param1;
         useHandCursor = this._enabled;
         buttonMode = this._enabled;
         this.resetEnabledImages();
      }
      
      protected function resetEnabledImages() : void
      {
         if(this._enabled)
         {
            alpha = 1;
            this._addCurrency.SetDisabled(false);
            this._addCurrency.clipListener.alpha = 1;
         }
         else
         {
            alpha = 0.4;
            this._addCurrency.SetDisabled(true);
            this._addCurrency.clipListener.alpha = 0.4;
         }
      }
      
      public function handleCartOpen() : void
      {
         this._addCurrencyTooltip.gotoAndStop(1);
         if(this.currencyType != CurrencyManager.TYPE_TOKENS)
         {
            this._app.party.stopStatusCountdown();
            this._app.network.ShowCart("navBuyCoins",this.currencyType);
         }
         else
         {
            this._app.party.stopStatusCountdown();
            PartyServerIO.sendBuyTokens();
         }
      }
      
      public function handleCartOver(param1:Event) : void
      {
         if(this.isEnabled() && this._addCurrency.clipListener.visible)
         {
            Utils.removeAllChildrenFrom(Tooltip_placeholder);
            Tooltip_placeholder.addChild(this._addCurrencyTooltip);
            this._addCurrencyTooltip.gotoAndPlay(2);
            this._addCurrencyTooltip.visible = true;
         }
      }
      
      public function handleCartOut(param1:Event) : void
      {
         if(this.isEnabled() && this._addCurrency.clipListener.visible)
         {
            Utils.removeAllChildrenFrom(Tooltip_placeholder);
            this._addCurrencyTooltip.visible = false;
         }
      }
   }
}
