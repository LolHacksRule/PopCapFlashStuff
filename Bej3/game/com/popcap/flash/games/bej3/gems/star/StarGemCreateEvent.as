package com.popcap.flash.games.bej3.gems.star
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.Match;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import flash.events.Event;
   
   public class StarGemCreateEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "StarGemCreateEvent";
      
      public static const DURATION:Number = 30;
       
      
      private var mLocus:Gem;
      
      private var mMatchA:Match;
      
      private var mMatchB:Match;
      
      private var mGems:Vector.<Gem>;
      
      private var mTime:Number = 0;
      
      private var mIsDone:Boolean = false;
      
      public function StarGemCreateEvent(locus:Gem, matchA:Match = null, matchB:Match = null)
      {
         super(ID);
         this.mLocus = locus;
         this.mMatchA = matchA;
         this.mMatchB = matchB;
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
         this.mGems = new Vector.<Gem>();
         var gem:Gem = null;
         if(this.mMatchA != null)
         {
            for each(gem in this.mMatchA.mGems)
            {
               if(!(gem == null || gem == this.mLocus || !gem.isMatching || gem.isElectric))
               {
                  gem.Flush();
                  this.mGems.push(gem);
               }
            }
         }
         if(this.mMatchB != null)
         {
            for each(gem in this.mMatchB.mGems)
            {
               if(!(gem == null || gem == this.mLocus || !gem.isMatching || gem.isElectric))
               {
                  gem.Flush();
                  this.mGems.push(gem);
               }
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
