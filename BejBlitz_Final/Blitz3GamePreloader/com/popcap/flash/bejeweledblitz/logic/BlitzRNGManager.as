package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.framework.math.MersenneTwister;
   import flash.utils.Dictionary;
   
   public class BlitzRNGManager
   {
      
      public static var RNG_BLITZ_PRIMARY:int = 1;
      
      public static var RNG_BLITZ_SECONDARY:int = 2;
      
      public static var RNG_BLITZ_FINISHER:int = 3;
      
      public static var RNG_BLITZ_BOOSTS:int = 4;
      
      public static var RNG_BLITZ_RG_KANGARUBY:int = 5;
       
      
      private var mLogic:BlitzLogic;
      
      private var mRNGMap:Dictionary;
      
      public function BlitzRNGManager(param1:BlitzLogic)
      {
         super();
         this.mLogic = param1;
         this.mRNGMap = new Dictionary();
      }
      
      public function Init() : void
      {
         this.mRNGMap[RNG_BLITZ_PRIMARY] = new BlitzRandom(new MersenneTwister());
         this.mRNGMap[RNG_BLITZ_SECONDARY] = new BlitzRandom(new MersenneTwister());
         this.mRNGMap[RNG_BLITZ_FINISHER] = new BlitzRandom(new MersenneTwister());
         this.mRNGMap[RNG_BLITZ_BOOSTS] = new BlitzRandom(new MersenneTwister());
         this.mRNGMap[RNG_BLITZ_RG_KANGARUBY] = new BlitzRandom(new MersenneTwister());
      }
      
      public function Reset() : void
      {
         var _loc1_:* = null;
         for(_loc1_ in this.mRNGMap)
         {
            this.mRNGMap[int(_loc1_)].Reset();
         }
      }
      
      public function SetSeed(param1:int) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in this.mRNGMap)
         {
            this.mRNGMap[int(_loc2_)].Reset();
            this.mRNGMap[int(_loc2_)].SetSeed(param1);
         }
      }
      
      public function GetRNGOfType(param1:int) : BlitzRandom
      {
         var _loc2_:BlitzRandom = null;
         if(this.mRNGMap != null)
         {
            _loc2_ = this.mRNGMap[param1];
         }
         return _loc2_;
      }
   }
}
