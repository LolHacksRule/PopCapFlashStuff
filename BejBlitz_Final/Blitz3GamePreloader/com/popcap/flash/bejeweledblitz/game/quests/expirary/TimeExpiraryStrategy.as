package com.popcap.flash.bejeweledblitz.game.quests.expirary
{
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class TimeExpiraryStrategy implements IQuestExpiraryStrategy
   {
       
      
      private var m_ExpiraryTime:Number;
      
      private var m_ExpiraryString:String;
      
      private var m_HasExpired:Boolean;
      
      private var _lastUpdateTime:int;
      
      public function TimeExpiraryStrategy(param1:Number, param2:BaseLocalizationManager)
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         super();
         var _loc3_:String = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_DAY);
         var _loc4_:String = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_HOUR);
         var _loc5_:String = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_MINS);
         var _loc6_:Date = new Date();
         this._lastUpdateTime = _loc6_.time / 1000;
         this.m_ExpiraryTime = param1;
         var _loc8_:int;
         var _loc7_:Number;
         if((_loc8_ = (_loc7_ = this.timeLeft()) / (60 * 60 * 24)) <= 0)
         {
            if((_loc9_ = _loc7_ / (60 * 60)) <= 0)
            {
               if((_loc10_ = _loc7_ / 60) < 0)
               {
                  this.m_ExpiraryString = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_LAST_CHANCE);
               }
               else if(_loc10_ <= 5)
               {
                  this.m_ExpiraryString = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_HURRY);
               }
               else
               {
                  this.m_ExpiraryString = _loc5_.replace("%mins%",_loc10_);
               }
            }
            else
            {
               if(_loc9_ == 1)
               {
                  _loc4_ = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_HOUR_SINGULAR);
               }
               this.m_ExpiraryString = _loc4_.replace("%hours%",_loc9_);
            }
         }
         else
         {
            if(_loc8_ == 1)
            {
               _loc3_ = param2.GetLocString(Blitz3GameLoc.LOC_QUEST_EXPIRARY_DAY_SINGULAR);
            }
            this.m_ExpiraryString = _loc3_.replace("%days%",_loc8_);
         }
      }
      
      public function timeLeft() : int
      {
         var _loc1_:int = this._lastUpdateTime - new Date().time / 1000;
         return this.m_ExpiraryTime + _loc1_;
      }
      
      public function SetQuest(param1:Quest) : void
      {
      }
      
      public function HasQuestExpired() : Boolean
      {
         return this.m_HasExpired;
      }
      
      public function GetExpiraryString() : String
      {
         return this.m_ExpiraryString;
      }
   }
}
