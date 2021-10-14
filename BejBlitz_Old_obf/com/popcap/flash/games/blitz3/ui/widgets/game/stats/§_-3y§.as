package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-3y§ extends Sprite
   {
       
      
      private var §_-RN§:TextField;
      
      private var mApp:§_-0Z§;
      
      private var §_-pd§:TextField;
      
      public function §_-3y§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.§_-RN§ = new TextField();
         this.§_-pd§ = new TextField();
      }
      
      public function Init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 30;
         this.§_-RN§.textColor = 16777215;
         this.§_-RN§.filters = [new GlowFilter(0,1,5,5,8)];
         this.§_-RN§.x = 0;
         this.§_-RN§.y = 0;
         this.§_-RN§.defaultTextFormat = _loc1_;
         this.§_-RN§.embedFonts = true;
         this.§_-RN§.selectable = false;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3Fonts.§_-Un§;
         _loc2_.size = 18;
         this.§_-pd§.textColor = 16777215;
         this.§_-pd§.filters = [new GlowFilter(0,1,5,5,8)];
         this.§_-pd§.x = -7;
         this.§_-pd§.y = 12;
         this.§_-pd§.defaultTextFormat = _loc2_;
         this.§_-pd§.embedFonts = true;
         this.§_-pd§.selectable = false;
         this.§_-3K§(500000);
         this.§_-pd§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_PTS");
         addChild(this.§_-pd§);
         addChild(this.§_-RN§);
      }
      
      public function §_-3K§(param1:int) : void
      {
         this.§_-RN§.text = §_-Ze§.§_-2P§(param1);
         this.§_-RN§.width = this.§_-RN§.textWidth + 5;
         this.§_-pd§.x = this.§_-RN§.width - 5;
      }
   }
}
