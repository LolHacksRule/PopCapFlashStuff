package §_-Xk§
{
   public class §_-l3§ extends §_-lI§
   {
       
      
      public var §_-2m§:Vector.<int>;
      
      public function §_-l3§()
      {
         super();
         this.§_-2m§ = new Vector.<int>();
      }
      
      override public function getOutValue(param1:Number) : Number
      {
         if(this.§_-2m§ == null)
         {
            return this.§_-gG§(param1);
         }
         var _loc2_:Number = Math.min(Math.max(param1,§_-IM§),§_-BU§);
         var _loc3_:Number = §_-BU§ - §_-IM§;
         var _loc4_:Number;
         if((_loc4_ = (_loc2_ - §_-IM§) / _loc3_) >= 1)
         {
            _loc4_ = 0;
         }
         var _loc5_:Number = this.§_-2m§.length * _loc4_;
         var _loc6_:int = int(_loc5_);
         var _loc7_:Number = _loc5_ - _loc6_;
         var _loc8_:int = _loc6_;
         var _loc9_:int;
         if((_loc9_ = _loc6_ + 1) >= this.§_-2m§.length)
         {
            _loc9_ = 0;
         }
         var _loc10_:Number = this.§_-2m§[_loc8_];
         var _loc12_:Number;
         var _loc11_:Number;
         return Number((_loc12_ = (_loc11_ = this.§_-2m§[_loc9_]) - _loc10_) * _loc7_ + _loc10_);
      }
      
      private function §_-gG§(param1:Number) : Number
      {
         var _loc2_:Number = Math.min(Math.max(param1,§_-IM§),§_-BU§);
         var _loc3_:Number = §_-BU§ - §_-IM§;
         var _loc4_:Number = (_loc2_ - §_-IM§) / _loc3_;
         var _loc5_:Number;
         return Number((_loc5_ = §_-J§ - §_-Dj§) * _loc4_ + §_-Dj§);
      }
   }
}
