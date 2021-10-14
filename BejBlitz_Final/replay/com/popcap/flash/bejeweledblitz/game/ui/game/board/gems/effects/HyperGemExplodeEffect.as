package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeExplodeEventHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.BlendMode;
   import flash.geom.Point;
   
   public class HyperGemExplodeEffect extends SpriteEffect implements IHypercubeExplodeEventHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var mEvent:HypercubeExplodeEvent;
      
      private var mLocus:Gem;
      
      private var mJolts:Vector.<HyperGemBolt>;
      
      private var mColor:int = 0;
      
      public function HyperGemExplodeEffect(app:Blitz3App, event:HypercubeExplodeEvent)
      {
         super();
         blendMode = BlendMode.ADD;
         this.m_App = app;
         this.mEvent = event;
         this.mLocus = this.mEvent.GetLocus();
         this.mJolts = new Vector.<HyperGemBolt>();
         var color:int = this.mLocus.mShatterColor;
         if(color == Gem.COLOR_ANY || color == Gem.COLOR_NONE)
         {
            color = this.mLocus.color;
         }
         this.mColor = GemSprite.GEM_COLOR_VALUES[color];
         this.mEvent.AddHandler(this);
      }
      
      override public function IsDone() : Boolean
      {
         return this.mEvent.IsDone();
      }
      
      override public function Update() : void
      {
         var jolt:HyperGemBolt = null;
         for each(jolt in this.mJolts)
         {
            jolt.Update();
         }
      }
      
      override public function Draw() : void
      {
         var jolt:HyperGemBolt = null;
         if(this.IsDone())
         {
            return;
         }
         for each(jolt in this.mJolts)
         {
            jolt.Draw();
         }
      }
      
      public function HandleHypercubeExplodeBegin(duration:int, gems:Vector.<Gem>) : void
      {
      }
      
      public function HandleHypercubeExplodeEnd() : void
      {
      }
      
      public function HandleHypercubeExplodeNextGem(gem:Gem, delay:int) : void
      {
         var srcGem:Gem = this.mEvent.GetLocus();
         if(srcGem == gem)
         {
            return;
         }
         var srcX:Number = srcGem.x * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var srcY:Number = srcGem.y * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var dstX:Number = gem.x * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         var dstY:Number = gem.y * GemSprite.GEM_SIZE + GemSprite.GEM_SIZE * 0.5;
         this.AddJolt(srcX,srcY,dstX,dstY);
      }
      
      private function AddJolt(x0:Number, y0:Number, x1:Number, y1:Number) : void
      {
         var distAlong:Number = NaN;
         var xCenter:Number = NaN;
         var yCenter:Number = NaN;
         var jolt:HyperGemBolt = new HyperGemBolt();
         var yDiff:Number = y1 - y0;
         var xDiff:Number = x1 - x0;
         var rot:Number = Math.atan2(yDiff,xDiff);
         var dist:Number = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
         jolt.pullX = Math.cos(rot - Math.PI * 0.5) * dist * 0.4;
         jolt.pullY = Math.sin(rot - Math.PI * 0.5) * dist * 0.4;
         jolt.color = this.mColor;
         for(var i:int = 0; i < 8; i++)
         {
            distAlong = i / 7;
            xCenter = x0 * (1 - distAlong) + x1 * distAlong;
            yCenter = y0 * (1 - distAlong) + y1 * distAlong;
            jolt.points[i] = new Array();
            jolt.points[i][0] = new Point(xCenter,yCenter);
            jolt.points[i][1] = new Point(xCenter,yCenter);
         }
         this.mJolts.push(jolt);
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_ELECTRO_PATH);
         addChild(jolt);
      }
   }
}
