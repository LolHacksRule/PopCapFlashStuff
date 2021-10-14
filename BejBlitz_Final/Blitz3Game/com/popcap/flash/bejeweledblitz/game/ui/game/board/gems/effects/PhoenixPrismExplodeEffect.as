package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   
   public class PhoenixPrismExplodeEffect extends SpriteEffect
   {
       
      
      private var m_App:Blitz3App;
      
      private var mX:Number = 0;
      
      private var mY:Number = 0;
      
      public function PhoenixPrismExplodeEffect(param1:Blitz3App, param2:Gem)
      {
         super();
         this.m_App = param1;
         this.mX = param2.x;
         this.mY = param2.y;
         (this.m_App.ui as MainWidgetGame).game.phoenixPrism.ShowGemExplosion(this.mY,this.mX);
      }
   }
}
