package com.popcap.flash.framework.resources.sounds
{
   import flash.events.Event;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class SoundInst
   {
       
      
      private var §_-4z§:Boolean = false;
      
      public var source:SoundResource;
      
      private var §_-ae§:Number = 0;
      
      private var §_-JK§:SoundChannel;
      
      public var §_-aL§:int = 0;
      
      private var §_-O-§:SoundTransform;
      
      public function SoundInst()
      {
         super();
         this.§_-O-§ = new SoundTransform();
      }
      
      public function §_-nM§() : Boolean
      {
         return this.§_-4z§;
      }
      
      private function §_-Np§() : void
      {
         this.§_-4z§ = true;
         if(this.§_-JK§ != null)
         {
            this.§_-JK§.removeEventListener(Event.SOUND_COMPLETE,this.§_-Px§);
         }
         this.§_-JK§ = null;
      }
      
      private function §_-Px§(param1:Event) : void
      {
         this.§_-JK§.removeEventListener(Event.SOUND_COMPLETE,this.§_-Px§);
         this.§_-JK§ = null;
         this.play(this.§_-O-§.volume);
      }
      
      public function stop() : void
      {
         if(this.§_-JK§ == null)
         {
            return;
         }
         this.§_-JK§.stop();
         this.§_-Np§();
      }
      
      public function resume() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-JK§ != null)
         {
            return;
         }
         this.§_-JK§ = this.source.sound.play(this.§_-ae§,0,this.§_-O-§);
         if(this.§_-JK§ == null)
         {
            this.§_-Np§();
            return;
         }
         this.§_-JK§.addEventListener(Event.SOUND_COMPLETE,this.§_-Px§);
      }
      
      public function §_-P0§(param1:SoundResource) : void
      {
         this.source = param1;
         this.§_-4z§ = false;
      }
      
      public function play(param1:Number = 1.0, param2:Number = 0) : void
      {
         if(this.source == null)
         {
            return;
         }
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-JK§ != null)
         {
            return;
         }
         if(this.§_-aL§ == 0)
         {
            this.§_-Np§();
            return;
         }
         if(this.§_-aL§ > 0)
         {
            --this.§_-aL§;
         }
         this.§_-O-§.volume = param1;
         this.§_-JK§ = this.source.sound.play(param2,0,this.§_-O-§);
         if(this.§_-JK§ == null)
         {
            this.§_-Np§();
            return;
         }
         this.§_-JK§.addEventListener(Event.SOUND_COMPLETE,this.§_-Px§);
      }
      
      public function pause() : void
      {
         if(this.§_-JK§ == null)
         {
            return;
         }
         this.§_-ae§ = this.§_-JK§.position;
         this.§_-JK§.stop();
         this.§_-JK§.removeEventListener(Event.SOUND_COMPLETE,this.§_-Px§);
         this.§_-JK§ = null;
      }
      
      public function §_-Zo§(param1:Number) : void
      {
         this.§_-O-§.volume = param1;
         if(this.§_-JK§ != null)
         {
            this.§_-JK§.soundTransform = this.§_-O-§;
         }
      }
   }
}
