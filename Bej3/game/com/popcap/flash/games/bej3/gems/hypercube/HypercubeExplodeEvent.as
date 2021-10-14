package com.popcap.flash.games.bej3.gems.hypercube
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.Event;
   
   public class HypercubeExplodeEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "HypercubeExplodeEvent";
      
      public static const JUMP_TIME:int = 5;
      
      public static const VALUE:int = 50;
       
      
      private var mApp:Blitz3App;
      
      private var mLocus:Gem = null;
      
      private var mMatchingGems:Vector.<Gem>;
      
      private var mToShatter:Vector.<Gem>;
      
      private var mTimer:int = 0;
      
      private var mIsDone:Boolean = false;
      
      public function HypercubeExplodeEvent(app:Blitz3App, locus:Gem)
      {
         super(ID);
         this.mApp = app;
         this.mLocus = locus;
         this.mToShatter = new Vector.<Gem>();
      }
      
      public function get locus() : Gem
      {
         return this.mLocus;
      }
      
      public function GetMatchingGems() : Vector.<Gem>
      {
         return this.mMatchingGems;
      }
      
      public function ShatterGem(gem:Gem) : void
      {
         if(gem.isImmune || gem.immuneTime > 0)
         {
            return;
         }
         this.mToShatter.push(gem);
      }
      
      public function Init() : void
      {
         var gem:Gem = null;
         this.mMatchingGems = new Vector.<Gem>();
         var color:int = this.mLocus.mShatterColor;
         if(color == Gem.COLOR_NONE)
         {
            color = this.mLocus.color;
         }
         var all:Vector.<Gem> = this.mApp.logic.board.GetGemsByColor(color);
         var len:int = all.length;
         for(var i:int = 0; i < len; i++)
         {
            gem = all[i];
            if(gem.y >= -1.5)
            {
               if(!(gem.isImmune || gem.immuneTime > 0))
               {
                  if(!(gem.isDetonated || gem.isShattered || gem.isDead || gem.fuseTime > 0))
                  {
                     gem.mMatchId = this.locus.mMatchId;
                     gem.mMoveId = this.locus.mMoveId;
                     this.mMatchingGems.push(gem);
                  }
               }
            }
         }
         this.mTimer = 0;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         var gem:Gem = null;
         for each(gem in this.mToShatter)
         {
            if(!(gem != this.mLocus && (gem.isDetonated || gem.isShattered || gem.isDead || gem.fuseTime > 0)))
            {
               gem.baseValue = 50;
               this.mApp.logic.AddScore(50);
               if(gem == this.mLocus)
               {
                  gem.ForceShatter();
               }
               else if(gem.type == Gem.TYPE_RAINBOW)
               {
                  gem.BenignDestroy();
                  gem.ForceShatter();
               }
               else
               {
                  gem.Shatter(this.mLocus);
               }
            }
         }
         this.mToShatter.length = 0;
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      public function Die() : void
      {
         this.mIsDone = true;
      }
   }
}
