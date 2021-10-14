package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class §_-7C§ extends Sprite
   {
      
      public static const §_-PU§:int = 16711680;
      
      public static const §_-iQ§:int = 16777024;
       
      
      private var §_-0k§:int = 0;
      
      private var §_-GE§:int = 0;
      
      private var §_-kD§:TextField;
      
      private var §_-m2§:Class;
      
      private var §_-TV§:Bitmap;
      
      public function §_-7C§()
      {
         this.§_-m2§ = §_-jv§;
         super();
         this.§_-TV§ = new this.§_-m2§() as Bitmap;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 16;
         _loc1_.color = §_-iQ§;
         _loc1_.align = "left";
         this.§_-kD§ = new TextField();
         this.§_-kD§.defaultTextFormat = _loc1_;
         this.§_-kD§.embedFonts = true;
         this.§_-kD§.text = "0";
         this.§_-kD§.height = 27.05;
         this.§_-kD§.selectable = false;
         this.§_-kD§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-kD§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         addChild(this.§_-kD§);
         addChild(this.§_-TV§);
      }
      
      public function §_-1N§() : void
      {
         this.§_-TV§.visible = false;
         this.§_-kD§.x = 0;
      }
      
      public function §_-NW§(param1:int, param2:int) : void
      {
         this.§_-GE§ = param1;
         this.§_-0k§ = param2;
         this.§_-TV§.y = param2 / 2 - this.§_-TV§.height / 2 - 1;
         this.§_-ge§();
      }
      
      public function SetText(param1:String) : void
      {
         var value:String = param1;
         this.§_-kD§.text = value;
         this.§_-kD§.x = this.§_-TV§.width;
         var format:TextFormat = this.§_-kD§.defaultTextFormat;
         format.color = §_-iQ§;
         try
         {
            if(int(value.replace(",","")) < 0)
            {
               format.color = §_-PU§;
            }
         }
         catch(err:Error)
         {
         }
         this.§_-kD§.setTextFormat(format);
         this.§_-ge§();
      }
      
      private function §_-ge§() : void
      {
         var _loc1_:int = this.§_-TV§.width + this.§_-kD§.width;
         this.§_-TV§.x = this.§_-GE§ / 2 - _loc1_ / 2;
         this.§_-kD§.x = this.§_-TV§.x + this.§_-TV§.width;
      }
      
      public function §_-fm§() : void
      {
         this.§_-TV§.visible = true;
         this.§_-kD§.x = this.§_-TV§.width;
      }
   }
}
