package com.popcap.flash.bejeweledblitz.game.ui.meta.tutorial.tips
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import flash.geom.Point;
   
   public class BoardTipRenderData extends TipRenderData
   {
       
      
      private var m_App:Blitz3Game;
      
      public function BoardTipRenderData(app:Blitz3Game, id:String, message:String, target:Point, boxPosition:String = "over")
      {
         super(app,id,message,target,boxPosition);
         this.m_App = app;
      }
      
      override public function Show(boxOffsetX:Number = 0) : void
      {
         targetPos.x *= GemSprite.GEM_SIZE;
         targetPos.y *= GemSprite.GEM_SIZE;
         targetPos = this.m_App.ui.game.board.localToGlobal(targetPos);
         targetPos = this.m_App.metaUI.globalToLocal(targetPos);
         super.Show(boxOffsetX == 0 ? Number(-Dimensions.LEFT_BORDER_WIDTH - GetBoxOffset()) : Number(0));
      }
   }
}
