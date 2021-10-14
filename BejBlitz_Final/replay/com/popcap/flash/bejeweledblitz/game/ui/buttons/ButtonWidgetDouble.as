package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class ButtonWidgetDouble extends ButtonWidget
   {
       
      
      public function ButtonWidgetDouble(app:Blitz3App)
      {
         super(app);
         var buttonCap:Bitmap = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_CAP));
         var flipCapData:BitmapData = new BitmapData(buttonCap.width,buttonCap.height,true,0);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(buttonCap.width,0);
         flipCapData.draw(buttonCap,matrix);
         var leftSlices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            leftSlices[row] = new Vector.<DisplayObject>(3);
         }
         leftSlices[0][0] = new Bitmap();
         leftSlices[0][1] = new Bitmap();
         leftSlices[0][2] = new Bitmap();
         leftSlices[1][0] = buttonCap;
         leftSlices[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         leftSlices[1][2] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_JOIN));
         leftSlices[2][0] = new Bitmap();
         leftSlices[2][1] = new Bitmap();
         leftSlices[2][2] = new Bitmap();
         m_FrameAccept = new ResizableAsset();
         m_FrameAccept.SetSlices(leftSlices);
         var rightSlices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(row = 0; row < 3; row++)
         {
            rightSlices[row] = new Vector.<DisplayObject>(3);
         }
         rightSlices[0][0] = new Bitmap();
         rightSlices[0][1] = new Bitmap();
         rightSlices[0][2] = new Bitmap();
         rightSlices[1][0] = new Bitmap();
         rightSlices[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         rightSlices[1][2] = new Bitmap(flipCapData);
         rightSlices[2][0] = new Bitmap();
         rightSlices[2][1] = new Bitmap();
         rightSlices[2][2] = new Bitmap();
         m_FrameDecline = new ResizableAsset();
         m_FrameDecline.SetSlices(rightSlices);
         m_ButtonAccept = new AcceptButton(m_App);
         m_ButtonDecline = new DeclineButton(m_App);
         this.Init();
      }
      
      override public function Init() : void
      {
         addChild(m_FrameAccept);
         addChild(m_FrameDecline);
         addChild(m_ButtonDecline);
         addChild(m_ButtonAccept);
         m_ButtonAccept.Init();
         m_ButtonDecline.Init();
      }
      
      override public function SetLabels(acceptLabel:String, declineLabel:String = "") : void
      {
         m_ButtonAccept.SetText(acceptLabel);
         m_ButtonDecline.SetText(declineLabel);
         m_FrameAccept.SetDimensions(m_ButtonDecline.GetSliceWidth(1,1) + 12,m_FrameAccept.GetSliceHeight(1,1));
         m_FrameDecline.SetDimensions(m_ButtonAccept.GetSliceWidth(1,1) + 12,m_FrameDecline.GetSliceHeight(1,1));
         m_FrameAccept.x = 0;
         m_FrameAccept.y = 0;
         m_FrameDecline.x = m_FrameAccept.x + m_FrameAccept.width;
         m_FrameDecline.y = m_FrameAccept.y;
         m_ButtonDecline.x = m_FrameAccept.x + m_FrameAccept.GetSliceWidth(1,0) + m_FrameAccept.GetSliceWidth(1,1) * 0.5 - m_ButtonDecline.width * 0.5;
         m_ButtonDecline.y = -1 + m_FrameAccept.y + m_FrameAccept.height * 0.5 - m_ButtonDecline.height * 0.5;
         m_ButtonAccept.x = m_FrameDecline.x + m_FrameDecline.GetSliceWidth(1,1) * 0.5 - m_ButtonAccept.width * 0.5;
         m_ButtonAccept.y = -1 + m_FrameDecline.y + m_FrameDecline.height * 0.5 - m_ButtonAccept.height * 0.5;
      }
   }
}
