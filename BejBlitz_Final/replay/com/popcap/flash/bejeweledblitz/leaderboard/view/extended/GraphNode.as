package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.utils.StringUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class GraphNode extends Sprite implements IInterfaceComponent
   {
       
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Id:int;
      
      protected var m_BackDot:Shape;
      
      protected var m_OverDot:Shape;
      
      public var score:int = 0;
      
      public function GraphNode(leaderboard:LeaderboardWidget, id:int)
      {
         super();
         this.m_Leaderboard = leaderboard;
         this.m_Id = id;
         this.m_BackDot = new Shape();
         this.m_OverDot = new Shape();
         this.m_OverDot.graphics.beginFill(16777215,1);
         this.m_OverDot.graphics.drawCircle(0,0,2);
         this.m_OverDot.graphics.endFill();
         this.m_OverDot.visible = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_BackDot);
         addChild(this.m_OverDot);
         this.Reset();
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
      }
      
      public function Reset() : void
      {
         this.score = 0;
         this.m_OverDot.visible = false;
      }
      
      public function SetColor(color:int) : void
      {
         this.m_BackDot.graphics.clear();
         this.m_BackDot.graphics.beginFill(color,1);
         this.m_BackDot.graphics.drawCircle(0,0,4);
         this.m_BackDot.graphics.endFill();
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         this.m_OverDot.visible = true;
         var ttText:String = StringUtils.InsertNumberCommas(this.score);
         var rect:Rectangle = getRect(this.m_Leaderboard.viewManager.extendedView.tooltipView);
         var horizPos:int = TooltipView.POINT_POS_CENTER;
         if(this.m_Id == PlayerData.NUM_TOURNEYS - 1)
         {
            horizPos = TooltipView.POINT_POS_RIGHT;
         }
         this.m_Leaderboard.viewManager.extendedView.tooltipView.ShowTooltip(ttText,rect.x + rect.width * 0.5,rect.y,false,horizPos);
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         this.m_OverDot.visible = false;
         this.m_Leaderboard.viewManager.extendedView.tooltipView.HideTooltip();
      }
   }
}
