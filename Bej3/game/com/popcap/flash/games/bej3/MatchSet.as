package com.popcap.flash.games.bej3
{
   public class MatchSet
   {
       
      
      public var mMatches:Vector.<Match>;
      
      public var mGems:Vector.<Gem>;
      
      public function MatchSet()
      {
         this.mMatches = new Vector.<Match>();
         this.mGems = new Vector.<Gem>();
         super();
      }
      
      public function get isDeferred() : Boolean
      {
         var gem:Gem = null;
         var numGems:int = this.mGems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = this.mGems[i];
            if(gem.mIsFalling)
            {
               return true;
            }
            if(gem.isUnswapping)
            {
               return true;
            }
         }
         return false;
      }
      
      public function resolve() : void
      {
         var match:Match = null;
         var gems:Vector.<Gem> = null;
         var numGems:int = 0;
         var k:int = 0;
         var gem:Gem = null;
         var index:int = 0;
         this.mGems.length = 0;
         var aNumMatches:int = this.mMatches.length;
         for(var i:int = 0; i < aNumMatches; i++)
         {
            match = this.mMatches[i];
            gems = match.mGems;
            numGems = gems.length;
            for(k = 0; k < numGems; k++)
            {
               gem = gems[k];
               index = this.mGems.indexOf(gem);
               if(index < 0)
               {
                  this.mGems.push(gem);
               }
            }
         }
      }
   }
}
