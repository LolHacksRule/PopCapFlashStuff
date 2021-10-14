package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.framework.math.MersenneTwister;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.osmf.logging.Log;
   
   public class SpinBoardHighlightController
   {
       
      
      private var mCurrentHighlightIndex:int = 0;
      
      private var mEnabledTiles:Vector.<int>;
      
      private var mTimer:Timer;
      
      private var mTimerTickCallback:Function;
      
      private var mPaused:Boolean = false;
      
      private var mController:SpinBoardController;
      
      public function SpinBoardHighlightController(param1:SpinBoardController)
      {
         super();
         this.mEnabledTiles = new Vector.<int>();
         this.mTimerTickCallback = null;
         this.mCurrentHighlightIndex = 0;
         this.mController = param1;
      }
      
      public function GetCurrentHighlightIndex() : int
      {
         return this.mCurrentHighlightIndex;
      }
      
      public function StopHighlightRunner() : void
      {
         if(this.mTimer != null)
         {
            this.mTimer.removeEventListener(TimerEvent.TIMER,this.OnHighlightTimerTick);
            this.mTimer.stop();
            this.mTimerTickCallback = null;
         }
      }
      
      public function StartHighlightRunnerForActiveBoard() : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:SpinBoardPlayerDataHandler = null;
         var _loc5_:SpinBoardPlayerProgress = null;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc1_:Boolean = false;
         this.mEnabledTiles = new Vector.<int>();
         if(this.mTimer != null)
         {
            this.mTimer.removeEventListener(TimerEvent.TIMER,this.OnHighlightTimerTick);
         }
         var _loc2_:SpinBoardInfo = this.mController.GetActiveSpinBoardInfo();
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.GetType();
            if((_loc4_ = this.mController.GetPlayerDataHandler()) != null)
            {
               _loc6_ = ~(_loc5_ = _loc4_.GetBoardProgressByType(_loc3_)).GetClaimedBitField();
               _loc7_ = 1;
               _loc8_ = 0;
               while(_loc8_ < SpinBoardInfo.sNumberOfTiles)
               {
                  if(_loc6_ & _loc7_)
                  {
                     this.mEnabledTiles.push(_loc8_);
                  }
                  _loc7_ <<= 1;
                  _loc8_++;
               }
               _loc1_ = true;
            }
         }
         if(_loc1_)
         {
            this.mTimer = new Timer(SpinBoardController.GetInstance().GetCatalogue().GetHighlightTimeInMilliSeconds());
            this.mTimer.addEventListener(TimerEvent.TIMER,this.OnHighlightTimerTick);
            this.mTimer.start();
         }
         else
         {
            Utils.log(this,"[SpinBoardHighlightController] Could not initiate highlight run.");
         }
         return _loc1_;
      }
      
      public function RegisterHighlightTimerTickCallback(param1:Function) : void
      {
         this.mTimerTickCallback = param1;
      }
      
      public function DeregisterHighlightTimerTickCallback(param1:Function) : void
      {
         if(this.mTimerTickCallback == param1)
         {
            this.mTimerTickCallback = null;
         }
      }
      
      public function ResumeHighlighter() : void
      {
         this.StartHighlightRunnerForActiveBoard();
         this.mPaused = false;
      }
      
      public function PauseHighlighter() : void
      {
         this.mPaused = true;
      }
      
      public function OnHighlightTimerTick(param1:TimerEvent) : void
      {
         if(!this.mPaused)
         {
            this.GetNextHighlightIndex();
            if(this.mTimerTickCallback != null)
            {
               this.mTimerTickCallback();
            }
         }
      }
      
      public function GetNextHighlightIndex() : int
      {
         var _loc3_:SpinBoardElementInfo = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Vector.<SpinBoardElementInfo> = null;
         var _loc12_:SpinBoardPlayerProgress = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Vector.<uint> = null;
         var _loc16_:BlitzRandom = null;
         var _loc17_:int = 0;
         var _loc18_:uint = 0;
         var _loc1_:int = this.mEnabledTiles.length;
         var _loc2_:uint = 0;
         var _loc6_:SpinBoardInfo;
         if((_loc6_ = this.mController.GetActiveSpinBoardInfo()) == null)
         {
            this.mCurrentHighlightIndex = 0;
         }
         else if(_loc1_ > 2)
         {
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc11_ = _loc6_.GetSpinBoardElements();
            if((_loc12_ = this.mController.GetPlayerDataHandler().GetBoardProgressByType(_loc6_.GetType())) != null)
            {
               _loc13_ = this.mEnabledTiles.length;
               _loc14_ = 0;
               while(_loc14_ < _loc13_)
               {
                  _loc2_ = this.mEnabledTiles[_loc14_];
                  _loc3_ = _loc11_[_loc2_];
                  if(_loc3_ != null)
                  {
                     _loc4_ = _loc12_.GetUpgradeStatus(_loc2_);
                     if((_loc5_ = _loc3_.GetHighlightWeight(_loc4_)) > _loc7_)
                     {
                        _loc8_ = _loc7_;
                        _loc10_ = _loc9_;
                        _loc7_ = _loc5_;
                        _loc9_ = _loc2_;
                     }
                     else if(_loc5_ > _loc8_)
                     {
                        _loc8_ = _loc5_;
                        _loc10_ = _loc2_;
                     }
                  }
                  else
                  {
                     Log("[SpinBoardHighlightController] BoardElement null");
                  }
                  _loc14_++;
               }
               _loc15_ = new Vector.<uint>();
               (_loc16_ = new BlitzRandom(new MersenneTwister())).SetSeed(new Date().time % 2000000000);
               _loc17_ = _loc16_.Int(0,_loc7_);
               _loc18_ = 0;
               while(_loc18_ < _loc1_)
               {
                  _loc2_ = this.mEnabledTiles[_loc18_];
                  _loc3_ = _loc11_[_loc2_];
                  if(_loc3_ != null)
                  {
                     if(_loc2_ != this.mCurrentHighlightIndex)
                     {
                        _loc4_ = _loc12_.GetUpgradeStatus(_loc2_);
                        if((_loc5_ = _loc3_.GetHighlightWeight(_loc4_)) >= _loc17_)
                        {
                           _loc15_.push(_loc2_);
                        }
                     }
                  }
                  _loc18_++;
               }
               if(_loc15_.length < 2 && _loc10_ != this.mCurrentHighlightIndex)
               {
                  _loc15_.push(_loc10_);
               }
               this.mCurrentHighlightIndex = _loc15_[_loc16_.Int(0,_loc15_.length - 1)];
            }
         }
         else if(_loc1_ == 2)
         {
            _loc2_ = this.mEnabledTiles[0];
            if(_loc2_ == this.mCurrentHighlightIndex)
            {
               _loc2_ = this.mEnabledTiles[1];
            }
            this.mCurrentHighlightIndex = _loc2_;
         }
         else if(_loc1_ == 1)
         {
            this.mCurrentHighlightIndex = this.mEnabledTiles[0];
         }
         else
         {
            this.mCurrentHighlightIndex = -1;
            this.mController.GetUpdateHandler().OnAllTimesClaimed();
            this.StopHighlightRunner();
         }
         return this.mCurrentHighlightIndex;
      }
   }
}
