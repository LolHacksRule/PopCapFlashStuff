package com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   
   public class PhoenixPrismLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var mNumCreated:int;
      
      private var mNumDestroyed:int;
      
      private var m_MoveIds:Vector.<Boolean>;
      
      private var m_Handlers:Vector.<IPhoenixPrismLogicHandler>;
      
      public var matchedColor:int;
      
      public var delayDataPool:PhoenixPrismDelayDataPool;
      
      public var hurrahExplodeEventPool:PhoenixPrismHurrahExplodeEventPool;
      
      private var m_ExplodeEventPool:PhoenixPrismExplodeEventPool;
      
      private var m_CreateEventPool:PhoenixPrismCreateEventPool;
      
      public function PhoenixPrismLogic(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.delayDataPool = new PhoenixPrismDelayDataPool();
         this.m_Logic.lifeguard.AddPool(this.delayDataPool);
         this.m_CreateEventPool = new PhoenixPrismCreateEventPool(param1);
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new PhoenixPrismExplodeEventPool(param1);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.hurrahExplodeEventPool = new PhoenixPrismHurrahExplodeEventPool(param1);
         this.m_Logic.lifeguard.AddPool(this.hurrahExplodeEventPool);
         this.matchedColor = Gem.COLOR_WHITE;
         this.m_MoveIds = new Vector.<Boolean>();
         this.m_Handlers = new Vector.<IPhoenixPrismLogicHandler>();
      }
      
      public function AddHandler(param1:IPhoenixPrismLogicHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IPhoenixPrismLogicHandler) : void
      {
         var _loc2_:int = this.m_Handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.m_Handlers.splice(_loc2_,1);
      }
      
      public function IsHyperMove(param1:int) : Boolean
      {
         return param1 < this.m_MoveIds.length && this.m_MoveIds[param1] == true;
      }
      
      public function GetNumCreated() : int
      {
         return this.mNumCreated;
      }
      
      public function GetNumDestroyed() : int
      {
         return this.mNumDestroyed;
      }
      
      public function Reset() : void
      {
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.m_MoveIds.length = 0;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         if(param1.IsDetonated())
         {
            param1.SetDead(true);
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         this.DetonateGem(param1);
      }
      
      public function HandleMatch(param1:Match) : void
      {
         this.matchedColor = param1.matchColor;
      }
      
      public function UpgradeGem(param1:Gem, param2:Match, param3:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this.mNumCreated;
         param1.upgrade(Gem.TYPE_PHOENIXPRISM,param3);
         param1.color = Gem.COLOR_ANY;
         var _loc4_:PhoenixPrismCreateEvent = this.m_CreateEventPool.GetNextPhoenixPrismCreateEvent(param1,param2);
         this.m_Logic.AddPassiveEvent(_loc4_);
         this.DispatchPhoenixPrismCreated(_loc4_);
      }
      
      private function DispatchPhoenixPrismCreated(param1:PhoenixPrismCreateEvent) : void
      {
         var _loc2_:IPhoenixPrismLogicHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandlePhoenixPrismCreated(param1);
         }
      }
      
      private function DispatchPhoenixPrismExploded(param1:PhoenixPrismExplodeEvent) : void
      {
         var _loc2_:IPhoenixPrismLogicHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandlePhoenixPrismExploded(param1);
         }
      }
      
      private function DetonateGem(param1:Gem) : void
      {
         if(param1.moveID >= this.m_MoveIds.length)
         {
            this.m_MoveIds.length = param1.moveID + 1;
         }
         if(param1.moveID > 0)
         {
            this.m_MoveIds[param1.moveID] = true;
         }
         ++this.mNumDestroyed;
         param1.baseValue = 0;
         var _loc2_:PhoenixPrismExplodeEvent = this.m_ExplodeEventPool.GetNextPhoenixPrismExplodeEvent(param1);
         this.m_Logic.AddBlockingEvent(_loc2_);
         this.DispatchPhoenixPrismExploded(_loc2_);
         var _loc3_:PhoenixPrismRGLogic = this.m_Logic.rareGemsLogic.GetRareGemByStringID(PhoenixPrismRGLogic.ID) as PhoenixPrismRGLogic;
         if(_loc3_ != null)
         {
            _loc3_.SetShouldSpawn();
         }
      }
   }
}
