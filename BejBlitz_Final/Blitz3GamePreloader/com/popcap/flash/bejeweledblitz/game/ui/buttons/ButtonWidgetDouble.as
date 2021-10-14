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
       
      
      public function ButtonWidgetDouble(param1:Blitz3App)
      {
         super(param1);
         var _loc2_:Bitmap = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_CAP));
         var _loc3_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc4_:Matrix;
         (_loc4_ = new Matrix()).scale(-1,1);
         _loc4_.translate(_loc2_.width,0);
         _loc3_.draw(_loc2_,_loc4_);
         var _loc5_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc5_[_loc6_] = new Vector.<DisplayObject>(3);
            _loc6_++;
         }
         _loc5_[0][0] = new Bitmap();
         _loc5_[0][1] = new Bitmap();
         _loc5_[0][2] = new Bitmap();
         _loc5_[1][0] = _loc2_;
         _loc5_[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         _loc5_[1][2] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_JOIN));
         _loc5_[2][0] = new Bitmap();
         _loc5_[2][1] = new Bitmap();
         _loc5_[2][2] = new Bitmap();
         m_FrameAccept = new ResizableAsset();
         m_FrameAccept.SetSlices(_loc5_);
         var _loc7_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc7_[_loc6_] = new Vector.<DisplayObject>(3);
            _loc6_++;
         }
         _loc7_[0][0] = new Bitmap();
         _loc7_[0][1] = new Bitmap();
         _loc7_[0][2] = new Bitmap();
         _loc7_[1][0] = new Bitmap();
         _loc7_[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         _loc7_[1][2] = new Bitmap(_loc3_);
         _loc7_[2][0] = new Bitmap();
         _loc7_[2][1] = new Bitmap();
         _loc7_[2][2] = new Bitmap();
         m_FrameDecline = new ResizableAsset();
         m_FrameDecline.SetSlices(_loc7_);
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
      
      override public function SetLabels(param1:String, param2:String = "") : void
      {
         m_ButtonAccept.SetText(param1);
         m_ButtonDecline.SetText(param2);
         m_FrameAccept.SetDimensions(m_ButtonDecline.GetSliceWidth(1,1) + 12,m_FrameAccept.GetSliceHeight(1,1));
         m_FrameDecline.SetDimensions(m_ButtonAccept.GetSliceWidth(1,1) + 12,m_FrameDecline.GetSliceHeight(1,1));
         m_FrameAccept.x = 0;
         m_FrameAccept.y = 0;
         m_FrameDecline.x = m_FrameAccept.x + m_FrameAccept.width;
         m_FrameDecline.y = m_FrameAccept.y;
         m_ButtonDecline.x = m_FrameAccept.x + m_FrameAccept.GetSliceWidth(1,0) + m_FrameAccept.GetSliceWidth(1,1) * 0.5 - m_ButtonDecline.width * 0.5;
         m_ButtonDecline.y = -11 + m_FrameAccept.y + m_FrameAccept.height * 0.5 - m_ButtonDecline.height * 0.5;
         m_ButtonAccept.x = m_FrameDecline.x + m_FrameDecline.GetSliceWidth(1,1) * 0.5 + m_ButtonAccept.width * 0.5;
         m_ButtonAccept.y = -11 + m_FrameDecline.y + m_FrameDecline.height * 0.5 - m_ButtonAccept.height * 0.5;
      }
   }
}
