package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import flash.utils.describeType;
   
   public class §_-WH§
   {
       
      
      private var §_-8x§:String = null;
      
      public function §_-WH§()
      {
         super();
      }
      
      protected static function §_-Rr§(param1:*) : void
      {
         var _loc3_:XML = null;
         var _loc4_:§_-WH§ = null;
         var _loc5_:* = undefined;
         var _loc2_:XML = describeType(param1);
         for each(_loc3_ in _loc2_.constant)
         {
            if((_loc4_ = param1[_loc3_.@name]).§_-PE§ != null)
            {
               throw new Error("Can\'t initialize \'" + param1 + "\' twice");
            }
            if((_loc5_ = _loc4_).constructor != param1)
            {
               throw new Error("Constant type \'" + _loc5_.constructor + "\' " + "does not match its enum class \'" + param1 + "\'");
            }
            _loc4_.§_-8x§ = _loc3_.@name;
         }
      }
      
      public function get §_-PE§() : String
      {
         return this.§_-8x§;
      }
      
      public function toString() : String
      {
         return this.§_-PE§;
      }
   }
}
