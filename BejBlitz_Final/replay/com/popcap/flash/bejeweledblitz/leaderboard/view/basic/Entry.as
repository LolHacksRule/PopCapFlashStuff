package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IDataUpdaterHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class Entry extends Sprite implements IInterfaceComponent, IEntryWheelHandler, IDataUpdaterHandler
   {
      
      public static const FLIP_POLICY_ALLOW:int = 0;
      
      public static const FLIP_POLICY_NONE:int = 1;
      
      public static const FLIP_POLICY_BACK_ONLY:int = 2;
      
      public static const MOUSEOVER_FLIP_DELAY:Number = 0.25;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      public var originalWidth:Number;
      
      public var originalHeight:Number;
      
      protected var m_PlayerData:PlayerData;
      
      protected var m_Wheel:EntryWheel;
      
      protected var m_Front:EntryFrontWrapper;
      
      protected var m_Back:EntryBackWrapper;
      
      protected var m_FlipPolicy:int = 0;
      
      protected var m_OriginalRect:Rectangle;
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      protected var m_Delay:Number = 0.25;
      
      public function Entry(app:App, leaderboard:LeaderboardWidget, flipPolicy:int = 0, data:PlayerData = null)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_PlayerData = data;
         this.m_FlipPolicy = flipPolicy;
         this.m_Delay = MOUSEOVER_FLIP_DELAY;
         buttonMode = flipPolicy == FLIP_POLICY_NONE;
         useHandCursor = flipPolicy == FLIP_POLICY_NONE;
         this.m_Wheel = new EntryWheel(this.m_Leaderboard);
         this.m_Front = new EntryFrontWrapper(this.m_App,this.m_Leaderboard,this.m_Wheel.front);
         this.m_Back = new EntryBackWrapper(this.m_App,this.m_Leaderboard,this.m_Wheel.back);
      }
      
      public function Init() : void
      {
         addChild(this.m_Wheel);
         this.originalWidth = width;
         this.originalHeight = height;
         this.m_Wheel.Init();
         this.m_Wheel.AddHandler(this);
         this.m_Front.Init();
         this.m_Back.Init();
         this.m_Front.front.clipArrow.mouseEnabled = false;
         this.m_Front.front.clipArrow.mouseChildren = false;
         this.m_Front.front.clipArrow.gotoAndStop(1);
         if(this.m_FlipPolicy == FLIP_POLICY_NONE)
         {
            this.m_Front.front.clipArrow.gotoAndStop(2);
         }
         this.m_OriginalRect = getRect(this);
         if(this.m_PlayerData != null)
         {
            this.SetPlayerData(this.m_PlayerData);
         }
         this.m_Leaderboard.updater.AddHandler(this);
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
      }
      
      public function Reset() : void
      {
         this.m_Wheel.Reset();
         this.m_Front.Reset();
         this.m_Back.Reset();
      }
      
      public function OnShow() : void
      {
         this.m_Wheel.ResetRotation();
      }
      
      public function SetPlayerData(data:PlayerData) : void
      {
         this.m_PlayerData = data;
         var rect:Rectangle = getRect(this);
         this.m_Front.SetPlayerData(this.m_PlayerData,this.originalWidth,rect);
         this.m_Back.SetPlayerData(this.m_PlayerData,this.originalWidth,rect);
      }
      
      public function HasData() : Boolean
      {
         return this.m_PlayerData != null;
      }
      
      public function SetFlipPolicy(policy:int) : void
      {
         this.m_FlipPolicy = policy;
      }
      
      public function HandleFlipToBackBegin() : void
      {
      }
      
      public function HandleFlipToBackComplete() : void
      {
         if(this.m_FlipPolicy == FLIP_POLICY_NONE)
         {
            return;
         }
         var rect:Rectangle = getRect(this);
         if(!rect.contains(mouseX,mouseY))
         {
            this.m_Wheel.BackFlip();
         }
      }
      
      public function HandleFlipToFrontBegin() : void
      {
      }
      
      public function HandleFlipToFrontComplete() : void
      {
      }
      
      public function HandleBasicLoadBegin() : void
      {
      }
      
      public function HandleBasicLoadComplete() : void
      {
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
         if(this.m_PlayerData && this.m_PlayerData.fuid == this.m_Leaderboard.curPlayerFUID)
         {
            this.SetPlayerData(this.m_PlayerData);
         }
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         if(this.m_FlipPolicy == FLIP_POLICY_NONE)
         {
            return;
         }
         if(this.m_OriginalRect.contains(mouseX,mouseY))
         {
            this.m_Delay -= dt;
            if(this.m_Delay > 0)
            {
               return;
            }
            if(!this.m_Wheel.IsFlipping() && this.m_Wheel.IsFrontFacing() && this.m_FlipPolicy == FLIP_POLICY_ALLOW)
            {
               this.m_Wheel.Flip();
            }
         }
         else
         {
            this.m_Delay = MOUSEOVER_FLIP_DELAY;
            if(!this.m_Wheel.IsFlipping() && !this.m_Wheel.IsFrontFacing())
            {
               this.m_Wheel.BackFlip();
            }
         }
      }
   }
}
