package §_-Xk§
{
   import com.popcap.flash.framework.math.HermitePoint;
   
   public class §_-Hd§ extends §_-lI§
   {
      
      public static const §_-gM§:int = 1;
      
      public static const §_-Dk§:int = 8192;
      
      public static const §class§:int = 8;
       
      
      private var §_-a-§:Boolean = false;
      
      private var §_-nL§:Boolean = true;
      
      private var §_-El§:§_-Pb§;
      
      public function §_-Hd§()
      {
         super();
      }
      
      private function §_-OT§() : Vector.<Number>
      {
         return null;
      }
      
      override public function getOutValue(param1:Number) : Number
      {
         var _loc7_:Number = NaN;
         if(this.§_-El§ == null)
         {
            return 0;
         }
         if(§_-BU§ - §_-IM§ == 0)
         {
            return 0;
         }
         var _loc2_:Number = Math.min((param1 - §_-IM§) / (§_-BU§ - §_-IM§),1);
         if(this.§_-nL§)
         {
            _loc7_ = §_-Dj§ + this.§_-El§.§_-p§.§var §(_loc2_) * (§_-J§ - §_-Dj§);
            if(this.§_-a-§)
            {
               if(§_-Dj§ < §_-J§)
               {
                  _loc7_ = Math.min(Math.max(_loc7_,§_-Dj§),§_-J§);
               }
               else
               {
                  _loc7_ = Math.max(Math.min(_loc7_,§_-Dj§),§_-J§);
               }
            }
            return _loc7_;
         }
         var _loc3_:Vector.<Number> = this.§_-El§.§_-Bk§;
         var _loc4_:Number = _loc2_ * (§_-Dk§ - 1);
         var _loc5_:int;
         if((_loc5_ = int(_loc4_)) == §_-Dk§ - 1)
         {
            return §_-Dj§ + _loc3_[_loc5_] * (§_-J§ - §_-Dj§);
         }
         var _loc6_:Number = _loc4_ - _loc5_;
         return Number((_loc7_ = (_loc7_ = §_-Dj§) + (_loc3_[_loc5_] * (1 - _loc6_) + _loc3_[_loc5_ + 1] * _loc6_)) * (§_-J§ - §_-Dj§));
      }
      
      public function §_-c3§(param1:Boolean, ... rest) : void
      {
         var _loc5_:§_-LE§ = null;
         var _loc6_:Number = NaN;
         var _loc7_:HermitePoint = null;
         this.§_-El§ = new §_-Pb§();
         this.§_-El§.§_-Bk§ = this.§_-OT§();
         this.§_-El§.§_-p§.§_-fq§.length = 0;
         var _loc3_:int = rest.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = rest[_loc4_];
            _loc6_ = Math.tan(_loc5_.§_-5§ / 180 * Math.PI);
            (_loc7_ = new HermitePoint()).x = _loc5_.x;
            _loc7_.fx = _loc5_.y;
            _loc7_.§_-5f§ = _loc6_;
            this.§_-El§.§_-p§.§_-fq§.push(_loc7_);
            _loc4_++;
         }
         this.§_-El§.§_-p§.§_-kM§();
      }
   }
}
