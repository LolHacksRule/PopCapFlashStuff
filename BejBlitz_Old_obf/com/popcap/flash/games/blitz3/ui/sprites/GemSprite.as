package com.popcap.flash.games.blitz3.ui.sprites
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class GemSprite extends Sprite
   {
       
      
      private var §_-Vj§:Boolean = false;
      
      public var §_-TQ§:Sprite;
      
      private var §_-O0§:Number = 0;
      
      public var gem:Gem = null;
      
      public var §_-c4§:Bitmap;
      
      public var §_-km§:Sprite;
      
      private var §_-3q§:Number = 0;
      
      public var §_-W3§:Bitmap;
      
      public var §_-0u§:Sprite;
      
      public var §_-W6§:Bitmap;
      
      public var §_-a0§:Boolean = false;
      
      private var mApp:§_-0Z§;
      
      private var §_-ZJ§:Number = 1.0;
      
      public var §_-dS§:int = 0;
      
      public function GemSprite(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         this.§_-0u§ = new Sprite();
         this.§_-TQ§ = new Sprite();
         this.§_-km§ = new Sprite();
         this.§_-c4§ = new Bitmap();
         this.§_-c4§.smoothing = true;
         this.§_-W3§ = new Bitmap();
         this.§_-W3§.smoothing = true;
         this.§_-W6§ = new Bitmap();
         this.§_-W6§.smoothing = true;
         this.§_-0u§.addChild(this.§_-c4§);
         this.§_-TQ§.addChild(this.§_-W3§);
         this.§_-km§.addChild(this.§_-W6§);
         this.§_-TQ§.addChild(this.§_-km§);
      }
      
      public function §_-Aw§(param1:Number, param2:Number, param3:Number, param4:ImageInst, param5:ImageInst, param6:ImageInst) : void
      {
         if(param1 != this.§_-O0§)
         {
            this.§_-O0§ = param1;
            this.§_-0u§.x = this.§_-O0§;
            this.§_-TQ§.x = this.§_-O0§;
         }
         if(param2 != this.§_-3q§)
         {
            this.§_-3q§ = param2;
            this.§_-0u§.y = this.§_-3q§;
            this.§_-TQ§.y = this.§_-3q§;
         }
         if(param3 != this.§_-ZJ§)
         {
            this.§_-ZJ§ = param3;
            this.§_-0u§.scaleX = this.§_-ZJ§;
            this.§_-0u§.scaleY = this.§_-ZJ§;
            this.§_-TQ§.scaleX = this.§_-ZJ§;
            this.§_-TQ§.scaleY = this.§_-ZJ§;
            this.§_-km§.scaleX = this.§_-ZJ§;
            this.§_-km§.scaleY = this.§_-ZJ§;
         }
         if(param4 == null)
         {
            if(this.§_-c4§.bitmapData != null)
            {
               this.§_-c4§.visible = false;
               this.§_-c4§.bitmapData = null;
            }
         }
         else if(this.§_-c4§.bitmapData != param4.§_-57§)
         {
            this.§_-c4§.visible = true;
            this.§_-c4§.bitmapData = param4.§_-57§;
            this.§_-c4§.x = -(this.§_-c4§.width / 2);
            this.§_-c4§.y = -(this.§_-c4§.height / 2);
            this.§_-c4§.smoothing = true;
         }
         if(param5 == null)
         {
            if(this.§_-W3§.bitmapData != null)
            {
               this.§_-W3§.visible = false;
               this.§_-W3§.bitmapData = null;
            }
         }
         else if(this.§_-W3§.bitmapData != param5.§_-57§)
         {
            this.§_-W3§.visible = true;
            this.§_-W3§.bitmapData = param5.§_-57§;
            this.§_-W3§.x = -(this.§_-W3§.width / 2);
            this.§_-W3§.y = -(this.§_-W3§.height / 2) + param5.y;
            this.§_-W3§.smoothing = true;
         }
         if(param6 == null)
         {
            if(this.§_-W6§.bitmapData != null)
            {
               this.§_-W6§.visible = false;
               this.§_-W6§.bitmapData = null;
            }
         }
         else if(this.§_-W6§.bitmapData != param6.§_-57§)
         {
            this.§_-W6§.visible = true;
            this.§_-W6§.bitmapData = param6.§_-57§;
            this.§_-W6§.x = -(this.§_-W6§.width / 2);
            this.§_-W6§.y = -(this.§_-W6§.height / 2);
            this.§_-W6§.blendMode = !!param6.§use § ? BlendMode.ADD : BlendMode.NORMAL;
            this.§_-W6§.smoothing = true;
         }
      }
      
      public function §_-kX§() : void
      {
         this.§_-0u§.visible = false;
         this.§_-TQ§.visible = false;
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
      }
      
      public function Init() : void
      {
         this.§_-Vj§ = true;
      }
      
      public function Update() : void
      {
         if(this.§_-dS§ > 0)
         {
            --this.§_-dS§;
         }
      }
      
      public function Show() : void
      {
         this.§_-0u§.visible = true;
         this.§_-TQ§.visible = true;
      }
   }
}
