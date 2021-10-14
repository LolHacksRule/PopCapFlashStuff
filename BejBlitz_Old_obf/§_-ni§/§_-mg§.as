package §_-ni§
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import flash.geom.Point;
   
   public class §_-mg§
   {
       
      
      private var §_-KY§:int = 0;
      
      private var §_-gW§:CoinSprite;
      
      private var §_-n4§:Point;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-Gn§:int = 0;
      
      private var §_-4z§:Boolean = false;
      
      private var §_-Lk§:Point;
      
      public function §_-mg§(param1:CoinSprite, param2:int, param3:int, param4:int)
      {
         this.§_-Lk§ = new Point();
         this.§_-n4§ = new Point();
         super();
         this.§_-n4§.x = param2;
         this.§_-n4§.y = param3;
         this.§_-gW§ = param1;
         this.§_-KY§ = param4;
      }
      
      public function Update() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         if(this.§_-Gn§ >= this.§_-KY§)
         {
            this.§_-4z§ = true;
            return;
         }
         if(!this.§_-Vj§)
         {
            this.Init();
         }
         var _loc1_:Number = this.§_-Gn§ / this.§_-KY§;
         this.§_-gW§.x = this.§_-n4§.x * _loc1_ + this.§_-Lk§.x;
         this.§_-gW§.y = this.§_-n4§.y * _loc1_ + this.§_-Lk§.y;
         ++this.§_-Gn§;
      }
      
      private function Init() : void
      {
         this.§_-Lk§.x = this.§_-gW§.x;
         this.§_-Lk§.y = this.§_-gW§.y;
         this.§_-n4§.x -= this.§_-Lk§.x;
         this.§_-n4§.y -= this.§_-Lk§.y;
         this.§_-Vj§ = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
   }
}
