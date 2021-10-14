package com.popcap.flash.bejeweledblitz.game.ui.buttons
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.ui.ResizableAsset;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   
   public class ButtonWidgetSingle extends ButtonWidget
   {
       
      
      public function ButtonWidgetSingle(app:Blitz3App)
      {
         super(app);
         var slices:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         for(var row:int = 0; row < 3; row++)
         {
            slices[row] = new Vector.<DisplayObject>(3);
         }
         var buttonCap:Bitmap = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_CAP));
         var flipCapData:BitmapData = new BitmapData(buttonCap.width,buttonCap.height,true,0);
         var matrix:Matrix = new Matrix();
         matrix.scale(-1,1);
         matrix.translate(buttonCap.width,0);
         flipCapData.draw(buttonCap,matrix);
         slices[0][0] = new Bitmap();
         slices[0][1] = new Bitmap();
         slices[0][2] = new Bitmap();
         slices[1][0] = buttonCap;
         slices[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         slices[1][2] = new Bitmap(flipCapData);
         slices[2][0] = new Bitmap();
         slices[2][1] = new Bitmap();
         slices[2][2] = new Bitmap();
         m_FrameAccept = new ResizableAsset();
         m_FrameAccept.SetSlices(slices);
         m_ButtonAccept = new AcceptButton(m_App);
         this.Init();
      }
      
      override public function Init() : void
      {
         addChild(m_FrameAccept);
         addChild(m_ButtonAccept);
         m_ButtonAccept.Init();
      }
      
      override public function SetLabels(acceptLabel:String, declineLabel:String = "") : void
      {
         m_ButtonAccept.SetText(acceptLabel);
         m_FrameAccept.SetDimensions(m_ButtonAccept.GetSliceWidth(1,1) + 12,m_FrameAccept.GetSliceHeight(1,1));
         m_ButtonAccept.x = m_FrameAccept.x + m_FrameAccept.width * 0.5 - m_ButtonAccept.width * 0.5;
         m_ButtonAccept.y = -1 + m_FrameAccept.y + m_FrameAccept.height * 0.5 - m_ButtonAccept.height * 0.5;
      }
   }
}
