package com.popcap.flash.bejeweledblitz.game.quests.completionbuilder
{
   import com.popcap.flash.bejeweledblitz.game.quests.QuestConstants;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NPowerGemsDestroyedCompletionStrategy;
   
   public class NPowerGemsDestroyedCompletionBuilder extends BaseCompletionBuilder
   {
      
      public static const IDS:Vector.<String> = new Vector.<String>();
      
      {
         IDS.push("DestroyFlameGem");
         IDS.push("DestroyFlameGemInOneGame");
         IDS.push("DestroyStarGem");
         IDS.push("DestroyStarGemInOneGame");
         IDS.push("DestroyHypercube");
         IDS.push("DestroyHypercubeInOneGame");
         IDS.push("DestroyCoinGems");
         IDS.push("DestroyCoinGemsInOneGame");
      }
      
      public function NPowerGemsDestroyedCompletionBuilder(param1:Blitz3Game)
      {
         super(param1);
      }
      
      override public function BuildQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         var _loc9_:* = null;
         if(!CanHandleList(param1,IDS))
         {
            return null;
         }
         var _loc3_:int = parseInt(param1[QuestConstants.KEY_COMPLETION_VAL1]);
         var _loc4_:String = "";
         var _loc5_:String = param1[QuestConstants.KEY_COMPLETION_VAL2];
         var _loc6_:String;
         if((_loc6_ = param1[QuestConstants.KEY_COMPLETION_TYPE]).indexOf("FlameGem") > 0)
         {
            _loc4_ = NPowerGemsDestroyedCompletionStrategy.FLAME_GEM;
         }
         else if(_loc6_.indexOf("StarGem") > 0)
         {
            _loc4_ = NPowerGemsDestroyedCompletionStrategy.STAR_GEM;
         }
         else if(_loc6_.indexOf("Hypercube") > 0)
         {
            _loc4_ = NPowerGemsDestroyedCompletionStrategy.HYPER_CUBE;
         }
         else if(_loc6_.indexOf("CoinGems") > 0)
         {
            _loc4_ = NPowerGemsDestroyedCompletionStrategy.COIN_GEM;
         }
         var _loc7_:int = _loc6_.indexOf("InOneGame");
         if(_loc4_ == NPowerGemsDestroyedCompletionStrategy.COIN_GEM)
         {
            _loc9_ = "Collect <font color=\'#b0017d\'>%max%</font> %gemtype%";
         }
         else
         {
            _loc9_ = "Destroy <font color=\'#b0017d\'>%max%</font> %gemtype%";
         }
         if(_loc7_ > 0)
         {
            _loc9_ += " in one game";
         }
         var _loc10_:String = m_App.questManager.GetConfigIdFromQuestId(param2);
         return new NPowerGemsDestroyedCompletionStrategy(m_App,m_App.logic,m_App.sessionData.configManager,_loc3_,_loc4_,_loc10_,"%cur% of %max%",_loc9_,_loc7_);
      }
   }
}
