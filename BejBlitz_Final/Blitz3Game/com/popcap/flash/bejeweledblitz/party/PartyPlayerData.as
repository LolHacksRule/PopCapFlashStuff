package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.PlayersData;
   
   public class PartyPlayerData
   {
       
      
      public var playerFBID:String = "";
      
      public var playerScore:Number = 0;
      
      public var comboData:PartyComboData;
      
      public var secondsRemaining:uint = 0;
      
      public var isFinalized:Boolean = false;
      
      public var hasCollected:Boolean = false;
      
      public var isTimedOut:Boolean = false;
      
      public var rareGemID:String = "";
      
      public function PartyPlayerData()
      {
         super();
         this.comboData = new PartyComboData();
         this.reset();
      }
      
      public function isFake() : Boolean
      {
         return this.playerFBID == PlayersData.FAKE_PLAYER_ID;
      }
      
      public function deregisterAllListeners() : void
      {
         this.comboData.deregisterListeners();
         this.comboData.deregisterMultiListener();
      }
      
      public function finishGame(param1:Blitz3Game) : void
      {
         this.playerScore = param1.logic.GetScoreKeeper().GetScore();
      }
      
      public function getPlayerData() : PlayerData
      {
         return PlayersData.getPlayerData(this.playerFBID);
      }
      
      public function getRareGemFrameName() : String
      {
         if(this.rareGemID == null || this.rareGemID == "" || Blitz3App.app.logic.rareGemsLogic == null || Blitz3App.app.logic.rareGemsLogic.isDynamicID(this.rareGemID))
         {
            return "off";
         }
         return this.rareGemID.toLowerCase();
      }
      
      public function copyFrom(param1:PartyPlayerData) : void
      {
         this.playerFBID = param1.playerFBID;
         this.playerScore = param1.playerScore;
         this.comboData.copyFrom(param1.comboData);
         this.isFinalized = param1.isFinalized;
         this.hasCollected = param1.hasCollected;
         this.isTimedOut = param1.isTimedOut;
         this.rareGemID = param1.rareGemID;
      }
      
      private function parseValues(param1:String, param2:Number, param3:Boolean, param4:Boolean, param5:String, param6:Object) : void
      {
         this.playerFBID = param1;
         this.isFinalized = param3;
         this.hasCollected = param4;
         if(param5 != null && param5 != "null" && param5 != "")
         {
            this.rareGemID = param5;
         }
         if(this.isFinalized)
         {
            this.playerScore = param2;
            this.comboData.parseObject(param6);
         }
         else
         {
            this.playerScore = 0;
            this.comboData.reset();
         }
      }
      
      public function parseObject(param1:Object) : Boolean
      {
         if(param1 != null)
         {
            this.parseValues(param1.id,param1.score,param1.scoreFinal,param1.payoutCollected,param1.rareGemId,param1.comboData);
            if(param1.isForfeited != null)
            {
               this.isTimedOut = String(param1.isForfeited).toLowerCase() == "true" || String(param1.isForfeited) == "1";
            }
            return true;
         }
         return false;
      }
      
      public function startGame() : void
      {
         this.rareGemID = "";
         this.playerScore = 0;
         this.comboData.reset();
      }
      
      public function reset() : void
      {
         this.playerFBID = "";
         this.playerScore = 0;
         this.comboData.reset();
         this.secondsRemaining = 0;
         this.isFinalized = false;
         this.hasCollected = false;
         this.isTimedOut = false;
         this.rareGemID = "";
      }
      
      public function destroy() : void
      {
         this.reset();
         this.comboData.destroy();
         this.comboData = null;
      }
   }
}
