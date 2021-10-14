package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
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
      
      public function StarGemWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function ShowBoltCross(row:int, col:int, color:int, time:int) : void
      {
         this.m_active = true;
         this.m_hBolt = this.m_BoltRows[row];
         this.m_hBolt.SetTime(time);
         this.m_hBolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[color]);
         this.m_vBolt = this.m_BoltCols[col];
         this.m_vBolt.SetTime(time);
         this.m_vBolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[color]);
      }
      
      public function Init() : void
      {
         var bolt:StarGemBolt = null;
         var i:int = 0;
         bolt = null;
         this.m_LightningImg = this.m_App.ImageManager.getImageInst(Blitz3GameImages.IMAGE_EFFECT_LIGHTNING);
         this.m_BoltRows = new Vector.<StarGemBolt>(8,true);
         for(i = 0; i < 8; i++)
         {
            bolt = new StarGemBolt(this.m_LightningImg);
            bolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[int(Math.random() * GemSprite.GEM_ACOLOR_VALUES.length)]);
            addChild(bolt);
            this.m_BoltRows[i] = bolt;
            bolt.x = 160;
            bolt.y = i * 40 + 20;
            bolt.rotation = 90;
         }
         this.m_BoltCols = new Vector.<StarGemBolt>(8,true);
         for(i = 0; i < 8; i++)
         {
            bolt = new StarGemBolt(this.m_LightningImg);
            bolt.SetColor(GemSprite.GEM_ACOLOR_VALUES[int(Math.random() * GemSprite.GEM_ACOLOR_VALUES.length)]);
            addChild(bolt);
            this.m_BoltCols[i] = bolt;
            bolt.x = i * 40 + 20;
            bolt.y = 160;
         }
      }
      
      public function Reset() : void
      {
         var bolt:StarGemBolt = null;
         for each(bolt in this.m_BoltCols)
         {
            bolt.SetTime(1);
            bolt.Update();
         }
         for each(bolt in this.m_BoltRows)
         {
            bolt.SetTime(1);
            bolt.Update();
         }
         this.m_active = false;
      }
      
      public function Update() : void
      {
         if(!this.m_active)
         {
            return;
         }
         var bolt:StarGemBolt = null;
         for each(bolt in this.m_BoltCols)
         {
            bolt.Update();
         }
         for each(bolt in this.m_BoltRows)
         {
            bolt.Update();
         }
         this.m_active = this.m_hBolt.visible || this.m_vBolt.visible;
      }
   }
}
