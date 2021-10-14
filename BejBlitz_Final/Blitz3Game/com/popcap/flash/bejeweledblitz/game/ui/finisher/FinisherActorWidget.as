package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherAnimHandler;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class FinisherActorWidget
   {
       
      
      private var startFrame:int;
      
      private var endFrame:int;
      
      private var movie:MovieClip;
      
      private var app:Blitz3App;
      
      private var _animationType:int = -1;
      
      private var _completeHandlers:Vector.<IFinisherAnimHandler> = null;
      
      private var _animationIsDone:Boolean = false;
      
      private var audioIsPlayed:Boolean = false;
      
      private var playAudioFrame:int = -1;
      
      private var playAudioFn:Function = null;
      
      private var audioLabels:Array;
      
      public function FinisherActorWidget(param1:Blitz3App, param2:MovieClip)
      {
         var _loc5_:FrameLabel = null;
         super();
         this.app = param1;
         this._completeHandlers = new Vector.<IFinisherAnimHandler>();
         this.movie = param2;
         this.movie.gotoAndStop(0);
         var _loc3_:Array = this.movie.currentLabels;
         this.audioLabels = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            if((_loc5_ = _loc3_[_loc4_]).name.indexOf("Audio") > -1)
            {
               this.audioLabels.push(_loc5_.frame);
            }
            _loc4_++;
         }
      }
      
      public function SetAudioPlayfn(param1:Function) : void
      {
         this.playAudioFn = param1;
      }
      
      public function Parse(param1:int, param2:int) : void
      {
         var _loc5_:int = 0;
         if(param2 == -1)
         {
            param2 = this.movie.totalFrames;
         }
         this.startFrame = param1;
         this.endFrame = param2;
         var _loc3_:int = this.audioLabels.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.audioLabels[_loc4_]) > param1 && _loc5_ < param2)
            {
               this.playAudioFrame = _loc5_;
               break;
            }
            _loc4_++;
         }
      }
      
      public function Play(param1:int) : void
      {
         this._animationIsDone = false;
         this.audioIsPlayed = false;
         this._animationType = param1;
         this.movie.gotoAndPlay(this.startFrame);
      }
      
      public function Update() : void
      {
         if(this._animationIsDone)
         {
            return;
         }
         if(!this.audioIsPlayed && this.movie.currentFrame >= this.playAudioFrame)
         {
            if(this.playAudioFn != null)
            {
               this.playAudioFn(this._animationType);
            }
            this.audioIsPlayed = true;
         }
         if(this.movie.currentFrame >= this.endFrame)
         {
            this.movie.stop();
            this._animationIsDone = true;
            this.playAudioFrame = -1;
            this.DispatchAnimationComplete();
         }
      }
      
      public function AddAnimationCompleteHandler(param1:IFinisherAnimHandler) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._completeHandlers.push(param1);
      }
      
      public function RemoveAnimationCompleteHandler(param1:IFinisherAnimHandler) : void
      {
         var _loc2_:int = this._completeHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._completeHandlers.splice(_loc2_,1);
      }
      
      private function DispatchAnimationComplete() : void
      {
         var _loc1_:IFinisherAnimHandler = null;
         for each(_loc1_ in this._completeHandlers)
         {
            _loc1_.AnimationCompleted(this._animationType);
         }
      }
      
      public function AddToStage() : void
      {
         (this.app.ui as MainWidgetGame).game.AlignmentAnchor.addChild(this.movie);
      }
      
      public function RemoveFromStage() : void
      {
         if(this.movie != null)
         {
            (this.app.ui as MainWidgetGame).game.AlignmentAnchor.removeChild(this.movie);
            this.movie = null;
         }
      }
      
      public function getPropSpawningPosition() : Point
      {
         var _loc1_:MovieClip = this.movie.getChildByName("PropTrigger") as MovieClip;
         if(_loc1_ != null)
         {
            return this.movie.localToGlobal(new Point(_loc1_.x,_loc1_.y));
         }
         return this.movie.localToGlobal(new Point(0,0));
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.movie.visible = param1;
         if(param1)
         {
            this.movie.gotoAndPlay(this.movie.currentFrame);
         }
         else
         {
            this.movie.gotoAndStop(this.movie.currentFrame);
         }
      }
   }
}
