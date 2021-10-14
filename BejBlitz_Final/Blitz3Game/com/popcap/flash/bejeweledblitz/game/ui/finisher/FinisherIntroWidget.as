package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherIntroHandler;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   
   public class FinisherIntroWidget
   {
       
      
      private var movie:MovieClip = null;
      
      private var app:Blitz3App = null;
      
      private var completeHandlers:Vector.<IFinisherIntroHandler> = null;
      
      private var finisherWidget:FinisherWidget = null;
      
      private var audioIsPlayed:Boolean = false;
      
      private var playAudioFrame:int = -1;
      
      public function FinisherIntroWidget(param1:Blitz3App, param2:MovieClip, param3:FinisherWidget)
      {
         var _loc6_:FrameLabel = null;
         super();
         this.app = param1;
         this.movie = param2;
         this.finisherWidget = param3;
         this.completeHandlers = new Vector.<IFinisherIntroHandler>();
         var _loc4_:Array = param2.currentLabels;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_.length)
         {
            if((_loc6_ = _loc4_[_loc5_]).name == "playAudio")
            {
               this.playAudioFrame = _loc6_.frame;
            }
            _loc5_++;
         }
      }
      
      public function AddAnimationCompleteHandler(param1:IFinisherIntroHandler) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.completeHandlers.push(param1);
      }
      
      public function RemoveAnimationCompleteHandler(param1:IFinisherIntroHandler) : void
      {
         var _loc2_:int = this.completeHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.completeHandlers.splice(_loc2_,1);
      }
      
      public function AddToStage() : void
      {
         this.app.addChild(this.movie);
      }
      
      public function didAnimationComplete() : Boolean
      {
         return this.movie.currentFrame == this.movie.totalFrames;
      }
      
      public function Update() : void
      {
         if(!this.audioIsPlayed && this.movie.currentFrame >= this.playAudioFrame)
         {
            this.finisherWidget.playSound(FinisherFacade.INTRO_ANIM);
            this.audioIsPlayed = true;
         }
         if(this.didAnimationComplete())
         {
            this.DispatchPopupAnimationCompleted();
         }
      }
      
      private function DispatchPopupAnimationCompleted() : void
      {
         var _loc1_:IFinisherIntroHandler = null;
         for each(_loc1_ in this.completeHandlers)
         {
            _loc1_.AnimationCompleted();
         }
      }
      
      public function RemoveFromStage() : void
      {
         if(this.movie != null)
         {
            this.app.removeChild(this.movie);
            this.movie = null;
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.movie.visible = param1;
      }
   }
}
