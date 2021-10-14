package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class §_-Zg§ extends Sprite
   {
      
      public static const CENTER:String = "center";
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
       
      
      private var §_-dI§:Class;
      
      private var §_-fT§:Class;
      
      private var §_-H1§:TextField;
      
      private var §_-Ro§:Bitmap;
      
      private var §_-Ak§:Bitmap;
      
      private var §_-80§:TextField;
      
      private var §_-SY§:§_-FF§;
      
      public function §_-Zg§()
      {
         this.§_-fT§ = §_-3u§;
         this.§_-dI§ = §_-hd§;
         super();
         addChild(this.§_-0K§);
         addChild(this.§_-Gz§);
         addChild(this.§_-bB§);
         addChild(this.§_-a3§);
         addChild(this.cost);
         mouseEnabled = false;
      }
      
      public function get §_-Gz§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-Ro§ == null)
         {
            this.§_-Ro§ = new this.§_-dI§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -131.999;
            _loc1_.ty = -10.999;
            this.§_-Ro§.transform.matrix = _loc1_;
         }
         return this.§_-Ro§;
      }
      
      public function get cost() : §_-FF§
      {
         if(this.§_-SY§ == null)
         {
            this.§_-SY§ = new §_-FF§();
            this.§_-SY§.§_-NW§(221,21.3);
            this.§_-SY§.x = -42;
            this.§_-SY§.y = 70;
         }
         return this.§_-SY§;
      }
      
      public function §_-5q§(param1:String) : void
      {
         this.§_-a3§.text = param1;
      }
      
      public function get §_-bB§() : TextField
      {
         var _loc1_:TextFormat = null;
         if(this.§_-80§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 16;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-80§ = new TextField();
            this.§_-80§.defaultTextFormat = _loc1_;
            this.§_-80§.embedFonts = true;
            this.§_-80§.text = "";
            this.§_-80§.width = 221;
            this.§_-80§.height = 30.05;
            this.§_-80§.selectable = false;
            this.§_-80§.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
         }
         return this.§_-80§;
      }
      
      public function §_-j3§(param1:String) : void
      {
         switch(param1)
         {
            case "left":
               this.§_-ZW§();
               break;
            case "center":
               this.§_-Ml§();
               break;
            case "right":
               this.§_-Ie§();
               break;
            default:
               trace("unknown caret position: " + param1);
         }
      }
      
      public function get §_-a3§() : TextField
      {
         var _loc1_:TextFormat = null;
         if(this.§_-H1§ == null)
         {
            _loc1_ = new TextFormat();
            _loc1_.font = Blitz3Fonts.§_-Un§;
            _loc1_.size = 12;
            _loc1_.color = 16777215;
            _loc1_.align = "center";
            this.§_-H1§ = new TextField();
            this.§_-H1§.defaultTextFormat = _loc1_;
            this.§_-H1§.embedFonts = true;
            this.§_-H1§.text = "";
            this.§_-H1§.width = 224;
            this.§_-H1§.height = 40.6;
            this.§_-H1§.selectable = false;
            this.§_-H1§.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            this.§_-H1§.multiline = true;
            this.§_-H1§.wordWrap = true;
         }
         return this.§_-H1§;
      }
      
      public function §_-ZW§() : void
      {
         this.§_-Ak§.visible = true;
         this.§_-Ro§.visible = false;
         var _loc1_:Matrix = null;
         _loc1_ = this.§_-80§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -32;
         _loc1_.ty = 15;
         this.§_-80§.transform.matrix = _loc1_;
         _loc1_ = this.§_-H1§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -33;
         _loc1_.ty = 35;
         this.§_-H1§.transform.matrix = _loc1_;
         _loc1_ = this.§_-SY§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -32;
         _loc1_.ty = 70;
         this.§_-SY§.transform.matrix = _loc1_;
         _loc1_ = this.§_-Ak§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -51.999;
         _loc1_.ty = -12;
         this.§_-Ak§.transform.matrix = _loc1_;
      }
      
      public function §_-Hj§(param1:String) : void
      {
         this.§_-bB§.text = param1;
      }
      
      public function §_-Ie§() : void
      {
         this.§_-Ak§.visible = true;
         this.§_-Ro§.visible = false;
         var _loc1_:Matrix = null;
         _loc1_ = this.§_-80§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -188;
         _loc1_.ty = 15;
         this.§_-80§.transform.matrix = _loc1_;
         _loc1_ = this.§_-H1§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -189;
         _loc1_.ty = 35;
         this.§_-H1§.transform.matrix = _loc1_;
         _loc1_ = this.§_-SY§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -188;
         _loc1_.ty = 70;
         this.§_-SY§.transform.matrix = _loc1_;
         _loc1_ = this.§_-Ak§.transform.matrix;
         _loc1_.a = -1.0000457763671875;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = 54;
         _loc1_.ty = -12;
         this.§_-Ak§.transform.matrix = _loc1_;
      }
      
      public function get §_-0K§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-Ak§ == null)
         {
            this.§_-Ak§ = new this.§_-fT§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -51.999;
            _loc1_.ty = -11.999;
            this.§_-Ak§.transform.matrix = _loc1_;
         }
         return this.§_-Ak§;
      }
      
      public function §_-Ml§() : void
      {
         this.§_-Ak§.visible = false;
         this.§_-Ro§.visible = true;
         var _loc1_:Matrix = null;
         _loc1_ = this.§_-80§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -112;
         _loc1_.ty = 15;
         this.§_-80§.transform.matrix = _loc1_;
         _loc1_ = this.§_-H1§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -113;
         _loc1_.ty = 35;
         this.§_-H1§.transform.matrix = _loc1_;
         _loc1_ = this.§_-SY§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -112;
         _loc1_.ty = 70;
         this.§_-SY§.transform.matrix = _loc1_;
         _loc1_ = this.§_-Ro§.transform.matrix;
         _loc1_.a = 1;
         _loc1_.b = 0;
         _loc1_.c = 0;
         _loc1_.d = 1;
         _loc1_.tx = -131.999;
         _loc1_.ty = -12;
         this.§_-Ro§.transform.matrix = _loc1_;
      }
   }
}
