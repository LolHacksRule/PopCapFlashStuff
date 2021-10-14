package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   
   public class PhoenixPrismSprite
   {
       
      
      private var m_GemImages:Vector.<ImageInst>;
      
      private var m_DrawGems:Vector.<ImageInst>;
      
      private var m_GemAlphas:Vector.<Number>;
      
      private var m_HotGemId:Number;
      
      private var m_Data:BitmapData;
      
      private var m_ImageInst:ImageInst;
      
      private var m_Transform:ColorTransform;
      
      private var m_lastFrameID:int = -1;
      
      public function PhoenixPrismSprite(gemImages:Vector.<ImageInst>)
      {
         super();
         this.m_GemImages = gemImages;
         this.m_DrawGems = new Vector.<ImageInst>(5,true);
         this.m_GemAlphas = new Vector.<Number>(5,true);
         this.m_HotGemId = 0;
         this.m_Data = new BitmapData(GemSprite.GEM_SIZE,GemSprite.GEM_SIZE,true,0);
         this.m_ImageInst = new ImageInst();
         this.m_ImageInst.mOverridePixels = this.m_Data;
         this.m_Transform = new ColorTransform();
      }
      
      public function GetImageInst(sprite:GemSprite, frameID:int) : ImageInst
      {
         var d:int = 0;
         var a:Number = NaN;
         var gem:ImageInst = null;
         var i:int = 0;
         if(frameID == this.m_lastFrameID)
         {
            return this.m_ImageInst;
         }
         this.m_lastFrameID = frameID;
         this.m_HotGemId += 0.05;
         if(this.m_HotGemId >= 8)
         {
            this.m_HotGemId = 1;
         }
         var id:int = 1;
         for each(gem in this.m_GemImages)
         {
            d = Math.floor(this.m_HotGemId) - id;
            a = this.m_HotGemId - id - 0.5;
            if(Math.abs(d) <= 2)
            {
               this.m_DrawGems[2 + d] = gem;
               this.m_GemAlphas[2 + d] = -120 * Math.abs(a);
            }
            else if(Math.abs(d + 7) <= 2)
            {
               this.m_DrawGems[2 + (d + 7)] = gem;
               this.m_GemAlphas[2 + (d + 7)] = -120 * Math.abs(a + 7);
            }
            else if(Math.abs(d - 7) <= 2)
            {
               this.m_DrawGems[2 + (d - 7)] = gem;
               this.m_GemAlphas[2 + (d - 7)] = -120 * Math.abs(a - 7);
            }
            id++;
         }
         this.m_Data.fillRect(this.m_Data.rect,0);
         for(i = 0; i < 5; i++)
         {
            gem = this.m_DrawGems[i];
            gem.mFrame = sprite.animTime * 0.25 % gem.mSource.mNumFrames;
            this.m_Transform.alphaOffset = this.m_GemAlphas[i];
            this.m_Data.draw(gem.pixels,null,this.m_Transform);
         }
         return this.m_ImageInst;
      }
   }
}
