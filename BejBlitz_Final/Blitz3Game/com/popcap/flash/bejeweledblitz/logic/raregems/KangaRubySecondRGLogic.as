package com.popcap.flash.bejeweledblitz.logic.raregems
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyAttackPatterns;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyAttackPatternsSecond;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyGemExplodeEventPool;
   
   public class KangaRubySecondRGLogic extends KangaRubyRGLogic
   {
      
      public static const ID:String = "kangaRuby2";
      
      public static const COOLDOWN_TIMER_MIN:int = 1000;
      
      public static const COOLDOWN_TIMER_VARIANCE:int = 200;
      
      public static const WARMUP_TIMER:int = 1000;
      
      public static const COINS_PER_RUBY_PAYOUT:int = 100;
      
      public static const RED_GEM_TIME_REDUCTION:int = 55;
      
      private static const _BOARD1:String = "WWYRRYWWWRRWWRRWYRRYYRRYRWYRRYWRRWYRRYWRYRRYYRRYWRRWWRRWWWYRRYWW";
      
      private static const _BOARD2:String = "YRWRRWRYRYROORYRWRYRRYRWRORYYRORRORYYRORWRYRRYRWRYROORYRYRWRRWRY";
      
      private static const _BOARD3:String = "WRRYPPGGRWRRYPPGRRWRRYPPYRRWRRYPBYRRWRRYBBYRRWRROBBYRRWROOBBYRRW";
       
      
      public function KangaRubySecondRGLogic(param1:BlitzLogic)
      {
         super();
         setDefaults(param1,ID);
         _boardPatterns.parseBoardString(_BOARD1);
         _boardPatterns.parseBoardString(_BOARD2);
         _boardPatterns.parseBoardString(_BOARD3);
         _state = STATE_INACTIVE;
         _kangaRubyAttackPatterns = new KangaRubyAttackPatternsSecond();
         m_ExplodeEventPool = new KangaRubyGemExplodeEventPool(_logic);
         _logic.lifeguard.AddPool(m_ExplodeEventPool);
      }
      
      override protected function determineWhichAttack(param1:Boolean) : void
      {
         var _loc2_:Vector.<Vector.<Boolean>> = null;
         var _loc3_:Vector.<Vector.<Vector.<Boolean>>> = null;
         var _loc4_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Gem = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc3_ = _kangaRubyAttackPatterns.getPrestigeAttack();
            _loc4_ = PRESTIGE_ATTACK;
         }
         else
         {
            ++_attackCounter;
            if(_attackCounter % 3 == 0)
            {
               _loc4_ = MEDIUM_ATTACK;
            }
            else
            {
               _loc4_ = SMALL_ATTACK;
            }
            _loc9_ = -1;
            _loc10_ = -1;
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               _loc6_ = 0;
               while(_loc6_ < 8)
               {
                  if((_loc8_ = _logic.board.GetGemAt(_loc6_,_loc7_)) != null)
                  {
                     if(_loc8_.IsSelected())
                     {
                        _loc9_ = determineQuadrant(_loc6_,_loc7_);
                     }
                     else if(_loc8_.type == Gem.TYPE_MULTI)
                     {
                        _loc10_ = determineWhichMoveWillHit(_loc6_,_loc7_,_loc4_);
                     }
                  }
                  _loc6_++;
               }
               _loc7_++;
            }
            _loc11_ = _logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_RG_KANGARUBY).Int(0,1);
            if(_loc9_ != -1)
            {
               if(_loc4_ == SMALL_ATTACK)
               {
                  if(_loc9_ == 0)
                  {
                     if(_loc11_ == 0)
                     {
                        _loc5_ = 2;
                     }
                     else
                     {
                        _loc5_ = 3;
                     }
                  }
                  else if(_loc9_ == 1)
                  {
                     if(_loc11_ == 0)
                     {
                        _loc5_ = 1;
                     }
                     else
                     {
                        _loc5_ = 3;
                     }
                  }
                  else if(_loc9_ == 2)
                  {
                     if(_loc11_ == 0)
                     {
                        _loc5_ = 0;
                     }
                     else
                     {
                        _loc5_ = 2;
                     }
                  }
                  else if(_loc9_ == 3)
                  {
                     if(_loc11_ == 0)
                     {
                        _loc5_ = 0;
                     }
                     else
                     {
                        _loc5_ = 1;
                     }
                  }
                  _loc2_ = _kangaRubyAttackPatterns.getSmallAttack(_loc5_);
               }
               else
               {
                  if(_loc9_ == 1 || _loc9_ == 3 || _loc10_ == -1)
                  {
                     if(_loc11_ == 0)
                     {
                        _loc5_ = 0;
                     }
                     else
                     {
                        _loc5_ = 1;
                     }
                  }
                  else
                  {
                     _loc5_ = _loc10_;
                  }
                  _loc2_ = _kangaRubyAttackPatterns.getMediumAttack(_loc5_);
               }
            }
            else if(_loc10_ != -1)
            {
               _loc5_ = _loc10_;
               if(_loc4_ == SMALL_ATTACK)
               {
                  _loc2_ = _kangaRubyAttackPatterns.getSmallAttack(_loc5_);
               }
               else
               {
                  _loc2_ = _kangaRubyAttackPatterns.getMediumAttack(_loc5_);
               }
            }
            else if(_loc4_ == SMALL_ATTACK)
            {
               _loc5_ = _logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_RG_KANGARUBY).Int(0,KangaRubyAttackPatterns.NUM_SMALL_HITS);
               _loc2_ = _kangaRubyAttackPatterns.getSmallAttack(_loc5_);
            }
            else
            {
               _loc5_ = _logic.GetRNGOfType(BlitzRNGManager.RNG_BLITZ_RG_KANGARUBY).Int(0,KangaRubyAttackPatterns.NUM_MEDIUM_HITS);
               _loc2_ = _kangaRubyAttackPatterns.getMediumAttack(_loc5_);
            }
         }
         _kangaRubyGemExplodeEvent = m_ExplodeEventPool.GetNextKangaRubyGemExplodeEvent(_loc2_,_loc3_,_loc4_,_loc5_);
         _logic.AddBlockingButStillUpdateEvent(_kangaRubyGemExplodeEvent);
      }
   }
}
