package org.osmf.logging
{
   public class Logger
   {
       
      
      private var _category:String;
      
      public function Logger(param1:String)
      {
         super();
         this._category = param1;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function debug(param1:String, ... rest) : void
      {
      }
      
      public function info(param1:String, ... rest) : void
      {
      }
      
      public function warn(param1:String, ... rest) : void
      {
      }
      
      public function error(param1:String, ... rest) : void
      {
      }
      
      public function fatal(param1:String, ... rest) : void
      {
      }
   }
}
