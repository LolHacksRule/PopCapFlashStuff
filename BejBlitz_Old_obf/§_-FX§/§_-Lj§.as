package §_-FX§
{
   import com.popcap.flash.games.bej3.boosts.§_-FA§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class §_-Lj§ extends Sprite
   {
      
      public static const §_-jT§:Number = 28;
      
      public static const §_-es§:Number = 29;
       
      
      protected var §_-TN§:Class;
      
      private var §_-h6§:DisplayObject = null;
      
      private var §_-Lp§:§_-0Z§;
      
      private var §_-oG§:Number = 0;
      
      private var §_-AJ§:Number = 0;
      
      public function §_-Lj§(param1:§_-0Z§, param2:Number = 28, param3:Number = 29)
      {
         this.§_-TN§ = §_-fP§;
         super();
         this.§_-Lp§ = param1;
         this.§_-oG§ = param2;
         this.§_-AJ§ = param3;
      }
      
      public function Clear() : void
      {
         if(this.§_-h6§)
         {
            if(this.§_-h6§.parent && this.§_-h6§.parent == this)
            {
               removeChild(this.§_-h6§);
               this.§_-h6§ = null;
            }
         }
      }
      
      public function Init() : void
      {
      }
      
      public function Reset() : void
      {
         this.Clear();
         if(this.§_-Lp§.logic.boostLogic.§_-hF§() == §_-FA§.§_-aB§)
         {
            this.§_-h6§ = new this.§_-TN§();
            this.§_-h6§.scaleX = this.§_-oG§ / this.§_-h6§.width;
            this.§_-h6§.scaleY = this.§_-AJ§ / this.§_-h6§.height;
            addChild(this.§_-h6§);
         }
      }
   }
}
