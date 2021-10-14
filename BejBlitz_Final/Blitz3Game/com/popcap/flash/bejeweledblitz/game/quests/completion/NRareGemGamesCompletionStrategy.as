package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.session.raregem.RareGemManager;
   
   public class NRareGemGamesCompletionStrategy extends NGamesCompletionStrategy
   {
       
      
      private var _rareGemType:String;
      
      private var m_RareGemManager:RareGemManager;
      
      public function NRareGemGamesCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:String)
      {
         super(param1,param2,param3,param4,param5);
         this._rareGemType = param6;
      }
      
      override public function UpdateCompletionState() : void
      {
         super.UpdateCompletionState();
      }
      
      override public function HandleGameEnd() : void
      {
         if(!m_App.logic.rareGemsLogic.currentRareGem)
         {
            return;
         }
         if(this._rareGemType == "featureunlock" || this._rareGemType == m_App.logic.rareGemsLogic.currentRareGem.getStringID())
         {
            super.HandleGameEnd();
         }
      }
   }
}
