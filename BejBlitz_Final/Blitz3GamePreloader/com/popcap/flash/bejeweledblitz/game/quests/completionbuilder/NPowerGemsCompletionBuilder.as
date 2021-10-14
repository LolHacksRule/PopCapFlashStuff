package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NPowerGemsCreatedCompletionStrategy;
   
   public class NPowerGemsCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("CreateFlameGem");
         IDS.push("CreateStarGem");
         IDS.push("CreateHypercube");
         IDS.push("CreateMultiplier");
         IDS.push("CreateFlameGemInOneGame");
         IDS.push("CreateStarGemInOneGame");
         IDS.push("CreateHypercubeInOneGame");
         IDS.push("CreateMultiplierInOneGame");
         IDS.push("CreateFlameGemColor");
         IDS.push("CreateStarGemColor");
      }
      
      public function NPowerGemsCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc4_:String = param1[QuestConstants.KEY_COMPLETION_VAL2];
         var _loc5_:String = "";
         var _loc6_:String;
         if((_loc6_ = param1[QuestConstants.KEY_COMPLETION_TYPE]) == "CreateFlameGemColor")
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.FLAME_GEM;
            _loc5_ = param1[QuestConstants.KEY_COMPLETION_VAL2];
         }
         else if(_loc6_ == "CreateStarGemColor")
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.STAR_GEM;
            _loc5_ = param1[QuestConstants.KEY_COMPLETION_VAL2];
         }
         else if(param1[QuestConstants.KEY_COMPLETION_TYPE] == IDS[0])
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.FLAME_GEM;
         }
         else if(param1[QuestConstants.KEY_COMPLETION_TYPE] == IDS[1])
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.STAR_GEM;
         }
         else if(param1[QuestConstants.KEY_COMPLETION_TYPE] == IDS[2])
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.HYPER_CUBE;
         }
         else if(param1[QuestConstants.KEY_COMPLETION_TYPE] == IDS[3])
         {
            _loc4_ = NPowerGemsCreatedCompletionStrategy.MULTI_GEM;
         }
         var _loc7_:int = param1[QuestConstants.KEY_COMPLETION_TYPE].indexOf("InOneGame");
         var _loc9_:* = "Create <font color=\'#b0017d\'>%max%</font> %color% %gemtype%";
         if(_loc7_ > 0)
         {
            _loc9_ += " in one game";
         }
         var _loc10_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NPowerGemsCreatedCompletionStrategy(m_App,m_App.logic,m_App.sessionData.configManager,_loc3_,_loc4_,_loc5_,_loc10_,"%cur% of %max%",_loc9_,_loc7_);
      }
   }
}
