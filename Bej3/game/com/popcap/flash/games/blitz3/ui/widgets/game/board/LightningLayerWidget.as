package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.LightningBolt;
   import flash.display.Sprite;
   
   public class LightningLayerWidget extends Sprite
   {
      
      private static const COLORS:Array = new Array(8);
      
      {
         COLORS[Gem.COLOR_NONE] = 0;
         COLORS[Gem.COLOR_RED] = 4294901760;
         COLORS[Gem.COLOR_ORANGE] = 4294934528;
         COLORS[Gem.COLOR_YELLOW] = 4294967040;
         COLORS[Gem.COLOR_GREEN] = 4278255360;
         COLORS[Gem.COLOR_BLUE] = 4278190335;
         COLORS[Gem.COLOR_PURPLE] = 4294902015;
         COLORS[Gem.COLOR_WHITE] = 4294967295;
      }
      
      private var mApp:Blitz3App;
      
      private var mLightningImg:ImageInst;
      
      private var mBoltRows:Vector.<LightningBolt>;
      
      private var mBoltCols:Vector.<LightningBolt>;
      
      public function LightningLayerWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function ShowBoltCross(row:int, col:int, color:int, time:int) : void
      {
         var hBolt:LightningBolt = this.mBoltRows[row];
         hBolt.SetTime(time);
         hBolt.SetColor(COLORS[color]);
         var vBolt:LightningBolt = this.mBoltCols[col];
         vBolt.SetTime(time);
         vBolt.SetColor(COLORS[color]);
      }
      
      public function Init() : void
      {
         var i:int = 0;
         var bolt:LightningBolt = null;
         this.mLightningImg = this.mApp.imageManager.getImageInst(Blitz3Images.IMAGE_EFFECT_LIGHTNING);
         this.mBoltRows = new Vector.<LightningBolt>(8,true);
         for(i = 0; i < 8; i++)
         {
            bolt = new LightningBolt(this.mLightningImg);
            bolt.SetColor(COLORS[int(Math.random() * COLORS.length)]);
            addChild(bolt);
            this.mBoltRows[i] = bolt;
            bolt.x = 160;
            bolt.y = i * 40 + 20;
            bolt.rotation = 90;
         }
         this.mBoltCols = new Vector.<LightningBolt>(8,true);
         for(i = 0; i < 8; i++)
         {
            bolt = new LightningBolt(this.mLightningImg);
            bolt.SetColor(COLORS[int(Math.random() * COLORS.length)]);
            addChild(bolt);
            this.mBoltCols[i] = bolt;
            bolt.x = i * 40 + 20;
            bolt.y = 160;
         }
      }
      
      public function Reset() : void
      {
      }
      
      public function Update() : void
      {
         var bolt:LightningBolt = null;
         for each(bolt in this.mBoltCols)
         {
            bolt.Update();
         }
         for each(bolt in this.mBoltRows)
         {
            bolt.Update();
         }
      }
      
      public function Draw() : void
      {
      }
   }
}
