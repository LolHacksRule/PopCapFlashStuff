package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips
{
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import flash.geom.Point;
   
   public class GemTipRenderData extends BoardTipRenderData
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_Gem:Gem;
      
      public function GemTipRenderData(app:Blitz3Game, id:String, message:String, gem:Gem, boxPosition:String = "not_over")
      {
         super(app,id,message,null,boxPosition);
         this.m_App = app;
         this.m_Gem = gem;
      }
      
      override public function IsReady() : Boolean
      {
         return this.m_Gem != null && this.m_Gem.y >= 0 && this.m_Gem.isStill();
      }
      
      override public function Show(boxOffsetX:Number = 0) : void
      {
         targetPos = new Point(this.m_Gem.x + 0.5,this.m_Gem.y + 0.5);
         super.Show(-1);
         var radius:Number = GemSprite.GEM_SIZE * 0.6;
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.highlight.HighlightCircle(targetPos.x,targetPos.y,radius,false);
      }
      
      override protected function GetBoxOffset() : Number
      {
         return GemSprite.GEM_SIZE * 0.75;
      }
   }
}
