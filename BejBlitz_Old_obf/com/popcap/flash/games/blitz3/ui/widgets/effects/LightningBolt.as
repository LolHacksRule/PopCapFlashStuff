package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.§_-e§;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class LightningBolt extends Sprite
   {
      
      public static const §_-IF§:int = 5;
       
      
      private var §_-Gn§:int = 0;
      
      public var §_-ga§:Vector.<LightningBoltPiece>;
      
      private var §_-EV§:int = 0;
      
      public function LightningBolt(param1:ImageInst)
      {
         super();
         visible = false;
         blendMode = BlendMode.ADD;
         this.§_-ga§ = new Vector.<LightningBoltPiece>(4,true);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this.§_-ga§[_loc2_] = new LightningBoltPiece(param1);
            _loc2_++;
         }
         this.§_-ga§[0].x = -40;
         this.§_-ga§[0].y = -160;
         addChild(this.§_-ga§[0]);
         this.§_-ga§[1].x = -40;
         this.§_-ga§[1].y = -80;
         addChild(this.§_-ga§[1]);
         this.§_-ga§[2].x = -40;
         this.§_-ga§[2].y = 0;
         addChild(this.§_-ga§[2]);
         this.§_-ga§[3].x = -40;
         this.§_-ga§[3].y = 80;
         addChild(this.§_-ga§[3]);
         this.§_-W9§();
      }
      
      public function §_-Rs§(param1:int) : void
      {
         var _loc3_:LightningBoltPiece = null;
         var _loc4_:ColorTransform = null;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this.§_-ga§[_loc2_];
            _loc4_ = _loc3_.§_-pQ§.transform.colorTransform;
            §_-e§.§_-Xt§(_loc4_,param1);
            _loc3_.§_-pQ§.transform.colorTransform = _loc4_;
            _loc2_++;
         }
      }
      
      public function §_-w§(param1:int) : void
      {
         this.§_-Gn§ = param1;
         if(this.§_-Gn§ > 0)
         {
            visible = true;
         }
      }
      
      public function Update() : void
      {
         if(this.§_-Gn§ > 0)
         {
            --this.§_-Gn§;
            ++this.§_-EV§;
            if(this.§_-EV§ == §_-IF§)
            {
               this.§_-EV§ = 0;
               this.§_-W9§();
            }
            if(this.§_-Gn§ == 0)
            {
               visible = false;
            }
         }
      }
      
      public function §_-W9§() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.§_-ga§.length)
         {
            this.§_-ga§[_loc1_].Change();
            _loc1_++;
         }
      }
   }
}
