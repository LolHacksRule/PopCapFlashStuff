package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class LegendPopup extends Sprite
   {
       
      
      private var _label:TextField;
      
      private var _element0:Bitmap;
      
      public function LegendPopup()
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function get label() : TextField
      {
         var format:TextFormat = null;
         var matrix:Matrix = null;
         if(this._label == null)
         {
            format = new TextFormat();
            format.font = Blitz3Fonts.BLITZ_STANDARD;
            format.size = 13;
            format.color = 16777215;
            format.align = "center";
            this._label = new TextField();
            this._label.defaultTextFormat = format;
            this._label.embedFonts = true;
            this._label.htmlText = "This is the message for hypers, powers, etc.";
            this._label.x = -184;
            this._label.y = -18.5;
            this._label.width = 172;
            this._label.height = 42;
            this._label.selectable = false;
            this._label.multiline = true;
            this._label.wordWrap = true;
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -185.999;
            matrix.ty = -20.499;
            this._label.transform.matrix = matrix;
            this._label.filters = [new GlowFilter(1191748,1,2,2,4,1,false,false)];
         }
         return this._label;
      }
      
      public function get element0() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._element0 == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -189.999;
            matrix.ty = -22.499;
         }
         return this._element0;
      }
   }
}
