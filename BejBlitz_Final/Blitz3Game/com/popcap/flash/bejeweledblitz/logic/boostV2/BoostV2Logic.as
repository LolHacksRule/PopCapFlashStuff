package com.popcap.flash.bejeweledblitz.logic.boostV2
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import flash.utils.Dictionary;
   
   public class BoostV2Logic
   {
       
      
      private var mLogic:BlitzLogic = null;
      
      public var mBoostMap:Dictionary;
      
      public var mHandlers:Vector.<IBoostV2Handler> = null;
      
      public var mBoostIndex:Dictionary;
      
      public function BoostV2Logic(param1:BlitzLogic)
      {
         super();
         this.mLogic = param1;
         this.mBoostMap = new Dictionary();
         this.mBoostIndex = new Dictionary();
         this.mHandlers = new Vector.<IBoostV2Handler>();
      }
      
      public function Init(param1:Vector.<BoostV2>) : void
      {
         var _loc4_:BoostV2 = null;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_] != null)
            {
               _loc4_ = param1[_loc3_];
               this.mBoostMap[_loc4_.getId()] = _loc4_;
               this.mLogic.AddHandler(_loc4_);
               this.mBoostIndex[_loc4_.getId()] = _loc3_;
               if(_loc4_.usesEventOfType(BoostV2.EVENT_TIMETICK))
               {
                  this.mLogic.timerLogic.AddTimeChangeHandler(_loc4_);
               }
               if(_loc4_.usesEventOfType(BoostV2.EVENT_GEMSPAWN))
               {
                  this.mLogic.AddSpawnHandler(_loc4_);
               }
               if(_loc4_.usesEventOfType(BoostV2.EVENT_MATCH))
               {
                  this.mLogic.AddEventHandler(_loc4_);
               }
               if(_loc4_.usesEventOfType(BoostV2.EVENT_SPECIALGEMBLAST))
               {
                  this.mLogic.AddEventHandler(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      public function Reset() : void
      {
      }
      
      public function CleanUp() : void
      {
         var _loc1_:* = null;
         var _loc2_:BoostV2 = null;
         for(_loc1_ in this.mBoostMap)
         {
            _loc2_ = this.mBoostMap[_loc1_];
            _loc2_.DoCleanUp();
            if(_loc2_.usesEventOfType(BoostV2.EVENT_TIMETICK))
            {
               this.mLogic.timerLogic.RemoveTimeChangeHandler(_loc2_);
            }
            if(_loc2_.usesEventOfType(BoostV2.EVENT_GAMEBEGIN) || _loc2_.usesEventOfType(BoostV2.EVENT_GAMEEND))
            {
               this.mLogic.RemoveHandler(_loc2_);
            }
            if(_loc2_.usesEventOfType(BoostV2.EVENT_GEMSPAWN))
            {
               this.mLogic.RemoveSpawnHandler(_loc2_);
            }
            if(_loc2_.usesEventOfType(BoostV2.EVENT_MATCH))
            {
               this.mLogic.RemoveEventHandler(_loc2_);
            }
            if(_loc2_.usesEventOfType(BoostV2.EVENT_SPECIALGEMBLAST))
            {
               this.mLogic.RemoveEventHandler(_loc2_);
            }
            _loc2_.RemoveAllHandlers();
         }
         this.mBoostMap = new Dictionary();
         this.mHandlers = new Vector.<IBoostV2Handler>();
         this.mBoostIndex = new Dictionary();
      }
      
      public function DispatchBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
         this.mBoostMap[param1].DispatchBoostFeedback(param1,param2);
      }
      
      public function DispatchBoostActivated(param1:String, param2:Vector.<Gem>) : void
      {
         this.mBoostMap[param1].DispatchBoostActivated(param1,param2);
      }
      
      public function DispatchMultiplierBonus(param1:Number) : void
      {
         var _loc2_:int = this.mHandlers.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.mHandlers[_loc3_].HandleMultiplierBonus(param1);
            _loc3_++;
         }
      }
      
      public function AddHandler(param1:IBoostV2Handler) : void
      {
         this.mHandlers.push(param1);
      }
      
      public function RemoveHandler(param1:IBoostV2Handler) : void
      {
         var _loc2_:int = this.mHandlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.mHandlers.splice(_loc2_,1);
      }
      
      public function DispatchBoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         var _loc7_:int = this.mHandlers.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            this.mHandlers[_loc8_].BoardCellsActivate(param1,param2,param3,param4,param5,param6);
            _loc8_++;
         }
      }
      
      public function DispatchBoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < this.mHandlers.length)
         {
            this.mHandlers[_loc3_].BoardCellsDeactivate(param1,param2);
            _loc3_++;
         }
      }
      
      public function DispatchForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void
      {
         var _loc8_:int = this.mHandlers.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            this.mHandlers[_loc9_].ForceStateChange(param1,param2,param3,param4,param5,param6,param7);
            _loc9_++;
         }
      }
   }
}
