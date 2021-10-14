package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseTooltipView;
   import flash.display.Shape;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TooltipView extends BaseTooltipView implements IInterfaceComponent
   {
      
      public static const BACKING_COLOR:int = 16777215;
      
      public static const HORIZ_BUFF:Number = 4;
      
      public static const VERT_BUFF:Number = 0;
      
      public static const CORNER_ROUNDING:Number = 8;
      
      public static const POINT_WIDTH:Number = 12;
      
      public static const POINT_HEIGHT:Number = 20;
      
      public static const POINT_POS_CENTER:int = 0;
      
      public static const POINT_POS_LEFT:int = 1;
      
      public static const POINT_POS_RIGHT:int = 2;
       
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_TxtText:TextField;
      
      protected var m_Backing:Shape;
      
      protected var m_VertData:Vector.<Number>;
      
      public function TooltipView(leaderboard:LeaderboardWidget)
      {
         super();
         this.m_Leaderboard = leaderboard;
         clipBackground.visible = false;
         this.m_TxtText = txtText;
         this.m_TxtText.selectable = false;
         this.m_TxtText.mouseEnabled = false;
         this.m_TxtText.multiline = false;
         this.m_TxtText.wordWrap = false;
         this.m_TxtText.autoSize = TextFieldAutoSize.RIGHT;
         this.m_Backing = new Shape();
         this.m_Backing.filters = [new GlowFilter(0,1,2,2,2)];
         this.m_VertData = new Vector.<Number>(6);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function Init() : void
      {
         addChild(this.m_Backing);
         addChild(this.m_TxtText);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.HideTooltip();
      }
      
      public function ShowTooltip(text:String, centerX:Number, centerY:Number, pointUp:Boolean, pointPos:int = 0) : void
      {
         this.m_TxtText.text = text;
         var xOffset:Number = 0;
         if(pointPos == POINT_POS_LEFT)
         {
            xOffset = this.m_TxtText.width * 0.5 + HORIZ_BUFF - POINT_WIDTH;
         }
         else if(pointPos == POINT_POS_RIGHT)
         {
            xOffset = -(this.m_TxtText.width * 0.5 + HORIZ_BUFF - POINT_WIDTH);
         }
         this.m_TxtText.x = centerX - this.m_TxtText.width * 0.5 + xOffset;
         this.m_TxtText.y = centerY - this.m_TxtText.height * 0.5 + (!!pointUp ? POINT_HEIGHT : -POINT_HEIGHT);
         var rect:Rectangle = this.m_TxtText.getRect(this);
         this.m_VertData[0] = centerX - POINT_WIDTH * 0.5;
         if(pointUp)
         {
            this.m_VertData[1] = rect.y - VERT_BUFF;
         }
         else
         {
            this.m_VertData[1] = rect.y + rect.height + VERT_BUFF;
         }
         this.m_VertData[2] = centerX;
         this.m_VertData[3] = centerY;
         this.m_VertData[4] = centerX + POINT_WIDTH * 0.5;
         this.m_VertData[5] = this.m_VertData[1];
         this.m_Backing.graphics.clear();
         this.m_Backing.graphics.beginFill(BACKING_COLOR,1);
         this.m_Backing.graphics.drawRoundRect(rect.x - HORIZ_BUFF,rect.y - VERT_BUFF,rect.width + HORIZ_BUFF * 2,rect.height + VERT_BUFF * 2,CORNER_ROUNDING);
         this.m_Backing.graphics.drawTriangles(this.m_VertData);
         this.m_Backing.graphics.endFill();
         this.m_TxtText.visible = true;
         this.m_Backing.visible = true;
      }
      
      public function HideTooltip() : void
      {
         this.m_TxtText.visible = false;
         this.m_Backing.visible = false;
      }
   }
}
