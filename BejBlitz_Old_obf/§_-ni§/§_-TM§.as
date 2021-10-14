package §_-ni§
{
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   
   public class §_-TM§
   {
       
      
      private var §_-KY§:int = 0;
      
      private var §_-gW§:CoinSprite = null;
      
      private var §_-LU§:int = 0;
      
      private var §_-4r§:int = 0;
      
      private var §_-TC§:int = 0;
      
      private var §_-Gn§:int = 0;
      
      private var §_-4z§:Boolean = false;
      
      public function §_-TM§(param1:CoinSprite, param2:int)
      {
         super();
         this.§_-gW§ = param1;
         this.§_-KY§ = param2;
         this.§_-LU§ = param1.y;
         this.§_-TC§ = this.§_-LU§ - 40;
         this.§_-4r§ = this.§_-TC§ - this.§_-LU§;
      }
      
      public function IsDone() : Boolean
      {
         return this.§_-4z§;
      }
      
      public function Update() : void
      {
         if(this.§_-4z§)
         {
            return;
         }
         var _loc1_:Number = this.§_-Gn§ / this.§_-KY§;
         this.§_-gW§.y = this.§_-4r§ * _loc1_ + this.§_-LU§;
         this.§_-gW§.scaleX = _loc1_ * 0.5 + 0.5;
         this.§_-gW§.scaleY = _loc1_ * 0.5 + 0.5;
         ++this.§_-Gn§;
         if(this.§_-Gn§ == this.§_-KY§)
         {
            this.§_-4z§ = true;
         }
      }
   }
}
