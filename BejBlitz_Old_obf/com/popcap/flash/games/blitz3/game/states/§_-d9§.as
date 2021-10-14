package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class §_-d9§ extends Sprite implements IAppState
   {
      
      public static const §_-hr§:int = 250;
       
      
      private var §_-1§:Point;
      
      private var §_-Gn§:int = 0;
      
      private var mApp:Blitz3Game;
      
      private var §_-l6§:Point;
      
      public function §_-d9§(param1:Blitz3Game)
      {
         this.§_-l6§ = new Point();
         this.§_-1§ = new Point();
         super();
         this.mApp = param1;
      }
      
      public function §_-7H§() : void
      {
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function update() : void
      {
         if(this.mApp.§_-Ba§.game.board.clock.alpha < 1)
         {
            this.mApp.§_-Ba§.game.board.clock.alpha += 0.05;
         }
         this.mApp.logic.isActive = false;
         this.mApp.logic.update();
         --this.§_-Gn§;
         var _loc1_:int = Math.min(100,this.§_-Gn§);
         var _loc2_:Number = 1 - _loc1_ / 100;
         var _loc3_:Sprite = this.mApp.§_-Ba§.game.board;
         var _loc4_:Sprite;
         (_loc4_ = this.mApp.§_-Ba§.game.board.clock).scaleX = (1 - _loc2_) * 3 + 1;
         _loc4_.scaleY = (1 - _loc2_) * 3 + 1;
         _loc4_.x = 160;
         _loc4_.y = 160 + 169.5 * _loc2_;
         if(this.§_-Gn§ == 0)
         {
            dispatchEvent(new Event(§_-ol§.§_-H5§));
         }
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function §_-TD§(param1:String) : void
      {
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-Bz§() : void
      {
      }
      
      public function §_-B§(param1:String) : void
      {
      }
      
      public function Reset() : void
      {
         this.mApp.§_-Ba§.game.Reset();
         this.mApp.§_-Ba§.game.board.clock.alpha = 0;
         this.§_-Gn§ = §_-hr§;
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_ONE_MINUTE);
         this.mApp.network.StartGame();
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
   }
}
