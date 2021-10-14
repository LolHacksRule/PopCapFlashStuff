package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class FinisherPropWidget
   {
       
      
      private var movie:MovieClip = null;
      
      private var app:Blitz3App = null;
      
      public function FinisherPropWidget(param1:Blitz3App, param2:MovieClip)
      {
         super();
         this.app = param1;
         this.movie = param2;
      }
      
      public function AddToStage() : void
      {
         this.app.addChild(this.movie);
      }
      
      public function RemoveFromStage() : void
      {
         if(this.movie != null)
         {
            this.movie.parent.removeChild(this.movie);
            this.movie = null;
         }
      }
      
      public function setPosition(param1:Point) : void
      {
         this.movie.x = param1.x;
         this.movie.y = param1.y;
      }
      
      public function getPosition() : Point
      {
         return new Point(this.movie.x,this.movie.y);
      }
      
      public function setRotation(param1:Number) : void
      {
         this.movie.rotation = param1;
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         if(this.movie == null)
         {
            return;
         }
         this.movie.visible = param1;
         if(param1)
         {
            this.movie.gotoAndStop(this.movie.currentFrame);
         }
         else
         {
            this.movie.gotoAndPlay(this.movie.currentFrame);
         }
      }
      
      public function getBaseMovie() : MovieClip
      {
         return this.movie;
      }
   }
}
