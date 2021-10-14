package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.games.bej3.Gem;
   import flash.utils.Dictionary;
   
   public class CascadeScore
   {
       
      
      private var §_-Dy§:Dictionary;
      
      private var §_-GL§:int = 0;
      
      public var §_-oa§:int = 0;
      
      public var §_-Tm§:Boolean = true;
      
      public function CascadeScore()
      {
         super();
         this.§_-Dy§ = new Dictionary();
      }
      
      public function §_-Pi§(param1:Gem) : Boolean
      {
         if(this.§_-Dy§[param1.id] != undefined)
         {
            return false;
         }
         this.§_-Dy§[param1.id] = param1;
         ++this.§_-GL§;
         return true;
      }
      
      public function §_-Ln§() : int
      {
         return this.§_-GL§;
      }
   }
}
