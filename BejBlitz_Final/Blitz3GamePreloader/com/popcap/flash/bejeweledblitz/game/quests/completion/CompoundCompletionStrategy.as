package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   
   public class CompoundCompletionStrategy implements IQuestCompletionStrategy
   {
       
      
      private var m_Strategies:Vector.<IQuestCompletionStrategy>;
      
      private var m_Separator:String;
      
      private var _requireAll:Boolean;
      
      private var _requireSimultaneousCompletion:Boolean;
      
      public function CompoundCompletionStrategy(param1:Vector.<IQuestCompletionStrategy>, param2:Boolean, param3:String = "<br>", param4:Boolean = false)
      {
         super();
         this.m_Strategies = param1;
         this.m_Separator = param3;
         this._requireAll = param2;
         this._requireSimultaneousCompletion = param4;
         if(this._requireSimultaneousCompletion && !this._requireAll)
         {
            throw new Error("CAN NOT REQUEST SIMULTANEOUS COMPLETION IF ALL QUESTS ARE NOT REQUIRED");
         }
      }
      
      public function SetQuest(param1:Quest) : void
      {
         var _loc2_:IQuestCompletionStrategy = null;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc2_.SetQuest(param1);
         }
      }
      
      public function IsQuestComplete() : Boolean
      {
         var _loc2_:IQuestCompletionStrategy = null;
         var _loc3_:Boolean = false;
         var _loc1_:Boolean = !!this._requireAll ? true : false;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc3_ = _loc2_.IsQuestComplete();
            _loc1_ = !!this._requireAll ? _loc1_ && _loc3_ : _loc1_ || _loc3_;
         }
         return _loc1_;
      }
      
      public function ForceCompletion() : void
      {
         var _loc1_:IQuestCompletionStrategy = null;
         for each(_loc1_ in this.m_Strategies)
         {
            _loc1_.ForceCompletion();
         }
      }
      
      public function clearCompletion() : void
      {
         var _loc1_:IQuestCompletionStrategy = null;
         for each(_loc1_ in this.m_Strategies)
         {
            _loc1_.clearCompletion();
         }
      }
      
      public function forceReset() : void
      {
         var _loc1_:IQuestCompletionStrategy = null;
         for each(_loc1_ in this.m_Strategies)
         {
            _loc1_.forceReset();
         }
      }
      
      public function UpdateCompletionState() : void
      {
         var _loc1_:IQuestCompletionStrategy = null;
         for each(_loc1_ in this.m_Strategies)
         {
            _loc1_.UpdateCompletionState();
         }
         if(this._requireSimultaneousCompletion)
         {
            if(!this.IsQuestComplete())
            {
               this.clearCompletion();
            }
         }
      }
      
      public function GetProgressString() : String
      {
         var _loc2_:IQuestCompletionStrategy = null;
         var _loc3_:String = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.m_Strategies)
         {
            _loc3_ = _loc2_.GetProgressString();
            if(_loc3_ != "")
            {
               if(_loc1_ != "")
               {
                  _loc1_ += this.m_Separator;
               }
               _loc1_ += _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function GetProgress() : int
      {
         var _loc2_:IQuestCompletionStrategy = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc1_ += _loc2_.GetProgress();
         }
         return _loc1_;
      }
      
      public function GetGoalString() : String
      {
         var _loc2_:IQuestCompletionStrategy = null;
         var _loc3_:String = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.m_Strategies)
         {
            _loc3_ = _loc2_.GetGoalString();
            if(_loc3_ != "")
            {
               if(_loc1_ != "")
               {
                  _loc1_ += this.m_Separator;
               }
               _loc1_ += _loc3_;
            }
         }
         return _loc1_;
      }
      
      public function GetGoal() : int
      {
         var _loc2_:IQuestCompletionStrategy = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_Strategies)
         {
            _loc3_ = _loc2_.GetGoal();
            _loc1_ += _loc3_;
         }
         return _loc1_;
      }
      
      public function CleanUpConfigData() : void
      {
         var _loc1_:IQuestCompletionStrategy = null;
         for each(_loc1_ in this.m_Strategies)
         {
            _loc1_.CleanUpConfigData();
         }
      }
   }
}
