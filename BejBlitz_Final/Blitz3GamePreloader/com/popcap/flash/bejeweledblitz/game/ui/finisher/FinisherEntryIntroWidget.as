package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherEntryIntroHandler;
   import flash.display.MovieClip;
   
   public class FinisherEntryIntroWidget
   {
       
      
      private var movie:MovieClip = null;
      
      private var app:Blitz3App = null;
      
      private var completeHandlers:Vector.<IFinisherEntryIntroHandler> = null;
      
      public function FinisherEntryIntroWidget(param1:Blitz3App, param2:MovieClip)
      {
         super();
         this.app = param1;
         this.movie = param2;
         this.completeHandlers = new Vector.<IFinisherEntryIntroHandler>();
      }
      
      public function AddAnimationCompleteHandler(param1:IFinisherEntryIntroHandler) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.completeHandlers.push(param1);
      }
      
      public function RemoveAnimationCompleteHandler(param1:IFinisherEntryIntroHandler) : void
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
         (this.app.ui as MainWidgetGame).game.AlignmentAnchor.addChild(this.movie);
      }
      
      public function didAnimationComplete() : Boolean
      {
         return this.movie.currentFrame == this.movie.totalFrames;
      }
      
      public function Update() : void
      {
         if(this.didAnimationComplete())
         {
            this.DispatchAnimationCompletedEvent();
         }
      }
      
      private function DispatchAnimationCompletedEvent() : void
      {
         var _loc1_:IFinisherEntryIntroHandler = null;
         for each(_loc1_ in this.completeHandlers)
         {
            _loc1_.AnimationCompleted();
         }
      }
      
      public function RemoveFromStage() : void
      {
         if(this.movie != null)
         {
            (this.app.ui as MainWidgetGame).game.AlignmentAnchor.removeChild(this.movie);
            this.movie = null;
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.movie.visible = param1;
      }
   }
}
