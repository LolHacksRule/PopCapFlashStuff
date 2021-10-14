package com.popcap.flash.bejeweledblitz.logic.game
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   
   public class BlazingSpeedLogic
   {
      
      private static const dummy:Match = null;
       
      
      private var _logic:BlitzLogic;
      
      private var m_NeedlePos:Number;
      
      private var m_SpeedFactor:Number;
      
      private var m_IsTriggered:Boolean;
      
      private var m_Timer:int;
      
      private var m_Duration:int;
      
      private var mTriggerCount:int;
      
      public var mIsEnabled:Boolean = false;
      
      private var m_MoveHistory:Vector.<int>;
      
      private var m_NumExplosions:int;
      
      private var m_Handlers:Vector.<IBlazingSpeedLogicHandler>;
      
      private var m_IsAnimationHeld:Boolean = false;
      
      public function BlazingSpeedLogic(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.m_NeedlePos = 0;
         this.m_SpeedFactor = 1;
         this.m_IsTriggered = false;
         this.m_Timer = 0;
         this.m_NumExplosions = 0;
         this.m_Duration = this._logic.config.blazingSpeedLogicBonusTime;
         this.m_MoveHistory = new Vector.<int>();
         this.m_Handlers = new Vector.<IBlazingSpeedLogicHandler>();
         this.Reset(true);
      }
      
      public function Init() : void
      {
      }
      
      public function Reset(param1:Boolean) : void
      {
         this.m_NeedlePos = 0;
         this.m_SpeedFactor = 1;
         this.m_IsTriggered = false;
         this.m_Timer = 0;
         this.mIsEnabled = true;
         this.m_NumExplosions = 0;
         this.m_MoveHistory.length = 0;
         this.m_Duration = this._logic.config.blazingSpeedLogicBonusTime;
         this.m_IsAnimationHeld = false;
         if(param1)
         {
            this.mTriggerCount = 0;
         }
      }
      
      public function GetTriggerCount() : int
      {
         return this.mTriggerCount;
      }
      
      public function SetDuration(param1:int) : void
      {
         this.m_Duration = param1;
      }
      
      public function GetPercent() : Number
      {
         return this.m_NeedlePos;
      }
      
      public function GetTimeLeft() : int
      {
         return this.m_Timer;
      }
      
      public function GetDuration() : int
      {
         return this.m_Duration;
      }
      
      public function GetSpeedFactor() : Number
      {
         return this.m_SpeedFactor;
      }
      
      public function GetNumExplosions() : int
      {
         return this.m_NumExplosions;
      }
      
      public function StartBonus() : void
      {
         if(this.m_IsTriggered)
         {
            return;
         }
         ++this.mTriggerCount;
         this.m_NeedlePos = 1;
         this.m_IsTriggered = true;
         this.m_Timer = this.m_Duration;
         this.m_SpeedFactor = this._logic.config.blitzLogicBaseSpeed + this._logic.config.blazingSpeedLogicSpeedBonus;
         this._logic.SetSpeed(this.m_SpeedFactor);
         if(this._logic.config.eternalBlazingSpeed)
         {
            this._logic.speedBonus.SetBonus(1000);
            this._logic.speedBonus.isEnabled = false;
         }
         this.DispatchPercentChanged();
         this.DispatchBlazingSpeedBegin();
      }
      
      public function Update(param1:Vector.<Match>, param2:BlitzLogic) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(this.m_IsAnimationHeld)
         {
            return;
         }
         var _loc3_:RGLogic = param2.rareGemsLogic.currentRareGem;
         var _loc4_:Boolean;
         if(!(_loc4_ = _loc3_ != null && _loc3_.getStringID() == BlazingSteedRGLogic.ID))
         {
            if(param2.IsGameOver() || param2.lastHurrahLogic.IsRunning())
            {
               if(this.m_Timer != 0 || this.m_NeedlePos != 0)
               {
                  this.m_Timer = 0;
                  this.m_NeedlePos = 0;
                  this.DispatchBlazingSpeedEnd();
               }
            }
            if(param2.lastHurrahLogic.IsRunning())
            {
               return;
            }
         }
         if(this._logic.config.eternalBlazingSpeed)
         {
            if(!this.m_IsTriggered)
            {
               this.StartBonus();
            }
            return;
         }
         if(this.m_IsTriggered && (param2.mBlockingEvents.length == 0 || param2.isActive))
         {
            this.m_NeedlePos = 1;
            if(this.m_Timer == 0)
            {
               this.m_IsTriggered = false;
               this.m_NeedlePos = 0;
               if(this._logic.speedBonus.GetBonusLevels() > 0)
               {
                  this._logic.speedBonus.ResetBonusLevels();
               }
               this.DispatchBlazingSpeedEnd();
               return;
            }
            if(param2.mBlockingEvents.length == 0)
            {
               --this.m_Timer;
            }
            if(_loc4_)
            {
               this.DispatchPercentChanged();
            }
            return;
         }
         if(!this.mIsEnabled)
         {
            return;
         }
         var _loc5_:Number = 0;
         var _loc6_:BlitzSpeedBonus;
         var _loc7_:int = (_loc6_ = this._logic.speedBonus).GetMoveTime();
         if(_loc6_.GetLevel() > this._logic.config.blazingSpeedLogicMinSpeedLevel)
         {
            _loc7_ = _loc7_ > this._logic.config.blazingSpeedLogicSpeedCap ? int(_loc7_) : int(this._logic.config.blazingSpeedLogicSpeedCap);
            _loc8_ = this._logic.config.blazingSpeedLogicMaxSpeed - this._logic.config.blazingSpeedLogicMinSpeed;
            _loc5_ = 1 - (_loc7_ - this._logic.config.blazingSpeedLogicMinSpeed) / _loc8_;
            _loc5_ = Math.min(1.5,_loc5_);
         }
         else
         {
            this.m_NeedlePos = 0;
         }
         if(_loc6_.WasMoveMade() && _loc5_ >= this.m_NeedlePos)
         {
            _loc9_ = 0;
            if(_loc6_.GetBonusLevels() > 0)
            {
               _loc9_ = _loc6_.GetBonusLevels() / this._logic.config.blitzSpeedBonusLevelMax;
               _loc6_.ResetBonusLevels();
            }
            else
            {
               _loc9_ = (_loc10_ = Number((_loc5_ - this.m_NeedlePos) * this._logic.config.blazingSpeedLogicGrowthPercent)) < this._logic.config.blazingSpeedLogicGrowthCap ? Number(_loc10_) : Number(this._logic.config.blazingSpeedLogicGrowthCap);
            }
            this.m_NeedlePos = Math.min(1,this.m_NeedlePos + _loc9_);
         }
         if(param2.mBlockingEvents.length == 0)
         {
            _loc11_ = this._logic.config.blazingSpeedLogicMaxSpeed + this.m_NeedlePos * (this._logic.config.blazingSpeedLogicMinSpeed - this._logic.config.blazingSpeedLogicMaxSpeed);
            if(_loc7_ >= _loc11_)
            {
               this.m_NeedlePos *= 1 - this._logic.config.blazingSpeedLogicDecayPercent;
            }
         }
         if(this.m_NeedlePos >= 1)
         {
            this.StartBonus();
         }
         this.DispatchPercentChanged();
         this.m_SpeedFactor = this._logic.config.blitzLogicBaseSpeed + this._logic.config.blazingSpeedLogicSpeedBonus * this.m_NeedlePos;
         this._logic.SetSpeed(this.m_SpeedFactor);
      }
      
      public function DoExplosions() : void
      {
         var _loc4_:SwapData = null;
         var _loc5_:MoveData = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!this.m_IsTriggered)
         {
            return;
         }
         var _loc1_:Vector.<SwapData> = this._logic.completedSwaps;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = _loc1_[_loc3_]).moveData;
            _loc6_ = this.m_MoveHistory.length;
            if(_loc5_.id >= _loc6_)
            {
               this.m_MoveHistory.length = _loc5_.id + 1;
               _loc7_ = _loc6_;
               while(_loc7_ <= _loc5_.id)
               {
                  this.m_MoveHistory[_loc7_] = -1;
                  _loc7_++;
               }
            }
            if(this.m_MoveHistory[_loc5_.id] == -1)
            {
               this.ExplodeGem(_loc5_.sourceGem);
               this.ExplodeGem(_loc5_.swapGem);
               this.m_MoveHistory[_loc5_.id] = _loc5_.id;
            }
            _loc3_++;
         }
      }
      
      public function AddHandler(param1:IBlazingSpeedLogicHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBlazingSpeedLogicHandler) : void
      {
         var _loc2_:int = this.m_Handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.m_Handlers.splice(_loc2_,1);
      }
      
      public function IsRunning() : Boolean
      {
         return this.m_IsTriggered;
      }
      
      private function ExplodeGem(param1:Gem) : void
      {
         if(param1 == null || !param1.hasMatch)
         {
            return;
         }
         if(this._logic.rareGemTokenLogic.GemHasRareGemGiftToken(param1))
         {
            param1.isImmune = true;
         }
         this._logic.flameGemLogic.ForceExplosion(param1.id);
         param1.SetDetonating(true);
         ++this.m_NumExplosions;
      }
      
      private function DispatchBlazingSpeedBegin() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleBlazingSpeedBegin();
         }
      }
      
      private function DispatchBlazingSpeedEnd() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleBlazingSpeedEnd();
         }
      }
      
      private function DispatchBlazingSpeedReset() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleBlazingSpeedReset();
         }
      }
      
      private function DispatchPercentChanged() : void
      {
         var _loc1_:IBlazingSpeedLogicHandler = null;
         for each(_loc1_ in this.m_Handlers)
         {
            _loc1_.HandleBlazingSpeedPercentChanged(this.m_NeedlePos);
         }
      }
      
      public function IsAnimationPending() : Boolean
      {
         return this.m_IsAnimationHeld;
      }
      
      public function BlockPendingAnimation() : void
      {
         this.m_IsAnimationHeld = true;
      }
      
      public function UnblockPendingAnimation() : void
      {
         this.m_IsAnimationHeld = false;
      }
      
      public function SetNeedlePos(param1:Number) : void
      {
         this.m_NeedlePos = param1;
         this.DispatchPercentChanged();
      }
      
      public function SetTimerLeft(param1:int) : void
      {
         this.m_Timer = param1;
      }
      
      public function ResetBlazingSpeed() : void
      {
         this.DispatchBlazingSpeedReset();
      }
   }
}
