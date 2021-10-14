package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageUtils;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class StarGemBolt extends Sprite
   {
      
      public static const CHANGE_TIME:int = 5;
       
      
      public var boltPieces:Vector.<StarGemBoltPiece>;
      
      private var m_Timer:int = 0;
      
      private var m_ChangeTimer:int = 0;
      
      public function StarGemBolt(img:ImageInst)
      {
         super();
         visible = false;
         blendMode = BlendMode.ADD;
         this.boltPieces = new Vector.<StarGemBoltPiece>(4,true);
         for(var i:int = 0; i < 4; i++)
         {
            this.boltPieces[i] = new StarGemBoltPiece(img);
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
         this.m_Timer = time;
         if(this.m_Timer > 0)
         {
            visible = true;
         }
      }
      
      public function Update() : void
      {
         if(this.m_Timer > 0)
         {
            --this.m_Timer;
            ++this.m_ChangeTimer;
            if(this.m_ChangeTimer == CHANGE_TIME)
            {
               this.m_ChangeTimer = 0;
               this.ChangeBolts();
            }
            if(this.m_Timer == 0)
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
         var piece:StarGemBoltPiece = null;
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
