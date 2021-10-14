package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import §_-ZL§.HypercubeExplodeEvent;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class §_-BT§ extends SpriteEffect
   {
      
      private static const §_-ZQ§:Vector.<int> = new Vector.<int>();
      
      private static const §_-KB§:Number = 25;
      
      private static const §_-G§:Number = 1 / §_-KB§;
      
      {
         §_-ZQ§[Gem.§_-aK§] = 2105376;
         §_-ZQ§[Gem.§_-Y7§] = 16711680;
         §_-ZQ§[Gem.§_-md§] = 16744448;
         §_-ZQ§[Gem.§_-AH§] = 16776960;
         §_-ZQ§[Gem.§_-Zz§] = 65280;
         §_-ZQ§[Gem.§ use§] = 255;
         §_-ZQ§[Gem.§_-70§] = 16711935;
         §_-ZQ§[Gem.§_-8M§] = 8421504;
      }
      
      private var §_-J0§:Vector.<Object>;
      
      private var §_-7Q§:int = 0;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-mw§:Vector.<Gem>;
      
      private var §_-jU§:Number = 0.0;
      
      private var §_-Gn§:int = 0;
      
      private var §_-0b§:Vector.<HyperJolt>;
      
      private var §_-AU§:int = 0;
      
      private var §_-EP§:Matrix;
      
      private var §_-h2§:HypercubeExplodeEvent;
      
      private var §_-IB§:Gem;
      
      private var mApp:§_-0Z§;
      
      private var §_-V8§:Vector.<Gem>;
      
      private var §_-F5§:int = 0;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-d6§:int = 0;
      
      public function §_-BT§(param1:§_-0Z§, param2:HypercubeExplodeEvent, param3:Number, param4:Number)
      {
         super();
         blendMode = BlendMode.ADD;
         this.mApp = param1;
         this.§_-h2§ = param2;
         this.§_-IB§ = this.§_-h2§.§_-Ub§;
         this.§_-0b§ = new Vector.<HyperJolt>();
         this.§_-EP§ = new Matrix();
         this.§_-EP§.translate(param3,param4);
         this.§_-J0§ = new Vector.<Object>();
         this.§_-mw§ = new Vector.<Gem>();
         this.§_-d6§ = §_-ZQ§[this.§_-IB§.§_-7f§];
      }
      
      override public function Update() : void
      {
         var _loc5_:HyperJolt = null;
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-jU§ < 1 && this.§_-7Q§ == 0)
         {
            this.§_-jU§ += 0.02;
         }
         if(this.§_-7Q§ > 0)
         {
            --this.§_-7Q§;
            if(this.§_-7Q§ == 0)
            {
               this.§_-4z§ = true;
            }
            this.§_-jU§ = this.§_-7Q§ * §_-G§;
            return;
         }
         if(!this.§_-Vj§)
         {
            this.Init();
         }
         this.§_-MM§();
         this.§_-jQ§();
         var _loc1_:int = this.§_-0b§.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            (_loc5_ = this.§_-0b§[_loc3_]).Update();
            if(_loc5_.§_-NZ§)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         var _loc4_:* = _loc2_ == _loc1_;
         ++this.§_-Gn§;
         if(_loc4_ && this.§_-AU§ == this.§_-F5§ && this.§_-7Q§ == 0)
         {
            this.§_-7Q§ = §_-KB§;
            this.§_-h2§.§_-e0§();
         }
      }
      
      override public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      private function §_-jQ§() : void
      {
         var _loc8_:Object = null;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Gem = null;
         var _loc13_:Number = NaN;
         if(this.§_-V8§.length == 0)
         {
            return;
         }
         var _loc1_:int = this.mApp.logic.random.§_-Nn§(int.MAX_VALUE);
         var _loc2_:int = int(20 / this.§_-J0§.length + 1 + 5);
         var _loc3_:* = _loc1_ % _loc2_ == 0;
         if(this.§_-0b§.length > 0 && !_loc3_)
         {
            return;
         }
         var _loc4_:Gem = null;
         var _loc5_:Gem = null;
         var _loc6_:int = -1;
         if(this.§_-mw§.length > 0)
         {
            _loc4_ = this.§_-mw§[int(this.mApp.logic.random.§_-Nn§(this.§_-mw§.length))];
         }
         else if(this.§_-J0§.length > 0)
         {
            _loc4_ = (_loc8_ = this.§_-J0§[int(this.mApp.logic.random.§_-Nn§(this.§_-J0§.length))]).gem;
         }
         if(_loc4_ != null)
         {
            _loc9_ = Number.MAX_VALUE;
            _loc10_ = this.§_-V8§.length;
            _loc11_ = 0;
            while(_loc11_ < _loc10_)
            {
               _loc12_ = this.§_-V8§[_loc11_];
               if((_loc13_ = Math.min(Math.abs(_loc12_.§_-pX§ - _loc4_.§_-pX§),Math.abs(_loc12_.§_-dg§ - _loc4_.§_-dg§))) < _loc9_)
               {
                  _loc5_ = _loc12_;
                  _loc6_ = _loc11_;
               }
               _loc11_++;
            }
            this.§_-LK§(_loc4_.x * 40 + 20,_loc4_.y * 40 + 20,_loc5_.x * 40 + 20,_loc5_.y * 40 + 20);
         }
         else
         {
            _loc6_ = this.mApp.logic.random.§_-Nn§(this.§_-V8§.length);
            _loc5_ = this.§_-V8§[_loc6_];
         }
         this.§_-V8§.splice(_loc6_,1);
         var _loc7_:Object;
         (_loc7_ = new Object()).gem = _loc5_;
         _loc7_.percent = 0;
         _loc7_.dead = false;
         this.§_-J0§.push(_loc7_);
      }
      
      private function §_-MM§() : void
      {
         var _loc3_:Object = null;
         var _loc4_:Gem = null;
         var _loc5_:Number = NaN;
         this.§_-mw§.length = 0;
         var _loc1_:int = this.§_-J0§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-J0§[_loc2_];
            if(!_loc3_.dead)
            {
               _loc4_ = _loc3_.gem;
               _loc5_ = _loc3_.percent;
               if(_loc4_ == this.§_-IB§)
               {
                  _loc5_ += 0.01;
               }
               else
               {
                  _loc5_ += 0.015;
               }
               if(_loc5_ >= 1)
               {
                  _loc3_.dead = true;
                  this.§_-h2§.§_-gl§(_loc4_);
                  ++this.§_-AU§;
               }
               else if(_loc5_ < 0.04)
               {
                  this.§_-mw§.push(_loc4_);
               }
               _loc3_.percent = _loc5_;
            }
            _loc2_++;
         }
      }
      
      public function Init() : void
      {
         this.§_-V8§ = this.§_-h2§.§_-J5§().slice();
         var _loc1_:Object = new Object();
         _loc1_.gem = this.§_-IB§;
         _loc1_.percent = 0;
         _loc1_.dead = false;
         this.§_-J0§.push(_loc1_);
         this.§_-F5§ = this.§_-V8§.length + 1;
         this.§_-Vj§ = true;
      }
      
      override public function Draw(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:HyperJolt = null;
         if(this.§_-4z§)
         {
            return;
         }
         if(!param1 && this.§_-7Q§ == 0)
         {
            _loc2_ = this.§_-0b§.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               (_loc4_ = this.§_-0b§[_loc3_]).Draw();
               _loc3_++;
            }
         }
      }
      
      private function §_-LK§(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc5_:HyperJolt = new HyperJolt();
         var _loc6_:Number = param4 - param2;
         var _loc7_:Number = param3 - param1;
         var _loc8_:Number = Math.atan2(_loc6_,_loc7_);
         var _loc9_:Number = Math.sqrt(_loc7_ * _loc7_ + _loc6_ * _loc6_);
         _loc5_.§_-hi§ = Math.cos(_loc8_ - Math.PI / 2) * _loc9_ * 0.4;
         _loc5_.§_-S7§ = Math.sin(_loc8_ - Math.PI / 2) * _loc9_ * 0.4;
         _loc5_.color = this.§_-d6§;
         var _loc10_:int = 0;
         while(_loc10_ < 8)
         {
            _loc11_ = _loc10_ / 7;
            _loc12_ = param1 * (1 - _loc11_) + param3 * _loc11_;
            _loc13_ = param2 * (1 - _loc11_) + param4 * _loc11_;
            _loc5_.§_-fq§[_loc10_] = new Array();
            _loc5_.§_-fq§[_loc10_][0] = new Point(_loc12_,_loc13_);
            _loc5_.§_-fq§[_loc10_][1] = new Point(_loc12_,_loc13_);
            _loc10_++;
         }
         this.§_-0b§.push(_loc5_);
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_ELECTRO_PATH);
         addChild(_loc5_);
      }
   }
}
