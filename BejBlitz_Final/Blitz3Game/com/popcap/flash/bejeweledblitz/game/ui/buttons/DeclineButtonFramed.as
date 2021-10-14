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
      
      public function DeclineButtonFramed(param1:Blitz3App, param2:int = 14, param3:String = null, param4:String = null)
      {
         super();
         this.m_App = param1;
         var _loc5_:Vector.<Vector.<DisplayObject>> = new Vector.<Vector.<DisplayObject>>(3);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc5_[_loc6_] = new Vector.<DisplayObject>(3);
            _loc6_++;
         }
         var _loc7_:Bitmap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FRAME_CAP));
         var _loc8_:BitmapData = new BitmapData(_loc7_.width,_loc7_.height,true,0);
         var _loc9_:Matrix;
         (_loc9_ = new Matrix()).scale(-1,1);
         _loc9_.translate(_loc7_.width,0);
         _loc8_.draw(_loc7_,_loc9_);
         _loc5_[0][0] = new Bitmap();
         _loc5_[0][1] = new Bitmap();
         _loc5_[0][2] = new Bitmap();
         _loc5_[1][0] = _loc7_;
         _loc5_[1][1] = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_FRAME_FILL));
         _loc5_[1][2] = new Bitmap(_loc8_);
         _loc5_[2][0] = new Bitmap();
         _loc5_[2][1] = new Bitmap();
         _loc5_[2][2] = new Bitmap();
         this.m_FrameDecline = new ResizableAsset();
         this.m_FrameDecline.SetSlices(_loc5_);
         this.m_ButtonDecline = new DeclineButton(param1,param2,param3,param4);
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
      
      public function SetText(param1:String) : void
      {
         this.m_ButtonDecline.SetText(param1);
         this.m_FrameDecline.SetDimensions(this.m_ButtonDecline.GetSliceWidth(1,1) + 8,this.m_FrameDecline.GetSliceHeight(1,1) + 2);
         this.m_ButtonDecline.x = this.m_FrameDecline.x + this.m_FrameDecline.width * 0.5 - this.m_ButtonDecline.width * 0.5;
         this.m_ButtonDecline.y = this.m_FrameDecline.y + this.m_FrameDecline.height * 0.5 - this.m_ButtonDecline.height * 0.5;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.m_ButtonDecline.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}
