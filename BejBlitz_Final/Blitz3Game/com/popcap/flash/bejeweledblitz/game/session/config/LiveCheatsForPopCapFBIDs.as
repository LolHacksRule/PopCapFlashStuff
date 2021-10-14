package com.popcap.flash.bejeweledblitz.game.session.config
{
   public class LiveCheatsForPopCapFBIDs
   {
      
      private static var FB_IDS:Array = new Array();
      
      public static var isOn:Boolean = false;
       
      
      public function LiveCheatsForPopCapFBIDs()
      {
         super();
      }
      
      public static function init(param1:Blitz3Game) : void
      {
         FB_IDS.push("639052381");
         if(FB_IDS.indexOf(param1.network.parameters.fb_user) < 0)
         {
            return;
         }
         isOn = false;
      }
   }
}
