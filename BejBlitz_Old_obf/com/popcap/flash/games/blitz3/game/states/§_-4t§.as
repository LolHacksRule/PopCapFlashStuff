package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class §_-4t§ extends EventDispatcher implements IAppState
   {
      
      public static const §_-SN§:int = 50;
       
      
      private var §_-8Z§:Boolean = false;
      
      private var §_-JD§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var mApp:Blitz3Game;
      
      public function §_-4t§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.mApp.§_-Ba§.menu.playButton.addEventListener(MouseEvent.CLICK,this.§_-Z3§);
      }
      
      public function §_-7H§() : void
      {
         this.mApp.§_-Ba§.game.sidebar.buttons.menuButton.buttonMode = false;
         this.mApp.§_-Ba§.game.sidebar.buttons.hintButton.buttonMode = false;
         this.mApp.§_-gN§.screenID = 0;
         this.mApp.§_-Pa§();
         this.§_-8Z§ = true;
         this.§_-Gn§ = 0;
         this.mApp.§_-Ba§.menu.Reset();
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      private function §_-Z3§(param1:MouseEvent) : void
      {
         this.mApp.§_-Ba§.game.sidebar.buttons.menuButton.buttonMode = true;
         this.mApp.§_-Ba§.game.sidebar.buttons.hintButton.buttonMode = true;
         this.mApp.§_-2x§(this.StartGame);
      }
      
      public function StartGame() : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_PLAY_BUTTON_CLICK);
         this.mApp.network.PlayGame();
         this.mApp.§_-Ba§.game.Reset();
         this.mApp.§_-Ba§.game.sidebar.boostIcons.Clear();
         this.mApp.§_-Ba§.game.sidebar.rareGem.Clear();
         this.§_-JD§ = true;
         this.§_-8Z§ = false;
         this.§_-Gn§ = 0;
         this.mApp.§_-Ba§.menu.playButton.mouseEnabled = false;
         this.mApp.§_-Ba§.menu.playButton.useHandCursor = false;
         this.mApp.§_-Ba§.stage.focus = this.mApp.§_-Ba§.stage;
      }
      
      public function update() : void
      {
         this.mApp.§_-Ba§.menu.Update();
         if(!this.§_-JD§)
         {
            return;
         }
         ++this.§_-Gn§;
         var _loc1_:Number = this.§_-Gn§ / §_-SN§;
         if(this.§_-8Z§)
         {
            _loc1_ = 1 - _loc1_;
         }
         this.§_-mv§(_loc1_);
         if(this.§_-Gn§ == §_-SN§)
         {
            if(this.§_-8Z§)
            {
               this.§_-8Z§ = false;
               this.§_-JD§ = false;
               this.mApp.§_-Ba§.menu.playButton.mouseEnabled = true;
               this.mApp.§_-Ba§.menu.playButton.useHandCursor = true;
            }
            else
            {
               this.mApp.§_-Ba§.menu.visible = false;
               dispatchEvent(new Event(§_-pB§.§_-by§));
            }
         }
      }
      
      public function §_-Bz§() : void
      {
      }
      
      private function §_-mv§(param1:Number) : void
      {
         this.mApp.§_-Ba§.menu.alpha = 1 - param1;
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
   }
}
