package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.MedalData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseMedalBar;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class MedalBar extends BaseMedalBar implements IInterfaceComponent
   {
      
      protected static const DEFAULT_STAR_COLOR_TRANS:ColorTransform = new ColorTransform(0,0,0,1,102,102,102);
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Fill:BarFill;
      
      protected var m_TxtLevel:TextField;
      
      protected var m_Id:int;
      
      protected var m_Data:MedalData;
      
      protected var m_CurTier:int = 2.147483647E9;
      
      protected var m_IsWaiting:Boolean = false;
      
      protected var m_StarGlowFilter:GlowFilter;
      
      protected var m_StarFilters:Array;
      
      protected var m_ColorTrans:ColorTransform;
      
      public function MedalBar(app:App, leaderboard:LeaderboardWidget, id:int = -1)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Fill = new BarFill(this.m_Leaderboard,id);
         this.m_StarGlowFilter = new GlowFilter(16777215,0.5,16,16,4);
         this.m_StarFilters = [this.m_StarGlowFilter];
         this.m_ColorTrans = new ColorTransform();
         this.m_TxtLevel = txtLevel;
         this.m_TxtLevel.selectable = false;
         this.m_TxtLevel.mouseEnabled = false;
         this.m_TxtLevel.autoSize = TextFieldAutoSize.NONE;
         clipGoldLevelBack.visible = false;
         clipCrest.clipGlowAnim.parent.removeChild(clipCrest.clipGlowAnim);
         clipCrest.clipStarAnim.parent.removeChild(clipCrest.clipStarAnim);
         clipCrestMask.parent.removeChild(clipCrestMask);
         clipCrestMask2.parent.removeChild(clipCrestMask2);
         clipCrest.filters = [new DropShadowFilter(2)];
         this.m_Id = id;
      }
      
      public function Init() : void
      {
         addChild(this.m_Fill);
         this.m_Fill.x = anchorFill.x;
         this.m_Fill.y = anchorFill.y;
         this.m_Fill.Init();
         this.Reset();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function Reset() : void
      {
         this.m_Fill.Reset();
         this.m_IsWaiting = false;
         this.m_CurTier = int.MAX_VALUE;
      }
      
      public function SetBarInfo(data:MedalData) : void
      {
         var color:int = 0;
         this.m_Data = data;
         if(data.tier > this.m_CurTier)
         {
            this.m_Fill.SetBarInfo(data,true);
         }
         this.m_CurTier = data.tier;
         color = BarFill.GetColorFromId(this.m_Id);
         this.m_ColorTrans.color = color;
         var content:String = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_MEDAL_BAR_LEVEL);
         content = content.replace("%s",data.tier + 1);
         this.m_TxtLevel.htmlText = content;
         clipGoldLevelBack.visible = false;
         if(data.tier >= MedalData.NUM_TIERS - 1)
         {
            this.m_TxtLevel.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_MEDAL_BAR_GOLD);
            clipGoldLevelBack.visible = true;
         }
         clipStarBackground.visible = false;
         clipStarBackground.filters = null;
         this.m_StarGlowFilter.color = color;
         if(data.tier >= 1)
         {
            clipStarBackground.visible = true;
            clipStarBackground.transform.colorTransform = DEFAULT_STAR_COLOR_TRANS;
            if(data.tier >= 2)
            {
               clipStarBackground.transform.colorTransform = this.m_ColorTrans;
               if(data.tier >= 3)
               {
                  clipStarBackground.filters = this.m_StarFilters;
               }
            }
         }
         this.m_Fill.SetBarInfo(data);
         clipCrest.clipImage.gotoAndStop(this.m_Id + 1);
      }
      
      public function GetCurTier() : int
      {
         return this.m_CurTier;
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         if(!this.m_Data)
         {
            return;
         }
         ++this.m_Data.count;
         this.m_Data.CalculateTier();
         this.SetBarInfo(this.m_Data);
      }
   }
}
