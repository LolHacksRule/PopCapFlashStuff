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
   
   public class DeclineButtonFramed extends Sprite
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_FrameDecline:ResizableAsset;
      
      protected var m_ButtonDecline:DeclineButton;
      
      public function DeclineButtonFramed(app:Blitz3App, fontSize:int = 14, eventId:String = null, trackId:String = null)
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
         this.m_FrameDecline = new ResizableAsset();
         this.m_FrameDecline.SetSlices(slices);
         this.m_ButtonDecline = new DeclineButton(app,fontSize,eventId,trackId);
      }
      
      public function Init() : void
      {
         addChild(this.m_FrameDecline);
         addChild(this.m_ButtonDecline);
         this.m_ButtonDecline.Init();
      }
      
      public function Reset() : void
      {
         this.m_ButtonDecline.Reset();
      }
      
      public function SetText(text:String) : void
      {
         this.m_ButtonDecline.SetText(text);
         this.m_FrameDecline.SetDimensions(this.m_ButtonDecline.GetSliceWidth(1,1) + 8,this.m_FrameDecline.GetSliceHeight(1,1) + 2);
         this.m_ButtonDecline.x = this.m_FrameDecline.x + this.m_FrameDecline.width * 0.5 - this.m_ButtonDecline.width * 0.5;
         this.m_ButtonDecline.y = this.m_FrameDecline.y + this.m_FrameDecline.height * 0.5 - this.m_ButtonDecline.height * 0.5;
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.m_ButtonDecline.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
   }
}
