package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.display.SpreadMethod;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class CornerGem extends Sprite
   {
      
      private static const COLORS:Array = [16776960,16711680,255,65280];
      
      private static const ALPHAS:Array = [0.5,0.5,0.5,0.5];
      
      private static const SPREAD:Array = [0,120,168,252];
       
      
      protected var m_App:Blitz3App;
      
      private var m_PhoenixPrismShape:Shape;
      
      public function CornerGem(app:Blitz3App)
      {
         var gemBitmap:Bitmap = null;
         super();
         this.m_App = app;
         gemBitmap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_CORNER_GEM));
         gemBitmap.x = gemBitmap.width * -0.5;
         gemBitmap.y = gemBitmap.height * -0.5;
         addChild(gemBitmap);
      }
      
      public function SetGemType(id:String) : void
      {
         var matrix:Matrix = null;
         if(this.m_PhoenixPrismShape != null && contains(this.m_PhoenixPrismShape))
         {
            removeChild(this.m_PhoenixPrismShape);
         }
         if(id == PhoenixPrismRGLogic.ID)
         {
            this.m_PhoenixPrismShape = new Shape();
            matrix = new Matrix();
            matrix.createGradientBox(width,height,0,-width * 0.5,-height * 0.5);
            this.m_PhoenixPrismShape.graphics.beginGradientFill(GradientType.RADIAL,COLORS,ALPHAS,SPREAD,matrix,SpreadMethod.REFLECT);
            this.m_PhoenixPrismShape.graphics.drawCircle(0,0,width * 0.5);
            addChild(this.m_PhoenixPrismShape);
            filters = null;
         }
         else if(id == MoonstoneRGLogic.ID)
         {
            filters = [new GlowFilter(26367,1,width,height,1,1,true)];
         }
         else if(id == CatseyeRGLogic.ID)
         {
            filters = [new GlowFilter(16711680,1,width,height,1,1,true)];
         }
      }
   }
}
