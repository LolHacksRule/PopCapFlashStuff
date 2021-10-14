package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class NavigationBadge extends Sprite
   {
       
      
      private var _app:Blitz3App;
      
      private var _navCounterBackground:NavigationNavButtonCounter;
      
      protected var _navCounterText:TextField;
      
      private var _enabled:Boolean = true;
      
      public function NavigationBadge(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._navCounterBackground = new NavigationNavButtonCounter();
         this._navCounterText = this._navCounterBackground.BadgeCounter;
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,11,16777215);
         _loc2_.align = TextFormatAlign.CENTER;
         this._navCounterText.defaultTextFormat = _loc2_;
         this._navCounterText.autoSize = TextFieldAutoSize.CENTER;
         this._navCounterText.multiline = false;
         this._navCounterText.embedFonts = true;
         this._navCounterText.selectable = false;
         this._navCounterText.mouseEnabled = false;
         this._navCounterText.filters = [new GlowFilter(0,1,2,2,2)];
         addChild(this._navCounterBackground);
         addChild(this._navCounterText);
         this._navCounterBackground.gotoAndStop(1);
      }
      
      protected function setStringValue(param1:String) : void
      {
         this._navCounterText.htmlText = param1;
         this._navCounterText.x = this._navCounterBackground.width * 0.5 - this._navCounterText.width * 0.5;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this._enabled = param1;
         useHandCursor = this._enabled;
         if(this._enabled)
         {
            this._navCounterBackground.gotoAndStop(1);
         }
         else
         {
            this._navCounterBackground.gotoAndStop(2);
         }
      }
      
      public function empty() : Boolean
      {
         return true;
      }
   }
}
