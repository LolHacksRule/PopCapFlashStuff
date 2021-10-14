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
       
      
      public function ButtonWidgetSingle(param1:Blitz3App)
      {
         super(param1);
         var _loc2_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc2_[_loc3_] = new Vector.<DisplayObject>(3);
            _loc3_++;
         }
         var _loc4_:Bitmap = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_CAP));
         var _loc5_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         var _loc6_:Matrix;
         (_loc6_ = new Matrix()).scale(-1,1);
         _loc6_.translate(_loc4_.width,0);
         _loc5_.draw(_loc4_,_loc6_);
         _loc2_[0][0] = new Bitmap();
         _loc2_[0][1] = new Bitmap();
         _loc2_[0][2] = new Bitmap();
         _loc2_[1][0] = _loc4_;
         _loc2_[1][1] = new Bitmap(m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FANCY_FRAME_FILL));
         _loc2_[1][2] = new Bitmap(_loc5_);
         _loc2_[2][0] = new Bitmap();
         _loc2_[2][1] = new Bitmap();
         _loc2_[2][2] = new Bitmap();
         m_FrameAccept = new ResizableAsset();
         m_FrameAccept.SetSlices(_loc2_);
         m_ButtonAccept = new AcceptButton(m_App);
         this.Init();
      }
      
      override public function Init() : void
      {
         addChild(m_FrameAccept);
         addChild(m_ButtonAccept);
         m_ButtonAccept.Init();
      }
      
      override public function SetLabels(param1:String, param2:String = "") : void
      {
         m_ButtonAccept.SetText(param1);
         m_FrameAccept.SetDimensions(m_ButtonAccept.GetSliceWidth(1,1) + 12,m_FrameAccept.GetSliceHeight(1,1));
         m_ButtonAccept.x = m_FrameAccept.x + m_FrameAccept.width * 0.5 - m_ButtonAccept.width * 0.5;
         m_ButtonAccept.y = -1 + m_FrameAccept.y + m_FrameAccept.height * 0.5 - m_ButtonAccept.height * 0.5;
      }
   }
}
