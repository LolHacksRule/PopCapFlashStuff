package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class ResizableDialog extends ResizableAsset
   {
       
      
      protected var m_App:Blitz3App;
      
      private var m_TopLeftData:BitmapData;
      
      private var m_TopMiddleData:BitmapData;
      
      private var m_TopRightData:BitmapData;
      
      private var m_CenterLeftData:BitmapData;
      
      private var m_CenterMiddleData:BitmapData;
      
      private var m_CenterRightData:BitmapData;
      
      private var m_BottomLeftData:BitmapData;
      
      private var m_BottomMiddleData:BitmapData;
      
      private var m_BottomRightData:BitmapData;
      
      public function ResizableDialog(app:Blitz3App)
      {
         var matrix:Matrix = null;
         super();
         this.m_App = app;
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         this.m_TopLeftData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RESIZEABLE_DIALOG_CORNER);
         this.m_TopRightData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(this.m_TopLeftData.width,0);
         this.m_TopRightData.draw(this.m_TopLeftData,matrix);
         this.m_BottomLeftData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         matrix = new Matrix();
         matrix.scale(1,-1);
         matrix.translate(0,this.m_TopLeftData.height);
         this.m_BottomLeftData.draw(this.m_TopLeftData,matrix);
         this.m_BottomRightData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         matrix = new Matrix();
         matrix.scale(-1,-1);
         matrix.translate(this.m_TopLeftData.width,this.m_TopLeftData.height);
         this.m_BottomRightData.draw(this.m_TopLeftData,matrix);
         this.m_TopMiddleData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RESIZEABLE_DIALOG_TOP);
         this.m_BottomMiddleData = new BitmapData(this.m_TopMiddleData.width,this.m_TopMiddleData.height,true,0);
         matrix = new Matrix();
         matrix.scale(1,-1);
         matrix.translate(0,this.m_TopMiddleData.height);
         this.m_BottomMiddleData.draw(this.m_TopMiddleData,matrix);
         this.m_CenterLeftData = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RESIZEABLE_DIALOG_SIDE);
         this.m_CenterRightData = new BitmapData(this.m_CenterLeftData.width,this.m_CenterLeftData.height,true,0);
         matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(this.m_CenterLeftData.width,0);
         this.m_CenterRightData.draw(this.m_CenterLeftData,matrix);
         this.m_CenterMiddleData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,4284945719);
         slices[0][0] = new Bitmap(this.m_TopLeftData);
         slices[0][1] = new Bitmap(this.m_TopMiddleData);
         slices[0][2] = new Bitmap(this.m_TopRightData);
         slices[1][0] = new Bitmap(this.m_CenterLeftData);
         slices[1][1] = new Bitmap(this.m_CenterMiddleData);
         slices[1][2] = new Bitmap(this.m_CenterRightData);
         slices[2][0] = new Bitmap(this.m_BottomLeftData);
         slices[2][1] = new Bitmap(this.m_BottomMiddleData);
         slices[2][2] = new Bitmap(this.m_BottomRightData);
         super.SetSlices(slices);
      }
      
      override public function SetDimensions(w:Number, h:Number) : void
      {
         super.SetDimensions(w - m_Slices[1][0].width - m_Slices[1][2].width,h);
      }
   }
}
