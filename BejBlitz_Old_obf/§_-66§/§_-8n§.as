package §_-66§
{
   import §_-4M§.§_-Ze§;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.§_-7C§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class §_-8n§ extends Sprite implements IBlitz3NetworkHandler
   {
      
      private static const §_-To§:Class = §_-28§;
      
      private static const §_-Tb§:Class = §_-In§;
      
      private static const §_-QO§:Class = §_-cb§;
       
      
      private var §_-ja§:§_-7C§;
      
      private var §_-7a§:§_-25§;
      
      private var §_-G3§:Bitmap;
      
      private var §_-Lp§:Blitz3Game;
      
      public function §_-8n§(param1:Blitz3Game)
      {
         super();
         this.§_-Lp§ = param1;
      }
      
      public function get §_-3A§() : §_-7C§
      {
         if(this.§_-ja§ == null)
         {
            this.§_-ja§ = new §_-7C§();
            this.§_-ja§.§_-NW§(111.95,27.05);
            this.§_-ja§.x = 13;
            this.§_-ja§.y = 15;
         }
         return this.§_-ja§;
      }
      
      public function §_-Kw§(param1:int) : void
      {
         this.§_-3A§.SetText(§_-Ze§.§_-2P§(param1));
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
      }
      
      public function §use§(param1:Dictionary) : void
      {
      }
      
      public function get §_-fc§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-G3§ == null)
         {
            this.§_-G3§ = new §_-To§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 0;
            _loc1_.ty = 0;
            this.§_-G3§.transform.matrix = _loc1_;
         }
         return this.§_-G3§;
      }
      
      public function §_-2i§() : void
      {
      }
      
      public function Init() : void
      {
         this.§_-Lp§.network.AddHandler(this);
         addChild(this.§_-fc§);
         addChild(this.button);
         addChild(this.§_-3A§);
      }
      
      public function §_-fX§() : void
      {
      }
      
      public function get button() : §_-25§
      {
         var _loc1_:Matrix = null;
         if(this.§_-7a§ == null)
         {
            this.§_-7a§ = new §_-25§(this.§_-Lp§);
            this.§_-7a§.§_-G0§.addChild(new §_-QO§());
            this.§_-7a§.§_-5H§.addChild(new §_-Tb§());
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 127.95;
            _loc1_.ty = 8;
            this.§_-7a§.transform.matrix = _loc1_;
         }
         return this.§_-7a§;
      }
      
      public function §_-Ae§(param1:int) : void
      {
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
      }
   }
}
