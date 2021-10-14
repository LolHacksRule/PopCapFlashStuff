package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.blitz3.§_-79§;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class §_-Wb§ extends Sprite implements IAppState
   {
       
      
      private var §_-8h§:Boolean = false;
      
      private var §_-hu§:Boolean = false;
      
      private var mApp:Blitz3Game;
      
      private var §_-Eb§:Boolean = false;
      
      public function §_-Wb§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.§_-Eb§ = this.mApp.§_-FL§.GetFlag(§_-79§.§_-Eh§);
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      private function §_-0G§() : void
      {
         if(!this.§_-8h§)
         {
            return;
         }
         this.mApp.§_-Ba§.removeChild(this.mApp.§_-Ba§.help);
         this.§_-8h§ = false;
      }
      
      public function draw(param1:int) : void
      {
      }
      
      private function §_-Fo§() : void
      {
         if(this.§_-8h§)
         {
            return;
         }
         this.mApp.§_-Ba§.addChild(this.mApp.§_-Ba§.help);
         this.mApp.§_-Ba§.help.continueButton.visible = true;
         this.mApp.§_-Ba§.help.backButton.visible = false;
         this.mApp.§_-Ba§.help.StartTutorial();
         this.§_-8h§ = true;
      }
      
      private function §_-ES§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function update() : void
      {
         if(this.§_-Eb§)
         {
            dispatchEvent(new Event(§_-31§.§_-a6§));
            return;
         }
         this.§_-Fo§();
      }
      
      public function §_-7H§() : void
      {
         if(this.§_-Eb§)
         {
            return;
         }
         this.§_-Fo§();
      }
      
      private function §null§(param1:Event) : void
      {
         this.mApp.§_-FL§.SetFlag(§_-79§.§_-Eh§,true);
         this.§_-Eb§ = true;
         dispatchEvent(new Event(§_-31§.§_-a6§));
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function §_-Bz§() : void
      {
         this.§_-0G§();
      }
      
      public function §_-bL§(param1:Boolean) : void
      {
         this.§_-hu§ = param1;
         this.mApp.§_-Ba§.help.continueButton.addEventListener(MouseEvent.CLICK,this.§null§);
         this.mApp.§_-Ba§.help.continueButton.addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         this.mApp.§_-Ba§.help.continueButton.addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      private function §_-Xu§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function §_-Lv§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
   }
}
