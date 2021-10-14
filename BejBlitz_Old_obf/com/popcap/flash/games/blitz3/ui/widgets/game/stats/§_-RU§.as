package com.popcap.flash.games.blitz3.ui.widgets.game.stats
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class §_-RU§ extends §_-25§
   {
      
      private static const §_-8P§:Class = §_-1o§;
      
      private static const §_-4U§:Class = §_-4q§;
      
      private static const UP:Class = §_-I7§;
       
      
      public function §_-RU§(param1:§_-0Z§)
      {
         super(param1);
      }
      
      public function Init() : void
      {
         §_-G0§.addChild(new UP());
         §_-5H§.addChild(new §_-8P§());
         background.addChild(new §_-4U§());
         §_-ge§();
      }
      
      public function MouseOver(param1:MouseEvent) : void
      {
         var _loc2_:Event = new Event("MouseOver",true);
         dispatchEvent(_loc2_);
      }
      
      public function §_-DW§(param1:MouseEvent) : void
      {
         var _loc2_:Event = new Event("PlayAgain",true);
         var _loc3_:Event = new Event("MouseClick",true);
         dispatchEvent(_loc3_);
         dispatchEvent(_loc2_);
      }
   }
}
