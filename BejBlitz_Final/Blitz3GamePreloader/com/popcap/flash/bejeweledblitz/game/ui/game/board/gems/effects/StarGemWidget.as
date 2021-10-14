package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Sprite;
   
   public class StarGemWidget extends Sprite
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_LightningImg:ImageInst;
      
      private var m_BoltRows:Vector.<StarGemBolt>;
      
      private var m_BoltCols:Vector.<StarGemBolt>;
      
      private var m_active:Boolean = false;
      
      private var m_hBolt:StarGemBolt;
      
      private var m_vBolt:StarGemBolt;
      
      public function StarGemWidget(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
      }
      
      public function ShowBoltCross(param1:int, param2:int, param3:int, param4:int) : void
      {
         this.m_active = true;
         this.m_hBolt = this.m_BoltRows[param1];
         this.m_hBolt.SetTime(param4);
         this.m_vBolt = this.m_BoltCols[param2];
         this.m_vBolt.SetTime(param4);
         if(Constants.IS_HALLOWEEN)
         {
            this.m_hBolt.SetColor(GemSprite.GEM_HALLOWEEN_COLOR);
            this.m_vBolt.SetColor(GemSprite.GEM_HALLOWEEN_COLOR);
         }
         else
         {
            this.m_hBolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[param3]);
            this.m_vBolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[param3]);
         }
      }
      
      public function Init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:StarGemBolt = null;
         _loc1_ = 0;
         _loc2_ = null;
         this.m_LightningImg = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_EFFECT_LIGHTNING);
         this.m_BoltRows = new Vector.<StarGemBolt>(8,true);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = new StarGemBolt(this.m_LightningImg);
            if(Constants.IS_HALLOWEEN)
            {
               _loc2_.SetColor(GemSprite.GEM_HALLOWEEN_COLOR);
            }
            else
            {
               _loc2_.SetColor(GemSprite.GEM_ACOLOR_VALUES[int(Math.random() * GemSprite.GEM_ACOLOR_VALUES.length)]);
            }
            addChild(_loc2_);
            this.m_BoltRows[_loc1_] = _loc2_;
            _loc2_.x = 160;
            _loc2_.y = _loc1_ * 40 + 20;
            _loc2_.rotation = 90;
            _loc1_++;
         }
         this.m_BoltCols = new Vector.<StarGemBolt>(8,true);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = new StarGemBolt(this.m_LightningImg);
            if(Constants.IS_HALLOWEEN)
            {
               _loc2_.SetColor(GemSprite.GEM_HALLOWEEN_COLOR);
            }
            else
            {
               _loc2_.SetColor(GemSprite.GEM_ACOLOR_VALUES[int(Math.random() * GemSprite.GEM_ACOLOR_VALUES.length)]);
            }
            addChild(_loc2_);
            this.m_BoltCols[_loc1_] = _loc2_;
            _loc2_.x = _loc1_ * 40 + 20;
            _loc2_.y = 160;
            _loc1_++;
         }
      }
      
      public function Reset() : void
      {
         var _loc1_:StarGemBolt = null;
         for each(_loc1_ in this.m_BoltCols)
         {
            _loc1_.SetTime(1);
            _loc1_.Update();
         }
         for each(_loc1_ in this.m_BoltRows)
         {
            _loc1_.SetTime(1);
            _loc1_.Update();
         }
         this.m_active = false;
      }
      
      public function Update() : void
      {
         if(!this.m_active)
         {
            return;
         }
         var _loc1_:StarGemBolt = null;
         for each(_loc1_ in this.m_BoltCols)
         {
            _loc1_.Update();
         }
         for each(_loc1_ in this.m_BoltRows)
         {
            _loc1_.Update();
         }
         this.m_active = this.m_hBolt.visible || this.m_vBolt.visible;
      }
   }
}
