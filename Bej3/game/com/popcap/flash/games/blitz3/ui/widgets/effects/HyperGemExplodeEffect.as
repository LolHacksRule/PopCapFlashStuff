package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class HyperGemExplodeEffect extends SpriteEffect
   {
      
      private static const COLORS:Vector.<int> = new Vector.<int>();
      
      private static const DELAY_TIME:Number = 25;
      
      private static const DELAY_FACTOR:Number = 1 / DELAY_TIME;
      
      {
         COLORS[Gem.COLOR_NONE] = 2105376;
         COLORS[Gem.COLOR_RED] = 16711680;
         COLORS[Gem.COLOR_ORANGE] = 16744448;
         COLORS[Gem.COLOR_YELLOW] = 16776960;
         COLORS[Gem.COLOR_GREEN] = 65280;
         COLORS[Gem.COLOR_BLUE] = 255;
         COLORS[Gem.COLOR_PURPLE] = 16711935;
         COLORS[Gem.COLOR_WHITE] = 8421504;
      }
      
      private var mApp:Blitz3App;
      
      private var mEvent:HypercubeExplodeEvent;
      
      private var mLocus:Gem;
      
      private var mJolts:Vector.<HyperJolt>;
      
      private var mIsDone:Boolean = false;
      
      private var mIsInited:Boolean = false;
      
      private var mOffset:Matrix;
      
      private var mMatched:Vector.<Gem>;
      
      private var mElectrified:Vector.<Object>;
      
      private var mJumpCandidate:Vector.<Gem>;
      
      private var mTotalCount:int = 0;
      
      private var mDeadCount:int = 0;
      
      private var mTimer:int = 0;
      
      private var mAlpha:Number = 0.0;
      
      private var mDoneDelay:int = 0;
      
      private var mColor:int = 0;
      
      public function HyperGemExplodeEffect(app:Blitz3App, e:HypercubeExplodeEvent, offsetX:Number, offsetY:Number)
      {
         super();
         blendMode = BlendMode.ADD;
         this.mApp = app;
         this.mEvent = e;
         this.mLocus = this.mEvent.locus;
         this.mJolts = new Vector.<HyperJolt>();
         this.mOffset = new Matrix();
         this.mOffset.translate(offsetX,offsetY);
         this.mElectrified = new Vector.<Object>();
         this.mJumpCandidate = new Vector.<Gem>();
         this.mColor = COLORS[this.mLocus.mShatterColor];
      }
      
      public function Init() : void
      {
         this.mMatched = this.mEvent.GetMatchingGems().slice();
         var o:Object = new Object();
         o.gem = this.mLocus;
         o.percent = 0;
         o.dead = false;
         this.mElectrified.push(o);
         this.mTotalCount = this.mMatched.length + 1;
         this.mIsInited = true;
      }
      
      override public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      override public function Update() : void
      {
         var jolt:HyperJolt = null;
         if(this.mIsDone)
         {
            return;
         }
         if(this.mAlpha < 1 && this.mDoneDelay == 0)
         {
            this.mAlpha += 0.02;
         }
         if(this.mDoneDelay > 0)
         {
            --this.mDoneDelay;
            if(this.mDoneDelay == 0)
            {
               this.mIsDone = true;
            }
            this.mAlpha = this.mDoneDelay * DELAY_FACTOR;
            return;
         }
         if(!this.mIsInited)
         {
            this.Init();
         }
         this.UpdateElectrified();
         this.UpdateJumping();
         var numJolts:int = this.mJolts.length;
         var deadJolts:int = 0;
         for(var i:int = 0; i < numJolts; i++)
         {
            jolt = this.mJolts[i];
            jolt.Update();
            if(jolt.isDead)
            {
               deadJolts++;
            }
         }
         var allJoltsDead:Boolean = deadJolts == numJolts;
         ++this.mTimer;
         if(allJoltsDead && this.mDeadCount == this.mTotalCount && this.mDoneDelay == 0)
         {
            this.mDoneDelay = DELAY_TIME;
            this.mEvent.Die();
         }
      }
      
      private function UpdateElectrified() : void
      {
         var o:Object = null;
         var gem:Gem = null;
         var percent:Number = NaN;
         this.mJumpCandidate.length = 0;
         var len:int = this.mElectrified.length;
         for(var i:int = 0; i < len; i++)
         {
            o = this.mElectrified[i];
            if(!o.dead)
            {
               gem = o.gem;
               percent = o.percent;
               if(gem == this.mLocus)
               {
                  percent += 0.01;
               }
               else
               {
                  percent += 0.015;
               }
               if(percent >= 1)
               {
                  o.dead = true;
                  this.mEvent.ShatterGem(gem);
                  ++this.mDeadCount;
               }
               else if(percent < 0.04)
               {
                  this.mJumpCandidate.push(gem);
               }
               o.percent = percent;
            }
         }
      }
      
      private function UpdateJumping() : void
      {
         var o:Object = null;
         var closest:Number = NaN;
         var len:int = 0;
         var i:int = 0;
         var gem:Gem = null;
         var dist:Number = NaN;
         if(this.mMatched.length == 0)
         {
            return;
         }
         var rand:int = this.mApp.logic.random.Int(int.MAX_VALUE);
         var mod:int = int(20 / this.mElectrified.length + 1 + 5);
         var isTime:Boolean = rand % mod == 0;
         if(this.mJolts.length > 0 && !isTime)
         {
            return;
         }
         var electrocutor:Gem = null;
         var newPiece:Gem = null;
         var index:int = -1;
         if(this.mJumpCandidate.length > 0)
         {
            electrocutor = this.mJumpCandidate[int(this.mApp.logic.random.Int(this.mJumpCandidate.length))];
         }
         else if(this.mElectrified.length > 0)
         {
            o = this.mElectrified[int(this.mApp.logic.random.Int(this.mElectrified.length))];
            electrocutor = o.gem;
         }
         if(electrocutor != null)
         {
            closest = Number.MAX_VALUE;
            len = this.mMatched.length;
            for(i = 0; i < len; i++)
            {
               gem = this.mMatched[i];
               dist = Math.min(Math.abs(gem.col - electrocutor.col),Math.abs(gem.row - electrocutor.row));
               if(dist < closest)
               {
                  newPiece = gem;
                  index = i;
               }
            }
            this.AddJolt(electrocutor.x * 40 + 20,electrocutor.y * 40 + 20,newPiece.x * 40 + 20,newPiece.y * 40 + 20);
         }
         else
         {
            index = this.mApp.logic.random.Int(this.mMatched.length);
            newPiece = this.mMatched[index];
         }
         this.mMatched.splice(index,1);
         var elec:Object = new Object();
         elec.gem = newPiece;
         elec.percent = 0;
         elec.dead = false;
         this.mElectrified.push(elec);
      }
      
      override public function Draw(postFX:Boolean) : void
      {
         var numJolts:int = 0;
         var i:int = 0;
         var jolt:HyperJolt = null;
         if(this.mIsDone)
         {
            return;
         }
         if(!postFX && this.mDoneDelay == 0)
         {
            numJolts = this.mJolts.length;
            for(i = 0; i < numJolts; i++)
            {
               jolt = this.mJolts[i];
               jolt.Draw();
            }
         }
      }
      
      private function AddJolt(x0:Number, y0:Number, x1:Number, y1:Number) : void
      {
         var distAlong:Number = NaN;
         var xCenter:Number = NaN;
         var yCenter:Number = NaN;
         var jolt:HyperJolt = new HyperJolt();
         var yDiff:Number = y1 - y0;
         var xDiff:Number = x1 - x0;
         var rot:Number = Math.atan2(yDiff,xDiff);
         var dist:Number = Math.sqrt(xDiff * xDiff + yDiff * yDiff);
         jolt.pullX = Math.cos(rot - Math.PI / 2) * dist * 0.4;
         jolt.pullY = Math.sin(rot - Math.PI / 2) * dist * 0.4;
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
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_ELECTRO_PATH);
         addChild(jolt);
      }
   }
}
