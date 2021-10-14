package com.popcap.flash.bejeweledblitz.dailyspin2
{
   import com.popcap.flash.bejeweledblitz.dailyspin2.UI.SpinBoardUIController;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ftue.FTUEManager;
   import com.popcap.flash.bejeweledblitz.game.ftue.impl.FtueFlowName;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpinBoardUpdateHandler
   {
       
      
      private var mController:SpinBoardController;
      
      private var mTimer:Timer;
      
      private var mFreeSpinAvailableEventHandlers:Vector.<Function>;
      
      public function SpinBoardUpdateHandler(param1:SpinBoardController)
      {
         super();
         this.mController = param1;
         this.mFreeSpinAvailableEventHandlers = new Vector.<Function>();
      }
      
      public function Init() : void
      {
         if(this.mTimer != null)
         {
            this.mTimer.removeEventListener(TimerEvent.TIMER,this.OnTimerTick);
            this.mTimer = null;
         }
         this.mTimer = new Timer(1000);
         this.mTimer.addEventListener(TimerEvent.TIMER,this.OnTimerTick);
         this.mTimer.start();
      }
      
      public function RegisterFreeSpinAvailableEventHandler(param1:Function) : void
      {
         if(this.mFreeSpinAvailableEventHandlers.indexOf(param1) == -1)
         {
            this.mFreeSpinAvailableEventHandlers.push(param1);
         }
      }
      
      public function DeregisterFreeSpinAvailableEventHandler(param1:Function) : void
      {
         var _loc2_:Number = this.mFreeSpinAvailableEventHandlers.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.mFreeSpinAvailableEventHandlers.splice(_loc2_,1);
         }
      }
      
      public function OnAllTimesClaimed() : void
      {
         this.mController.GetStateHandler().SetState(SpinBoardState.WholeSpinBoardCleared);
      }
      
      public function OnTimerTick(param1:TimerEvent) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:SpinBoardPlayerProgress = null;
         var _loc8_:int = 0;
         var _loc9_:FTUEManager = null;
         var _loc10_:Boolean = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:Number = new Date().time / 1000;
         var _loc3_:SpinBoardInfo = this.mController.GetActiveSpinBoardInfo();
         if(this.mController.GetActiveSpinBoardInfo() != null)
         {
            _loc6_ = 0;
            if((_loc7_ = SpinBoardController.GetInstance().GetPlayerDataHandler().GetBoardProgressByType(_loc3_.GetType())) != null && _loc7_.GetBoardResetTime() != 0)
            {
               _loc6_ = _loc7_.GetBoardResetTime();
            }
            else if(_loc3_.GetType() != SpinBoardType.PremiumBoard)
            {
               _loc6_ = _loc3_.GetEndTime();
            }
            if(_loc6_ > 0 && _loc6_ <= _loc2_)
            {
               if((_loc8_ = this.mController.GetStateHandler().GetState()) == SpinBoardState.BoardRunning && SpinBoardUIController.GetInstance().AreUserActionsAllowed())
               {
                  this.mController.GetStateHandler().SetState(SpinBoardState.BoardExpired);
               }
               if(_loc3_.IsFTUEBoard())
               {
                  _loc9_ = Blitz3App.app.sessionData.ftueManager;
                  _loc10_ = _loc9_.IsFlowCompleted(_loc9_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING));
                  if(_loc3_.GetType() == SpinBoardType.RegularBoard && !_loc10_)
                  {
                     if(_loc9_.getCurrentFlow() && _loc9_.getCurrentFlow().GetFlowId() == _loc9_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING))
                     {
                        _loc9_.markCurrentFlowAsDone();
                     }
                     else
                     {
                        _loc9_.markFlowAsDoneForId(_loc9_.GetFlowId(FtueFlowName.SPINBOARD_INTRO_EXISTING));
                     }
                     if(_loc9_.getCurrentFlow() && _loc9_.getCurrentFlow().GetFlowId() == _loc9_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING))
                     {
                        _loc9_.markCurrentFlowAsDone();
                     }
                     else
                     {
                        _loc9_.markFlowAsDoneForId(_loc9_.GetFlowId(FtueFlowName.REGULAR_SPINBOARD_INTRO_EXISTING));
                     }
                  }
               }
            }
         }
         var _loc4_:Boolean = this.mController.GetPlayerDataHandler().HasFreeSpinAvailable();
         var _loc5_:Number = this.mController.GetPlayerDataHandler().GetNextFreeSpinAvailableTime();
         if(!_loc4_ && _loc5_ <= _loc2_)
         {
            this.mController.GetPlayerDataHandler().SetHasFreeSpinAvailable(true);
            _loc11_ = this.mFreeSpinAvailableEventHandlers.length;
            _loc12_ = 0;
            while(_loc12_ < _loc11_)
            {
               if(this.mFreeSpinAvailableEventHandlers[_loc12_] != null)
               {
                  this.mFreeSpinAvailableEventHandlers[_loc12_]();
               }
               _loc12_++;
            }
         }
      }
   }
}
