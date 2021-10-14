package com.popcap.flash.games.blitz3.ui.widgets.levels
{
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.bej3.blitz.Blitz3Network;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   
   public class LevelView extends Sprite
   {
      
      public static const MAX_LEVEL:int = 131;
      
      protected static const DISABLED_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
       
      
      protected var m_App:Blitz3App;
      
      public var xpBar:XPBar;
      
      protected var m_LevelCrest:LevelCrest;
      
      protected var m_IsFirstCall:Boolean = true;
      
      protected var m_IsDisabled:Boolean = false;
      
      public function LevelView(app:Blitz3App)
      {
         super();
         this.m_App = app;
         this.xpBar = new XPBar(app,175,30);
         this.m_LevelCrest = new LevelCrest();
         filters = [new DropShadowFilter(2,45,0,0.5)];
      }
      
      public function Init() : void
      {
         addChild(this.xpBar);
         addChild(this.m_LevelCrest);
         this.xpBar.x = this.m_LevelCrest.width - XPBar.FRAME_SIZE - XPBar.SPEC_LAYER_HORIZ_BUFFER - XPBar.LEFT_TEXT_OFFSET - 6;
         this.xpBar.y = 3;
         this.xpBar.Init();
         this.m_LevelCrest.Init();
         this.m_IsDisabled = this.m_App.network.isOffline;
         if(this.m_IsDisabled)
         {
            filters = [DISABLED_FILTER];
         }
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function Reset() : void
      {
         this.xpBar.Reset();
         this.m_LevelCrest.Reset();
         this.m_IsDisabled = this.m_App.network.isOffline;
         if(this.m_IsDisabled)
         {
            filters = [DISABLED_FILTER];
         }
         else
         {
            filters = [];
         }
         this.xpBar.x = this.m_LevelCrest.width - XPBar.FRAME_SIZE - XPBar.SPEC_LAYER_HORIZ_BUFFER - XPBar.LEFT_TEXT_OFFSET - 6;
         this.xpBar.y = 6;
      }
      
      public function Update() : void
      {
         this.xpBar.Update();
      }
      
      public function SetData(xp:Number) : void
      {
         if(this.m_IsDisabled)
         {
            xp = 0;
         }
         var prevLevelCutoff:Number = this.m_App.sessionData.userData.GetPrevLevelCutoff();
         var nextLevelCutoff:Number = this.m_App.sessionData.userData.GetNextLevelCutoff();
         var level:Number = this.m_App.sessionData.userData.GetLevel();
         var percent:Number = (xp - prevLevelCutoff) / (nextLevelCutoff - prevLevelCutoff);
         var nameIndex:int = Math.max(Math.min(level - 1,MAX_LEVEL - 1),0);
         var levelName:String = this.m_App.locManager.GetLocString("LEVEL_NAME_" + nameIndex);
         var xpRemaining:String = this.m_App.locManager.GetLocString("LEVEL_BAR_XP_REMAINING");
         xpRemaining = xpRemaining.replace("%s",StringUtils.InsertNumberCommas(Math.ceil(nextLevelCutoff - xp)));
         if(this.m_IsDisabled)
         {
            xpRemaining = this.m_App.locManager.GetLocString("LEVEL_BAR_XP_REMAINING_DISABLED");
            levelName = this.m_App.locManager.GetLocString("LEVEL_NAME_OFFLINE");
            if(this.m_App.network.networkMode == Blitz3Network.NET_MODE_TUTORIAL)
            {
               levelName = this.m_App.locManager.GetLocString("LEVEL_NAME_PRACTICE");
            }
         }
         this.xpBar.SetData(percent,levelName,xpRemaining,this.m_IsFirstCall);
         this.m_LevelCrest.SetLevel(level);
         this.m_IsFirstCall = false;
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         this.m_App.sessionData.userData.ForceLevelUp();
      }
   }
}
