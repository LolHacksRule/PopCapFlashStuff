package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class §_-FF§ extends Sprite
   {
       
      
      private var §_-0k§:int = 0;
      
      private var §_-GE§:int = 0;
      
      private var §_-kD§:TextField;
      
      private var §_-Cj§:TextField;
      
      private var §_-F4§:Class;
      
      private var §_-TV§:Bitmap;
      
      public function §_-FF§()
      {
         this.§_-F4§ = §_-eW§;
         super();
         this.§_-TV§ = new this.§_-F4§() as Bitmap;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 12;
         _loc1_.color = 16777215;
         _loc1_.align = "left";
         this.§_-kD§ = new TextField();
         this.§_-kD§.defaultTextFormat = _loc1_;
         this.§_-kD§.embedFonts = true;
         this.§_-kD§.text = "0";
         this.§_-kD§.selectable = false;
         this.§_-kD§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-Cj§ = new TextField();
         this.§_-Cj§.defaultTextFormat = _loc1_;
         this.§_-Cj§.embedFonts = true;
         this.§_-Cj§.text = "";
         this.§_-Cj§.selectable = false;
         this.§_-Cj§.autoSize = TextFieldAutoSize.RIGHT;
         this.§_-kD§.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
         this.§_-Cj§.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
         addChild(this.§_-Cj§);
         addChild(this.§_-kD§);
         addChild(this.§_-TV§);
      }
      
      public function §_-Rs§(param1:uint) : void
      {
         this.§_-Cj§.textColor = param1;
         this.§_-kD§.textColor = param1;
      }
      
      public function §_-NW§(param1:int, param2:int) : void
      {
         this.§_-GE§ = param1;
         this.§_-0k§ = param2;
         this.§_-TV§.y = param2 / 2 - this.§_-TV§.height / 2 - 1;
         this.§_-ge§();
      }
      
      public function §_-63§() : void
      {
         this.§_-TV§.visible = false;
         this.§_-Cj§.visible = false;
         this.§_-ge§();
      }
      
      public function SetText(param1:String, param2:String) : void
      {
         this.§_-Cj§.text = param1;
         this.§_-kD§.text = param2;
         this.§_-ge§();
      }
      
      private function §_-ge§() : void
      {
         var _loc1_:int = 0;
         if(this.§_-TV§.visible)
         {
            _loc1_ = this.§_-Cj§.width + this.§_-TV§.width + this.§_-kD§.width;
            this.§_-Cj§.x = this.§_-GE§ / 2 - _loc1_ / 2;
            this.§_-TV§.x = this.§_-Cj§.x + this.§_-Cj§.width;
            this.§_-kD§.x = this.§_-TV§.x + this.§_-TV§.width;
         }
         else
         {
            this.§_-kD§.x = this.§_-GE§ / 2 - this.§_-kD§.width / 2;
         }
      }
      
      public function §_-ny§() : void
      {
         this.§_-TV§.visible = true;
         this.§_-Cj§.visible = true;
         this.§_-ge§();
      }
   }
}
