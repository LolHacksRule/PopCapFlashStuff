package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IPlayerDataHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.MedalData;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseMedalStrip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class MedalStrip extends BaseMedalStrip implements IInterfaceComponent, IPlayerDataHandler, IDataUpdaterHandler
   {
      
      protected static const MEDAL_SPACING:Number = 3;
      
      protected static const LEFT_OFFSET:Number = 16.5;
      
      protected static const BARS_PER_PAGE:int = 4;
      
      protected static const BARS_PER_CLICK:int = 4;
      
      protected static const MAX_MOVE_SPEED:Number = 10;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_MedalGroup:Sprite;
      
      protected var m_Data:PlayerData;
      
      protected var m_CurPlayerData:PlayerData;
      
      protected var m_Medals:Vector.<MedalBar>;
      
      protected var m_BarWidth:Number;
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      protected var m_Spline:LinearSampleCurvedVal;
      
      protected var m_SplinePos:Number;
      
      protected var m_TargetX:Number;
      
      protected var m_MaxX:Number;
      
      protected var m_MaxMoveSpeed:Number;
      
      protected var m_RangeTop:Number;
      
      protected var m_Handlers:Vector.<IMedalStripHandler>;
      
      public function MedalStrip(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_MedalGroup = new Sprite();
         this.m_Medals = new Vector.<MedalBar>();
         for(var i:int = 0; i < PlayerData.NUM_MEDALS; i++)
         {
            this.m_Medals.push(new MedalBar(this.m_App,this.m_Leaderboard,i));
         }
         this.m_BarWidth = this.m_Medals[0].width + MEDAL_SPACING;
         this.m_MaxMoveSpeed = MAX_MOVE_SPEED * this.m_BarWidth;
         this.m_SplinePos = 0;
         this.m_Handlers = new Vector.<IMedalStripHandler>();
         this.m_SplinePos = 1.1;
         this.m_RangeTop = 1;
         clipShadow.mouseEnabled = false;
         clipFrame.mouseEnabled = false;
      }
      
      public function Init() : void
      {
         var curMedal:MedalBar = null;
         scrollRect = getRect(this);
         this.LayoutMedals();
         for each(curMedal in this.m_Medals)
         {
            this.m_MedalGroup.addChild(curMedal);
         }
         this.m_MedalGroup.x = LEFT_OFFSET;
         this.m_MedalGroup.y = height * 0.5 - this.m_MedalGroup.height * 0.5;
         this.m_TargetX = this.m_MedalGroup.x;
         this.m_MaxX = (this.m_Medals.length - BARS_PER_PAGE) * this.m_BarWidth - LEFT_OFFSET;
         addChild(this.m_MedalGroup);
         setChildIndex(clipShadow,numChildren - 1);
         setChildIndex(clipFrame,numChildren - 1);
         for each(curMedal in this.m_Medals)
         {
            curMedal.Init();
         }
         this.UpdateMouseStates();
         this.m_Leaderboard.updater.AddHandler(this);
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function Reset() : void
      {
         var curMedal:MedalBar = null;
         if(this.m_Data && this.m_Data.fuid != this.m_Leaderboard.curPlayerFUID)
         {
            this.m_Data.RemoveHandler(this);
         }
         this.m_TargetX = LEFT_OFFSET;
         this.m_Spline = new LinearSampleCurvedVal();
         this.m_Spline.setInRange(0,Number.MIN_VALUE);
         this.m_Spline.setOutRange(this.m_MedalGroup.x,this.m_TargetX);
         this.m_SplinePos = 0;
         this.DispatchStripMoved();
         for each(curMedal in this.m_Medals)
         {
            curMedal.Reset();
         }
      }
      
      public function AddHandler(handler:IMedalStripHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function ScrollLeft() : void
      {
         this.m_TargetX += this.m_BarWidth * BARS_PER_CLICK;
         this.m_TargetX = Math.max(Math.min(this.m_TargetX,LEFT_OFFSET),-this.m_MaxX);
         this.m_Spline = new LinearSampleCurvedVal();
         var oldRangeTop:Number = this.m_RangeTop;
         this.m_RangeTop = Math.max(Math.abs((this.m_TargetX - this.m_MedalGroup.x) / this.m_MaxMoveSpeed),Number.MIN_VALUE);
         this.m_Spline.setInRange(0,this.m_RangeTop);
         this.m_Spline.setOutRange(this.m_MedalGroup.x,this.m_TargetX);
         if(Math.abs(this.m_SplinePos) >= Math.abs(oldRangeTop))
         {
            this.m_Spline.addPoint(this.m_RangeTop * 0.1,this.m_MedalGroup.x + (this.m_TargetX - this.m_MedalGroup.x) * 0.05);
         }
         this.m_Spline.addPoint(this.m_RangeTop * 0.9,this.m_MedalGroup.x + (this.m_TargetX - this.m_MedalGroup.x) * 0.95);
         this.m_SplinePos = 0;
         this.UpdateMouseStates();
         this.DispatchStripMoved();
      }
      
      public function ScrollRight() : void
      {
         this.m_TargetX -= this.m_BarWidth * BARS_PER_CLICK;
         this.m_TargetX = Math.max(Math.min(this.m_TargetX,LEFT_OFFSET),-this.m_MaxX);
         this.m_Spline = new LinearSampleCurvedVal();
         var oldRangeTop:Number = this.m_RangeTop;
         this.m_RangeTop = Math.max(Math.abs((this.m_TargetX - this.m_MedalGroup.x) / this.m_MaxMoveSpeed),Number.MIN_VALUE);
         this.m_Spline.setInRange(0,this.m_RangeTop);
         this.m_Spline.setOutRange(this.m_MedalGroup.x,this.m_TargetX);
         if(Math.abs(this.m_SplinePos) >= Math.abs(oldRangeTop))
         {
            this.m_Spline.addPoint(this.m_RangeTop * 0.1,this.m_MedalGroup.x + (this.m_TargetX - this.m_MedalGroup.x) * 0.05);
         }
         this.m_Spline.addPoint(this.m_RangeTop * 0.9,this.m_MedalGroup.x + (this.m_TargetX - this.m_MedalGroup.x) * 0.95);
         this.m_SplinePos = 0;
         this.UpdateMouseStates();
         this.DispatchStripMoved();
      }
      
      public function SetPlayerData(data:PlayerData) : void
      {
         var curMedalHist:MedalData = null;
         this.Reset();
         this.m_Data = data;
         if(this.m_Data.fuid != this.m_Leaderboard.curPlayerFUID)
         {
            data.AddHandler(this);
         }
         for(var i:int = 0; i < this.m_Medals.length; i++)
         {
            this.m_Medals[i].Reset();
            curMedalHist = data.medalHistory[i];
            if(curMedalHist)
            {
               this.m_Medals[i].SetBarInfo(curMedalHist);
            }
         }
         this.UpdateMouseStates();
      }
      
      public function IsMaxLeft() : Boolean
      {
         return this.m_TargetX >= LEFT_OFFSET;
      }
      
      public function IsMaxRight() : Boolean
      {
         return this.m_TargetX <= -this.m_MaxX;
      }
      
      public function HandleStarMedalAwarded(data:PlayerData, id:int) : void
      {
         if(id < 0 || id >= this.m_Medals.length)
         {
            return;
         }
         var curMedal:MedalBar = this.m_Medals[id];
         var curMedalData:MedalData = data.medalHistory[id];
         if(data.fuid == this.m_Leaderboard.curPlayerFUID)
         {
            if(curMedalData.tier > curMedal.GetCurTier())
            {
               return;
            }
         }
         curMedal.SetBarInfo(curMedalData);
      }
      
      public function HandleMedalBucketFilled(data:PlayerData, id:int) : void
      {
         if(id < 0 || id >= this.m_Medals.length)
         {
            return;
         }
         var curMedal:MedalBar = this.m_Medals[id];
         var curMedalData:MedalData = data.medalHistory[id];
         if(data.fuid == this.m_Leaderboard.curPlayerFUID)
         {
            if(curMedalData.tier > curMedal.GetCurTier())
            {
               --curMedalData.count;
               curMedalData.CalculateTier();
               this.m_Leaderboard.viewManager.ShowExtendedView(data);
               this.ShowMedal(id);
               ++curMedalData.count;
               curMedalData.CalculateTier();
               curMedal.SetBarInfo(curMedalData);
            }
         }
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
         if(this.m_CurPlayerData != null)
         {
            return;
         }
         this.UpdateCurPlayerData();
      }
      
      public function HandleBasicLoadError() : void
      {
      }
      
      public function HandleExtendedLoadBegin(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadComplete(fuid1:String, fuid2:String) : void
      {
      }
      
      public function HandleExtendedLoadError() : void
      {
      }
      
      public function HandleScoreUpdated(newScore:int) : void
      {
      }
      
      protected function LayoutMedals() : void
      {
         var i:int = 0;
         var prevMedal:MedalBar = null;
         var numMedals:int = this.m_Medals.length;
         if(numMedals <= 0)
         {
            return;
         }
         this.m_Medals[0].x = 0;
         this.m_Medals[0].y = height * 0.5 - this.m_Medals[0].height * 0.5 - 4;
         for(i = 1; i < numMedals; i++)
         {
            prevMedal = this.m_Medals[i - 1];
            this.m_Medals[i].x = prevMedal.x + prevMedal.width + MEDAL_SPACING;
            this.m_Medals[i].y = prevMedal.y;
         }
      }
      
      protected function UpdateCurPlayerData() : void
      {
         if(this.m_CurPlayerData != null)
         {
            return;
         }
         this.m_CurPlayerData = this.m_Leaderboard.highScoreList.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         if(this.m_CurPlayerData == null)
         {
            return;
         }
         this.m_CurPlayerData.AddHandler(this);
      }
      
      protected function UpdateMouseStates() : void
      {
         var medal:MedalBar = null;
         var leftSide:Number = NaN;
         for each(medal in this.m_Medals)
         {
            medal.mouseChildren = false;
            leftSide = this.m_TargetX + medal.x;
            if(leftSide >= scrollRect.x && leftSide + this.m_BarWidth - MEDAL_SPACING <= scrollRect.x + scrollRect.width)
            {
               medal.mouseChildren = true;
            }
         }
      }
      
      protected function ShowMedal(id:int) : void
      {
         if(id < 0 || id >= this.m_Medals.length)
         {
            return;
         }
         var targetPage:int = id / BARS_PER_PAGE;
         this.m_TargetX = LEFT_OFFSET - this.m_BarWidth * (targetPage * BARS_PER_PAGE);
         this.m_TargetX = Math.max(Math.min(this.m_TargetX,LEFT_OFFSET),-this.m_MaxX);
         this.m_MedalGroup.x = this.m_TargetX;
         this.m_SplinePos = this.m_RangeTop + 0.1;
         this.DispatchStripMoved();
      }
      
      protected function DispatchStripMoved() : void
      {
         var handler:IMedalStripHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleStripMoved();
         }
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         this.m_SplinePos += dt;
         if(!this.m_Spline || this.m_SplinePos > 1)
         {
            return;
         }
         this.m_MedalGroup.x = this.m_Spline.getOutValue(this.m_SplinePos);
      }
   }
}
