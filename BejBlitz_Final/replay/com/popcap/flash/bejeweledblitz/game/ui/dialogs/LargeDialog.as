package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class LargeDialog extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      private var m_LeftData:BitmapData;
      
      private var m_RightData:BitmapData;
      
      private var m_TopData:BitmapData;
      
      private var m_BottomData:BitmapData;
      
      private var m_Left:Bitmap;
      
      private var m_Right:Bitmap;
      
      private var m_Top:Bitmap;
      
      private var m_Bottom:Bitmap;
      
      public function LargeDialog(app:Blitz3App, addCoins:Boolean = false)
      {
         var frame:Sprite = null;
         var decoration:Bitmap = null;
         super();
         this.m_App = app;
         this.m_LeftData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_SIDE);
         this.m_RightData = new BitmapData(this.m_LeftData.width,this.m_LeftData.height,true,0);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(this.m_LeftData.width,0);
         this.m_RightData.draw(this.m_LeftData,matrix);
         this.m_TopData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP);
         this.m_BottomData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_BOTTOM);
         this.m_Left = new Bitmap(this.m_LeftData);
         this.m_Right = new Bitmap(this.m_RightData);
         this.m_Top = new Bitmap(this.m_TopData);
         this.m_Bottom = new Bitmap(this.m_BottomData);
         this.m_Top.x = this.m_Left.width;
         this.m_Top.y = 5;
         this.m_Right.x = this.m_Top.x + this.m_Top.width;
         this.m_Bottom.x = this.m_Left.width;
         this.m_Bottom.y = this.m_Left.height - this.m_Bottom.height;
         frame = new Sprite();
         frame.graphics.beginFill(0,0.6);
         frame.graphics.drawRect(this.m_Left.width,this.m_Top.y + this.m_Top.height,this.m_Top.width,this.m_Left.height - (this.m_Top.y + this.m_Top.height) - this.m_Bottom.height);
         frame.graphics.endFill();
         frame.addChild(this.m_Left);
         frame.addChild(this.m_Right);
         frame.addChild(this.m_Top);
         frame.addChild(this.m_Bottom);
         frame.x = 15;
         frame.y = 22;
         if(addCoins)
         {
            decoration = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP_COINS));
            decoration.x = this.m_Top.x + (this.m_Top.width - decoration.width) * 0.5;
         }
         else
         {
            decoration = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_LARGE_DIALOG_TOP_GEM));
            decoration.x = this.m_Top.x + (this.m_Top.width - decoration.width) * 0.5;
            decoration.y = -8;
         }
         frame.addChild(decoration);
         addChild(frame);
      }
   }
}
