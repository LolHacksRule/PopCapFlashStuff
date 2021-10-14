package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   
   public class LevelView extends Sprite
   {
      
      public static const MAX_LEVEL:int = 182;
      
      protected static const DISABLED_FILTER:ColorMatrixFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
       
      
      protected var m_App:Blitz3App;
      
      public var xpBar:XPBar;
      
      protected var m_LevelCrest:LevelCrest;
      
      protected var m_IsFirstCall:Boolean = true;
      
      protected var m_IsDisabled:Boolean = false;
      
      public function LevelView(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.xpBar = new XPBar(param1,175,30);
         this.m_LevelCrest = new LevelCrest(param1);
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
      }
      
      public function Reset() : void
      {
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
         visible = true;
         if(!this.m_App.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_XP))
         {
            visible = false;
         }
      }
      
      public function Update() : void
      {
         this.xpBar.Update();
      }
      
      public function SetData(param1:Number) : void
      {
         if(this.m_IsDisabled)
         {
            param1 = 0;
         }
         var _loc2_:Number = this.m_App.sessionData.userData.GetPrevLevelCutoff();
         var _loc3_:Number = this.m_App.sessionData.userData.GetNextLevelCutoff();
         var _loc4_:Number = this.m_App.sessionData.userData.GetLevel();
         var _loc5_:Number = (param1 - _loc2_) / (_loc3_ - _loc2_);
         var _loc6_:int = Math.max(Math.min(_loc4_ - 1,MAX_LEVEL - 1),0);
         var _loc7_:String = Constants.LEVEL_NAMES[_loc6_];
         var _loc8_:String = (_loc8_ = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_BAR_XP_REMAINING)).replace("%s",StringUtils.InsertNumberCommas(Math.ceil(_loc3_ - param1)));
         if(this.m_IsDisabled)
         {
            _loc8_ = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_BAR_XP_REMAINING_DISABLED);
            _loc7_ = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_LEVEL_NAME_DISABLED);
         }
         this.xpBar.SetData(_loc5_,_loc7_,_loc8_,this.m_IsFirstCall);
         this.m_LevelCrest.SetLevel(_loc4_);
         this.m_IsFirstCall = false;
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
      }
   }
}
