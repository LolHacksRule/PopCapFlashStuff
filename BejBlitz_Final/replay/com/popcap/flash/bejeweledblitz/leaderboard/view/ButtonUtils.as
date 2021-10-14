package com.popcap.flash.bejeweledblitz.leaderboard.view
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ButtonUtils
   {
       
      
      public function ButtonUtils()
      {
         super();
      }
      
      public static function AddButtonListeners(clip:MovieClip) : void
      {
         clip.mouseChildren = false;
         clip.addEventListener(MouseEvent.MOUSE_OVER,HandleOver);
         clip.addEventListener(MouseEvent.ROLL_OVER,HandleOver);
         clip.addEventListener(MouseEvent.MOUSE_OUT,HandleOut);
         clip.addEventListener(MouseEvent.ROLL_OUT,HandleOut);
      }
      
      private static function HandleOver(event:MouseEvent) : void
      {
         (event.target as MovieClip).gotoAndStop(2);
      }
      
      private static function HandleOut(event:MouseEvent) : void
      {
         (event.target as MovieClip).gotoAndStop(1);
      }
   }
}
