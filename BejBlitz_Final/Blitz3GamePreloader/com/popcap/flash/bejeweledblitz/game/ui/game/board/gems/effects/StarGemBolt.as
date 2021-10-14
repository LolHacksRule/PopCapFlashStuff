package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class StarGemBolt extends Sprite
   {
      
      public static const CHANGE_TIME:int = 5;
       
      
      public var boltPieces:Vector.<StarGemBoltPiece>;
      
      private var m_Timer:int = 0;
      
      private var m_ChangeTimer:int = 0;
      
      public function StarGemBolt(param1:ImageInst)
      {
         super();
         visible = false;
         blendMode = BlendMode.ADD;
         this.boltPieces = new Vector.<StarGemBoltPiece>(4,true);
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            this.boltPieces[_loc2_] = new StarGemBoltPiece(param1);
            _loc2_++;
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
      
      public function SetTime(param1:int) : void
      {
         this.m_Timer = param1;
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
         var _loc1_:int = this.boltPieces.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.boltPieces[_loc2_].Change();
            _loc2_++;
         }
      }
      
      public function SetColor(param1:int) : void
      {
         var _loc3_:StarGemBoltPiece = null;
         var _loc4_:ColorTransform = null;
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = this.boltPieces[_loc2_];
            (_loc4_ = _loc3_.bottomBolt.transform.colorTransform).alphaOffset = (param1 & 4278190080) >> 24;
            _loc4_.redOffset = (param1 & 16711680) >> 16;
            _loc4_.greenOffset = (param1 & 65280) >> 8;
            _loc4_.blueOffset = param1 & 255;
            _loc3_.bottomBolt.transform.colorTransform = _loc4_;
            _loc2_++;
         }
      }
   }
}
