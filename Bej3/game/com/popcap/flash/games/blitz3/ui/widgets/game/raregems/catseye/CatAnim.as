package com.popcap.flash.games.blitz3.ui.widgets.game.raregems.catseye
{
   import flash.display.MovieClip;
   
   public dynamic class CatAnim extends MovieClip
   {
       
      
      public var lightbeam:MovieClip;
      
      public var head:CatHead;
      
      public var m_ShouldLoop:Boolean;
      
      public function CatAnim()
      {
         super();
      }
      
      public function PlayEnterAnim() : void
      {
         this.m_ShouldLoop = true;
         gotoAndPlay(1);
      }
      
      public function LoopIdleAnim() : void
      {
         this.m_ShouldLoop = true;
         gotoAndPlay(96);
      }
      
      public function FinishIdleLoop() : void
      {
         this.m_ShouldLoop = false;
      }
      
      public function PlayExitAnim() : void
      {
         gotoAndPlay(160);
      }
   }
}
