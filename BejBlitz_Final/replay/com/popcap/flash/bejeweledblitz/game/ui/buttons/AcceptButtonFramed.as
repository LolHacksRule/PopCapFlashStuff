package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class AcceptButtonFramed extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_FrameAccept:ResizableAsset;
      
      protected var m_ButtonAccept:AcceptButton;
      
      public function AcceptButtonFramed(app:Blitz3App, fontSize:int = 14, eventId:String = null, trackId:String = null)
      {
         super();
         this.m_App = app;
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         var buttonCap:Bitmap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FRAME_CAP));
         var flipCapData:BitmapData = new BitmapData(buttonCap.width,buttonCap.height,true,0);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(buttonCap.width,0);
         flipCapData.draw(buttonCap,matrix);
         slices[0][0] = new Bitmap();
         slices[0][1] = new Bitmap();
         slices[0][2] = new Bitmap();
         slices[1][0] = buttonCap;
         slices[1][1] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FRAME_FILL));
         slices[1][2] = new Bitmap(flipCapData);
         slices[2][0] = new Bitmap();
         slices[2][1] = new Bitmap();
         slices[2][2] = new Bitmap();
         this.m_FrameAccept = new ResizableAsset();
         this.m_FrameAccept.SetSlices(slices);
         this.m_FrameAccept.mouseEnabled = false;
         this.m_FrameAccept.mouseChildren = false;
         this.m_ButtonAccept = new AcceptButton(app,fontSize,eventId,trackId);
      }
      
      public function Init() : void
      {
         addChild(this.m_FrameAccept);
         addChild(this.m_ButtonAccept);
         this.m_ButtonAccept.Init();
      }
      
      public function Reset() : void
      {
         this.m_ButtonAccept.Reset();
      }
      
      public function SetText(text:String) : void
      {
         this.m_ButtonAccept.SetText(text);
         this.m_FrameAccept.SetDimensions(this.m_ButtonAccept.GetSliceWidth(1,1) + 8,this.m_FrameAccept.GetSliceHeight(1,1) + 2);
         this.m_ButtonAccept.x = this.m_FrameAccept.x + this.m_FrameAccept.width * 0.5 - this.m_ButtonAccept.width * 0.5;
         this.m_ButtonAccept.y = this.m_FrameAccept.y + this.m_FrameAccept.height * 0.5 - this.m_ButtonAccept.height * 0.5;
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.m_ButtonAccept.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
   }
}
