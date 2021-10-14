package com.popcap.flash.bejeweledblitz.game.ui.dialogs
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
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
      
      public function ResizableDialog(param1:Blitz3App, param2:String = "IMAGE_BLITZ3GAME_RESIZEABLE_DIALOG_CORNER", param3:String = "IMAGE_BLITZ3GAME_RESIZEABLE_DIALOG_TOP", param4:String = "IMAGE_BLITZ3GAME_RESIZEABLE_DIALOG_SIDE")
      {
         var _loc5_:Matrix = null;
         super();
         this.m_App = param1;
         var _loc6_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc7_:int = 0;
         while(_loc7_ < 3)
         {
            _loc6_[_loc7_] = new Vector.<DisplayObject>(3);
            _loc7_++;
         }
         this.m_TopLeftData = this.m_App.ImageManager.getBitmapData(param2);
         this.m_TopRightData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         (_loc5_ = new Matrix()).scale(-1,1);
         _loc5_.translate(this.m_TopLeftData.width,0);
         this.m_TopRightData.draw(this.m_TopLeftData,_loc5_);
         this.m_BottomLeftData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         (_loc5_ = new Matrix()).scale(1,-1);
         _loc5_.translate(0,this.m_TopLeftData.height);
         this.m_BottomLeftData.draw(this.m_TopLeftData,_loc5_);
         this.m_BottomRightData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,0);
         (_loc5_ = new Matrix()).scale(-1,-1);
         _loc5_.translate(this.m_TopLeftData.width,this.m_TopLeftData.height);
         this.m_BottomRightData.draw(this.m_TopLeftData,_loc5_);
         this.m_TopMiddleData = this.m_App.ImageManager.getBitmapData(param3);
         this.m_BottomMiddleData = new BitmapData(this.m_TopMiddleData.width,this.m_TopMiddleData.height,true,0);
         (_loc5_ = new Matrix()).scale(1,-1);
         _loc5_.translate(0,this.m_TopMiddleData.height);
         this.m_BottomMiddleData.draw(this.m_TopMiddleData,_loc5_);
         this.m_CenterLeftData = this.m_App.ImageManager.getBitmapData(param4);
         this.m_CenterRightData = new BitmapData(this.m_CenterLeftData.width,this.m_CenterLeftData.height,true,0);
         (_loc5_ = new Matrix()).scale(-1,1);
         _loc5_.translate(this.m_CenterLeftData.width,0);
         this.m_CenterRightData.draw(this.m_CenterLeftData,_loc5_);
         this.m_CenterMiddleData = new BitmapData(this.m_TopLeftData.width,this.m_TopLeftData.height,true,this.m_TopMiddleData.getPixel32(0,this.m_TopMiddleData.height - 2));
         _loc6_[0][0] = new Bitmap(this.m_TopLeftData);
         _loc6_[0][1] = new Bitmap(this.m_TopMiddleData);
         _loc6_[0][2] = new Bitmap(this.m_TopRightData);
         _loc6_[1][0] = new Bitmap(this.m_CenterLeftData);
         _loc6_[1][1] = new Bitmap(this.m_CenterMiddleData);
         _loc6_[1][2] = new Bitmap(this.m_CenterRightData);
         _loc6_[2][0] = new Bitmap(this.m_BottomLeftData);
         _loc6_[2][1] = new Bitmap(this.m_BottomMiddleData);
         _loc6_[2][2] = new Bitmap(this.m_BottomRightData);
         super.SetSlices(_loc6_);
      }
      
      override public function SetDimensions(param1:Number, param2:Number) : void
      {
         super.SetDimensions(param1 - m_Slices[1][0].width - m_Slices[1][2].width,param2 - m_Slices[0][0].height - m_Slices[0][2].height);
      }
   }
}
