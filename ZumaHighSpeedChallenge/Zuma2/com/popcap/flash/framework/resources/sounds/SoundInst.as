package com.popcap.flash.framework.resources.sounds
{
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SoundInst
   {
       
      
      private var mIsDone:Boolean = false;
      
      public var source:SoundResource;
      
      private var mPosition:Number = 0;
      
      private var mChannel:SoundChannel;
      
      public var numPlays:int = 0;
      
      private var mTrans:SoundTransform;
      
      public function SoundInst()
      {
         super();
         this.mTrans = new SoundTransform();
      }
      
      public function isDone() : Boolean
      {
         return this.mIsDone;
      }
      
      private function die() : void
      {
         this.mIsDone = true;
         if(this.mChannel != null)
         {
            this.mChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         }
         this.mChannel = null;
      }
      
      private function handleComplete(param1:Event) : void
      {
         this.mChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mChannel = null;
         this.play(this.mTrans.volume);
      }
      
      public function stop() : void
      {
         if(this.mChannel == null)
         {
            return;
         }
         this.mChannel.stop();
         this.die();
      }
      
      public function resume() : void
      {
         if(this.mIsDone)
         {
            return;
         }
         if(this.mChannel != null)
         {
            return;
         }
         this.mChannel = this.source.sound.play(this.mPosition,0,this.mTrans);
         if(this.mChannel == null)
         {
            this.die();
            return;
         }
         this.mChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
      }
      
      public function reset(param1:SoundResource) : void
      {
         this.source = param1;
         this.mIsDone = false;
      }
      
      public function play(param1:Number = 1.0, param2:Number = 0) : void
      {
         if(this.source == null)
         {
            return;
         }
         if(this.mIsDone)
         {
            return;
         }
         if(this.mChannel != null)
         {
            return;
         }
         if(this.numPlays == 0)
         {
            this.die();
            return;
         }
         if(this.numPlays > 0)
         {
            --this.numPlays;
         }
         this.mTrans.volume = param1;
         this.mChannel = this.source.sound.play(param2,0,this.mTrans);
         if(this.mChannel == null)
         {
            this.die();
            return;
         }
         this.mChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
      }
      
      public function pause() : void
      {
         if(this.mChannel == null)
         {
            return;
         }
         this.mPosition = this.mChannel.position;
         this.mChannel.stop();
         this.mChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mChannel = null;
      }
      
      public function setVolume(param1:Number) : void
      {
         this.mTrans.volume = param1;
         if(this.mChannel != null)
         {
            this.mChannel.soundTransform = this.mTrans;
         }
      }
   }
}
