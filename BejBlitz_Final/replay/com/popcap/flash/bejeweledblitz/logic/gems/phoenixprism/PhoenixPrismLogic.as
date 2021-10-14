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
      
      public function PhoenixPrismLogic(logic:BlitzLogic)
      {
         super();
         this.m_Logic = logic;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.delayDataPool = new PhoenixPrismDelayDataPool();
         this.m_Logic.lifeguard.AddPool(this.delayDataPool);
         this.m_CreateEventPool = new PhoenixPrismCreateEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new PhoenixPrismExplodeEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.hurrahExplodeEventPool = new PhoenixPrismHurrahExplodeEventPool(logic);
         this.m_Logic.lifeguard.AddPool(this.hurrahExplodeEventPool);
         this.matchedColor = Gem.COLOR_WHITE;
         this.m_MoveIds = new Vector.<Boolean>();
         this.m_Handlers = new Vector.<IPhoenixPrismLogicHandler>();
      }
      
      public function AddHandler(handler:IPhoenixPrismLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function IsHyperMove(moveId:int) : Boolean
      {
         return moveId < this.m_MoveIds.length && this.m_MoveIds[moveId] == true;
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
      
      public function HandleMatchedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleShatteredGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         if(gem.IsDetonated())
         {
            gem.SetDead(true);
            return;
         }
         gem.SetDetonating(true);
      }
      
      public function HandleDetonatedGem(gem:Gem) : void
      {
         if(gem.type != Gem.TYPE_PHOENIXPRISM)
         {
            return;
         }
         this.DetonateGem(gem);
      }
      
      public function HandleMatch(match:Match) : void
      {
         this.matchedColor = match.matchColor;
      }
      
      public function UpgradeGem(locus:Gem, match:Match, forced:Boolean) : void
      {
         if(locus == null)
         {
            return;
         }
         ++this.mNumCreated;
         locus.upgrade(Gem.TYPE_PHOENIXPRISM,forced);
         locus.color = Gem.COLOR_ANY;
         var event:PhoenixPrismCreateEvent = this.m_CreateEventPool.GetNextPhoenixPrismCreateEvent(locus,match);
         this.m_Logic.AddPassiveEvent(event);
         this.DispatchPhoenixPrismCreated(event);
      }
      
      private function DispatchPhoenixPrismCreated(event:PhoenixPrismCreateEvent) : void
      {
         var handler:IPhoenixPrismLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismCreated(event);
         }
      }
      
      private function DispatchPhoenixPrismExploded(event:PhoenixPrismExplodeEvent) : void
      {
         var handler:IPhoenixPrismLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismExploded(event);
         }
      }
      
      private function DetonateGem(gem:Gem) : void
      {
         if(gem.mMoveId >= this.m_MoveIds.length)
         {
            this.m_MoveIds.length = gem.mMoveId + 1;
         }
         if(gem.mMoveId > 0)
         {
            this.m_MoveIds[gem.mMoveId] = true;
         }
         ++this.mNumDestroyed;
         gem.baseValue = 0;
         var event:PhoenixPrismExplodeEvent = this.m_ExplodeEventPool.GetNextPhoenixPrismExplodeEvent(gem);
         this.m_Logic.AddBlockingEvent(event);
         this.DispatchPhoenixPrismExploded(event);
         var rgLogic:PhoenixPrismRGLogic = this.m_Logic.rareGemLogic.GetRareGemByStringID(PhoenixPrismRGLogic.ID) as PhoenixPrismRGLogic;
         if(rgLogic != null)
         {
            rgLogic.SetShouldSpawn();
         }
      }
   }
}
