package §_-ni§
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import flash.geom.Point;
   
   public class §_-c§
   {
       
      
      private var §_-KY§:int = 0;
      
      private var §_-gW§:CoinSprite = null;
      
      private var §_-n4§:Point;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Lk§:Point;
      
      public function §_-c§(param1:CoinSprite, param2:int)
      {
         this.§_-Lk§ = new Point();
         this.§_-n4§ = new Point();
         super();
         this.§_-gW§ = param1;
         this.§_-KY§ = param2;
      }
      
      public function Update() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         if(!this.§_-Vj§)
         {
            this.Init();
         }
         if(this.§_-Gn§ == this.§_-KY§)
         {
            this.§_-gW§.parent.removeChild(this.§_-gW§);
            this.§_-4z§ = true;
            return;
         }
         var _loc1_:Number = this.§_-Gn§ / this.§_-KY§;
         this.§_-gW§.y = this.§_-n4§.y * _loc1_ + this.§_-Lk§.y;
         this.§_-gW§.alpha = 1 - _loc1_;
         var _loc2_:Number = 1 - _loc1_ * 0.8;
         this.§_-gW§.scaleX = _loc2_;
         this.§_-gW§.scaleY = _loc2_;
         ++this.§_-Gn§;
      }
      
      private function Init() : void
      {
         this.§_-Lk§.x = this.§_-gW§.x;
         this.§_-Lk§.y = this.§_-gW§.y;
         this.§_-n4§.x = 0;
         this.§_-n4§.y = 40;
         this.§_-Vj§ = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
