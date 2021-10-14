package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import flash.utils.Dictionary;
   
   public class RareGemLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Handler:IRareGemLogicHandler;
      
      private var m_RareGemList:Vector.<IRareGem>;
      
      private var m_RareGemMap:Dictionary;
      
      private var m_EmptyString:String;
      
      public var currentRareGem:IRareGem;
      
      public function RareGemLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Handler = null;
         this.m_RareGemList = new Vector.<IRareGem>();
         this.m_RareGemMap = new Dictionary();
         this.m_EmptyString = "";
         this.currentRareGem = null;
         this.MapRareGem(new MoonstoneRGLogic());
         this.MapRareGem(new CatseyeRGLogic());
         this.MapRareGem(new PhoenixPrismRGLogic());
      }
      
      public function Init() : void
      {
         var rareGem:IRareGem = null;
         for each(rareGem in this.m_RareGemList)
         {
            if(rareGem)
            {
               rareGem.Init(this.m_Logic);
            }
         }
      }
      
      public function SetHandler(handler:IRareGemLogicHandler) : Boolean
      {
         if(this.m_Handler != null)
         {
            return false;
         }
         this.m_Handler = handler;
         return true;
      }
      
      public function Reset() : void
      {
         var logic:IRareGem = null;
         for each(logic in this.m_RareGemList)
         {
            logic.Reset();
         }
      }
      
      public function MapRareGem(rareGem:IRareGem) : void
      {
         var intID:int = rareGem.GetOrderingID();
         if(intID >= this.m_RareGemList.length)
         {
            this.m_RareGemList.length = intID + 1;
         }
         this.m_RareGemList[intID] = rareGem;
         this.m_RareGemMap[rareGem.GetStringID()] = intID;
      }
      
      public function ActivateRareGem(index:int) : void
      {
         this.currentRareGem = this.m_RareGemList[index];
      }
      
      public function CycleRareGem() : void
      {
         this.currentRareGem = null;
         if(this.m_Logic.isReplay)
         {
            return;
         }
         var nextRareGem:String = this.GetNextRareGem();
         if(nextRareGem.length == 0)
         {
            return;
         }
         var index:int = this.m_RareGemMap[nextRareGem];
         this.currentRareGem = this.m_RareGemList[index];
      }
      
      public function UseBoosts() : void
      {
         if(!this.currentRareGem)
         {
            return;
         }
         var rareGem:IRareGem = this.currentRareGem;
         var key:String = rareGem.GetStringID();
         rareGem.OnStartGame();
         var data:ReplayData = this.m_Logic.replayDataPool.GetNextReplayData();
         data.command.push(this.m_RareGemMap[key]);
         this.m_Logic.QueueCommand(ReplayCommands.COMMAND_RAREGEM,data);
      }
      
      public function GetRareGemByStringID(id:String) : IRareGem
      {
         if(id.length == 0)
         {
            return null;
         }
         var index:int = this.m_RareGemMap[id];
         return this.m_RareGemList[index];
      }
      
      public function GetRareGemByOrderingID(id:int) : IRareGem
      {
         if(id < 0 || id >= this.m_RareGemList.length)
         {
            return null;
         }
         return this.m_RareGemList[id];
      }
      
      private function GetNextRareGem() : String
      {
         if(this.m_Handler == null)
         {
            return this.m_EmptyString;
         }
         return this.m_Handler.GetActiveRareGem();
      }
   }
}
