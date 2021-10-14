package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   
   public class StarGemCreateEvent implements IBlitzEvent
   {
      
      public static const DURATION:Number = 30;
       
      
      private var mLocus:Gem;
      
      private var mMatchA:Match;
      
      private var mMatchB:Match;
      
      private var mGems:Vector.<Gem>;
      
      private var mTime:Number;
      
      private var mIsDone:Boolean;
      
      public function StarGemCreateEvent()
      {
         super();
         this.mGems = new Vector.<Gem>();
      }
      
      public function GetPercent() : Number
      {
         return this.mTime / DURATION;
      }
      
      public function GetLocus() : Gem
      {
         return this.mLocus;
      }
      
      public function GetGems() : Vector.<Gem>
      {
         return this.mGems;
      }
      
      public function GetTime() : Number
      {
         return this.mTime;
      }
      
      public function Set(locus:Gem, matchA:Match, matchB:Match) : void
      {
         this.mLocus = locus;
         this.mMatchA = matchA;
         this.mMatchB = matchB;
      }
      
      public function Init() : void
      {
         var gem:Gem = null;
         var curGem:Gem = null;
         if(this.mMatchA != null)
         {
            for each(gem in this.mMatchA.matchGems)
            {
               if(!(gem == null || gem == this.mLocus || !gem.IsMatching() || gem.IsElectric()))
               {
                  gem.Flush();
                  this.mGems.push(gem);
               }
            }
         }
         if(this.mMatchB != null)
         {
            for each(curGem in this.mMatchB.matchGems)
            {
               if(!(curGem == null || curGem == this.mLocus || !curGem.IsMatching() || curGem.IsElectric()))
               {
                  curGem.Flush();
                  this.mGems.push(curGem);
               }
            }
         }
      }
      
      public function Reset() : void
      {
         this.mTime = 0;
         this.mIsDone = false;
         this.mLocus = null;
         this.mMatchA = null;
         this.mMatchB = null;
         this.mGems.length = 0;
      }
      
      public function Update(speed:Number) : void
      {
         if(this.mIsDone)
         {
            return;
         }
         this.mTime += speed;
         if(this.mTime >= DURATION)
         {
            this.mTime = DURATION;
            this.mIsDone = true;
            this.OnDone();
         }
      }
      
      public function IsDone() : Boolean
      {
         return this.mIsDone;
      }
      
      private function OnDone() : void
      {
         var gem:Gem = null;
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            gem.SetDead(true);
         }
      }
   }
}
