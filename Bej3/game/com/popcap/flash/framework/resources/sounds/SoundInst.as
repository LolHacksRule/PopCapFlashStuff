package com.popcap.flash.framework.resources.sounds
{
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SoundInst
   {
       
      
      public var source:SoundResource;
      
      public var numPlays:int = 0;
      
      private var mIsDone:Boolean = false;
      
      private var mTrans:SoundTransform;
      
      private var mChannel:SoundChannel;
      
      private var mPosition:Number = 0;
      
      public function SoundInst()
      {
         super();
         this.mTrans = new SoundTransform();
      }
      
      public function setVolume(volume:Number) : void
      {
         this.mTrans.volume = volume;
         if(this.mChannel != null)
         {
            this.mChannel.soundTransform = this.mTrans;
         }
      }
      
      public function reset(res:SoundResource) : void
      {
         this.source = res;
         this.mIsDone = false;
      }
      
      public function play(volume:Number = 1.0, position:Number = 0) : void
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
         this.mTrans.volume = volume;
         this.mChannel = this.source.sound.play(position,0,this.mTrans);
         if(this.mChannel == null)
         {
            this.die();
            return;
         }
         this.mChannel.addEventListener(Event.SOUND_COMPLETE,this.handleComplete);
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
      
      private function handleComplete(e:Event) : void
      {
         this.mChannel.removeEventListener(Event.SOUND_COMPLETE,this.handleComplete);
         this.mChannel = null;
         this.play(this.mTrans.volume);
      }
   }
}
