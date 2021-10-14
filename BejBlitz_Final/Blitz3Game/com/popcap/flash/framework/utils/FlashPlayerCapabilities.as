package com.popcap.flash.framework.utils
{
   import flash.system.Capabilities;
   
   public class FlashPlayerCapabilities
   {
       
      
      public const BROWSER_IDENTIFIERS:Vector.<String> = new Vector.<String>("Plugin","ActiveX");
      
      public const AIR_IDENTIFIER:String = "Desktop";
      
      public const STANDALONE_IDENTIFIER:String = "Standalone";
      
      public const PREVIEWER_IDENTIFIER:String = "External";
      
      private var playerType:String;
      
      public function FlashPlayerCapabilities()
      {
         super();
         this.playerType = String(Capabilities.playerType);
      }
      
      public function isRunningInAdobeAir() : Boolean
      {
         return this.playerType == this.AIR_IDENTIFIER;
      }
   }
}
