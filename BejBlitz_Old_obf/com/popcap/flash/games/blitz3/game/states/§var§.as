package com.popcap.flash.games.blitz3.game.states
{
   import §case §.§_-Zh§;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class §var§ extends Sprite implements IAppState
   {
       
      
      private var mApp:§_-Zh§;
      
      public function §var§(param1:§_-Zh§)
      {
         super();
         this.mApp = param1;
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function §_-Bz§() : void
      {
      }
      
      public function update() : void
      {
         dispatchEvent(new Event(§_-31§.§_-41§));
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-7H§() : void
      {
         this.mApp.logic.Reset();
         this.mApp.§_-Ba§.game.Reset();
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
   }
}
