package §_-P2§
{
   import §_-2v§.FlameGemCreateEvent;
   import §_-2v§.FlameGemExplodeEvent;
   import §_-FX§.§_-RG§;
   import §_-Pe§.StarGemCreateEvent;
   import §_-Pe§.StarGemExplodeEvent;
   import §_-ZL§.HypercubeExplodeEvent;
   import §_-ZL§.§_-YJ§;
   import §_-ni§.§_-Y5§;
   import §case §.§_-Zh§;
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.events.§_-3D§;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.bej3.§_-2j§;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.§_-Ov§;
   import com.popcap.flash.games.bej3.blitz.§_-ZG§;
   import com.popcap.flash.games.bej3.tokens.CoinToken;
   import com.popcap.flash.games.bej3.tokens.CoinTokenCollectedEvent;
   import com.popcap.flash.games.bej3.tokens.CoinTokenSpawnedEvent;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import com.popcap.flash.games.blitz3.ui.sprites.GemSprite;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.SpriteEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-1W§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-BT§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-Bo§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-Oa§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-cB§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§_-nm§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§case§;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.§return§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class §_-kf§ extends Sprite
   {
       
      
      private var §_-M0§:ImageInst;
      
      private var §_-nf§:Array;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-Kz§:ImageInst;
      
      private var §_-ke§:ImageInst;
      
      private var §_-CE§:Vector.<ImageInst>;
      
      private var §_-YO§:Sprite;
      
      public var §_-DE§:int = 40;
      
      private var §_-dD§:Sprite;
      
      public var §_-k3§:Point;
      
      private var §_-WC§:ImageInst;
      
      private var §_-Q5§:ImageInst;
      
      private var §_-Ha§:Sprite;
      
      private var §_-D6§:int = -1;
      
      private var §_-lO§:Sprite;
      
      private var §_-Su§:Vector.<ImageInst>;
      
      private var §_-fz§:Vector.<ImageInst>;
      
      private var §_-Xn§:ImageInst;
      
      private var §_-jL§:Vector.<ImageInst>;
      
      public var lightning:§_-GF§;
      
      private var §_-1c§:Vector.<GemSprite>;
      
      private var §_-gJ§:ImageInst;
      
      private var §_-gw§:ImageInst;
      
      private var §_-bD§:Vector.<SpriteEffect>;
      
      private var §_-Ui§:Sprite;
      
      private var §_-c1§:Vector.<CoinSprite>;
      
      private var §_-OG§:int = 0;
      
      private var §_-mf§:Vector.<ImageInst>;
      
      private var §_-8L§:Vector.<ImageInst>;
      
      private var §_-6k§:Sprite;
      
      private var §_-0d§:ImageInst;
      
      private var §_-Na§:Sprite;
      
      private var mApp:§_-Zh§;
      
      public var §_-Ku§:Sprite;
      
      private var §_-q§:Sprite;
      
      public function §_-kf§(param1:§_-Zh§)
      {
         this.§_-k3§ = new Point();
         this.§_-nf§ = [];
         super();
         this.mApp = param1;
         this.lightning = new §_-GF§(param1);
      }
      
      private function §_-VG§(param1:EventContext) : void
      {
         var _loc5_:GemSprite = null;
         var _loc2_:CoinToken = param1.§_-fw§() as CoinToken;
         var _loc3_:CoinSprite = new CoinSprite();
         this.§_-c1§[_loc2_.id] = _loc3_;
         var _loc4_:Gem;
         if((_loc4_ = _loc2_.host) != null)
         {
            (_loc5_ = this.§_-1c§[_loc4_.id]).§_-TQ§.addChild(_loc3_);
         }
      }
      
      private function §_-O§(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc3_:ImageInst = null;
         if(param1.type == Gem.§_-Jz§)
         {
            _loc3_ = this.§_-jL§[param1.color];
            _loc3_.§_-hj§ = param2.§_-dS§ / 4 % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-Q3§)
         {
            _loc3_ = this.§_-jL§[param1.color];
            _loc3_.§_-hj§ = 0;
         }
         else if(param1.type == Gem.§_-l0§)
         {
            _loc3_ = this.§_-Kz§;
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * (70 / 3)) % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-N3§)
         {
            _loc3_ = this.§_-jL§[param1.color];
            _loc3_.§_-hj§ = 0;
         }
         else if(param1.type == Gem.§_-ec§)
         {
            _loc3_ = this.§_-WC§;
            _loc3_.§_-hj§ = 0;
         }
         else if(param1.type == Gem.§_-72§)
         {
            _loc3_ = null;
         }
         else if(param1.type == Gem.§_-nT§)
         {
            _loc3_ = null;
         }
         return _loc3_;
      }
      
      private function §_-Hs§() : void
      {
         var _loc6_:BlitzEvent = null;
         var _loc8_:HypercubeExplodeEvent = null;
         var _loc9_:Vector.<Gem> = null;
         var _loc10_:Gem = null;
         var _loc11_:GemSprite = null;
         var _loc12_:SwapData = null;
         var _loc13_:Gem = null;
         var _loc14_:Gem = null;
         var _loc15_:GemSprite = null;
         var _loc16_:GemSprite = null;
         var _loc1_:Vector.<Gem> = this.mApp.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:Gem = null;
         var _loc4_:GemSprite = null;
         var _loc5_:int = 0;
         this.§_-Na§.visible = false;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if(_loc3_ != null)
            {
               _loc4_ = this.§_-1c§[_loc3_.id];
               if(_loc3_.§_-NZ§)
               {
                  _loc4_.§_-kX§();
               }
               else
               {
                  _loc4_.§_-a0§ = false;
                  _loc4_.Show();
                  if(_loc3_.§_-An§)
                  {
                     this.§_-Na§.visible = true;
                     _loc4_.§_-TQ§.addChild(this.§_-Na§);
                  }
               }
            }
            _loc5_++;
         }
         for each(_loc6_ in this.mApp.logic.mBlockingEvents)
         {
            if(_loc6_ is HypercubeExplodeEvent)
            {
               _loc9_ = (_loc8_ = _loc6_ as HypercubeExplodeEvent).§_-J5§();
               for each(_loc10_ in _loc9_)
               {
                  (_loc11_ = this.§_-1c§[_loc10_.id]).§_-a0§ = true;
               }
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if(_loc3_ != null)
            {
               _loc4_ = this.§_-1c§[_loc3_.id];
               this.§_-1Q§(_loc3_,_loc4_);
            }
            _loc5_++;
         }
         var _loc7_:int = this.mApp.logic.swaps.length;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            if(!(_loc12_ = this.mApp.logic.swaps[_loc5_]).§_-nM§())
            {
               _loc13_ = _loc12_.§_-iX§.§_-5Y§;
               _loc14_ = _loc12_.§_-iX§.§_-5p§;
               _loc15_ = this.§_-1c§[_loc13_.id];
               _loc16_ = this.§_-1c§[_loc14_.id];
               if(!_loc14_.§_-NZ§)
               {
                  this.§_-Ui§.addChild(_loc16_.§_-TQ§);
               }
               if(!_loc13_.§_-NZ§)
               {
                  this.§_-Ui§.addChild(_loc15_.§_-TQ§);
               }
            }
            _loc5_++;
         }
      }
      
      private function §_-Wi§(param1:StarGemCreateEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_STAR_APPEAR);
         this.§_-bD§.push(new §_-1W§(param1));
      }
      
      private function §_-AF§(param1:StarGemExplodeEvent) : void
      {
         this.§_-bD§.push(new §_-cB§(this.mApp,param1.§_-Ub§));
      }
      
      private function §_-pO§(param1:HypercubeExplodeEvent) : void
      {
         this.§_-bD§.push(new §_-BT§(this.mApp,param1,x,y));
      }
      
      private function §_-iJ§(param1:FlameGemExplodeEvent) : void
      {
         this.§_-bD§.push(new §case§(this.mApp,param1.§_-Ub§));
      }
      
      private function §_-Ug§(param1:Boolean) : void
      {
         var _loc5_:SpriteEffect = null;
         var _loc2_:Boolean = true;
         var _loc3_:int = this.§_-bD§.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.§_-bD§[_loc4_]).parent == null)
            {
               this.§_-dD§.addChild(_loc5_);
            }
            if(!_loc5_.IsDone())
            {
               _loc2_ = false;
            }
            else if(_loc5_.parent != null)
            {
               this.§_-dD§.removeChild(_loc5_);
            }
            _loc5_.Draw(param1);
            _loc4_++;
         }
         if(_loc2_)
         {
            this.§_-bD§.length = 0;
         }
      }
      
      private function §_-IJ§(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc3_:ImageInst = null;
         if(param1.type == Gem.§_-Jz§)
         {
            _loc3_ = this.§_-fz§[param1.color];
            _loc3_.§_-hj§ = param2.§_-dS§ / 4 % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-Q3§)
         {
            _loc3_ = this.§_-mf§[param1.color];
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * 26) % _loc3_.§_-O8§.§_-Jk§;
            _loc3_.y = -6;
         }
         else if(param1.type == Gem.§_-l0§)
         {
            _loc3_ = this.§_-gw§;
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * (70 / 3)) % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-N3§)
         {
            _loc3_ = this.§_-Su§[param1.color];
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * 30) % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-ec§)
         {
            _loc3_ = this.§_-8L§[param1.color];
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * 30) % _loc3_.§_-O8§.§_-Jk§;
         }
         else if(param1.type == Gem.§_-72§)
         {
            _loc3_ = this.§_-Xn§;
            if(param1.§_-dg§ == this.§_-k3§.y && param1.§_-pX§ == this.§_-k3§.x && this.mApp.logic.GetTimeRemaining() > 0)
            {
               _loc3_ = this.§_-M0§;
            }
         }
         else if(param1.type == Gem.§_-nT§)
         {
            _loc3_ = this.§_-Xn§;
            if(param1.§_-dg§ == this.§_-k3§.y && param1.§_-pX§ == this.§_-k3§.x && this.mApp.logic.GetTimeRemaining() > 0)
            {
               _loc3_ = this.§_-M0§;
            }
         }
         return _loc3_;
      }
      
      public function Reset() : void
      {
         var _loc1_:GemSprite = null;
         var _loc2_:SpriteEffect = null;
         var _loc3_:CoinSprite = null;
         this.§_-OG§ = 0;
         this.§_-D6§ = -1;
         this.§_-YO§.alpha = 0;
         for each(_loc1_ in this.§_-1c§)
         {
            _loc1_.§_-kX§();
         }
         for each(_loc2_ in this.§_-bD§)
         {
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         for each(_loc3_ in this.§_-c1§)
         {
            _loc3_.Reset();
         }
         this.§_-c1§.length = 0;
         this.§_-nf§.length = 0;
         this.§_-bD§.length = 0;
         this.lightning.Reset();
      }
      
      public function Init() : void
      {
         this.§_-bD§ = new Vector.<SpriteEffect>();
         this.§_-6k§ = new Sprite();
         this.§_-Ui§ = new Sprite();
         this.§_-YO§ = new Sprite();
         this.§_-Ha§ = new Sprite();
         this.§_-dD§ = new Sprite();
         this.§_-q§ = new Sprite();
         this.§_-lO§ = new Sprite();
         this.§_-YO§.graphics.beginFill(0,0.5);
         this.§_-YO§.graphics.drawRect(0,0,§_-0Z§.§_-h8§,§_-0Z§.§_-GN§);
         this.§_-YO§.graphics.endFill();
         this.§_-YO§.alpha = 0;
         this.§_-YO§.visible = false;
         addChild(this.§_-6k§);
         addChild(this.§_-Ui§);
         addChild(this.§_-YO§);
         addChild(this.§_-Ha§);
         addChild(this.§_-dD§);
         addChild(this.§_-q§);
         addChild(this.§_-lO§);
         this.mApp.logic.flameGemLogic.addEventListener(FlameGemCreateEvent.§_-aB§,this.§_-XK§);
         this.mApp.logic.flameGemLogic.addEventListener(FlameGemExplodeEvent.§_-aB§,this.§_-iJ§);
         this.mApp.logic.starGemLogic.addEventListener(StarGemCreateEvent.§_-aB§,this.§_-Wi§);
         this.mApp.logic.starGemLogic.addEventListener(StarGemExplodeEvent.§_-aB§,this.§_-AF§);
         this.mApp.logic.hypercubeLogic.addEventListener(§_-YJ§.§_-aB§,this.§_-4b§);
         this.mApp.logic.hypercubeLogic.addEventListener(HypercubeExplodeEvent.§_-aB§,this.§_-pO§);
         var _loc1_:§_-ex§ = this.mApp.§_-QZ§;
         this.§_-fz§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-jL§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-mf§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-Su§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-8L§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-CE§ = new Vector.<ImageInst>(Gem.§_-ef§,true);
         this.§_-fz§[Gem.§_-aK§] = null;
         this.§_-fz§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_RED);
         this.§_-fz§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_ORANGE);
         this.§_-fz§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_YELLOW);
         this.§_-fz§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_GREEN);
         this.§_-fz§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_BLUE);
         this.§_-fz§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_PURPLE);
         this.§_-fz§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_WHITE);
         this.§_-jL§[Gem.§_-aK§] = null;
         this.§_-jL§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_RED);
         this.§_-jL§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_ORANGE);
         this.§_-jL§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_YELLOW);
         this.§_-jL§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_GREEN);
         this.§_-jL§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_BLUE);
         this.§_-jL§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_PURPLE);
         this.§_-jL§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_SHADOW_WHITE);
         this.§_-mf§[Gem.§_-aK§] = null;
         this.§_-mf§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_RED);
         this.§_-mf§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_ORANGE);
         this.§_-mf§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_YELLOW);
         this.§_-mf§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_GREEN);
         this.§_-mf§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_BLUE);
         this.§_-mf§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_PURPLE);
         this.§_-mf§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_FLAME_WHITE);
         this.§_-Su§[Gem.§_-aK§] = null;
         this.§_-Su§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_RED);
         this.§_-Su§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_ORANGE);
         this.§_-Su§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_YELLOW);
         this.§_-Su§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_GREEN);
         this.§_-Su§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_BLUE);
         this.§_-Su§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_PURPLE);
         this.§_-Su§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_STAR_WHITE);
         this.§_-8L§[Gem.§_-aK§] = null;
         this.§_-8L§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_RED);
         this.§_-8L§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_ORANGE);
         this.§_-8L§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_YELLOW);
         this.§_-8L§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_GREEN);
         this.§_-8L§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_BLUE);
         this.§_-8L§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_PURPLE);
         this.§_-8L§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_WHITE);
         this.§_-CE§[Gem.§_-aK§] = null;
         this.§_-CE§[Gem.§_-Y7§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_RED);
         this.§_-CE§[Gem.§_-md§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_ORANGE);
         this.§_-CE§[Gem.§_-AH§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_YELLOW);
         this.§_-CE§[Gem.§_-Zz§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_GREEN);
         this.§_-CE§[Gem.§ use§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_BLUE);
         this.§_-CE§[Gem.§_-70§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_PURPLE);
         this.§_-CE§[Gem.§_-8M§] = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_NUMBERS_WHITE);
         this.§_-0d§ = _loc1_.§_-op§(Blitz3Images.IMAGE_SELECTOR);
         this.§_-gw§ = _loc1_.§_-op§(Blitz3Images.§_-Pd§);
         this.§_-Kz§ = _loc1_.§_-op§(Blitz3Images.§_-8y§);
         this.§_-WC§ = _loc1_.§_-op§(Blitz3Images.IMAGE_GEM_MULTI_SHADOW);
         this.§_-gJ§ = _loc1_.§_-op§(Blitz3Images.§_-ak§);
         this.§_-Xn§ = _loc1_.§_-op§(Blitz3Images.IMAGE_BOOST_BUTTON_UP);
         this.§_-M0§ = _loc1_.§_-op§(Blitz3Images.IMAGE_BOOST_BUTTON_OVER);
         this.§_-ke§ = _loc1_.§_-op§(Blitz3Images.IMAGE_SCRAMBLE_EFFECT);
         this.§_-Q5§ = _loc1_.§_-op§(Blitz3Images.IMAGE_DETONATE_EFFECT);
         this.§_-1c§ = new Vector.<GemSprite>();
         this.§_-c1§ = new Vector.<CoinSprite>();
         this.§_-Na§ = new Sprite();
         var _loc2_:Bitmap = new Bitmap(_loc1_.getBitmapData(Blitz3Images.IMAGE_SELECTOR));
         _loc2_.x = -(_loc2_.width / 2);
         _loc2_.y = -(_loc2_.height / 2);
         this.§_-Na§.addChild(_loc2_);
         this.lightning.Init();
         addChild(this.lightning);
         var _loc3_:§_-3D§ = §_-3D§.§_-Tj§();
         _loc3_.§_-o1§("SpawnEndEvent",this.§_-Nq§,10);
         _loc3_.§_-o1§(CoinTokenSpawnedEvent.§_-aB§,this.§_-VG§);
         _loc3_.§_-o1§(CoinTokenCollectedEvent.§_-aB§,this.§_-DH§);
         this.§_-Vj§ = true;
      }
      
      private function §_-XN§() : void
      {
         var _loc1_:§_-2j§ = this.mApp.logic.board;
         var _loc2_:Vector.<Gem> = _loc1_.mGems;
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:GemSprite = null;
         while(this.§_-1c§.length <= _loc1_.§_-F8§)
         {
            (_loc5_ = new GemSprite(this.mApp)).gem = _loc1_.§_-gH§(this.§_-1c§.length);
            this.§_-6k§.addChild(_loc5_.§_-0u§);
            this.§_-Ha§.addChild(_loc5_.§_-TQ§);
            this.§_-1c§[this.§_-1c§.length] = _loc5_;
         }
         var _loc6_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            if((_loc4_ = _loc2_[_loc3_]) != null)
            {
               (_loc5_ = this.§_-1c§[_loc4_.id]).gem = _loc4_;
               if(_loc5_.§_-0u§.parent == null)
               {
                  this.§_-6k§.addChild(_loc5_.§_-0u§);
               }
               if(_loc5_.§_-TQ§.parent == null)
               {
                  this.§_-Ui§.addChild(_loc5_.§_-TQ§);
               }
            }
            _loc3_++;
         }
         var _loc7_:int = this.§_-1c§.length;
         _loc3_ = 0;
         while(_loc3_ < _loc7_)
         {
            if((_loc4_ = (_loc5_ = this.§_-1c§[_loc3_]).gem) == null || _loc4_.§_-NZ§)
            {
               if(_loc5_.§_-0u§.parent != null)
               {
                  _loc5_.§_-0u§.parent.removeChild(_loc5_.§_-0u§);
               }
               if(_loc5_.§_-TQ§.parent != null)
               {
                  _loc5_.§_-TQ§.parent.removeChild(_loc5_.§_-TQ§);
               }
            }
            _loc3_++;
         }
      }
      
      private function §_-7M§(param1:Gem, param2:GemSprite) : ImageInst
      {
         if(param1.§_-hk§)
         {
            return null;
         }
         var _loc3_:ImageInst = null;
         if(param1.type == Gem.§_-ec§)
         {
            _loc3_ = this.§_-CE§[Gem.§_-8M§];
            _loc3_.§_-hj§ = param1.§_-Nx§ - 2;
         }
         else if(param1.type == Gem.§_-N3§)
         {
            _loc3_ = this.§_-gJ§;
            _loc3_.§_-hj§ = int(param1.§_-Td§ / 100 * 15) % _loc3_.§_-O8§.§_-Jk§;
            _loc3_.§use § = true;
         }
         else if(param1.type == Gem.§_-72§)
         {
            _loc3_ = this.§_-Q5§;
         }
         else if(param1.type == Gem.§_-nT§)
         {
            _loc3_ = this.§_-ke§;
         }
         return _loc3_;
      }
      
      private function §_-4b§(param1:§_-YJ§) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_RAINBOW_APPEAR);
         this.§_-bD§.push(new §_-Oa§(param1));
      }
      
      private function §_-kH§() : void
      {
         var _loc2_:§_-Ov§ = null;
         if(this.§_-D6§ == this.mApp.logic.frameID)
         {
            return;
         }
         this.§_-D6§ = this.mApp.logic.frameID;
         if(this.mApp.logic.gemsHit)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_HIT);
         }
         if(this.mApp.logic.badMove)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BAD_MOVE);
         }
         if(this.mApp.logic.startedMove)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_START_MOVE);
         }
         if(this.mApp.logic.multiLogic.spawned)
         {
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_MULTI_APPEAR);
         }
         var _loc1_:§_-ZG§ = this.mApp.logic.scoreKeeper;
         if(_loc1_.§_-Kj§ > 0)
         {
            if(_loc1_.§_-L-§ == 2)
            {
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COMBO_1);
            }
            else if(_loc1_.§_-L-§ == 3)
            {
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COMBO_2);
            }
            else if(_loc1_.§_-L-§ == 4)
            {
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COMBO_3);
            }
            else if(_loc1_.§_-L-§ == 5)
            {
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COMBO_4);
            }
            else if(_loc1_.§_-L-§ >= 6)
            {
               this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_COMBO_5);
            }
            else
            {
               _loc2_ = this.mApp.logic.speedBonus;
               if(_loc2_.§_-iU§() == 0)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_MATCH_ONE);
               }
               else if(_loc2_.§_-iU§() == 1)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_1);
               }
               else if(_loc2_.§_-iU§() == 2)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_2);
               }
               else if(_loc2_.§_-iU§() == 3)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_3);
               }
               else if(_loc2_.§_-iU§() == 4)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_4);
               }
               else if(_loc2_.§_-iU§() == 5)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_5);
               }
               else if(_loc2_.§_-iU§() == 6)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_6);
               }
               else if(_loc2_.§_-iU§() == 7)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_7);
               }
               else if(_loc2_.§_-iU§() == 8)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_8);
               }
               else if(_loc2_.§_-iU§() == 9 || _loc2_.§_-iU§() == 10)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_9);
               }
               else if(_loc2_.§_-iU§() >= 11)
               {
                  this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_FLAME_SPEED_1);
               }
            }
         }
      }
      
      private function §_-Nq§(param1:EventContext) : void
      {
         var _loc6_:GemSprite = null;
         var _loc7_:Gem = null;
         var _loc8_:GemSprite = null;
         var _loc2_:§_-2j§ = this.mApp.logic.board;
         var _loc3_:Vector.<Gem> = _loc2_.§_-Md§;
         if(_loc3_.length == 0)
         {
            return;
         }
         while(this.§_-1c§.length <= _loc2_.§_-F8§)
         {
            _loc6_ = new GemSprite(this.mApp);
            this.§_-6k§.addChild(_loc6_.§_-0u§);
            this.§_-Ha§.addChild(_loc6_.§_-TQ§);
            this.§_-1c§[this.§_-1c§.length] = _loc6_;
         }
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = _loc3_[_loc5_];
            (_loc8_ = this.§_-1c§[_loc7_.id]).gem = _loc7_;
            _loc5_++;
         }
      }
      
      private function §_-1Q§(param1:Gem, param2:GemSprite) : void
      {
         var _loc3_:Number = param1.x * this.§_-DE§ + 20;
         var _loc4_:Number = param1.y * this.§_-DE§ + 20;
         if(param1.§_-An§)
         {
            if(param2.§_-dS§ == 0)
            {
               param2.§_-dS§ = 80;
            }
         }
         if(param1.§_-Vx§ && this.mApp.logic.frameID > this.§_-D6§)
         {
            _loc3_ += Math.random() * 2 - 1;
            _loc4_ += Math.random() * 2 - 1;
         }
         var _loc5_:ImageInst = this.§_-O§(param1,param2);
         var _loc6_:ImageInst = this.§_-IJ§(param1,param2);
         var _loc7_:ImageInst = this.§_-7M§(param1,param2);
         param2.§_-Aw§(_loc3_,_loc4_,param1.scale,_loc5_,_loc6_,_loc7_);
         if(param2.§_-a0§ && param2.§_-TQ§.parent != this.§_-Ha§)
         {
            this.§_-Ha§.addChild(param2.§_-TQ§);
         }
         else if(!param2.§_-a0§ && param2.§_-TQ§.parent != this.§_-Ui§)
         {
            this.§_-Ui§.addChild(param2.§_-TQ§);
         }
      }
      
      private function §_-XK§(param1:FlameGemCreateEvent) : void
      {
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_GEM_FLAME_APPEAR);
         this.§_-bD§.push(new §_-Bo§(param1));
      }
      
      public function Update() : void
      {
         var _loc2_:BlitzEvent = null;
         var _loc3_:GemSprite = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<Gem> = null;
         var _loc6_:int = 0;
         var _loc8_:CoinSprite = null;
         var _loc9_:int = 0;
         var _loc10_:Gem = null;
         var _loc11_:SpriteEffect = null;
         var _loc12_:§_-Y5§ = null;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         this.§_-YO§.x = -this.mApp.§_-Ba§.game.board.x;
         this.§_-YO§.y = -this.mApp.§_-Ba§.game.board.y;
         var _loc1_:Boolean = false;
         for each(_loc2_ in this.mApp.logic.mBlockingEvents)
         {
            _loc1_ = _loc1_ || _loc2_ is HypercubeExplodeEvent;
            _loc1_ = _loc1_ || _loc2_ is StarGemExplodeEvent;
         }
         if(_loc1_)
         {
            this.§_-YO§.visible = true;
            if(this.§_-YO§.alpha < 1)
            {
               this.§_-YO§.alpha += 0.02;
            }
         }
         else if(this.§_-YO§.alpha > 0)
         {
            this.§_-YO§.alpha -= 0.02;
         }
         else
         {
            this.§_-YO§.visible = false;
         }
         for each(_loc3_ in this.§_-1c§)
         {
            _loc3_.Update();
         }
         _loc6_ = (_loc5_ = this.mApp.logic.board.mGems).length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            if((_loc10_ = _loc5_[_loc4_]) != null)
            {
               if(_loc10_.§_-iH§)
               {
                  this.§_-bD§.push(new §_-nm§(this.mApp,_loc10_));
               }
               if(_loc10_.§_-Yl§)
               {
                  _loc10_.§_-Yl§ = false;
                  this.§_-bD§.push(new §return§(this.mApp,_loc10_));
               }
            }
            _loc4_++;
         }
         var _loc7_:int = this.§_-bD§.length;
         _loc4_ = 0;
         while(_loc4_ < _loc7_)
         {
            (_loc11_ = this.§_-bD§[_loc4_]).Update();
            _loc4_++;
         }
         this.lightning.Update();
         for each(_loc8_ in this.§_-c1§)
         {
            _loc8_.Update();
         }
         _loc9_ = this.§_-nf§.length;
         _loc4_ = 0;
         while(_loc4_ < _loc9_)
         {
            (_loc12_ = this.§_-nf§[_loc4_]).Update();
            _loc4_++;
         }
         this.§_-kH§();
      }
      
      private function §_-DH§(param1:EventContext) : void
      {
         var _loc2_:CoinToken = param1.§_-fw§() as CoinToken;
         var _loc3_:CoinSprite = this.§_-c1§[_loc2_.id];
         var _loc4_:Gem = _loc2_.host;
         _loc3_.§_-7c§ = true;
         if(_loc4_ == null)
         {
            _loc3_.x = this.mApp.§_-Ba§.game.sidebar.score.x - this.mApp.§_-Ba§.game.board.x + 60;
            _loc3_.y = this.mApp.§_-Ba§.game.sidebar.score.y - this.mApp.§_-Ba§.game.board.y + 44;
         }
         else
         {
            _loc3_.x = _loc4_.x * this.§_-DE§ + (this.§_-DE§ >> 1);
            _loc3_.y = _loc4_.y * this.§_-DE§ + (this.§_-DE§ >> 1);
         }
         _loc3_.scaleX = 0.5;
         _loc3_.scaleY = 0.5;
         this.§_-q§.addChild(_loc3_);
         var _loc5_:§_-RG§;
         var _loc6_:int = (_loc5_ = this.mApp.§_-Ba§.game.sidebar.coinBank).x - this.mApp.§_-Ba§.game.board.x;
         var _loc7_:int = _loc5_.y - this.mApp.§_-Ba§.game.board.y - 50;
         var _loc8_:§_-Y5§;
         (_loc8_ = new §_-Y5§(_loc3_,_loc6_,_loc7_)).§_-AN§();
         this.§_-nf§.push(_loc8_);
      }
      
      public function Draw() : void
      {
         this.§_-XN§();
         this.§_-Hs§();
         this.§_-Ug§(false);
         this.lightning.Draw();
      }
   }
}
