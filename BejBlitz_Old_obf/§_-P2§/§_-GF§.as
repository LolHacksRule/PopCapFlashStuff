package §_-P2§
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.LightningBolt;
   import flash.display.Sprite;
   
   public class §_-GF§ extends Sprite
   {
      
      private static const §_-ZQ§:Array = new Array(8);
      
      {
         §_-ZQ§[Gem.§_-aK§] = 0;
         §_-ZQ§[Gem.§_-Y7§] = 4294901760;
         §_-ZQ§[Gem.§_-md§] = 4294934528;
         §_-ZQ§[Gem.§_-AH§] = 4294967040;
         §_-ZQ§[Gem.§_-Zz§] = 4278255360;
         §_-ZQ§[Gem.§ use§] = 4278190335;
         §_-ZQ§[Gem.§_-70§] = 4294902015;
         §_-ZQ§[Gem.§_-8M§] = 4294967295;
      }
      
      private var §_-V0§:ImageInst;
      
      private var mApp:§_-0Z§;
      
      private var §_-14§:Vector.<LightningBolt>;
      
      private var §_-no§:Vector.<LightningBolt>;
      
      public function §_-GF§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:LightningBolt = null;
         for each(_loc1_ in this.§_-14§)
         {
            _loc1_.Update();
         }
         for each(_loc1_ in this.§_-no§)
         {
            _loc1_.Update();
         }
      }
      
      public function ShowBoltCross(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc5_:LightningBolt;
         (_loc5_ = this.§_-no§[param1]).§_-w§(param4);
         _loc5_.§_-Rs§(§_-ZQ§[param3]);
         var _loc6_:LightningBolt;
         (_loc6_ = this.§_-14§[param2]).§_-w§(param4);
         _loc6_.§_-Rs§(§_-ZQ§[param3]);
      }
      
      public function Reset() : void
      {
      }
      
      public function Init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:LightningBolt = null;
         this.§_-V0§ = this.mApp.§_-QZ§.§_-op§(Blitz3Images.IMAGE_EFFECT_LIGHTNING);
         this.§_-no§ = new Vector.<LightningBolt>(8,true);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = new LightningBolt(this.§_-V0§);
            _loc2_.§_-Rs§(§_-ZQ§[int(Math.random() * §_-ZQ§.length)]);
            addChild(_loc2_);
            this.§_-no§[_loc1_] = _loc2_;
            _loc2_.x = 160;
            _loc2_.y = _loc1_ * 40 + 20;
            _loc2_.rotation = 90;
            _loc1_++;
         }
         this.§_-14§ = new Vector.<LightningBolt>(8,true);
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = new LightningBolt(this.§_-V0§);
            _loc2_.§_-Rs§(§_-ZQ§[int(Math.random() * §_-ZQ§.length)]);
            addChild(_loc2_);
            this.§_-14§[_loc1_] = _loc2_;
            _loc2_.x = _loc1_ * 40 + 20;
            _loc2_.y = 160;
            _loc1_++;
         }
      }
   }
}
