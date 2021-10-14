package com.popcap.flash.games.bej3
{
   import flash.utils.Dictionary;
   
   public class §_-AX§
   {
      
      public static const §_-MH§:int = -§_-2j§.§_-IP§;
      
      public static const §_-W2§:int = §_-2j§.§_-IP§;
      
      public static const §_-Cw§:int = 1;
      
      public static const §_-TS§:int = -1;
      
      public static const §_-Rf§:int = 2;
      
      public static const §_-4w§:int = §_-2j§.§_-IP§ + 1;
      
      public static const §_-Gf§:int = -§_-2j§.§_-IP§ - §_-2j§.§_-IP§ - §_-2j§.§_-IP§;
      
      public static const §_-IC§:int = §_-2j§.§_-IP§ - 1;
      
      public static const §_-Lg§:int = §_-2j§.§_-IP§ + §_-2j§.§_-IP§ + 1;
      
      public static const §_-TW§:int = -§_-2j§.§_-IP§ - §_-2j§.§_-IP§ - 1;
      
      public static const §_-lS§:int = §_-2j§.§_-IP§ + §_-2j§.§_-IP§;
      
      public static const §_-bE§:int = 3;
      
      public static const §_-8s§:int = -§_-2j§.§_-IP§ + 2;
      
      public static const §_-mt§:int = -§_-2j§.§_-IP§ + 1;
      
      public static const §_-aM§:int = -2;
      
      public static const §_-PC§:int = §_-2j§.§_-IP§ + 2;
      
      public static const §_-Mu§:int = -§_-2j§.§_-IP§ - 2;
      
      public static const §_-Qx§:int = §_-2j§.§_-IP§ + §_-2j§.§_-IP§ - 1;
      
      public static const §_-lc§:int = §_-2j§.§_-IP§ - 2;
      
      public static const §_-Ud§:int = -3;
      
      public static const §_-16§:int = -§_-2j§.§_-IP§ - §_-2j§.§_-IP§;
      
      public static const §_-6o§:int = §_-2j§.§_-IP§ + §_-2j§.§_-IP§ + §_-2j§.§_-IP§;
      
      public static const §_-JJ§:int = -§_-2j§.§_-IP§ - 1;
      
      public static const §_-Xa§:int = -§_-2j§.§_-IP§ - §_-2j§.§_-IP§ + 1;
       
      
      private var §_-jV§:Vector.<MoveData>;
      
      private var §_-hR§:Dictionary;
      
      public function §_-AX§()
      {
         super();
         this.§_-jV§ = new Vector.<MoveData>();
         this.§_-hR§ = new Dictionary();
      }
      
      public function §_-Gx§(param1:§_-2j§, param2:Gem, param3:Vector.<MoveData> = null) : void
      {
         if(!param2.movePolicy.§set §)
         {
            return;
         }
         var _loc4_:Vector.<Gem> = param1.mGems;
         var _loc5_:MoveData = null;
         var _loc6_:int = param2.§_-dg§;
         var _loc7_:int = param2.§_-pX§;
         var _loc8_:int = _loc6_ * §_-2j§.§_-IP§ + _loc7_;
         var _loc9_:Boolean = _loc6_ > §_-2j§.§_-ou§ && _loc4_[_loc8_ + §_-MH§] != null && _loc4_[_loc8_ + §_-MH§].movePolicy.canSwapSouth;
         var _loc10_:Boolean = _loc7_ < §_-2j§.RIGHT && _loc4_[_loc8_ + §_-Cw§] != null && _loc4_[_loc8_ + §_-Cw§].movePolicy.canSwapWest;
         var _loc11_:Boolean = _loc6_ < §_-2j§.§_-dp§ && _loc4_[_loc8_ + §_-W2§] != null && _loc4_[_loc8_ + §_-W2§].movePolicy.canSwapNorth;
         var _loc12_:Boolean = _loc7_ > §_-2j§.LEFT && _loc4_[_loc8_ + §_-TS§] != null && _loc4_[_loc8_ + §_-TS§].movePolicy.canSwapEast;
         if(_loc9_ && param2.movePolicy.§_-HE§)
         {
            param2.§_-DQ§ = true;
            _loc4_[_loc8_ + §_-MH§].mIsMatchee = true;
            (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
            _loc5_.§_-fr§.x = _loc7_;
            _loc5_.§_-fr§.y = _loc6_;
            _loc5_.§_-hK§ = param2.movePolicy.§_-Zx§;
            _loc5_.§_-6O§.x = 0;
            _loc5_.§_-6O§.y = -1;
            param3.push(_loc5_);
         }
         if(_loc10_ && param2.movePolicy.§_-8c§)
         {
            param2.§_-DQ§ = true;
            _loc4_[_loc8_ + §_-Cw§].mIsMatchee = true;
            (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
            _loc5_.§_-fr§.x = _loc7_;
            _loc5_.§_-fr§.y = _loc6_;
            _loc5_.§_-hK§ = param2.movePolicy.§_-Zx§;
            _loc5_.§_-6O§.x = 1;
            _loc5_.§_-6O§.y = 0;
            param3.push(_loc5_);
         }
         if(_loc11_ && param2.movePolicy.§_-Oe§)
         {
            param2.§_-DQ§ = true;
            _loc4_[_loc8_ + §_-W2§].mIsMatchee = true;
            (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
            _loc5_.§_-fr§.x = _loc7_;
            _loc5_.§_-fr§.y = _loc6_;
            _loc5_.§_-hK§ = param2.movePolicy.§_-Zx§;
            _loc5_.§_-6O§.x = 0;
            _loc5_.§_-6O§.y = 1;
            param3.push(_loc5_);
         }
         if(_loc12_ && param2.movePolicy.§_-Tk§)
         {
            param2.§_-DQ§ = true;
            _loc4_[_loc8_ + §_-TS§].mIsMatchee = true;
            (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
            _loc5_.§_-fr§.x = _loc7_;
            _loc5_.§_-fr§.y = _loc6_;
            _loc5_.§_-hK§ = param2.movePolicy.§_-Zx§;
            _loc5_.§_-6O§.x = -1;
            _loc5_.§_-6O§.y = 0;
            param3.push(_loc5_);
         }
         var _loc13_:Boolean = _loc6_ > 2 && _loc4_[_loc8_ + §_-Gf§] != null && _loc4_[_loc8_ + §_-Gf§].canMatch() && _loc4_[_loc8_ + §_-Gf§].color == param2.color;
         var _loc14_:Boolean = _loc6_ > 1 && _loc7_ > 0 && _loc4_[_loc8_ + §_-TW§] != null && _loc4_[_loc8_ + §_-TW§].canMatch() && _loc4_[_loc8_ + §_-TW§].color == param2.color;
         var _loc15_:Boolean = _loc6_ > 1 && _loc4_[_loc8_ + §_-16§] != null && _loc4_[_loc8_ + §_-16§].canMatch() && _loc4_[_loc8_ + §_-16§].color == param2.color;
         var _loc16_:Boolean = _loc6_ > 1 && _loc7_ < §_-2j§.§_-IP§ - 1 && _loc4_[_loc8_ + §_-Xa§] != null && _loc4_[_loc8_ + §_-Xa§].canMatch() && _loc4_[_loc8_ + §_-Xa§].color == param2.color;
         var _loc17_:Boolean = _loc6_ > 0 && _loc7_ > 1 && _loc4_[_loc8_ + §_-Mu§] != null && _loc4_[_loc8_ + §_-Mu§].canMatch() && _loc4_[_loc8_ + §_-Mu§].color == param2.color;
         var _loc18_:Boolean = _loc6_ > 0 && _loc7_ > 0 && _loc4_[_loc8_ + §_-JJ§] != null && _loc4_[_loc8_ + §_-JJ§].canMatch() && _loc4_[_loc8_ + §_-JJ§].color == param2.color;
         var _loc19_:Boolean = _loc6_ > 0 && _loc7_ < §_-2j§.§_-IP§ - 1 && _loc4_[_loc8_ + §_-mt§] != null && _loc4_[_loc8_ + §_-mt§].canMatch() && _loc4_[_loc8_ + §_-mt§].color == param2.color;
         var _loc20_:Boolean = _loc6_ > 0 && _loc7_ < §_-2j§.§_-IP§ - 2 && _loc4_[_loc8_ + §_-8s§] != null && _loc4_[_loc8_ + §_-8s§].canMatch() && _loc4_[_loc8_ + §_-8s§].color == param2.color;
         var _loc21_:Boolean = _loc7_ > 2 && _loc4_[_loc8_ + §_-Ud§] != null && _loc4_[_loc8_ + §_-Ud§].canMatch() && _loc4_[_loc8_ + §_-Ud§].color == param2.color;
         var _loc22_:Boolean = _loc7_ > 1 && _loc4_[_loc8_ + §_-aM§] != null && _loc4_[_loc8_ + §_-aM§].canMatch() && _loc4_[_loc8_ + §_-aM§].color == param2.color;
         var _loc23_:Boolean = _loc7_ < §_-2j§.§_-IP§ - 2 && _loc4_[_loc8_ + §_-Rf§] != null && _loc4_[_loc8_ + §_-Rf§].canMatch() && _loc4_[_loc8_ + §_-Rf§].color == param2.color;
         var _loc24_:Boolean = _loc7_ < §_-2j§.§_-IP§ - 3 && _loc4_[_loc8_ + §_-bE§] != null && _loc4_[_loc8_ + §_-bE§].canMatch() && _loc4_[_loc8_ + §_-bE§].color == param2.color;
         var _loc25_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 1 && _loc7_ > 1 && _loc4_[_loc8_ + §_-lc§] != null && _loc4_[_loc8_ + §_-lc§].canMatch() && _loc4_[_loc8_ + §_-lc§].color == param2.color;
         var _loc26_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 1 && _loc7_ > 0 && _loc4_[_loc8_ + §_-IC§] != null && _loc4_[_loc8_ + §_-IC§].canMatch() && _loc4_[_loc8_ + §_-IC§].color == param2.color;
         var _loc27_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 1 && _loc7_ < §_-2j§.§_-IP§ - 1 && _loc4_[_loc8_ + §_-4w§] != null && _loc4_[_loc8_ + §_-4w§].canMatch() && _loc4_[_loc8_ + §_-4w§].color == param2.color;
         var _loc28_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 1 && _loc7_ < §_-2j§.§_-IP§ - 2 && _loc4_[_loc8_ + §_-PC§] != null && _loc4_[_loc8_ + §_-PC§].canMatch() && _loc4_[_loc8_ + §_-PC§].color == param2.color;
         var _loc29_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 2 && _loc7_ > 0 && _loc4_[_loc8_ + §_-Qx§] != null && _loc4_[_loc8_ + §_-Qx§].canMatch() && _loc4_[_loc8_ + §_-Qx§].color == param2.color;
         var _loc30_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 2 && _loc4_[_loc8_ + §_-lS§] != null && _loc4_[_loc8_ + §_-lS§].canMatch() && _loc4_[_loc8_ + §_-lS§].color == param2.color;
         var _loc31_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 2 && _loc7_ < §_-2j§.§_-IP§ - 1 && _loc4_[_loc8_ + §_-Lg§] != null && _loc4_[_loc8_ + §_-Lg§].canMatch() && _loc4_[_loc8_ + §_-Lg§].color == param2.color;
         var _loc32_:Boolean = _loc6_ < §_-2j§.§_-H0§ - 3 && _loc4_[_loc8_ + §_-6o§] != null && _loc4_[_loc8_ + §_-6o§].canMatch() && _loc4_[_loc8_ + §_-6o§].color == param2.color;
         if(_loc9_)
         {
            if(_loc17_ && _loc18_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-Mu§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-JJ§].mIsMatchee = true;
            }
            if(_loc18_ && _loc19_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-JJ§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-mt§].mIsMatchee = true;
            }
            if(_loc19_ && _loc20_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-mt§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-8s§].mIsMatchee = true;
            }
            if(_loc15_ && _loc13_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-16§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-Gf§].mIsMatchee = true;
            }
            if(param2.§_-DQ§)
            {
               (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
               _loc5_.§_-fr§.x = _loc7_;
               _loc5_.§_-fr§.y = _loc6_;
               _loc5_.§_-hK§ = true;
               _loc5_.§_-6O§.x = 0;
               _loc5_.§_-6O§.y = -1;
               param3.push(_loc5_);
            }
         }
         if(_loc10_)
         {
            if(_loc16_ && _loc19_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-Xa§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-mt§].mIsMatchee = true;
            }
            if(_loc19_ && _loc27_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-mt§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-4w§].mIsMatchee = true;
            }
            if(_loc27_ && _loc31_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-4w§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-Lg§].mIsMatchee = true;
            }
            if(_loc23_ && _loc24_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-Rf§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-bE§].mIsMatchee = true;
            }
            if(param2.§_-DQ§)
            {
               (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
               _loc5_.§_-fr§.x = _loc7_;
               _loc5_.§_-fr§.y = _loc6_;
               _loc5_.§_-hK§ = true;
               _loc5_.§_-6O§.x = 1;
               _loc5_.§_-6O§.y = 0;
               param3.push(_loc5_);
            }
         }
         if(_loc11_)
         {
            if(_loc25_ && _loc26_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-lc§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-IC§].mIsMatchee = true;
            }
            if(_loc26_ && _loc27_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-IC§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-4w§].mIsMatchee = true;
            }
            if(_loc27_ && _loc28_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-4w§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-PC§].mIsMatchee = true;
            }
            if(_loc30_ && _loc32_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-lS§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-6o§].mIsMatchee = true;
            }
            if(param2.§_-DQ§)
            {
               (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
               _loc5_.§_-fr§.x = _loc7_;
               _loc5_.§_-fr§.y = _loc6_;
               _loc5_.§_-hK§ = true;
               _loc5_.§_-6O§.x = 0;
               _loc5_.§_-6O§.y = 1;
               param3.push(_loc5_);
            }
         }
         if(_loc12_)
         {
            if(_loc14_ && _loc18_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-TW§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-JJ§].mIsMatchee = true;
            }
            if(_loc18_ && _loc26_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-JJ§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-IC§].mIsMatchee = true;
            }
            if(_loc26_ && _loc29_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-IC§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-Qx§].mIsMatchee = true;
            }
            if(_loc22_ && _loc21_)
            {
               param2.§_-DQ§ = true;
               _loc4_[_loc8_ + §_-aM§].mIsMatchee = true;
               _loc4_[_loc8_ + §_-Ud§].mIsMatchee = true;
            }
            if(param2.§_-DQ§)
            {
               (_loc5_ = §_-L7§.§_-hQ§()).§_-5Y§ = param2;
               _loc5_.§_-fr§.x = _loc7_;
               _loc5_.§_-fr§.y = _loc6_;
               _loc5_.§_-hK§ = true;
               _loc5_.§_-6O§.x = -1;
               _loc5_.§_-6O§.y = 0;
               param3.push(_loc5_);
            }
         }
      }
      
      public function §true§(param1:§_-2j§) : Vector.<MoveData>
      {
         this.§_-jV§.length = 0;
         var _loc2_:Vector.<Gem> = param1.mGems;
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:int = §_-2j§.§_-gL§;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if((_loc4_ = _loc2_[_loc3_]) != null)
            {
               _loc4_.§_-DQ§ = false;
               _loc4_.mIsMatchee = false;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            if((_loc4_ = _loc2_[_loc3_]) != null)
            {
               this.§_-Gx§(param1,_loc2_[_loc3_],this.§_-jV§);
            }
            _loc3_++;
         }
         return this.§_-jV§;
      }
      
      public function Reset() : void
      {
         this.§_-jV§.length = 0;
      }
   }
}
