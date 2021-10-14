package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.§_-27§;
   import com.popcap.flash.framework.§_-Tn§;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class §_-pB§ extends Sprite implements IAppState
   {
      
      public static const §_-32§:String = "State:Game";
      
      public static const §_-Z4§:String = "Event:Quit";
      
      public static const §_-by§:String = "Event:Play";
      
      public static const §_-gk§:String = "State:Main";
       
      
      private var §_-YP§:§_-Tn§;
      
      public var game:§_-31§;
      
      public var menu:§_-4t§;
      
      private var mApp:Blitz3Game;
      
      public function §_-pB§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.§_-YP§ = new §_-27§();
         this.menu = new §_-4t§(param1);
         this.game = new §_-31§(param1);
         this.menu.addEventListener(§_-by§,this.§_-Yx§);
         this.game.addEventListener(§_-Z4§,this.§_-E2§);
         this.§_-YP§.§_-Fl§(§_-gk§,this.menu);
         this.§_-YP§.§_-Fl§(§_-32§,this.game);
         addChild(this.game);
      }
      
      public function §_-7H§() : void
      {
         this.§_-YP§.§_-Jp§(§_-gk§);
      }
      
      public function draw(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().draw(param1);
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-3Z§(param1,param2);
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-W-§(param1,param2);
      }
      
      public function update() : void
      {
         this.§_-YP§.§_-Sp§().update();
      }
      
      public function §_-5Q§(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().§_-5Q§(param1);
      }
      
      public function §_-Fn§() : void
      {
      }
      
      private function §_-Yx§(param1:Event) : void
      {
         this.§_-YP§.§_-Jp§(§_-32§);
      }
      
      public function §_-Bz§() : void
      {
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-Yz§(param1,param2);
      }
      
      public function §_-2R§(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().§_-2R§(param1);
      }
      
      private function §_-E2§(param1:Event) : void
      {
         this.mApp.logic.Quit();
         this.mApp.§_-Ba§.menu.visible = true;
         this.§_-YP§.§_-Jp§(§_-gk§);
      }
   }
}
