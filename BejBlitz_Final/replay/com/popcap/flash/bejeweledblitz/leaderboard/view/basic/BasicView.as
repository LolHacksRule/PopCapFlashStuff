package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.framework.misc.LinearSampleCurvedVal;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseBasicView;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class BasicView extends BaseBasicView implements IInterfaceComponent, IDataUpdaterHandler
   {
      
      public static const MAX_VISIBLE_ENTRIES:int = 5;
      
      public static const VERTICAL_BUFFER:Number = 2;
      
      public static const HORIZ_MASK_BUFF:Number = 5;
      
      public static const TIME_PER_PAGE:Number = 0.5;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_EntryContainer:Sprite;
      
      protected var m_Entries:Vector.<Entry>;
      
      protected var m_CurPageNumber:int;
      
      protected var m_Spline:LinearSampleCurvedVal;
      
      protected var m_SplinePos:Number;
      
      protected var m_RangeTop:Number;
      
      protected var m_MaxMoveSpeed:Number;
      
      protected var m_CurPlayerHighScore:int = 0;
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      public function BasicView(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_EntryContainer = new Sprite();
         this.m_EntryContainer.x = anchor.x;
         this.m_EntryContainer.y = anchor.y;
         addChild(this.m_EntryContainer);
         this.m_CurPageNumber = 0;
         this.m_RangeTop = 1;
         this.m_SplinePos = 1.1;
         btnUp.addEventListener(MouseEvent.CLICK,this.HandleUpClick);
         btnDown.addEventListener(MouseEvent.CLICK,this.HandleDownClick);
         this.m_Entries = new Vector.<Entry>(1);
         this.m_Entries[0] = new Entry(this.m_App,this.m_Leaderboard);
         this.m_Entries[0].Init();
         this.m_EntryContainer.addChild(this.m_Entries[0]);
         this.m_Entries[0].y = this.m_Entries[0].height * 0.5 - 6;
         this.m_MaxMoveSpeed = (this.m_Entries[0].originalHeight + VERTICAL_BUFFER) * MAX_VISIBLE_ENTRIES / TIME_PER_PAGE;
         var mask:Shape = new Shape();
         mask.graphics.beginFill(0);
         mask.graphics.drawRect(anchor.x - this.m_Entries[0].width * 0.5 - HORIZ_MASK_BUFF,anchor.height + this.m_Entries[0].height * 0.5 - 8,this.m_Entries[0].width + HORIZ_MASK_BUFF * 2,MAX_VISIBLE_ENTRIES * (this.m_Entries[0].originalHeight + VERTICAL_BUFFER) + 2);
         mask.graphics.endFill();
         mask.cacheAsBitmap = true;
         addChild(mask);
         this.m_EntryContainer.mask = mask;
         this.ShowPage(0);
      }
      
      public function Init() : void
      {
         this.m_Leaderboard.updater.AddHandler(this);
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function Reset() : void
      {
         this.ShowPage(0);
      }
      
      public function OnShow() : void
      {
         var entry:Entry = null;
         for each(entry in this.m_Entries)
         {
            entry.OnShow();
         }
      }
      
      public function ShowCurrentPlayer(animate:Boolean = true) : void
      {
         var curPlayerIndex:int = -1;
         var list:Vector.<String> = this.m_Leaderboard.highScoreList.GetList();
         curPlayerIndex = list.indexOf(this.m_Leaderboard.curPlayerFUID);
         if(curPlayerIndex >= 0)
         {
            this.ShowPage(int(curPlayerIndex / MAX_VISIBLE_ENTRIES),animate);
         }
      }
      
      public function GetEntryBounds(index:int, targetSpace:DisplayObject) : Rectangle
      {
         if(index < 0 || index >= this.m_Entries.length)
         {
            return null;
         }
         return this.m_Entries[index].getRect(targetSpace);
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
         var curPlayerData:PlayerData = this.m_Leaderboard.highScoreList.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         if(curPlayerData)
         {
            this.m_CurPlayerHighScore = curPlayerData.curTourneyData.score;
         }
         this.ShowCurrentPlayer(false);
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
         var curPlayerData:PlayerData = this.m_Leaderboard.highScoreList.GetPlayerData(this.m_Leaderboard.curPlayerFUID);
         if(!curPlayerData || newScore <= this.m_CurPlayerHighScore)
         {
            this.ShowPage();
            return;
         }
         this.m_CurPlayerHighScore = newScore;
         this.ShowCurrentPlayer();
      }
      
      protected function ShowPage(pageNum:int = -1, animate:Boolean = true) : void
      {
         var i:int = 0;
         var curEntry:Entry = null;
         var prevEntry:Entry = null;
         var prevPage:int = this.m_CurPageNumber;
         var fuidList:Vector.<String> = this.m_Leaderboard.highScoreList.GetList();
         var numFriends:int = fuidList.length;
         var numPages:int = Math.ceil(numFriends / MAX_VISIBLE_ENTRIES);
         if(pageNum >= 0 && pageNum < numPages)
         {
            this.m_CurPageNumber = pageNum;
         }
         btnUp.mouseEnabled = true;
         btnDown.mouseEnabled = true;
         clipUpDisabled.visible = false;
         clipDownDisabled.visible = false;
         if(this.m_CurPageNumber == 0)
         {
            btnUp.mouseEnabled = false;
            clipUpDisabled.visible = true;
         }
         if(this.m_CurPageNumber == numPages - 1)
         {
            btnDown.mouseEnabled = false;
            clipDownDisabled.visible = true;
         }
         var totalEntriesNeeded:int = (this.m_CurPageNumber + 1) * MAX_VISIBLE_ENTRIES;
         for(i = this.m_Entries.length; i < totalEntriesNeeded; i++)
         {
            this.m_Entries[i] = new Entry(this.m_App,this.m_Leaderboard);
            curEntry = this.m_Entries[i];
            prevEntry = this.m_Entries[i - 1];
            curEntry.Init();
            this.m_EntryContainer.addChild(curEntry);
            curEntry.x = prevEntry.x;
            curEntry.y = prevEntry.y + prevEntry.originalHeight + VERTICAL_BUFFER;
            curEntry.visible = false;
         }
         var numEntries:int = this.m_Entries.length;
         var numFUIDs:int = fuidList.length;
         for(i = 0; i < numEntries; i++)
         {
            this.m_Entries[i].SetFlipPolicy(Entry.FLIP_POLICY_BACK_ONLY);
         }
         var minEntry:int = Math.max(0,(this.m_CurPageNumber - 1) * MAX_VISIBLE_ENTRIES);
         var maxEntry:int = Math.min((this.m_CurPageNumber + 2) * MAX_VISIBLE_ENTRIES,this.m_Entries.length);
         for(i = minEntry; i < maxEntry; i++)
         {
            if(i >= numEntries || i >= numFUIDs)
            {
               break;
            }
            curEntry = this.m_Entries[i];
            if(visible)
            {
               curEntry.SetPlayerData(this.m_Leaderboard.highScoreList.GetPlayerData(fuidList[i]));
            }
            curEntry.visible = true;
         }
         var topEntry:Entry = this.m_Entries[this.m_CurPageNumber * MAX_VISIBLE_ENTRIES];
         var topRect:Rectangle = topEntry.getRect(this.m_EntryContainer);
         var targetY:Number = anchor.y - this.m_CurPageNumber * MAX_VISIBLE_ENTRIES * (this.m_Entries[0].originalHeight + VERTICAL_BUFFER);
         var oldRangeTop:Number = this.m_RangeTop;
         this.m_RangeTop = Math.max(Math.abs((targetY - this.m_EntryContainer.y) / this.m_MaxMoveSpeed),Number.MIN_VALUE);
         if(!animate)
         {
            this.m_RangeTop = Number.MIN_VALUE;
         }
         this.m_Spline = new LinearSampleCurvedVal();
         this.m_Spline.setInRange(0,this.m_RangeTop);
         this.m_Spline.setOutRange(this.m_EntryContainer.y,targetY);
         if(Math.abs(this.m_SplinePos) >= Math.abs(oldRangeTop))
         {
            this.m_Spline.addPoint(0.1 * this.m_RangeTop,this.m_EntryContainer.y + (targetY - this.m_EntryContainer.y) * 0.05);
         }
         this.m_Spline.addPoint(0.9 * this.m_RangeTop,this.m_EntryContainer.y + (targetY - this.m_EntryContainer.y) * 0.95);
         this.m_SplinePos = 0;
         for each(curEntry in this.m_Entries)
         {
            if(curEntry.HasData())
            {
               curEntry.visible = true;
            }
         }
      }
      
      protected function HandleUpClick(event:MouseEvent) : void
      {
         this.ShowPage(this.m_CurPageNumber - 1);
      }
      
      protected function HandleDownClick(event:MouseEvent) : void
      {
         this.ShowPage(this.m_CurPageNumber + 1);
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         var numEntries:int = 0;
         var i:int = 0;
         var curEntry:Entry = null;
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         this.m_SplinePos += dt;
         if(this.m_SplinePos >= this.m_RangeTop)
         {
            numEntries = this.m_Entries.length;
            for(i = 0; i < numEntries; i++)
            {
               curEntry = this.m_Entries[i];
               if(int(i / MAX_VISIBLE_ENTRIES) == this.m_CurPageNumber && curEntry.HasData())
               {
                  curEntry.visible = true;
                  curEntry.SetFlipPolicy(Entry.FLIP_POLICY_ALLOW);
               }
               else
               {
                  curEntry.visible = false;
               }
            }
         }
         if(this.m_Spline)
         {
            this.m_EntryContainer.y = this.m_Spline.getOutValue(this.m_SplinePos);
         }
      }
   }
}
