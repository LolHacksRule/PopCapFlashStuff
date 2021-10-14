package com.popcap.flash.bejeweledblitz.game.quests.completion
{
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2Manager;
   
   public class NBoostedGamesCompletionStrategy extends NGamesCompletionStrategy
   {
       
      
      private var m_BoostManager:BoostV2Manager;
      
      private var _specificBoost:String;
      
      private var _specificBoostIsActive:Boolean;
      
      public function NBoostedGamesCompletionStrategy(param1:Blitz3Game, param2:int, param3:String, param4:String, param5:String, param6:BoostV2Manager, param7:String = "")
      {
         super(param1,param2,param3,param4,param5);
         this.m_BoostManager = param6;
         this._specificBoost = param7;
         this._specificBoostIsActive = false;
      }
      
      override public function HandleGameLoad() : void
      {
      }
      
      override public function HandleGameBegin() : void
      {
         if(this.m_BoostManager.IsBoostActive(this._specificBoost) || this._specificBoost == "" && this.m_BoostManager.GetNumActiveBoosts() > 0)
         {
            this._specificBoostIsActive = true;
         }
      }
      
      override public function HandleGameEnd() : void
      {
         if(this._specificBoostIsActive)
         {
            super.HandleGameEnd();
         }
      }
   }
}
