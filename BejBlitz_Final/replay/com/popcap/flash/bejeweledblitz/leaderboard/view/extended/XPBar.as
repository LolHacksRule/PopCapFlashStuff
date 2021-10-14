package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseXPBar;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class XPBar extends BaseXPBar implements IInterfaceComponent
   {
      
      public static const FRAME_SIZE:Number = 2;
      
      protected static const FRAME_COLOR:int = 13421772;
      
      protected static const BACKING_COLOR:int = 6052956;
      
      protected static const FILL_COLOR:int = 10818250;
      
      protected static const SPEC_LAYER_HORIZ_BUFFER:Number = 2;
      
      protected static const PERCENT_SPEED:Number = 0.5;
      
      protected static const PERCENT_LOWER_TEXT_CHEAT:Number = 0.6;
      
      protected static const LEFT_TEXT_OFFSET:Number = 4;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Frame:Shape;
      
      protected var m_Backing:Shape;
      
      protected var m_Fill:Shape;
      
      protected var m_FillMask:Shape;
      
      protected var m_SpecLayer:Shape;
      
      protected var m_SpecGlowFilter:GlowFilter;
      
      protected var m_LevelName:TextField;
      
      protected var m_XPToGo:TextField;
      
      protected var m_TargetPercent:Number = 0;
      
      protected var m_CurPercent:Number = 0;
      
      protected var m_NextLevelName:String = "";
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      public function XPBar(app:App, leaderboard:LeaderboardWidget, targetWidth:Number = 200, targetHeight:Number = 20)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Frame = new Shape();
         this.m_Backing = new Shape();
         this.m_Fill = new Shape();
         this.m_FillMask = new Shape();
         this.m_SpecLayer = new Shape();
         this.m_LevelName = txtName;
         this.m_XPToGo = txtXP;
         this.m_Fill.mask = this.m_FillMask;
         this.m_SpecGlowFilter = new GlowFilter(16777215,0.7,0,8,2);
         this.m_SpecLayer.filters = [this.m_SpecGlowFilter];
         this.m_LevelName.selectable = false;
         this.m_LevelName.mouseEnabled = false;
         this.m_LevelName.autoSize = TextFieldAutoSize.LEFT;
         this.m_XPToGo.selectable = false;
         this.m_XPToGo.mouseEnabled = false;
         this.m_XPToGo.autoSize = TextFieldAutoSize.RIGHT;
         this.SetDimenions(targetWidth,targetHeight);
         filters = [new DropShadowFilter(2,45,0,0.5)];
      }
      
      public function Init() : void
      {
         addChild(this.m_Backing);
         addChild(this.m_Fill);
         addChild(this.m_FillMask);
         addChild(this.m_SpecLayer);
         addChild(this.m_LevelName);
         addChild(this.m_XPToGo);
         this.m_LevelName.text = "";
         this.m_XPToGo.text = "";
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
      }
      
      public function Reset() : void
      {
      }
      
      public function SetPlayerData(data:PlayerData, shouldAnimate:Boolean = false) : void
      {
         var content:String = null;
         var xpDelta:String = null;
         var percent:Number = (data.xp - data.prevLevelCutoff) / (data.nextLevelCutoff - data.prevLevelCutoff);
         if(shouldAnimate)
         {
            this.m_TargetPercent = percent;
            if(this.m_TargetPercent < this.m_CurPercent)
            {
               this.m_TargetPercent += 1;
            }
            this.m_NextLevelName = data.levelName;
            if(this.m_LevelName.text == "")
            {
               this.m_LevelName.text = data.levelName;
            }
            content = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_POINTS_TO_GO);
            xpDelta = StringUtils.InsertNumberCommas(data.nextLevelCutoff - data.xp);
            content = content.replace("%s",xpDelta);
            this.m_XPToGo.htmlText = content;
            return;
         }
         this.m_TargetPercent = percent;
         this.m_CurPercent = percent;
         this.m_FillMask.graphics.clear();
         this.m_FillMask.graphics.beginFill(16777215,1);
         this.m_FillMask.graphics.drawRect(FRAME_SIZE,FRAME_SIZE,this.m_Fill.width * percent,this.m_Fill.height);
         this.m_FillMask.graphics.endFill();
         this.m_FillMask.cacheAsBitmap = true;
         this.m_LevelName.text = data.levelName;
         content = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_POINTS_TO_GO);
         xpDelta = StringUtils.InsertNumberCommas(data.nextLevelCutoff - data.xp);
         content = content.replace("%s",xpDelta);
         this.m_XPToGo.htmlText = content;
      }
      
      protected function SetDimenions(targetWidth:Number, targetHeight:Number) : void
      {
         this.m_XPToGo.x = targetWidth - SPEC_LAYER_HORIZ_BUFFER - FRAME_SIZE - this.m_XPToGo.width;
         this.m_XPToGo.y = targetHeight - this.m_LevelName.height * PERCENT_LOWER_TEXT_CHEAT;
         targetHeight = this.m_XPToGo.y;
         this.m_Frame.graphics.clear();
         this.m_Frame.graphics.beginFill(FRAME_COLOR,1);
         this.m_Frame.graphics.drawRoundRect(0,0,targetWidth,targetHeight,4);
         this.m_Frame.graphics.endFill();
         this.m_Frame.cacheAsBitmap = true;
         this.m_Backing.graphics.clear();
         this.m_Backing.graphics.beginFill(BACKING_COLOR,1);
         this.m_Backing.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,targetWidth - 2 * FRAME_SIZE,targetHeight - 2 * FRAME_SIZE,4);
         this.m_Backing.graphics.endFill();
         this.m_Backing.cacheAsBitmap = true;
         this.m_Fill.graphics.clear();
         this.m_Fill.graphics.beginFill(FILL_COLOR,1);
         this.m_Fill.graphics.drawRoundRect(FRAME_SIZE,FRAME_SIZE,targetWidth - 2 * FRAME_SIZE,targetHeight - 2 * FRAME_SIZE,4);
         this.m_Fill.graphics.endFill();
         this.m_Fill.cacheAsBitmap = true;
         this.m_SpecLayer.graphics.clear();
         this.m_SpecLayer.graphics.beginFill(16777215,0.35);
         this.m_SpecLayer.graphics.drawRoundRect(SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE,FRAME_SIZE + 0.2 * (targetHeight - FRAME_SIZE),targetWidth - 2 * (SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE),2,4);
         this.m_SpecLayer.graphics.endFill();
         this.m_SpecLayer.cacheAsBitmap = true;
         this.m_LevelName.text = "Novice";
         this.m_LevelName.x = SPEC_LAYER_HORIZ_BUFFER + FRAME_SIZE + LEFT_TEXT_OFFSET;
         this.m_LevelName.y = FRAME_SIZE + targetHeight * 0.5 - this.m_LevelName.height * 0.5;
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         var dPercent:Number = this.m_TargetPercent - this.m_CurPercent;
         if(dPercent <= 0)
         {
            return;
         }
         if(dPercent > PERCENT_SPEED * dt)
         {
            dPercent = PERCENT_SPEED * dt;
         }
         if(this.m_CurPercent < 1 && this.m_CurPercent + dPercent >= 1 && this.m_NextLevelName.length > 0)
         {
            this.m_LevelName.text = this.m_NextLevelName;
            this.m_NextLevelName = "";
         }
         this.m_CurPercent += dPercent;
         if(this.m_CurPercent > 1)
         {
            this.m_CurPercent -= 1;
            this.m_TargetPercent -= 1;
         }
         this.m_FillMask.graphics.clear();
         this.m_FillMask.graphics.beginFill(16777215,1);
         this.m_FillMask.graphics.drawRect(FRAME_SIZE,FRAME_SIZE,this.m_Fill.width * this.m_CurPercent,this.m_Fill.height);
         this.m_FillMask.graphics.endFill();
      }
   }
}
