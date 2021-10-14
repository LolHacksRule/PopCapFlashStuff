package com.popcap.flash.bejeweledblitz.game.ui.gameover
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class MultiSprite extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var _number:Bitmap;
      
      private var _color:Bitmap;
      
      private var _numberIndex:int;
      
      private var _colorIndex:int;
      
      private var _numbers:Array;
      
      private var _colors:Array;
      
      public function MultiSprite(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this._numbers = [null,null,app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X2),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X3),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X4),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X5),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X6),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X7),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_X8)];
         this._colors = [null,app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_RED),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_ORANGE),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_YELLOW),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_GREEN),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_BLUE),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_PURPLE),app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_MULT_WHITE)];
         addChild(this.color);
         addChild(this.number);
      }
      
      public function SetNumber(value:int) : void
      {
         this._numberIndex = value;
         this._number.bitmapData = this._numbers[value];
      }
      
      public function SetColor(value:int) : void
      {
         this._colorIndex = value;
         this._color.bitmapData = this._colors[value];
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
            this._number = new Bitmap(this._numbers[0]);
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -14;
            matrix.ty = -13.5;
            this._number.transform.matrix = matrix;
         }
         return this._number;
      }
      
      private function get color() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._color == null)
         {
            this._color = new Bitmap(this._colors[0]);
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -14;
            matrix.ty = -13.5;
            this._color.transform.matrix = matrix;
         }
         return this._color;
      }
   }
}
