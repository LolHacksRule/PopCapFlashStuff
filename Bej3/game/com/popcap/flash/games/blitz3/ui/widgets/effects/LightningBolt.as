package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageUtils;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class LightningBolt extends Sprite
   {
      
      public static const CHANGE_TIME:int = 5;
       
      
      public var boltPieces:Vector.<LightningBoltPiece>;
      
      private var mTimer:int = 0;
      
      private var mChangeTimer:int = 0;
      
      public function LightningBolt(img:ImageInst)
      {
         super();
         visible = false;
         blendMode = BlendMode.ADD;
         this.boltPieces = new Vector.<LightningBoltPiece>(4,true);
         for(var i:int = 0; i < 4; i++)
         {
            this.boltPieces[i] = new LightningBoltPiece(img);
         }
         this.boltPieces[0].x = -40;
         this.boltPieces[0].y = -160;
         addChild(this.boltPieces[0]);
         this.boltPieces[1].x = -40;
         this.boltPieces[1].y = -80;
         addChild(this.boltPieces[1]);
         this.boltPieces[2].x = -40;
         this.boltPieces[2].y = 0;
         addChild(this.boltPieces[2]);
         this.boltPieces[3].x = -40;
         this.boltPieces[3].y = 80;
         addChild(this.boltPieces[3]);
         this.ChangeBolts();
      }
      
      public function SetTime(time:int) : void
      {
         this.mTimer = time;
         if(this.mTimer > 0)
         {
            visible = true;
         }
      }
      
      public function Update() : void
      {
         if(this.mTimer > 0)
         {
            --this.mTimer;
            ++this.mChangeTimer;
            if(this.mChangeTimer == CHANGE_TIME)
            {
               this.mChangeTimer = 0;
               this.ChangeBolts();
            }
            if(this.mTimer == 0)
            {
               visible = false;
            }
         }
      }
      
      public function ChangeBolts() : void
      {
         for(var i:int = 0; i < this.boltPieces.length; i++)
         {
            this.boltPieces[i].Change();
         }
      }
      
      public function SetColor(color:int) : void
      {
         var piece:LightningBoltPiece = null;
         var cTrans:ColorTransform = null;
         for(var i:int = 0; i < 4; i++)
         {
            piece = this.boltPieces[i];
            cTrans = piece.bottomBolt.transform.colorTransform;
            ImageUtils.setColor(cTrans,color);
            piece.bottomBolt.transform.colorTransform = cTrans;
         }
      }
   }
}
