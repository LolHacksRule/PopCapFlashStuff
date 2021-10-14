package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.MedalData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseBarFill;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BevelFilter;
   import flash.geom.Rectangle;
   
   public class BarFill extends BaseBarFill implements IInterfaceComponent
   {
      
      public static const BAR_FILL_COLORS:Vector.<int> = new Vector.<int>(15);
      
      public static const NUM_FILL_COLORS:int = BAR_FILL_COLORS.length;
      
      public static const BAR_GOLD:int = 16229144;
      
      public static const HORIZ_BUFF:Number = 1;
      
      public static const VERT_BUFF:Number = 0;
      
      {
         BAR_FILL_COLORS[0] = 7950589;
         BAR_FILL_COLORS[1] = 34017;
         BAR_FILL_COLORS[2] = 48285;
         BAR_FILL_COLORS[3] = 12058807;
         BAR_FILL_COLORS[4] = 11734318;
         BAR_FILL_COLORS[5] = 7586309;
         BAR_FILL_COLORS[6] = 14573056;
         BAR_FILL_COLORS[7] = 15418365;
         BAR_FILL_COLORS[8] = 5305599;
         BAR_FILL_COLORS[9] = 16765952;
         BAR_FILL_COLORS[10] = 10015499;
         BAR_FILL_COLORS[11] = 13512960;
         BAR_FILL_COLORS[12] = 8917963;
         BAR_FILL_COLORS[13] = 707027;
         BAR_FILL_COLORS[14] = 13018112;
      }
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Bar:Shape;
      
      protected var m_MouseStop:Sprite;
      
      protected var m_OriginalRect:Rectangle;
      
      protected var m_BarArea:Rectangle;
      
      protected var m_MedalData:MedalData;
      
      protected var m_TTYPos:Number;
      
      protected var m_Id:int;
      
      public function BarFill(leaderboard:LeaderboardWidget, id:int = -1)
      {
         super();
         this.m_Leaderboard = leaderboard;
         this.m_Id = id;
         this.m_Bar = new Shape();
         this.m_MouseStop = new Sprite();
         this.m_OriginalRect = clipBacking.getRect(this);
         this.m_BarArea = new Rectangle();
         this.m_MouseStop.graphics.beginFill(0,0);
         this.m_MouseStop.graphics.drawRect(this.m_OriginalRect.x,this.m_OriginalRect.y,this.m_OriginalRect.width,this.m_OriginalRect.height);
         this.m_MouseStop.graphics.endFill();
         clipBacking.visible = false;
         clipGoldBurnishing.visible = false;
         clipGoldBurnishing.mouseEnabled = false;
         clipGoldBurnishing.mouseChildren = false;
         this.m_Bar.filters = [new BevelFilter(3,45,16777215,0.5,0,0.5,3,3)];
      }
      
      public static function GetColorFromId(id:int) : int
      {
         var color:int = BAR_FILL_COLORS[0];
         if(id >= 0 && id < NUM_FILL_COLORS)
         {
            color = BAR_FILL_COLORS[id];
         }
         return color;
      }
      
      public function Init() : void
      {
         addChildAt(this.m_Bar,0);
         addChildAt(this.m_MouseStop,0);
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_Bar.graphics.clear();
      }
      
      public function SetBarInfo(data:MedalData, usePrevTier:Boolean = false) : void
      {
         var curTier:int = 0;
         this.m_MedalData = data;
         curTier = data.tier;
         if(usePrevTier)
         {
            curTier = Math.max(0,curTier - 1);
         }
         var percentFilled:Number = Math.min(data.count / MedalData.TIER_CUTOFFS[curTier],1);
         if(curTier == MedalData.NUM_TIERS - 1)
         {
            percentFilled = 1;
         }
         this.m_BarArea.x = this.m_OriginalRect.x + HORIZ_BUFF;
         this.m_BarArea.y = -this.m_OriginalRect.height * percentFilled + VERT_BUFF + 1;
         this.m_BarArea.width = this.m_OriginalRect.width - HORIZ_BUFF * 2;
         this.m_BarArea.height = this.m_OriginalRect.height * percentFilled - VERT_BUFF * 2 - 1;
         var color:int = GetColorFromId(this.m_Id);
         clipGoldBurnishing.visible = false;
         if(curTier == MedalData.NUM_TIERS - 1)
         {
            color = BAR_GOLD;
            clipGoldBurnishing.visible = true;
         }
         this.m_Bar.graphics.clear();
         if(percentFilled > 0)
         {
            this.m_Bar.graphics.lineStyle(0,6710886);
            this.m_Bar.graphics.beginFill(color);
            this.m_Bar.graphics.drawRoundRect(this.m_BarArea.x,this.m_BarArea.y,this.m_BarArea.width,this.m_BarArea.height,4);
            this.m_Bar.graphics.endFill();
         }
         var rect:Rectangle = getRect(this.m_Leaderboard.viewManager.extendedView.tooltipView);
         this.m_TTYPos = rect.y + rect.height;
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         var ttText:String = this.m_MedalData.count + "/";
         if(this.m_MedalData.tier >= MedalData.NUM_TIERS - 1)
         {
            ttText += MedalData.TIER_CUTOFFS[MedalData.NUM_TIERS - 2];
         }
         else
         {
            ttText += MedalData.TIER_CUTOFFS[this.m_MedalData.tier];
         }
         var rect:Rectangle = getRect(this.m_Leaderboard.viewManager.extendedView.tooltipView);
         this.m_Leaderboard.viewManager.extendedView.tooltipView.ShowTooltip(ttText,rect.x + rect.width * 0.5,this.m_TTYPos,true);
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         this.m_Leaderboard.viewManager.extendedView.tooltipView.HideTooltip();
      }
   }
}
