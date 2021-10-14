package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HyperJolt extends Sprite
   {
       
      
      public var color:int = 0;
      
      public var §_-29§:int = 0;
      
      public var §_-Me§:Boolean = false;
      
      public var §_-Fq§:Number = 0.0;
      
      public var §_-fq§:Array;
      
      public var §_-NZ§:Boolean = false;
      
      public var §_-hi§:Number = 0.0;
      
      public var §_-S7§:Number = 0.0;
      
      public function HyperJolt()
      {
         this.§_-fq§ = new Array();
         super();
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Number = NaN;
         if(this.§_-NZ§)
         {
            return;
         }
         this.§_-Fq§ += 0.01;
         if(this.§_-Fq§ > 1)
         {
            this.§_-NZ§ = true;
            visible = false;
            if(parent != null)
            {
               parent.removeChild(this);
            }
         }
         if(this.§_-29§ % 4 == 0)
         {
            this.§_-Me§ = true;
            _loc1_ = Math.max(0,1 - (1 - this.§_-Fq§) * 3);
            _loc2_ = this.§_-fq§[0][0].x;
            _loc3_ = this.§_-fq§[0][0].y;
            _loc4_ = this.§_-fq§[7][0].x;
            _loc5_ = this.§_-fq§[7][0].y;
            _loc6_ = 0;
            while(_loc6_ < 8)
            {
               _loc7_ = _loc6_ / 7;
               _loc8_ = 1 - Math.abs(1 - _loc7_ * 2);
               _loc9_ = _loc2_ * (1 - _loc7_) + _loc4_ * _loc7_ + _loc8_ * (Math.random() * (40 / 128) + _loc1_ * this.§_-hi§);
               _loc10_ = _loc3_ * (1 - _loc7_) + _loc5_ * _loc7_ + _loc8_ * (Math.random() * (40 / 128) + _loc1_ * this.§_-S7§);
               _loc11_ = this.§_-fq§[_loc6_][0];
               _loc12_ = this.§_-fq§[_loc6_][1];
               if(_loc6_ == 0 || _loc6_ == 7)
               {
                  _loc11_.x = _loc9_;
                  _loc11_.y = _loc10_;
                  _loc12_.x = _loc9_;
                  _loc12_.y = _loc10_;
               }
               else
               {
                  _loc13_ = 24;
                  _loc11_.x = _loc9_ + Math.random() * _loc13_;
                  _loc11_.y = _loc10_ + Math.random() * _loc13_;
                  _loc12_.x = _loc9_ + Math.random() * _loc13_;
                  _loc12_.y = _loc10_ + Math.random() * _loc13_;
               }
               _loc6_++;
            }
         }
         ++this.§_-29§;
      }
      
      public function Draw() : void
      {
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Point = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Point = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Graphics = null;
         if(!this.§_-Me§)
         {
            return;
         }
         this.§_-Me§ = false;
         var _loc1_:Number = Math.min((1 - this.§_-Fq§) * 8,1);
         var _loc2_:int = int(16777215 * _loc1_);
         graphics.clear();
         var _loc3_:int = 0;
         while(_loc3_ < 7)
         {
            _loc5_ = (_loc4_ = this.§_-fq§[_loc3_][0]).x;
            _loc6_ = _loc4_.y;
            _loc8_ = (_loc7_ = this.§_-fq§[_loc3_][1]).x;
            _loc9_ = _loc7_.y;
            _loc11_ = (_loc10_ = this.§_-fq§[_loc3_ + 1][0]).x;
            _loc12_ = _loc10_.y;
            _loc14_ = (_loc13_ = this.§_-fq§[_loc3_ + 1][1]).x;
            _loc15_ = _loc13_.y;
            _loc16_ = 0.3;
            _loc17_ = _loc5_ * _loc16_ + _loc8_ * (1 - _loc16_);
            _loc18_ = _loc6_ * _loc16_ + _loc9_ * (1 - _loc16_);
            _loc19_ = _loc8_ * _loc16_ + _loc5_ * (1 - _loc16_);
            _loc20_ = _loc9_ * _loc16_ + _loc6_ * (1 - _loc16_);
            _loc21_ = _loc11_ * _loc16_ + _loc14_ * (1 - _loc16_);
            _loc22_ = _loc12_ * _loc16_ + _loc15_ * (1 - _loc16_);
            _loc23_ = _loc14_ * _loc16_ + _loc11_ * (1 - _loc16_);
            _loc24_ = _loc15_ * _loc16_ + _loc12_ * (1 - _loc16_);
            (_loc25_ = graphics).beginFill(this.color);
            _loc25_.moveTo(_loc5_,_loc6_);
            _loc25_.lineTo(_loc14_,_loc15_);
            _loc25_.lineTo(_loc11_,_loc12_);
            _loc25_.lineTo(_loc5_,_loc6_);
            _loc25_.moveTo(_loc5_,_loc6_);
            _loc25_.lineTo(_loc8_,_loc9_);
            _loc25_.lineTo(_loc14_,_loc15_);
            _loc25_.lineTo(_loc5_,_loc6_);
            _loc25_.endFill();
            _loc25_.beginFill(_loc2_);
            _loc25_.moveTo(_loc17_,_loc18_);
            _loc25_.lineTo(_loc23_,_loc24_);
            _loc25_.lineTo(_loc21_,_loc22_);
            _loc25_.lineTo(_loc17_,_loc18_);
            _loc25_.moveTo(_loc17_,_loc18_);
            _loc25_.lineTo(_loc19_,_loc20_);
            _loc25_.lineTo(_loc23_,_loc24_);
            _loc25_.lineTo(_loc17_,_loc18_);
            _loc25_.endFill();
            _loc3_++;
         }
      }
   }
}
