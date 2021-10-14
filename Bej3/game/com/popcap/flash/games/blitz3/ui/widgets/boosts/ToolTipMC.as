package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class ToolTipMC extends Sprite
   {
      
      public static const LEFT:String = "left";
      
      public static const RIGHT:String = "right";
      
      public static const CENTER:String = "center";
       
      
      private var _bgSide:Bitmap;
      
      private var _bgMiddle:Bitmap;
      
      private var _title:TextField;
      
      private var _bodyText:TextField;
      
      private var _cost:SmallCoinLabel;
      
      public function ToolTipMC()
      {
         super();
         mouseEnabled = false;
      }
      
      public function SetCaret(caretSide:String) : void
      {
         switch(caretSide)
         {
            case "left":
               this.LayoutLeft();
               break;
            case "center":
               this.LayoutCenter();
               break;
            case "right":
               this.LayoutRight();
               break;
            default:
               trace("unknown caret position: " + caretSide);
         }
      }
      
      public function SetTitle(titleString:String) : void
      {
         this.title.htmlText = titleString;
      }
      
      public function SetBodyText(i_bodyText:String) : void
      {
         this.bodyText.htmlText = i_bodyText;
      }
      
      public function LayoutLeft() : void
      {
         this._bgSide.visible = true;
         this._bgMiddle.visible = false;
         var matrix:Matrix = null;
         matrix = this._title.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -32;
         matrix.ty = 15;
         this._title.transform.matrix = matrix;
         matrix = this._bodyText.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -33;
         matrix.ty = 35;
         this._bodyText.transform.matrix = matrix;
         matrix = this._cost.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -32;
         matrix.ty = 70;
         this._cost.transform.matrix = matrix;
         matrix = this._bgSide.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -51.999;
         matrix.ty = -12;
         this._bgSide.transform.matrix = matrix;
      }
      
      public function LayoutRight() : void
      {
         this._bgSide.visible = true;
         this._bgMiddle.visible = false;
         var matrix:Matrix = null;
         matrix = this._title.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -188;
         matrix.ty = 15;
         this._title.transform.matrix = matrix;
         matrix = this._bodyText.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -189;
         matrix.ty = 35;
         this._bodyText.transform.matrix = matrix;
         matrix = this._cost.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -188;
         matrix.ty = 70;
         this._cost.transform.matrix = matrix;
         matrix = this._bgSide.transform.matrix;
         matrix.a = -1.0000457763671875;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = 54;
         matrix.ty = -12;
         this._bgSide.transform.matrix = matrix;
      }
      
      public function LayoutCenter() : void
      {
         this._bgSide.visible = false;
         this._bgMiddle.visible = true;
         var matrix:Matrix = null;
         matrix = this._title.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -112;
         matrix.ty = 15;
         this._title.transform.matrix = matrix;
         matrix = this._bodyText.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -113;
         matrix.ty = 35;
         this._bodyText.transform.matrix = matrix;
         matrix = this._cost.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -112;
         matrix.ty = 70;
         this._cost.transform.matrix = matrix;
         matrix = this._bgMiddle.transform.matrix;
         matrix.a = 1;
         matrix.b = 0;
         matrix.c = 0;
         matrix.d = 1;
         matrix.tx = -131.999;
         matrix.ty = -12;
         this._bgMiddle.transform.matrix = matrix;
      }
      
      public function get title() : TextField
      {
         var format:TextFormat = null;
         if(this._title == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 16;
            format.color = 16777215;
            format.align = "center";
            this._title = new TextField();
            this._title.defaultTextFormat = format;
            this._title.embedFonts = true;
            this._title.htmlText = "";
            this._title.width = 221;
            this._title.height = 30.05;
            this._title.selectable = false;
            this._title.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
         }
         return this._title;
      }
      
      public function get bodyText() : TextField
      {
         var format:TextFormat = null;
         if(this._bodyText == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 12;
            format.color = 16777215;
            format.align = "center";
            this._bodyText = new TextField();
            this._bodyText.defaultTextFormat = format;
            this._bodyText.embedFonts = true;
            this._bodyText.htmlText = "";
            this._bodyText.width = 224;
            this._bodyText.height = 40.6;
            this._bodyText.selectable = false;
            this._bodyText.filters = [new GlowFilter(0,1,5,5,1,1,false,false)];
            this._bodyText.multiline = true;
            this._bodyText.wordWrap = true;
         }
         return this._bodyText;
      }
      
      public function get cost() : SmallCoinLabel
      {
         if(this._cost == null)
         {
            this._cost = new SmallCoinLabel();
            this._cost.SetSize(221,21.3);
            this._cost.x = -42;
            this._cost.y = 70;
         }
         return this._cost;
      }
      
      public function get bgSide() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._bgSide == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -51.999;
            matrix.ty = -11.999;
            this._bgSide.transform.matrix = matrix;
         }
         return this._bgSide;
      }
      
      public function get bgMiddle() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._bgMiddle == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -131.999;
            matrix.ty = -10.999;
            this._bgMiddle.transform.matrix = matrix;
         }
         return this._bgMiddle;
      }
   }
}
