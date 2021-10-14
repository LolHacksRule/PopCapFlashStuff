package com.popcap.flash.bejeweledblitz.logic.gems.star
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Match;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class StarGemLogic
   {
       
      
      private var m_Logic:BlitzLogic;
      
      private var mNumCreated:int;
      
      private var mNumDestroyed:int;
      
      private var m_CreateEventPool:StarGemCreateEventPool;
      
      private var m_ExplodeEventPool:StarGemExplodeEventPool;
      
      public var delayDataPool:StarGemDelayDataPool;
      
      private var m_Handlers:Vector.<IStarGemLogicHandler>;
      
      private var m_TmpGems:Vector.<Gem>;
      
      public function StarGemLogic(param1:BlitzLogic)
      {
         super();
         this.m_Logic = param1;
         this.mNumCreated = 0;
         this.mNumDestroyed = 0;
         this.m_CreateEventPool = new StarGemCreateEventPool(param1);
         this.m_Logic.lifeguard.AddPool(this.m_CreateEventPool);
         this.m_ExplodeEventPool = new StarGemExplodeEventPool(param1);
         this.m_Logic.lifeguard.AddPool(this.m_ExplodeEventPool);
         this.delayDataPool = new StarGemDelayDataPool();
         this.m_Logic.lifeguard.AddPool(this.delayDataPool);
         this.m_Handlers = new Vector.<IStarGemLogicHandler>();
         this.m_TmpGems = new Vector.<Gem>();
      }
      
      public function AddHandler(param1:IStarGemLogicHandler) : void
      {
         this.m_Handlers.push(param1);
      }
      
      public function RemoveHandler(param1:IStarGemLogicHandler) : void
      {
         var _loc2_:int = this.m_Handlers.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this.m_Handlers.splice(_loc2_,1);
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
         this.m_TmpGems.length = 0;
      }
      
      public function HandleMatchedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_STAR)
         {
            return;
         }
         param1.SetDetonating(true);
      }
      
      public function HandleShatteredGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_STAR)
         {
            return;
         }
         if(param1.IsDetonated())
         {
            param1.SetDead(true);
         }
         else
         {
            param1.SetDetonating(true);
         }
      }
      
      public function HandleDetonatedGem(param1:Gem) : void
      {
         if(param1.type != Gem.TYPE_STAR)
         {
            return;
         }
         this.DetonateGem(param1);
      }
      
      public function HandleMatch(param1:Match) : void
      {
         var _loc6_:Match = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Gem = null;
         var _loc2_:* = param1.left == param1.right;
         if(_loc2_)
         {
            return;
         }
         var _loc3_:Vector.<Match> = param1.overlaps;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_];
            _loc7_ = 0;
            _loc8_ = 0;
            if(param1.matchColor == _loc6_.matchColor)
            {
               _loc8_ = _loc6_.left;
               _loc7_ = param1.top;
               if((_loc9_ = this.m_Logic.board.GetGemAt(_loc7_,_loc8_)) != null)
               {
                  if(_loc9_.CanUpgrade(Gem.TYPE_STAR) && !this.m_Logic.rareGemTokenLogic.GemHasRareGemGiftToken(_loc9_))
                  {
                     this.UpgradeGem(_loc9_,param1,_loc6_,false,false);
                  }
                  else
                  {
                     this.UpgradeAnotherGem(_loc9_,param1,_loc6_);
                  }
               }
            }
            _loc5_++;
         }
      }
      
      public function UpgradeGem(param1:Gem, param2:Match, param3:Match, param4:Boolean, param5:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         ++this.mNumCreated;
         if(param1.moveID > 0)
         {
            ++this.m_Logic.moves[param1.moveID].starsMade;
         }
         param1.upgrade(Gem.TYPE_STAR,param4);
         var _loc6_:StarGemCreateEvent = this.m_CreateEventPool.GetNextStarGemCreateEvent(param1,param2,param3,param5);
         this.m_Logic.AddPassiveEvent(_loc6_);
         this.DispatchStarGemCreated(_loc6_);
      }
      
      private function DispatchStarGemCreated(param1:StarGemCreateEvent) : void
      {
         var _loc2_:IStarGemLogicHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleStarGemCreated(param1);
         }
      }
      
      private function DispatchStarGemExploded(param1:StarGemExplodeEvent) : void
      {
         var _loc2_:IStarGemLogicHandler = null;
         for each(_loc2_ in this.m_Handlers)
         {
            _loc2_.HandleStarGemExploded(param1);
         }
      }
      
      private function DetonateGem(param1:Gem) : void
      {
         ++this.mNumDestroyed;
         if(param1.moveID > 0)
         {
            ++this.m_Logic.moves[param1.moveID].starsUsed;
         }
         param1.baseValue = 0;
         var _loc2_:StarGemExplodeEvent = this.m_ExplodeEventPool.GetNextStarGemExplodeEvent(param1);
         this.m_Logic.AddBlockingEvent(_loc2_);
         this.DispatchStarGemExploded(_loc2_);
      }
      
      private function UpgradeAnotherGem(param1:Gem, param2:Match, param3:Match) : void
      {
         var _loc4_:Gem = null;
         var _loc5_:Gem = null;
         var _loc6_:Gem = null;
         var _loc7_:Gem = null;
         this.m_TmpGems.length = 0;
         for each(_loc4_ in param2.matchGems)
         {
            this.m_TmpGems.push(_loc4_);
         }
         for each(_loc5_ in param3.matchGems)
         {
            this.m_TmpGems.push(_loc5_);
         }
         _loc6_ = null;
         for each(_loc7_ in this.m_TmpGems)
         {
            if(!(_loc7_.type >= Gem.TYPE_STAR || this.m_Logic.rareGemTokenLogic.GemHasRareGemGiftToken(_loc7_)))
            {
               if(_loc6_ == null)
               {
                  _loc6_ = _loc7_;
               }
               if(_loc7_.col < _loc6_.col && _loc7_.col >= param1.col)
               {
                  _loc6_ = _loc7_;
               }
               if(_loc7_.col > _loc6_.col && _loc7_.col <= param1.col)
               {
                  _loc6_ = _loc7_;
               }
               if(_loc7_.row < _loc6_.row && _loc7_.row >= param1.row)
               {
                  _loc6_ = _loc7_;
               }
               if(_loc7_.row > _loc6_.row && _loc7_.row <= param1.row)
               {
                  _loc6_ = _loc7_;
               }
               if(_loc7_.activeCount > _loc6_.activeCount)
               {
                  _loc6_ = _loc7_;
               }
            }
         }
         this.UpgradeGem(_loc6_,param2,param3,false,false);
      }
   }
}
