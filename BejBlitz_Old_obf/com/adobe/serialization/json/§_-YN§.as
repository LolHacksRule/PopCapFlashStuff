package com.adobe.serialization.json
{
   public class §_-YN§ extends Error
   {
       
      
      private var §_-A1§:int;
      
      private var §_-kD§:String;
      
      public function §_-YN§(param1:String = "", param2:int = 0, param3:String = "")
      {
         super(param1);
         §_-A1§ = param2;
         §_-kD§ = param3;
      }
      
      public function get location() : int
      {
         return §_-A1§;
      }
      
      public function get text() : String
      {
         return §_-kD§;
      }
   }
}
