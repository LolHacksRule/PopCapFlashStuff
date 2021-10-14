package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class MultiSprite extends Sprite
   {
       
      
      private var _number:Bitmap;
      
      private var _color:Bitmap;
      
      private var _numberIndex:int;
      
      private var _colorIndex:int;
      
      public function MultiSprite()
      {
         super();
         addChild(this.color);
         addChild(this.number);
      }
      
      public function SetNumber(value:int) : void
      {
         this._numberIndex = value;
      }
      
      public function SetColor(value:int) : void
      {
         this._colorIndex = value;
      }
      
      public function GetNumber() : int
      {
         return this._numberIndex;
      }
      
      public function GetColor() : int
      {
         return this._colorIndex;
      }
      
      private function get number() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._number == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -13.999;
            matrix.ty = -13.499;
            this._number.transform.matrix = matrix;
         }
         return this._number;
      }
      
      private function get color() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._color == null)
         {
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -13.999;
            matrix.ty = -13.499;
            this._color.transform.matrix = matrix;
         }
         return this._color;
      }
   }
}
