package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.DynamicRGInterface;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemImageLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class RareGemWidget extends Sprite
   {
       
      
      private var _app:Blitz3App;
      
      private var _loader:DynamicRareGemLoader;
      
      private var _image:Bitmap;
      
      private var _icons:Object;
      
      private var _dynamicGemImageKey:String;
      
      private var _centerAlignImage:Boolean;
      
      public function RareGemWidget(param1:Blitz3App, param2:DynamicRareGemLoader, param3:String = "small", param4:int = 0, param5:int = 0, param6:Number = 1, param7:Number = 1, param8:Boolean = true)
      {
         super();
         this._app = param1;
         this._loader = param2;
         this._image = new Bitmap();
         this._icons = new Object();
         this._centerAlignImage = param8;
         if(param3 == "small")
         {
            this._icons[MoonstoneRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_MOONSTONE);
            this._icons[CatseyeRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_CATSEYE);
            this._icons[PhoenixPrismRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_PHOENIXPRISM);
            this._icons[BlazingSteedRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_BLAZINGSTEED);
            this._icons[KangaRubyFirstRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_KANGARUBY1);
            this._icons[KangaRubySecondRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_KANGARUBY2);
            this._icons[KangaRubyThirdRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_ICON_KANGARUBY3);
            this._dynamicGemImageKey = "Gameicon";
         }
         else if(param3 == "large")
         {
            this._icons[MoonstoneRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_MOONSTONE);
            this._icons[CatseyeRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_CATSEYE);
            this._icons[PhoenixPrismRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_PHOENIXPRISM);
            this._icons[BlazingSteedRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_BLAZINGSTEED);
            this._icons[KangaRubyFirstRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_KANGARUBY);
            this._icons[KangaRubySecondRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_KANGARUBY2);
            this._icons[KangaRubyThirdRGLogic.ID] = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_KANGARUBY3);
            this._dynamicGemImageKey = "Prizebase";
         }
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
            if(curRareGem.isDynamicGem())
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
            else if(this._icons[curRareGem.getStringID()] == null)
            {
               this.dispatchResult(curRareGem.getStringID(),onComplete,false);
            }
            else
            {
               this._image.bitmapData = BitmapData(this._icons[curRareGem.getStringID()]).clone();
               this.dispatchResult(curRareGem.getStringID(),onComplete,true);
            }
         }
      }
      
      private function dispatchResult(param1:String, param2:Function, param3:Boolean) : void
      {
         if(param3)
         {
            this._image.smoothing = true;
            if(this._centerAlignImage)
            {
               this._image.x = this._image.width * -0.5;
               this._image.y = this._image.height * -0.5;
            }
            else
            {
               this._image.x = 0;
               this._image.y = 0;
            }
            this._image.smoothing = true;
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
