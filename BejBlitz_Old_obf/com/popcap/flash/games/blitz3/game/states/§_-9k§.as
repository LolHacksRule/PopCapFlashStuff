package com.popcap.flash.games.blitz3.game.states
{
   import §_-D4§.§_-I6§;
   import §case §.§_-Zh§;
   import com.popcap.flash.framework.IAppState;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class §_-9k§ extends Sprite implements IAppState, §_-I6§
   {
      
      public static const set:int = 175;
      
      public static const §_-1x§:int = 175;
       
      
      private var §_-Gn§:int = 0;
      
      private var §_-CL§:Boolean = false;
      
      private var §_-eP§:Boolean = false;
      
      private var mApp:§_-Zh§;
      
      public function §_-9k§(param1:§_-Zh§)
      {
         super();
         this.mApp = param1;
      }
      
      public function §_-7H§() : void
      {
         if(!this.§_-eP§)
         {
            this.§_-Gn§ = set;
            this.§_-eP§ = true;
         }
         this.mApp.logic.Resume();
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function draw(param1:int) : void
      {
         this.mApp.§_-Ba§.game.board.frame.Draw();
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function update() : void
      {
         if(!this.mApp.logic.isActive)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_GO);
            this.mApp.§_-Ba§.game.board.broadcast.PlayGo();
         }
         this.mApp.logic.isActive = true;
         this.mApp.logic.update();
         if(this.mApp.logic.GetTimeRemaining() == 0 && this.§_-CL§ == false)
         {
            this.§_-CL§ = true;
            this.mApp.§_-Ba§.game.board.broadcast.PlayTimeUp();
         }
         if(this.mApp.logic.GetTimeRemaining() == 0)
         {
            if(this.§_-Gn§ > 0)
            {
               --this.§_-Gn§;
            }
         }
         if(this.mApp.logic.isGameOver && this.§_-Gn§ == 0)
         {
            dispatchEvent(new Event(§_-ol§.§_-ha§));
            this.§_-eP§ = false;
         }
         this.mApp.§_-Ba§.game.board.frame.Update();
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function §_-B§(param1:String) : void
      {
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-K3§(param1:String) : void
      {
         dispatchEvent(new Event(§_-ol§.§_-86§));
      }
      
      public function §_-Bz§() : void
      {
         this.mApp.logic.Pause();
      }
      
      public function §_-TD§(param1:String) : void
      {
      }
      
      public function Reset() : void
      {
         this.§_-eP§ = false;
         this.§_-CL§ = false;
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
   }
}
