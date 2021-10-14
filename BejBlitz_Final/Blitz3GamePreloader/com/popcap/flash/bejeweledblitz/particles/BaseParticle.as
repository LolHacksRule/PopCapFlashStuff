package com.popcap.flash.bejeweledblitz.particles
{
   import com.plumbee.stardustplayer.SimLoader;
   import com.plumbee.stardustplayer.SimPlayer;
   import com.plumbee.stardustplayer.SimTimeModel;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class BaseParticle extends Sprite
   {
       
      
      private var loader:SimLoader;
      
      private var player:SimPlayer;
      
      private var timeModel:SimTimeModel;
      
      private var autoDeleteTimer:Timer = null;
      
      public function BaseParticle()
      {
         super();
         this.timeModel = new SimTimeModel();
         this.player = new SimPlayer();
         this.loader = new SimLoader();
      }
      
      public function loadSim(param1:ByteArray) : void
      {
         this.loader.addEventListener(Event.COMPLETE,this.onSimLoaded);
         this.loader.loadSim(param1);
      }
      
      private function onSimLoaded(param1:Event) : void
      {
         this.timeModel.resetTime();
         this.player.setSimulation(this.loader.project,this);
         ParticleUpdater.GetInstance().AddParticle(this);
         this.loader.removeEventListener(Event.COMPLETE,this.onSimLoaded);
         addEventListener(Event.REMOVED_FROM_STAGE,this.CleanUp);
      }
      
      public function onEnterFrame(param1:Event) : void
      {
         this.timeModel.update();
         this.player.stepSimulation(this.timeModel.timeStepNormalizedTo60fps);
      }
      
      public function AutoDelete(param1:Number) : void
      {
         this.autoDeleteTimer = new Timer(param1);
         this.autoDeleteTimer.addEventListener(TimerEvent.TIMER,this.timerCompleteHandler);
         this.autoDeleteTimer.start();
      }
      
      private function timerCompleteHandler(param1:TimerEvent) : void
      {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function CleanUp(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.CleanUp);
         ParticleUpdater.GetInstance().RemoveParticle(this);
         if(this.autoDeleteTimer != null)
         {
            this.autoDeleteTimer.removeEventListener(TimerEvent.TIMER,this.timerCompleteHandler);
            this.autoDeleteTimer.stop();
            this.autoDeleteTimer = null;
         }
      }
   }
}
