package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ArrowPointer extends Sprite
   {
      
      private static const PERIOD:int = 75;
      
      private static const DISTANCE_PERCENT:Number = 0.125;
       
      
      private var m_App:Blitz3App;
      
      private var m_Arrow:Bitmap;
      
      private var m_Curve:LinearSampleCurvedVal;
      
      private var m_CurvePos:int;
      
      public function ArrowPointer(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.m_Arrow = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_TUTORIAL_ARROW));
         mouseEnabled = false;
         mouseChildren = false;
         this.m_CurvePos = 0;
         this.m_Curve = new LinearSampleCurvedVal();
         var baseX:Number = 0.5 * GemSprite.GEM_SIZE;
         this.m_Curve.setInRange(0,PERIOD);
         this.m_Curve.setOutRange(baseX,baseX);
         this.m_Curve.addPoint(0.5 * PERIOD,baseX + DISTANCE_PERCENT * this.m_Arrow.width);
      }
      
      public function Init() : void
      {
         addChild(this.m_Arrow);
         this.m_Arrow.x = this.m_Curve.getOutValue(0);
         this.m_Arrow.y = -0.5 * this.m_Arrow.height;
      }
      
      public function Reset() : void
      {
         this.m_CurvePos = 0;
      }
      
      public function Update() : void
      {
         ++this.m_CurvePos;
         this.m_CurvePos %= PERIOD;
         this.m_Arrow.x = this.m_Curve.getOutValue(this.m_CurvePos);
      }
   }
}
