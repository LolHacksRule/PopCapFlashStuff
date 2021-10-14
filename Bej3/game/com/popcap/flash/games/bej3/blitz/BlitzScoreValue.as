package com.popcap.flash.games.bej3.blitz
{
   import de.polygonal.ds.HashMap;
   
   public class BlitzScoreValue
   {
       
      
      public var value:int = 0;
      
      public var time:int = 0;
      
      public var tags:HashMap;
      
      public function BlitzScoreValue()
      {
         super();
         this.tags = new HashMap();
      }
      
      public function Reset() : void
      {
         this.value = 0;
         this.time = 0;
         this.tags.clear();
      }
      
      public function toString() : String
      {
         var tagStr:String = "";
         var arr:Array = this.tags.getKeySet();
         for(var i:int = 0; i < arr.length; i++)
         {
            tagStr += arr[0] + " ";
         }
         tagStr = "[" + tagStr + "]";
         return this.value.toString() + " " + tagStr;
      }
   }
}
