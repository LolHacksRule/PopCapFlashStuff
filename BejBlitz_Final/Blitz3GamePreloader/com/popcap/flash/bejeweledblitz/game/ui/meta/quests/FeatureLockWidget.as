package com.popcap.flash.bejeweledblitz.game.ui.meta.quests
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.tutorial.ITutorialWatcherHandler;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.BevelFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class FeatureLockWidget extends Sprite implements IFeatureManagerHandler, ITutorialWatcherHandler
   {
       
      
      private var m_App:Blitz3Game;
      
      private var m_QuestWidgetLocked:DisplayObject;
      
      private var m_LeaderboardLocked:DisplayObject;
      
      private var m_Widgets:Vector.<DisplayObject>;
      
      public function FeatureLockWidget(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_LeaderboardLocked = this.BuildLeaderboardLocked();
         this.m_Widgets = new Vector.<DisplayObject>();
         this.m_Widgets.push(this.m_LeaderboardLocked);
      }
      
      public function Init() : void
      {
         addChild(this.m_LeaderboardLocked);
         this.m_LeaderboardLocked.x = Dimensions.LEADERBOARD_X;
         this.m_LeaderboardLocked.y = Dimensions.LEADERBOARD_Y;
         this.UpdateWidgets();
         this.m_App.sessionData.featureManager.AddHandler(this);
         this.m_App.tutorial.AddHandler(this);
         cacheAsBitmap = true;
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         this.UpdateWidgets();
      }
      
      public function HandleTutorialComplete(param1:Boolean) : void
      {
         this.UpdateWidgets();
      }
      
      public function HandleTutorialRestarted() : void
      {
         this.UpdateWidgets();
      }
      
      private function Show() : void
      {
         if(visible)
         {
            return;
         }
         visible = true;
         this.m_App.metaUI.addChildAt(this,0);
      }
      
      private function Hide() : void
      {
         if(!visible)
         {
            return;
         }
         if(parent != null)
         {
            parent.removeChild(this);
         }
         visible = false;
      }
      
      private function SetWidgetVisible(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1.visible)
            {
               return;
            }
            param1.visible = true;
            addChild(param1);
         }
         else
         {
            if(!param1.visible)
            {
               return;
            }
            removeChild(param1);
            param1.visible = false;
         }
      }
      
      private function AreSomeVisible() : Boolean
      {
         var _loc1_:DisplayObject = null;
         for each(_loc1_ in this.m_Widgets)
         {
            if(_loc1_.visible)
            {
               return true;
            }
         }
         return false;
      }
      
      private function UpdateWidgets() : void
      {
         var _loc1_:FeatureManager = this.m_App.sessionData.featureManager;
         var _loc2_:Boolean = this.m_App.tutorial.IsActive();
         this.SetWidgetVisible(this.m_LeaderboardLocked,!_loc2_ && !_loc1_.isFeatureEnabled(FeatureManager.FEATURE_LEADERBOARD_BASIC));
         if(this.AreSomeVisible())
         {
            this.Show();
         }
         else
         {
            this.Hide();
         }
      }
      
      private function BuildQuestWidgetLocked() : DisplayObject
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.addChild(new QuestWidgetLocked());
         return _loc1_;
      }
      
      private function BuildFriendscoreWidgetLocked() : DisplayObject
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc5_:TextField = null;
         _loc1_ = new Sprite();
         _loc2_ = 10;
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,1);
         _loc3_.graphics.drawRoundRect(_loc2_,5,Dimensions.FRIENDSCORE_WIDTH - 15,Dimensions.FRIENDSCORE_HEIGHT - 2 * _loc2_,20,20);
         _loc3_.filters = [new BevelFilter(1,45,16777215,1,0,1,1,1,2,BitmapFilterQuality.LOW,"inner",true)];
         _loc1_.addChild(_loc3_);
         var _loc4_:MovieClip;
         (_loc4_ = new FriendscoreLockRibbon()).x = Dimensions.FRIENDSCORE_WIDTH - 115;
         _loc1_.addChild(_loc4_);
         (_loc5_ = this.BuildTextField(TextFormatAlign.LEFT,14)).htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PLAY_MORE_TO_UNLOCK);
         _loc5_.x = _loc2_ + 10;
         _loc5_.y = 35;
         _loc1_.addChild(_loc5_);
         return _loc1_;
      }
      
      private function BuildLeaderboardLocked() : DisplayObject
      {
         var _loc1_:Sprite = null;
         _loc1_ = new Sprite();
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16711680,1);
         _loc3_.graphics.drawRoundRect(10,0,Dimensions.LEADERBOARD_WIDTH - 8,Dimensions.LEADERBOARD_HEIGHT,20,20);
         _loc3_.filters = [new BevelFilter(1,45,16777215,1,0,1,1,1,2,BitmapFilterQuality.LOW,"inner",true)];
         _loc1_.addChild(_loc3_);
         var _loc4_:TextField;
         (_loc4_ = this.BuildTextField(TextFormatAlign.CENTER,14)).htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PLAY_MORE_TO_UNLOCK);
         _loc4_.x = _loc3_.width * 0.5 - _loc4_.width * 0.5 + 10;
         _loc4_.y = 230;
         _loc1_.addChild(_loc4_);
         return _loc1_;
      }
      
      private function BuildTextField(param1:String = "center", param2:int = 20) : TextField
      {
         var _loc3_:TextField = new TextField();
         _loc3_.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,param2,16777215,null,null,null,null,null,param1);
         _loc3_.autoSize = TextFieldAutoSize.CENTER;
         _loc3_.embedFonts = true;
         _loc3_.multiline = true;
         _loc3_.selectable = false;
         _loc3_.mouseEnabled = false;
         _loc3_.filters = [new GlowFilter(0,1,3,3,3,BitmapFilterQuality.LOW)];
         return _loc3_;
      }
   }
}
