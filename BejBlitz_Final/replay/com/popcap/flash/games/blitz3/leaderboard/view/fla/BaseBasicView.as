package com.popcap.flash.games.blitz3.leaderboard.view.fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   public dynamic class BaseBasicView extends MovieClip
   {
       
      
      public var background:BaseBackground;
      
      public var btnUp:SimpleButton;
      
      public var btnDown:SimpleButton;
      
      public var anchor:AnchorPoint;
      
      public var clipDownDisabled:MovieClip;
      
      public var clipUpDisabled:MovieClip;
      
      public function BaseBasicView()
      {
         super();
      }
   }
}
