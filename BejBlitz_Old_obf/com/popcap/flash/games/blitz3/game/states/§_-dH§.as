package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class §_-dH§ extends Sprite implements IAppState, IBlitz3NetworkHandler
   {
       
      
      private var §_-1D§:Boolean = false;
      
      private var §_-kK§:Boolean = false;
      
      private var §_-8h§:Boolean = false;
      
      private var mApp:Blitz3Game;
      
      public function §_-dH§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.mApp.§_-Ba§.stats.playAgainButton.addEventListener(MouseEvent.CLICK,this.§_-f7§);
         this.mApp.network.AddHandler(this);
      }
      
      private function §_-KM§(param1:Event) : void
      {
      }
      
      public function §_-Kw§(param1:int) : void
      {
      }
      
      private function §_-Tf§() : void
      {
         if(this.mApp.§_-o3§.HasCurRareGem())
         {
            try
            {
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("reportSimpleEvent","RareGemBought");
               }
            }
            catch(err:Error)
            {
            }
            if(this.§_-1D§)
            {
               try
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("reportSimpleEvent","RareGemMonitized");
                  }
               }
               catch(err:Error)
               {
               }
            }
         }
         this.mApp.§_-2x§(this.StartGame);
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-Bz§() : void
      {
         this.§_-6v§();
         this.mApp.§_-Ba§.stage.focus = this.mApp.§_-Ba§.stage;
      }
      
      private function §_-a5§(param1:Event) : void
      {
         var e:Event = param1;
         var score:int = this.mApp.logic.GetScore();
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("launchFeedForm_StarMedalFromFlash",score);
            }
         }
         catch(err:Error)
         {
            trace("Unable to publish feed due to ExternalInterface error:");
            trace(err);
         }
      }
      
      private function §_-f7§(param1:Event) : void
      {
         var e:Event = param1;
         if(this.mApp.§_-o3§.ShouldAwardRareGem() || this.mApp.§_-o3§.HasCurRareGem() && this.mApp.§_-3A§ < 0)
         {
            this.mApp.§_-Ba§.stats.ShowRareGemScreen(this.§_-Tf§);
            if(!this.§_-kK§)
            {
               try
               {
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("reportSimpleEvent","RareGemOffered");
                     this.§_-kK§ = true;
                  }
               }
               catch(err:Error)
               {
               }
            }
         }
         else
         {
            this.§_-Tf§();
         }
      }
      
      public function Reset() : void
      {
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
      
      private function §_-Xu§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function §_-ES§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_RELEASE);
      }
      
      public function §_-7H§() : void
      {
         this.§_-kK§ = false;
         this.§_-1D§ = false;
         this.mApp.§_-gN§.screenID = this.mApp.logic.multiLogic.multiplier;
         this.mApp.§_-Pa§();
         this.§_-cI§();
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-5Q§(param1:int) : void
      {
      }
      
      public function draw(param1:int) : void
      {
      }
      
      private function §package§(param1:Event) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_NEW_HIGH_SCORE);
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
      }
      
      public function §_-2R§(param1:int) : void
      {
      }
      
      public function update() : void
      {
         this.mApp.§_-Ba§.stats.Update();
         this.mApp.§_-Ba§.boosts.Update();
      }
      
      private function StartGame() : void
      {
         dispatchEvent(new Event(§_-31§.§_-a6§));
      }
      
      public function §use§(param1:Dictionary) : void
      {
      }
      
      public function §_-2i§() : void
      {
      }
      
      public function §_-fX§() : void
      {
      }
      
      private function §_-6v§() : void
      {
         if(!this.§_-8h§)
         {
            return;
         }
         this.mApp.§_-Ba§.stats.ResetButtonState();
         this.mApp.§_-Ba§.removeChild(this.mApp.§_-Ba§.stats);
         this.mApp.§_-Ba§.game.board.visible = true;
         this.mApp.§_-Ba§.game.sidebar.visible = true;
         this.§_-8h§ = false;
      }
      
      private function §_-cI§() : void
      {
         var _loc4_:Object = null;
         if(this.§_-8h§)
         {
            return;
         }
         if(this.mApp.logic.GetScore() == this.mApp.§_-fV§)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_VOICE_NEW_HIGH_SCORE);
         }
         this.mApp.§_-Ba§.addChild(this.mApp.§_-Ba§.stats);
         this.mApp.§_-Ba§.game.board.visible = false;
         this.mApp.§_-Ba§.game.sidebar.visible = false;
         this.mApp.§_-Ba§.boosts.visible = true;
         this.mApp.§_-Ba§.boosts.alpha = 1;
         this.mApp.§_-Ba§.stats.SetOffline(this.mApp.network.isOffline);
         this.mApp.§_-Ba§.stats.Reset();
         this.mApp.§_-Ba§.stats.SetPowerGemCounts(this.mApp.logic.flameGemLogic.numCreated,this.mApp.logic.starGemLogic.numDestroyed,this.mApp.logic.hypercubeLogic.numDestroyed);
         this.mApp.§_-Ba§.stats.SetScores(this.mApp.logic.scoreKeeper.scores,this.mApp.logic.GetGameDuration());
         var _loc1_:Array = this.mApp.logic.multiLogic.used;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _loc1_[_loc3_];
            this.mApp.§_-Ba§.stats.AddMultiplier(_loc4_.time,_loc4_.number,_loc4_.color);
            _loc3_++;
         }
         this.mApp.§_-Ba§.stats.StartAnimation();
         this.§_-8h§ = true;
         this.mApp.§_-Ba§.boosts.alpha = 1;
         this.mApp.§_-Ba§.boosts.visible = true;
         this.mApp.§_-Ba§.boosts.OnShowBar();
         this.mApp.§_-Ba§.stats.addChild(this.mApp.§_-Ba§.boosts);
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
         if(param1)
         {
            this.§_-1D§ = true;
         }
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
      }
      
      private function §_-Lv§(param1:MouseEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BUTTON_PRESS);
      }
   }
}
