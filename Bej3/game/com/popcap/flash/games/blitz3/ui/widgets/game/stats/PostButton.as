package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   
   public class PostButton extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _button:FadeButton;
      
      private var _medal:Bitmap;
      
      public function PostButton(app:Blitz3Game)
      {
         super();
         this._app = app;
         addChild(this.button);
         addChild(this.medal);
         this.button.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function SetScore(score:int) : void
      {
         var bd:BitmapData = this._app.starMedalTable.GetMedal(score);
         if(bd == null)
         {
            visible = false;
            return;
         }
         visible = true;
         this.medal.bitmapData = bd;
         this.medal.smoothing = true;
      }
      
      public function get button() : FadeButton
      {
         var matrix:Matrix = null;
         if(this._button == null)
         {
            this._button = new FadeButton(this._app);
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = 36;
            matrix.ty = 4;
            this._button.transform.matrix = matrix;
         }
         return this._button;
      }
      
      public function get medal() : Bitmap
      {
         var matrix:Matrix = null;
         if(this._medal == null)
         {
            this._medal = new Bitmap();
            matrix = new Matrix();
            matrix.a = 1;
            matrix.b = 0;
            matrix.c = 0;
            matrix.d = 1;
            matrix.tx = -2;
            matrix.ty = -2;
            this._medal.transform.matrix = matrix;
         }
         return this._medal;
      }
      
      private function HandleClick(e:MouseEvent) : void
      {
         this._app.network.PostMedal();
      }
   }
}
