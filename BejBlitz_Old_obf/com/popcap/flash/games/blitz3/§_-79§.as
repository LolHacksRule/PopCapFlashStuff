package com.popcap.flash.games.blitz3
{
   import flash.net.SharedObject;
   
   public class §_-79§
   {
      
      private static const §_-Dr§:String = "Blitz3";
      
      public static const §_-Eh§:String = "showHelp";
      
      private static const §_-SC§:String = "/";
      
      public static const §_-5E§:String = "isMuted";
      
      public static const §_-pC§:String = "rareGemCounter";
       
      
      protected var §_-LR§:String = "";
      
      public function §_-79§(param1:String = "")
      {
         super();
         this.§_-LR§ = param1;
      }
      
      public function GetFlag(param1:String, param2:Boolean = false) : Boolean
      {
         var so:SharedObject = null;
         var flagName:String = param1;
         var defaultVal:Boolean = param2;
         try
         {
            so = SharedObject.getLocal(this.§_-aH§(),§_-SC§);
            if(flagName in so.data)
            {
               return so.data[flagName];
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to read SO value.");
         }
         return defaultVal;
      }
      
      public function §_-Ix§(param1:String, param2:int) : void
      {
         var so:SharedObject = null;
         var name:String = param1;
         var value:int = param2;
         try
         {
            so = SharedObject.getLocal(this.§_-aH§(),§_-SC§);
            so.setProperty(name,value);
            so.flush();
         }
         catch(err:Error)
         {
            trace("Error while attempting to set SO value.");
         }
      }
      
      public function §_-Z6§(param1:String, param2:int = -1) : int
      {
         var so:SharedObject = null;
         var name:String = param1;
         var defaultVal:int = param2;
         try
         {
            so = SharedObject.getLocal(this.§_-aH§(),§_-SC§);
            if(name in so.data)
            {
               return so.data[name];
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to read SO value.");
         }
         return defaultVal;
      }
      
      protected function §_-aH§() : String
      {
         if(this.§_-LR§.length > 0)
         {
            return §_-Dr§ + "_" + this.§_-LR§;
         }
         return §_-Dr§;
      }
      
      public function SetFlag(param1:String, param2:Boolean) : void
      {
         var so:SharedObject = null;
         var flagName:String = param1;
         var flagVal:Boolean = param2;
         try
         {
            so = SharedObject.getLocal(this.§_-aH§(),§_-SC§);
            so.setProperty(flagName,flagVal);
            so.flush();
         }
         catch(err:Error)
         {
            trace("Error while attempting to set SO value.");
         }
      }
      
      public function §_-gS§(param1:String) : Boolean
      {
         var so:SharedObject = null;
         var propName:String = param1;
         try
         {
            so = SharedObject.getLocal(this.§_-aH§(),§_-SC§);
            if(propName in so.data)
            {
               return true;
            }
         }
         catch(err:Error)
         {
            trace("Error while attempting to check for existance of SO value.");
         }
         return false;
      }
   }
}
