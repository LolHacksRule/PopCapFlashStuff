package com.popcap.flash.games.bej3.gems.hypercube
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class HypercubeCreateEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "RainbowGemCreateEvent";
      
      public static const DURATION:Number = 30;
       
      
      private var mLocus:Gem;
      
      private var mMatch:Match;
      
      private var mGems:Vector.<Gem>;
      
      private var mTime:Number = 0;
      
      private var mIsDone:Boolean = false;
      
      public function HypercubeCreateEvent(locus:Gem, match:Match = null)
      {
         super(ID);
         this.mLocus = locus;
         this.mMatch = match;
      }
      
      public function get percent() : Number
      {
         return this.mTime / DURATION;
      }
      
      public function get locus() : Gem
      {
         return this.mLocus;
      }
      
      public function get gems() : Vector.<Gem>
      {
         return this.mGems;
      }
      
      public function get time() : Number
      {
         return this.mTime;
      }
      
      public function Init() : void
      {
         var gem:Gem = null;
         this.mGems = new Vector.<Gem>();
         if(this.mMatch == null)
         {
            return;
         }
         for each(gem in this.mMatch.mGems)
         {
            if(!(gem == null || gem == this.mLocus || !gem.isMatching || gem.isElectric))
            {
               gem.Flush();
               this.mGems.push(gem);
            }
         }
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
            gem.isDead = true;
         }
      }
   }
}
