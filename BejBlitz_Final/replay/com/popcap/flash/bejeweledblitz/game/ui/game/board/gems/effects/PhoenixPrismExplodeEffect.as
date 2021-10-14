package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class PhoenixPrismExplodeEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      public function PhoenixPrismExplodeEffect(app:Blitz3App, locus:Gem)
      {
         super();
         this.m_App = app;
         this.mX = locus.x;
         this.mY = locus.y;
         this.m_App.ui.game.phoenixPrism.ShowGemExplosion(this.mY,this.mX);
      }
   }
}
