package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class §_-nc§ extends Sprite
   {
       
      
      private var §_-9u§:TextField;
      
      private var §_-e9§:Bitmap;
      
      private var §_-dy§:Class;
      
      private var mApp:§_-0Z§;
      
      private var §_-XD§:TextField;
      
      public function §_-nc§(param1:§_-0Z§)
      {
         this.§_-dy§ = §_-Zj§;
         super();
         this.mApp = param1;
         this.§_-e9§ = new this.§_-dy§();
         this.§_-XD§ = new TextField();
         this.§_-9u§ = new TextField();
      }
      
      public function §_-oZ§(param1:int) : void
      {
         this.§_-XD§.text = §_-Ze§.§_-2P§(param1);
         this.§_-XD§.x = this.§_-e9§.x + this.§_-e9§.width;
         this.§_-9u§.x = this.§_-XD§.x + this.§_-XD§.width;
      }
      
      public function Init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.size = 18;
         _loc1_.color = 16777024;
         _loc1_.font = Blitz3Fonts.§_-Un§;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.size = 30;
         _loc2_.color = 16770048;
         _loc2_.font = Blitz3Fonts.§_-Un§;
         this.§_-XD§.defaultTextFormat = _loc2_;
         this.§_-XD§.embedFonts = true;
         this.§_-XD§.selectable = false;
         this.§_-XD§.autoSize = TextFieldAutoSize.CENTER;
         this.§_-9u§.defaultTextFormat = _loc1_;
         this.§_-9u§.embedFonts = true;
         this.§_-9u§.selectable = false;
         this.§_-9u§.autoSize = TextFieldAutoSize.CENTER;
         var _loc3_:GlowFilter = new GlowFilter(0,1,5,5,8);
         this.§_-XD§.filters = [_loc3_];
         this.§_-9u§.filters = [_loc3_];
         this.§_-XD§.text = "0";
         this.§_-9u§.text = this.mApp.§_-JC§.GetLocString("UI_GAMESTATS_EARNED");
         this.§_-e9§.y = this.§_-XD§.height / 2 - this.§_-e9§.height / 2 - 2;
         this.§_-XD§.y = 0;
         this.§_-XD§.x = this.§_-e9§.x + this.§_-e9§.width;
         this.§_-9u§.y = 11.6;
         addChild(this.§_-e9§);
         addChild(this.§_-9u§);
         addChild(this.§_-XD§);
         this.§_-oZ§(1600);
      }
   }
}
