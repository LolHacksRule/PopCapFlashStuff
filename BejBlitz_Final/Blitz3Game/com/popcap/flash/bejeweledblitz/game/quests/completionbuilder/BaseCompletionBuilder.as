package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   
   public class BaseCompletionBuilder implements IQuestCompletionBuilder
   {
       
      
      protected var m_App:Blitz3Game;
      
      public function BaseCompletionBuilder(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
      }
      
      public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         return null;
      }
      
      protected function CanHandle(param1:Object, param2:String) : Boolean
      {
         if(!(QuestConstants.KEY_COMPLETION_TYPE in param1))
         {
            return false;
         }
         var _loc3_:String = param1[QuestConstants.KEY_COMPLETION_TYPE];
         _loc3_ = _loc3_.split("_")[0];
         return _loc3_ == param2;
      }
      
      protected function CanHandleList(param1:Object, param2:Vector.<String>) : Boolean
      {
         var _loc4_:String = null;
         if(!(QuestConstants.KEY_COMPLETION_TYPE in param1))
         {
            return false;
         }
         var _loc3_:String = param1[QuestConstants.KEY_COMPLETION_TYPE];
         for each(_loc4_ in param2)
         {
            _loc3_ = _loc3_.split("_")[0];
            if(_loc3_ == _loc4_)
            {
               return true;
            }
         }
         return false;
      }
   }
}
