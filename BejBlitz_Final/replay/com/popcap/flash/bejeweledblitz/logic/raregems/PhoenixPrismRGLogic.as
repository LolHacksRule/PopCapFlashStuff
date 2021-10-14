package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MatchSet;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ILastHurrahLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismHurrahExplodeEvent;
   
   public class PhoenixPrismRGLogic implements IRareGem, ILastHurrahLogicHandler, ITimerLogicHandler, IBlitzLogicHandler, IBlitzLogicSpawnHandler
   {
      
      public static const ID:String = "PhoenixPrism";
      
      public static const ORDERING_ID:int = 2;
      
      public static const MAX_SPAWNED:int = 6;
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ARMED:int = 1;
      
      private static const STATE_HURRAH:int = 2;
      
      private static const STATE_PRESTIGE:int = 3;
      
      private static const STATE_COMPLETE:int = 4;
      
      private static const MIN_SPAWN_DELAY:int = 400;
      
      private static const MAX_SPAWN_DELAY:int = 800;
      
      private static const POINT_AWARD_DELAY:int = 200;
      
      private static const SHOW_POINT_AWARD_DELAY:int = 350;
      
      private static const BASE_BONUS_POINTS:int = 5000;
       
      
      private var m_Logic:BlitzLogic;
      
      private var m_NumSpawned:int;
      
      private var m_ShouldSpawn:Boolean;
      
      private var m_NextSpawnTime:int;
      
      private var m_PointAwardTimer:int;
      
      private var m_ShowPointAwardTimer:int;
      
      private var m_OverrideColors:Vector.<int>;
      
      private var m_TmpMatchSets:Vector.<MatchSet>;
      
      private var m_TmpShuffledGems:Vector.<Gem>;
      
      private var m_Handlers:Vector.<IPhoenixPrismRGLogicHandler>;
      
      private var m_State:int;
      
      public function PhoenixPrismRGLogic()
      {
         super();
         this.m_PointAwardTimer = -1;
         this.m_ShowPointAwardTimer = -1;
         this.m_State = STATE_INACTIVE;
         this.m_OverrideColors = new Vector.<int>(Board.NUM_GEMS);
         for(var i:int = 0; i < Board.NUM_GEMS; i++)
         {
            this.m_OverrideColors[i] = Gem.COLOR_NONE;
         }
         this.m_TmpMatchSets = new Vector.<MatchSet>();
         this.m_TmpShuffledGems = new Vector.<Gem>();
         this.m_Handlers = new Vector.<IPhoenixPrismRGLogicHandler>();
         this.Reset();
      }
      
      public function SetShouldSpawn() : void
      {
         this.m_ShouldSpawn = true;
         this.m_NextSpawnTime = this.m_Logic.timerLogic.GetTimeElapsed() + (MIN_SPAWN_DELAY + this.m_Logic.random.Next() * (MAX_SPAWN_DELAY - MIN_SPAWN_DELAY));
      }
      
      public function AddHandler(handler:IPhoenixPrismRGLogicHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function GetStringID() : String
      {
         return ID;
      }
      
      public function GetOrderingID() : int
      {
         return ORDERING_ID;
      }
      
      public function Init(logic:BlitzLogic) : void
      {
         this.m_Logic = logic;
         this.m_Logic.lastHurrahLogic.AddHandler(this);
         this.m_Logic.timerLogic.AddHandler(this);
         this.m_Logic.AddSpawnHandler(this);
         this.m_Logic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         this.m_State = STATE_INACTIVE;
         this.m_NumSpawned = 0;
         this.m_ShouldSpawn = true;
         this.m_NextSpawnTime = 0;
         this.m_PointAwardTimer = -1;
         this.m_ShowPointAwardTimer = -1;
         this.m_TmpShuffledGems.length = 0;
      }
      
      public function OnStartGame() : void
      {
         this.m_State = STATE_ARMED;
      }
      
      public function HandleLastHurrahBegin() : void
      {
         var event:PhoenixPrismHurrahExplodeEvent = null;
         if(this.m_State == STATE_ARMED)
         {
            this.m_State = STATE_HURRAH;
            this.DispatchPointPrestigeInit();
            this.m_Logic.lastHurrahLogic.StartLastHurrah();
            event = this.m_Logic.phoenixPrismLogic.hurrahExplodeEventPool.GetNextPhoenixPrismHurrahExplodeEvent();
            this.m_Logic.AddBlockingEvent(event);
            this.DispatchPhoenixPrismHurrahExploded(event);
         }
      }
      
      public function HandleLastHurrahEnd() : void
      {
      }
      
      public function HandlePreCoinHurrah() : void
      {
         if(this.m_State == STATE_HURRAH)
         {
            this.m_State = STATE_PRESTIGE;
            this.m_PointAwardTimer = POINT_AWARD_DELAY;
            this.DispatchPointPrestigeBegin();
         }
      }
      
      public function CanBeginCoinHurrah() : Boolean
      {
         return this.m_State == STATE_INACTIVE || this.m_State == STATE_COMPLETE;
      }
      
      public function HandleTimePhaseBegin() : void
      {
      }
      
      public function HandleTimePhaseEnd() : void
      {
         if(this.m_State != STATE_PRESTIGE)
         {
            return;
         }
         --this.m_PointAwardTimer;
         if(this.m_PointAwardTimer == 0)
         {
            this.DispatchPointsAwarded(BASE_BONUS_POINTS,this.m_Logic.multiLogic.multiplier);
            this.m_ShowPointAwardTimer = SHOW_POINT_AWARD_DELAY;
         }
         --this.m_ShowPointAwardTimer;
         if(this.m_ShowPointAwardTimer == 0)
         {
            this.m_Logic.scoreKeeper.AddPoints(BASE_BONUS_POINTS * this.m_Logic.multiLogic.multiplier,null);
         }
         if(this.m_State == STATE_PRESTIGE && this.AllowPointPrestigeComplete())
         {
            this.DispatchPointPrestigeComplete();
            this.m_State = STATE_COMPLETE;
         }
      }
      
      public function HandleGameTimeChange(newTime:int) : void
      {
      }
      
      public function HandleGameDurationChange(prevDuration:int, newDuration:int) : void
      {
      }
      
      public function HandleGameBegin() : void
      {
      }
      
      public function HandleGameEnd() : void
      {
         this.Reset();
      }
      
      public function HandleGameAbort() : void
      {
         this.Reset();
      }
      
      public function HandleGamePaused() : void
      {
      }
      
      public function HandleGameResumed() : void
      {
      }
      
      public function HandleScore(score:ScoreValue) : void
      {
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
         if(this.m_Logic.rareGemLogic.currentRareGem != this)
         {
            return;
         }
         if(this.ShouldSpawn())
         {
            this.SpawnNewPhoenixPrism();
         }
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
      }
      
      private function DispatchPhoenixPrismHurrahExploded(event:PhoenixPrismHurrahExplodeEvent) : void
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismHurrahExploded(event);
         }
      }
      
      private function DispatchPointPrestigeInit() : void
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismPrestigeInit();
         }
      }
      
      private function DispatchPointPrestigeBegin() : void
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismPrestigeBegin();
         }
      }
      
      private function DispatchPointPrestigeComplete() : void
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismPrestigeComplete();
         }
      }
      
      private function AllowPointPrestigeComplete() : Boolean
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         var result:Boolean = true;
         for each(handler in this.m_Handlers)
         {
            result = result && handler.AllowPhoenixPrismPrestigeComplete();
         }
         return result;
      }
      
      private function DispatchPointsAwarded(points:int, curMult:int) : void
      {
         var handler:IPhoenixPrismRGLogicHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandlePhoenixPrismPointsAwarded(points,curMult);
         }
      }
      
      private function ShouldSpawn() : Boolean
      {
         return this.m_ShouldSpawn && this.m_NumSpawned < MAX_SPAWNED && (this.m_Logic.timerLogic.GetTimeElapsed() >= this.m_NextSpawnTime || this.m_State == STATE_HURRAH);
      }
      
      private function SpawnNewPhoenixPrism() : void
      {
         this.ShuffleGems(this.m_Logic.board.freshGems,this.m_TmpShuffledGems);
         var gem:Gem = this.GetUpgradeLocation(this.m_TmpShuffledGems);
         if(gem == null)
         {
            return;
         }
         this.m_Logic.phoenixPrismLogic.UpgradeGem(gem,null,true);
         ++this.m_NumSpawned;
         this.m_ShouldSpawn = false;
      }
      
      private function ShuffleGems(candidates:Vector.<Gem>, result:Vector.<Gem>) : void
      {
         var candidate:Gem = null;
         var numGems:int = 0;
         var i:int = 0;
         var idx1:int = 0;
         var idx2:int = 0;
         var tmp:Gem = null;
         result.length = 0;
         for each(candidate in candidates)
         {
            if(candidate.col != 0 && candidate.col != 7 && candidate.row != 7 && candidate.type == Gem.TYPE_STANDARD)
            {
               result.push(candidate);
            }
         }
         numGems = result.length;
         for(i = 0; i < 2 * numGems; i++)
         {
            idx1 = this.m_Logic.random.Int(0,numGems);
            idx2 = this.m_Logic.random.Int(0,numGems);
            tmp = result[idx1];
            result[idx1] = result[idx2];
            result[idx2] = tmp;
         }
      }
      
      private function GetUpgradeLocation(candidates:Vector.<Gem>) : Gem
      {
         var candidate:Gem = null;
         var index:int = 0;
         var isValid:Boolean = false;
         var matchSet:MatchSet = null;
         var gem:Gem = null;
         var _loc7_:int = 0;
         var _loc8_:* = candidates;
         while(true)
         {
            for each(candidate in _loc8_)
            {
               index = candidate.row * Board.NUM_COLS + candidate.col;
               if(!(index < 0 || index >= Board.NUM_GEMS))
               {
                  this.m_OverrideColors[index] = Gem.COLOR_ANY;
                  this.m_Logic.board.matchGenerator.FindMatches(this.m_Logic.board.mGems,this.m_OverrideColors,this.m_TmpMatchSets);
                  this.m_OverrideColors[index] = Gem.COLOR_NONE;
                  isValid = true;
                  for each(matchSet in this.m_TmpMatchSets)
                  {
                     for each(gem in matchSet.mGems)
                     {
                        if(gem == candidate)
                        {
                           isValid = false;
                           break;
                        }
                     }
                     if(isValid)
                     {
                        break;
                     }
                  }
                  this.m_Logic.matchSetPool.FreeMatchSets(this.m_TmpMatchSets,true);
                  if(isValid)
                  {
                     break;
                  }
               }
            }
            return null;
         }
         return candidate;
      }
   }
}
