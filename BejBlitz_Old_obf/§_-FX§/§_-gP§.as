package §_-FX§
{
   import com.popcap.flash.games.bej3.boosts.IBoost;
   import com.popcap.flash.games.bej3.boosts.§_-8r§;
   import com.popcap.flash.games.bej3.boosts.§_-b4§;
   import com.popcap.flash.games.bej3.boosts.§_-ia§;
   import com.popcap.flash.games.bej3.boosts.§_-kT§;
   import com.popcap.flash.games.bej3.boosts.§_-of§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class §_-gP§ extends Sprite
   {
      
      private static const §_-eQ§:Class = §_-53§;
      
      private static const §_-V-§:Class = §_-Hu§;
      
      private static const §_-2Z§:Class = §_-I0§;
      
      private static const §_-C2§:Class = §_-hy§;
      
      private static const §_-aV§:Class = §_-3O§;
       
      
      private var §_-UO§:Sprite;
      
      private var §_-09§:§_-0Z§;
      
      private var §_-WG§:Dictionary;
      
      public function §_-gP§(param1:§_-0Z§)
      {
         super();
         this.§_-09§ = param1;
         this.§_-UO§ = new Sprite();
         addChild(this.§_-UO§);
         this.§_-WG§ = new Dictionary();
         this.§_-WG§[§_-b4§.§_-aB§] = new §_-eQ§() as Bitmap;
         this.§_-WG§[§_-of§.§_-aB§] = new §_-aV§() as Bitmap;
         this.§_-WG§[§_-ia§.§_-aB§] = new §_-2Z§() as Bitmap;
         this.§_-WG§[§_-8r§.§_-aB§] = new §_-C2§() as Bitmap;
         this.§_-WG§[§_-kT§.§_-aB§] = new §_-V-§() as Bitmap;
      }
      
      public function Init() : void
      {
      }
      
      public function Clear() : void
      {
         while(this.§_-UO§.numChildren > 0)
         {
            this.§_-UO§.removeChildAt(0);
         }
      }
      
      public function Reset() : void
      {
         var _loc4_:IBoost = null;
         var _loc5_:String = null;
         var _loc6_:Bitmap = null;
         this.Clear();
         var _loc1_:Vector.<IBoost> = this.§_-09§.logic.boostLogic.§_-SM§;
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = (_loc4_ = _loc1_[_loc3_]).§_-eA§();
            if((_loc6_ = this.§_-WG§[_loc5_]) != null)
            {
               _loc6_.x = this.§_-UO§.width;
               this.§_-UO§.addChild(_loc6_);
            }
            _loc3_++;
         }
         this.§_-UO§.x = -(this.§_-UO§.width / 2);
         this.§_-UO§.y = -(this.§_-UO§.height / 2);
      }
   }
}
