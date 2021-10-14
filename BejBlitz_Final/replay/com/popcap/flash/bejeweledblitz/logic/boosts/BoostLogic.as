package com.popcap.flash.bejeweledblitz.logic.boosts
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import flash.utils.Dictionary;
   
   public class BoostLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_Handler:IBoostLogicHandler;
      
      private var m_BoostList:Vector.<IBoost>;
      
      private var m_BoostMap:Dictionary;
      
      public var currentBoosts:Vector.<IBoost>;
      
      private var m_TmpBoosts:Vector.<String>;
      
      public function BoostLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.m_Handler = null;
         this.m_BoostList = new Vector.<IBoost>();
         this.m_BoostMap = new Dictionary();
         this.currentBoosts = new Vector.<IBoost>();
         this.m_TmpBoosts = new Vector.<String>();
         this.MapBoost(new ScrambleBoostLogic());
         this.MapBoost(new DetonateBoostLogic());
         this.MapBoost(new MysteryGemBoostLogic());
         this.MapBoost(new FiveSecondBoostLogic());
         this.MapBoost(new MultiplierBoostLogic());
      }
      
      public function Init() : void
      {
         var boost:IBoost = null;
         for each(boost in this.m_BoostList)
         {
            boost.Init(this.m_Logic);
         }
      }
      
      public function SetHandler(handler:IBoostLogicHandler) : Boolean
      {
         if(this.m_Handler != null)
         {
            return false;
         }
         this.m_Handler = handler;
         return true;
      }
      
      public function MapBoost(boost:IBoost) : void
      {
         var intID:int = boost.GetIntID();
         if(intID >= this.m_BoostList.length)
         {
            this.m_BoostList.length = intID + 1;
         }
         this.m_BoostList[intID] = boost;
         this.m_BoostMap[boost.GetStringID()] = boost.GetIntID();
      }
      
      public function ActivateBoost(index:int) : void
      {
         this.currentBoosts.push(this.m_BoostList[index]);
      }
      
      public function Reset() : void
      {
         var boost:IBoost = null;
         for each(boost in this.m_BoostList)
         {
            boost.Reset();
         }
      }
      
      public function CycleBoosts() : void
      {
         var key:String = null;
         var index:int = 0;
         var boost:IBoost = null;
         this.currentBoosts.length = 0;
         if(this.m_Logic.isReplay)
         {
            return;
         }
         this.GetNextBoostList(this.m_TmpBoosts);
         if(this.m_TmpBoosts.length <= 0)
         {
            return;
         }
         var numBoosts:int = this.m_TmpBoosts.length;
         for(var i:int = 0; i < numBoosts; i++)
         {
            key = this.m_TmpBoosts[i];
            index = this.m_BoostMap[key];
            boost = this.m_BoostList[index];
            this.currentBoosts.push(boost);
         }
      }
      
      public function UseBoosts() : void
      {
         var boost:IBoost = null;
         var key:String = null;
         var data:ReplayData = null;
         var numBoosts:int = this.currentBoosts.length;
         for(var i:int = 0; i < numBoosts; i++)
         {
            boost = this.currentBoosts[i];
            key = boost.GetStringID();
            boost.OnStartGame();
            data = this.m_Logic.replayDataPool.GetNextReplayData();
            data.command.push(this.m_BoostMap[key]);
            this.m_Logic.QueueCommand(ReplayCommands.COMMAND_BOOST,data);
         }
      }
      
      public function GetBoostByIntID(id:int) : IBoost
      {
         return this.m_BoostList[id];
      }
      
      public function GetBoostByStringID(id:String) : IBoost
      {
         var num:int = this.m_BoostMap[id];
         return this.m_BoostList[num];
      }
      
      public function GetBoostIntIDFromStringID(id:String) : int
      {
         return this.m_BoostMap[id];
      }
      
      public function GetBoostOrderingIDFromStringID(id:String) : int
      {
         if(!(id in this.m_BoostMap))
         {
            return -1;
         }
         var index:int = this.m_BoostMap[id];
         if(index < 0 || index >= this.m_BoostList.length)
         {
            return -1;
         }
         return (this.m_BoostList[this.m_BoostMap[id]] as IBoost).GetOrderingID();
      }
      
      public function GetNumTotalBoosts() : int
      {
         return this.m_BoostList.length;
      }
      
      public function GetNextBoostList(boosts:Vector.<String>) : void
      {
         boosts.length = 0;
         if(this.m_Handler == null)
         {
            return;
         }
         return this.m_Handler.GetActiveBoostList(boosts);
      }
   }
}
