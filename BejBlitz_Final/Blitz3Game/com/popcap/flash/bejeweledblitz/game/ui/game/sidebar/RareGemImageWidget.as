package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RareGemImageWidget extends Sprite
   {
       
      
      private var _app:Blitz3App;
      
      private var _loader:DynamicRareGemImageLoader;
      
      private var _image:Bitmap;
      
      private var _dynamicGemImageKey:String;
      
      private var _centerAlign:Boolean;
      
      public function RareGemImageWidget(param1:Blitz3App, param2:DynamicRareGemImageLoader, param3:String = "small", param4:int = 0, param5:int = 0, param6:Number = 1, param7:Number = 1, param8:Boolean = true)
      {
         super();
         this._app = param1;
         this._loader = param2;
         this._image = new Bitmap();
         this._centerAlign = param8;
         this.setCoordinates(param4,param5);
         this.rescale(param6,param7);
      }
      
      public function clear() : void
      {
         if(this._image != null && contains(this._image))
         {
            this._image.bitmapData.fillRect(this._image.bitmapData.rect,0);
         }
      }
      
      public function reset(param1:RGLogic, param2:Function = null) : void
      {
         var curRareGem:RGLogic = param1;
         var onComplete:Function = param2;
         this.clear();
         if(curRareGem)
         {
            this._loader.load(curRareGem.getStringID(),function():void
            {
            },function():void
            {
               var _loc1_:Bitmap = null;
               if(_loader is DynamicRareGemImageLoader)
               {
                  _loc1_ = DynamicRGInterface.getBitmap(curRareGem.getStringID());
               }
               else
               {
                  _loc1_ = DynamicRGInterface.getImage(curRareGem.getStringID(),_dynamicGemImageKey);
               }
               if(_loc1_ != null && _loc1_.bitmapData != null)
               {
                  _image.bitmapData = _loc1_.bitmapData.clone();
                  dispatchResult(curRareGem.getStringID(),onComplete,true);
               }
               else
               {
                  dispatchResult(curRareGem.getStringID(),onComplete,false);
               }
            });
         }
      }
      
      private function dispatchResult(param1:String, param2:Function, param3:Boolean) : void
      {
         if(param3)
         {
            this._image.smoothing = true;
            this._image.width = 100;
            this._image.height = 100;
            if(this._centerAlign)
            {
               this._image.x = this._image.width * -0.5;
               this._image.y = this._image.height * -0.5;
            }
            if(!contains(this._image))
            {
               addChild(this._image);
            }
         }
         if(param2 != null)
         {
            param2(param3);
         }
      }
      
      public function setCoordinates(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function move(param1:int, param2:int) : void
      {
         this.x += param1;
         this.y += param2;
      }
      
      public function rescale(param1:Number, param2:Number) : void
      {
         this.scaleX = param1;
         this.scaleY = param2;
      }
   }
}
