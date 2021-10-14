package com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby
{
   public class KangaRubyAttackPatterns
   {
      
      public static const NUM_SMALL_HITS:int = 4;
      
      public static const NUM_MEDIUM_HITS:int = 2;
       
      
      protected var _smallHitExplosionPattern:Vector.<Vector.<Vector.<Boolean>>>;
      
      protected var _mediumHitExplosionPattern:Vector.<Vector.<Vector.<Boolean>>>;
      
      protected var _prestigeExplosionPattern:Vector.<Vector.<Vector.<Boolean>>>;
      
      public function KangaRubyAttackPatterns()
      {
         super();
      }
      
      public function getSmallAttack(param1:int) : Vector.<Vector.<Boolean>>
      {
         return this._smallHitExplosionPattern[param1];
      }
      
      public function getMediumAttack(param1:int) : Vector.<Vector.<Boolean>>
      {
         return this._mediumHitExplosionPattern[param1];
      }
      
      public function getPrestigeAttack() : Vector.<Vector.<Vector.<Boolean>>>
      {
         return this._prestigeExplosionPattern;
      }
      
      public function overrideAttackPattern(param1:Boolean, param2:Vector.<Vector.<Boolean>>, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = 0;
            while(_loc5_ < param2[_loc4_].length)
            {
               if(param1)
               {
                  this._smallHitExplosionPattern[param3][_loc4_][_loc5_] = param2[_loc4_][_loc5_];
               }
               else
               {
                  this._mediumHitExplosionPattern[param3][_loc4_][_loc5_] = param2[_loc4_][_loc5_];
               }
               _loc5_++;
            }
            _loc4_++;
         }
      }
      
      public function overridePrestigeAttackPattern(param1:Vector.<Vector.<Vector.<Boolean>>>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = 0;
            while(_loc3_ < param1[_loc2_].length)
            {
               _loc4_ = 0;
               while(_loc4_ < param1[_loc2_][_loc3_].length)
               {
                  this._prestigeExplosionPattern[_loc2_][_loc3_][_loc4_] = param1[_loc2_][_loc3_][_loc4_];
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
   }
}
