package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.session.IBoostManagerHandler;
   import flash.utils.Dictionary;
   
   public class BoostLogic implements IBoostManagerHandler
   {
       
      
      private var m_App:Blitz3App = null;
      
      private var m_BoostList:Array;
      
      private var m_BoostMap:Dictionary;
      
      private var m_NextKeys:Vector.<String>;
      
      public var currentBoosts:Vector.<IBoost>;
      
      public function BoostLogic(app:Blitz3App)
      {
         this.m_BoostList = [];
         this.m_BoostMap = new Dictionary();
         this.m_NextKeys = new Vector.<String>();
         this.currentBoosts = new Vector.<IBoost>();
         super();
         this.m_App = app;
         this.MapBoost(new ScrambleBoostLogic(this.m_App));
         this.MapBoost(new DetonateBoostLogic(this.m_App));
         this.MapBoost(new MysteryGemBoostLogic(this.m_App));
         this.MapBoost(new FiveSecondBoostLogic(this.m_App));
         this.MapBoost(new FreeMultiplierBoostLogic(this.m_App));
      }
      
      public function Init() : void
      {
         this.m_App.sessionData.boostManager.AddHandler(this);
      }
      
      public function MapBoost(boost:IBoost) : void
      {
         this.m_BoostList[boost.GetIntID()] = boost;
         this.m_BoostMap[boost.GetStringID()] = boost.GetIntID();
      }
      
      public function ClearQueue() : void
      {
         this.m_NextKeys.length = 0;
      }
      
      public function QueueBoost(id:String) : void
      {
         this.m_NextKeys.push(id);
      }
      
      public function ActivateBoost(index:int) : void
      {
         this.currentBoosts.push(this.m_BoostList[index]);
      }
      
      public function CycleBoosts() : void
      {
         var key:String = null;
         var index:int = 0;
         var boost:IBoost = null;
         this.currentBoosts.length = 0;
         if(this.m_App.logic.isReplay)
         {
            return;
         }
         var numBoosts:int = this.m_NextKeys.length;
         for(var i:int = 0; i < numBoosts; i++)
         {
            key = this.m_NextKeys[i];
            index = this.m_BoostMap[key];
            boost = this.m_BoostList[index];
            this.currentBoosts.push(boost);
         }
      }
      
      public function UseBoosts() : void
      {
         var boost:IBoost = null;
         var key:String = null;
         var numBoosts:int = this.currentBoosts.length;
         for(var i:int = 0; i < numBoosts; i++)
         {
            boost = this.currentBoosts[i];
            key = boost.GetStringID();
            boost.OnStartGame();
            this.m_App.logic.QueueCommand(BlitzLogic.COMMAND_BOOST,this.m_BoostMap[key]);
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
         return IBoost(this.m_BoostList[this.m_BoostMap[id]]).GetOrderingID();
      }
      
      public function GetNumTotalBoosts() : int
      {
         return this.m_BoostList.length;
      }
      
      public function HandleBoostCatalogChanged(boostCatalog:Dictionary) : void
      {
      }
      
      public function HandleActiveBoostsChanged(activeBoosts:Dictionary) : void
      {
         var key:* = null;
         this.ClearQueue();
         for(key in activeBoosts)
         {
            this.QueueBoost(key);
         }
      }
      
      public function HandleBoostAutorenew(renewedBoosts:Vector.<String>) : void
      {
      }
   }
}
