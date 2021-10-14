package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Gem;
   import flash.utils.Dictionary;
   
   public class CascadeScore
   {
       
      
      public var score:int;
      
      public var active:Boolean = true;
      
      public var cascadeCount:int = 0;
      
      private var mGemCount:int = 0;
      
      private var mGemHistory:Dictionary;
      
      public function CascadeScore()
      {
         super();
         this.mGemHistory = new Dictionary();
      }
      
      public function GetGemCount() : int
      {
         return this.mGemCount;
      }
      
      public function AddGem(gem:Gem) : Boolean
      {
         if(this.mGemHistory[gem.id] != undefined)
         {
            return false;
         }
         this.mGemHistory[gem.id] = gem;
         ++this.mGemCount;
         return true;
      }
   }
}
