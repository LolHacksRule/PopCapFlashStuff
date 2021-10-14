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
      
      public function AcceptButtonFramed(param1:Blitz3App, param2:int = 14, param3:String = null, param4:String = null)
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
         this.m_FrameAccept = new ResizableAsset();
         this.m_FrameAccept.SetSlices(_loc5_);
         this.m_FrameAccept.mouseEnabled = false;
         this.m_FrameAccept.mouseChildren = false;
         this.m_ButtonAccept = new AcceptButton(param1,param2,param3,param4);
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
      
      public function SetText(param1:String) : void
      {
         this.m_ButtonAccept.SetText(param1);
         this.m_FrameAccept.SetDimensions(this.m_ButtonAccept.GetSliceWidth(1,1) + 8,this.m_FrameAccept.GetSliceHeight(1,1) + 2);
         this.m_ButtonAccept.x = this.m_FrameAccept.x + this.m_FrameAccept.width * 0.5 - this.m_ButtonAccept.width * 0.5;
         this.m_ButtonAccept.y = this.m_FrameAccept.y + this.m_FrameAccept.height * 0.5 - this.m_ButtonAccept.height * 0.5;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.m_ButtonAccept.addEventListener(param1,param2,param3,param4,param5);
      }
   }
}
