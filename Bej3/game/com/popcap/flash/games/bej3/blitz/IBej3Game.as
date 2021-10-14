package com.popcap.flash.games.bej3.blitz
{
   import com.popcap.flash.framework.ads.MSNAdAPI;
   import com.popcap.flash.framework.resources.localization.LocalizationManager;
   import flash.display.MovieClip;
   
   public interface IBej3Game
   {
       
      
      function startGame() : void;
      
      function hide(param1:Boolean = false) : void;
      
      function show() : void;
      
      function setMenu(param1:IBej3MainMenu) : void;
      
      function setAPI(param1:MSNAdAPI) : void;
      
      function setLocXML(param1:XML) : void;
      
      function getLocManager() : LocalizationManager;
      
      function getHelpScreen() : IHelpWidget;
      
      function setVolume(param1:Number) : void;
      
      function getVolume() : Number;
      
      function setBackgrounds(param1:MovieClip, param2:MovieClip) : void;
      
      function setDataXML(param1:XML) : void;
   }
}
