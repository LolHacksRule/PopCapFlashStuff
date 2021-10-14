package com.adobe.serialization.json
{
   public class §_-61§
   {
       
      
      private var value;
      
      private var §_-Gq§:§_-Le§;
      
      private var §_-Ow§:§_-5s§;
      
      public function §_-61§(param1:String)
      {
         super();
         §_-Gq§ = new §_-Le§(param1);
         §_-0C§();
         value = §in §();
      }
      
      private function §_-WO§() : Object
      {
         var _loc2_:String = null;
         var _loc1_:Object = new Object();
         §_-0C§();
         if(§_-Ow§.type == §_-K0§.RIGHT_BRACE)
         {
            return _loc1_;
         }
         while(true)
         {
            if(§_-Ow§.type == §_-K0§.§_-BP§)
            {
               _loc2_ = String(§_-Ow§.value);
               §_-0C§();
               if(§_-Ow§.type == §_-K0§.COLON)
               {
                  §_-0C§();
                  _loc1_[_loc2_] = §in §();
                  §_-0C§();
                  if(§_-Ow§.type == §_-K0§.RIGHT_BRACE)
                  {
                     break;
                  }
                  if(§_-Ow§.type == §_-K0§.COMMA)
                  {
                     §_-0C§();
                  }
                  else
                  {
                     §_-Gq§.§_-0-§("Expecting } or , but found " + §_-Ow§.value);
                  }
               }
               else
               {
                  §_-Gq§.§_-0-§("Expecting : but found " + §_-Ow§.value);
               }
            }
            else
            {
               §_-Gq§.§_-0-§("Expecting string but found " + §_-Ow§.value);
            }
         }
         return _loc1_;
      }
      
      private function §in §() : Object
      {
         switch(§_-Ow§.type)
         {
            case §_-K0§.LEFT_BRACE:
               return §_-WO§();
            case §_-K0§.LEFT_BRACKET:
               return §_-m8§();
            case §_-K0§.§_-BP§:
            case §_-K0§.§_-bT§:
            case §_-K0§.§_-nI§:
            case §_-K0§.§_-ly§:
            case §_-K0§.§_-Ua§:
               return §_-Ow§.value;
            default:
               §_-Gq§.§_-0-§("Unexpected " + §_-Ow§.value);
               return null;
         }
      }
      
      private function §_-0C§() : §_-5s§
      {
         return §_-Ow§ = §_-Gq§.§_-Bv§();
      }
      
      public function §_-Pf§() : *
      {
         return value;
      }
      
      private function §_-m8§() : Array
      {
         var _loc1_:Array = new Array();
         §_-0C§();
         if(§_-Ow§.type == §_-K0§.RIGHT_BRACKET)
         {
            return _loc1_;
         }
         while(true)
         {
            _loc1_.push(§in §());
            §_-0C§();
            if(§_-Ow§.type == §_-K0§.RIGHT_BRACKET)
            {
               break;
            }
            if(§_-Ow§.type == §_-K0§.COMMA)
            {
               §_-0C§();
            }
            else
            {
               §_-Gq§.§_-0-§("Expecting ] or , but found " + §_-Ow§.value);
            }
         }
         return _loc1_;
      }
   }
}
