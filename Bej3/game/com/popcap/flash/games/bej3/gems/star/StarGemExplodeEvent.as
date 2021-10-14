package com.popcap.flash.games.bej3.gems.star
{
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.GemGrid;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import flash.events.Event;
   
   public class StarGemExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "StarGemExplodeEvent";
      
      public static const VALUE:int = 50;
      
      public static const START_TIME:int = 80;
      
      public static const JUMP_TIME:int = 10;
      
      public static const LASER_RANGE:int = 8;
       
      
      private var mLocus:Gem = null;
      
      private var mLogic:BlitzLogic = null;
      
      private var mGrid:GemGrid = null;
      
      private var mIsDone:Boolean = false;
      
      private var mTimer:int = 0;
      
      private var mIndex:int = 0;
      
      private var mJumps:Array;
      
      public function StarGemExplodeEvent(locus:Gem, logic:BlitzLogic)
      {
         var gems:Vector.<Gem> = null;
         var o:Object = null;
         super(ID);
         this.mLocus = locus;
         this.mLogic = logic;
         this.mGrid = this.mLogic.grid;
         var range:int = 1;
         var fuse:int = START_TIME;
         var done:Boolean = false;
         this.mJumps = new Array();
         while(!done)
         {
            gems = this.ElectrocuteRange(range);
            o = new Object();
            o.gems = gems;
            o.time = fuse;
            this.mJumps.push(o);
            range++;
            fuse += JUMP_TIME;
            done = gems == null;
         }
      }
      
      public function get locus() : Gem
      {
         return this.mLocus;
      }
      
      public function Init() : void
      {
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var gems:Vector.<Gem> = null;
         var g:Gem = null;
         if(this.mIsDone == true)
         {
            return;
         }
         ++this.mTimer;
         var o:Object = this.mJumps[0];
         if(o.time == this.mTimer)
         {
            this.mJumps.shift();
            gems = o.gems;
            if(gems == null)
            {
               this.ShatterGem(this.mLocus);
               this.mIsDone = true;
            }
            else
            {
               for each(g in gems)
               {
                  this.ShatterGem(g);
               }
            }
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      private function ShatterGem(gem:Gem) : void
      {
         gem.baseValue = VALUE;
         this.mLogic.AddScore(VALUE);
         if(gem == this.mLocus)
         {
            gem.ForceShatter();
         }
         else
         {
            gem.Shatter(this.mLocus);
            gem.mMatchId = this.mLocus.mMatchId;
            gem.mShatterGemId = this.mLocus.id;
         }
      }
      
      private function ElectrocuteRange(range:int) : Vector.<Gem>
      {
         var row:int = this.mLocus.y;
         var col:int = this.mLocus.x;
         var left:int = col - range;
         var right:int = col + range;
         var top:int = row - range;
         var bottom:int = row + range;
         if(left < Board.LEFT && right > Board.RIGHT && top < Board.TOP && bottom > Board.BOTTOM)
         {
            return null;
         }
         var gems:Vector.<Gem> = new Vector.<Gem>();
         this.TestGem(row,left,gems);
         this.TestGem(row,right,gems);
         this.TestGem(top,col,gems);
         this.TestGem(bottom,col,gems);
         return gems;
      }
      
      private function TestGem(row:int, col:int, gems:Vector.<Gem>) : void
      {
         var gem:Gem = this.mGrid.getGem(row,col);
         if(gem == null)
         {
            return;
         }
         if(gem.type == Gem.TYPE_DETONATE || gem.type == Gem.TYPE_SCRAMBLE)
         {
            return;
         }
         if(gem.isImmune || gem.immuneTime > 0)
         {
            return;
         }
         if(gem.isDead || gem.isShattered || gem.isDetonated || gem.fuseTime > 0)
         {
            return;
         }
         gem.isElectric = true;
         gems.push(gem);
      }
   }
}
