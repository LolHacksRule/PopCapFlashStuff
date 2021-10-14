package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.FlameGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.FlameGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.GemShatterEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HintEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HyperGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HyperGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismHurrahExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.SpriteEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism.PhoenixPrismSprite;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzScoreKeeper;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzSpeedBonus;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.flame.IFlameGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.hypercube.IHypercubeLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.IPhoenixPrismLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.phoenixprism.PhoenixPrismHurrahExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.IStarGemLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemCreateEvent;
   import com.popcap.flash.bejeweledblitz.logic.gems.star.StarGemExplodeEvent;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GemsWidget extends Sprite implements IBlitzLogicSpawnHandler, ICoinTokenLogicHandler, IFlameGemLogicHandler, IHypercubeLogicHandler, IPhoenixPrismLogicHandler, IStarGemLogicHandler
   {
       
      
      public var mouseOver:Point;
      
      private var m_App:Blitz3App;
      
      private var m_GemImages:Vector.<ImageInst>;
      
      private var m_ShadowImages:Vector.<ImageInst>;
      
      private var m_FlameImages:Vector.<ImageInst>;
      
      private var m_StarImages:Vector.<ImageInst>;
      
      private var m_MultiImages:Vector.<ImageInst>;
      
      private var m_MultiNumberImage:ImageInst;
      
      private var m_Selector:BitmapData;
      
      private var m_HypercubeImage:ImageInst;
      
      private var m_HypercubeShadow:ImageInst;
      
      private var m_PhoenixPrismImage:PhoenixPrismSprite;
      
      private var m_PhoenixPrismShadow:ImageInst;
      
      private var m_PhoenixPrismEffect:ImageInst;
      
      private var m_MultiShadow:ImageInst;
      
      private var m_StarEffect:ImageInst;
      
      private var m_BoostButtonUp:ImageInst;
      
      private var m_BoostButtonOver:ImageInst;
      
      private var m_ScrambleEffect:ImageInst;
      
      private var m_DetonateEffect:ImageInst;
      
      private var m_BackGemLayer:Sprite;
      
      private var m_DarkLayer:Shape;
      
      private var m_FrontGemLayer:Sprite;
      
      private var m_EffectLayer:Sprite;
      
      public var starGemLayer:StarGemWidget;
      
      private var m_GemSprites:Vector.<GemSprite>;
      
      private var m_Effects:Vector.<SpriteEffect>;
      
      private var m_CoinSprites:Vector.<CoinSprite>;
      
      private var m_CoinAnims:Vector.<CoinTokenCollectAnim>;
      
      private var m_SelectSprite:Sprite;
      
      private var m_UpdateCount:int = -1;
      
      private var m_HintAvailable:Boolean = true;
      
      public function GemsWidget(app:Blitz3App)
      {
         this.mouseOver = new Point();
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         var selectBitmap:Bitmap = null;
         this.m_GemSprites = new Vector.<GemSprite>();
         this.m_Effects = new Vector.<SpriteEffect>();
         this.m_CoinSprites = new Vector.<CoinSprite>();
         this.m_CoinAnims = new Vector.<CoinTokenCollectAnim>();
         this.m_BackGemLayer = new Sprite();
         this.m_DarkLayer = new Shape();
         this.m_FrontGemLayer = new Sprite();
         this.m_EffectLayer = new Sprite();
         this.starGemLayer = new StarGemWidget(this.m_App);
         this.starGemLayer.Init();
         this.m_DarkLayer.graphics.beginFill(0,0.5);
         this.m_DarkLayer.graphics.drawRect(0,0,this.m_App.uiFactory.GetGameWidth(),this.m_App.uiFactory.GetGameHeight());
         this.m_DarkLayer.graphics.endFill();
         this.m_DarkLayer.alpha = 0;
         this.m_DarkLayer.x = -this.m_App.ui.game.board.x;
         this.m_DarkLayer.y = -this.m_App.ui.game.board.y;
         this.m_DarkLayer.visible = false;
         this.m_DarkLayer.cacheAsBitmap = true;
         addChild(this.m_BackGemLayer);
         addChild(this.m_DarkLayer);
         addChild(this.m_FrontGemLayer);
         addChild(this.m_EffectLayer);
         addChild(this.starGemLayer);
         this.m_App.logic.flameGemLogic.AddHandler(this);
         this.m_App.logic.starGemLogic.AddHandler(this);
         this.m_App.logic.hypercubeLogic.AddHandler(this);
         this.m_App.logic.phoenixPrismLogic.AddHandler(this);
         var imgMan:BaseImageManager = this.m_App.ImageManager;
         this.m_GemImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.m_ShadowImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.m_FlameImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.m_StarImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.m_MultiImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.m_GemImages[Gem.COLOR_NONE] = null;
         this.m_GemImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
         this.m_GemImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
         this.m_GemImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
         this.m_GemImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
         this.m_GemImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
         this.m_GemImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
         this.m_GemImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
         this.m_ShadowImages[Gem.COLOR_NONE] = null;
         this.m_ShadowImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_RED);
         this.m_ShadowImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_ORANGE);
         this.m_ShadowImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_YELLOW);
         this.m_ShadowImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_GREEN);
         this.m_ShadowImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_BLUE);
         this.m_ShadowImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_PURPLE);
         this.m_ShadowImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_SHADOW_WHITE);
         this.m_FlameImages[Gem.COLOR_NONE] = null;
         this.m_FlameImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_RED);
         this.m_FlameImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_ORANGE);
         this.m_FlameImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_YELLOW);
         this.m_FlameImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_GREEN);
         this.m_FlameImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_BLUE);
         this.m_FlameImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_PURPLE);
         this.m_FlameImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_FLAME_WHITE);
         this.m_StarImages[Gem.COLOR_NONE] = null;
         this.m_StarImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_RED);
         this.m_StarImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_ORANGE);
         this.m_StarImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_YELLOW);
         this.m_StarImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_GREEN);
         this.m_StarImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_BLUE);
         this.m_StarImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_PURPLE);
         this.m_StarImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_WHITE);
         this.m_MultiImages[Gem.COLOR_NONE] = null;
         this.m_MultiImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_RED);
         this.m_MultiImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_ORANGE);
         this.m_MultiImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_YELLOW);
         this.m_MultiImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_GREEN);
         this.m_MultiImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_BLUE);
         this.m_MultiImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_PURPLE);
         this.m_MultiImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_WHITE);
         this.m_MultiNumberImage = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_NUMBERS_WHITE);
         this.m_HypercubeImage = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_HYPERCUBE);
         this.m_HypercubeShadow = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_HYPERCUBE_SHADOW);
         this.m_MultiShadow = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_SHADOW);
         this.m_StarEffect = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_STAR_EFFECT);
         this.m_BoostButtonUp = imgMan.getImageInst(Blitz3GameImages.IMAGE_BOOST_BUTTON_UP);
         this.m_BoostButtonOver = imgMan.getImageInst(Blitz3GameImages.IMAGE_BOOST_BUTTON_OVER);
         this.m_ScrambleEffect = imgMan.getImageInst(Blitz3GameImages.IMAGE_SCRAMBLE_EFFECT);
         this.m_DetonateEffect = imgMan.getImageInst(Blitz3GameImages.IMAGE_DETONATE_EFFECT);
         var m_PhoenixPrismImages:Vector.<ImageInst> = new Vector.<ImageInst>(7,true);
         m_PhoenixPrismImages[0] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
         m_PhoenixPrismImages[1] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
         m_PhoenixPrismImages[2] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
         m_PhoenixPrismImages[3] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
         m_PhoenixPrismImages[4] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
         m_PhoenixPrismImages[5] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
         m_PhoenixPrismImages[6] = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
         this.m_PhoenixPrismImage = new PhoenixPrismSprite(m_PhoenixPrismImages);
         this.m_PhoenixPrismShadow = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_PHOENIXPRISM_SHADOW);
         this.m_PhoenixPrismEffect = imgMan.getImageInst(Blitz3GameImages.IMAGE_GEM_PHOENIXPRISM_EFFECT);
         this.m_Selector = imgMan.getBitmapData(Blitz3GameImages.IMAGE_SELECTOR);
         this.m_SelectSprite = new Sprite();
         selectBitmap = new Bitmap(this.m_Selector);
         selectBitmap.x = -(selectBitmap.width * 0.5);
         selectBitmap.y = -(selectBitmap.height * 0.5);
         this.m_SelectSprite.addChild(selectBitmap);
         this.m_App.logic.AddSpawnHandler(this);
         this.m_App.logic.coinTokenLogic.AddHandler(this);
      }
      
      public function Reset() : void
      {
         var sprite:GemSprite = null;
         var effect:SpriteEffect = null;
         var coinSprite:CoinSprite = null;
         this.m_UpdateCount = -1;
         this.m_DarkLayer.alpha = 0;
         for each(sprite in this.m_GemSprites)
         {
            sprite.Hide();
         }
         for each(effect in this.m_Effects)
         {
            if(effect.parent != null)
            {
               effect.parent.removeChild(effect);
            }
         }
         this.m_Effects.length = 0;
         for each(coinSprite in this.m_CoinSprites)
         {
            coinSprite.Reset();
         }
         this.m_CoinSprites.length = 0;
         this.m_CoinAnims.length = 0;
         this.m_HintAvailable = true;
         this.starGemLayer.Reset();
      }
      
      public function Update() : void
      {
         var event:IBlitzEvent = null;
         var sprite:GemSprite = null;
         var i:int = 0;
         var gems:Vector.<Gem> = null;
         var numGems:int = 0;
         var effect:SpriteEffect = null;
         var coinSprite:CoinSprite = null;
         var coinAnim:CoinTokenCollectAnim = null;
         var gem:Gem = null;
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         var isDark:Boolean = false;
         for each(event in this.m_App.logic.mBlockingEvents)
         {
            isDark = isDark || event is HypercubeExplodeEvent;
            isDark = isDark || event is StarGemExplodeEvent;
            isDark = isDark || event is PhoenixPrismExplodeEvent;
            isDark = isDark || event is PhoenixPrismHurrahExplodeEvent;
         }
         if(isDark)
         {
            this.m_DarkLayer.visible = true;
            if(this.m_DarkLayer.alpha < 1)
            {
               this.m_DarkLayer.alpha += 0.02;
            }
         }
         else if(this.m_DarkLayer.alpha > 0)
         {
            this.m_DarkLayer.alpha -= 0.02;
         }
         else
         {
            this.m_DarkLayer.visible = false;
         }
         for each(sprite in this.m_GemSprites)
         {
            sprite.Update();
         }
         gems = this.m_App.logic.board.mGems;
         numGems = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.IsShattering())
               {
                  this.m_Effects.push(new GemShatterEffect(this.m_App,gem));
               }
               if(gem.isHinted && this.m_HintAvailable)
               {
                  this.m_HintAvailable = false;
                  gem.isHinted = false;
                  this.m_Effects.push(new HintEffect(this.m_App,gem));
               }
            }
         }
         for each(effect in this.m_Effects)
         {
            effect.Update();
         }
         for each(coinSprite in this.m_CoinSprites)
         {
            coinSprite.Update();
         }
         for each(coinAnim in this.m_CoinAnims)
         {
            coinAnim.Update();
            if(coinAnim.IsDone())
            {
               this.m_CoinAnims.splice(this.m_CoinAnims.indexOf(coinAnim),1);
               coinAnim.coinSprite.parent.removeChild(coinAnim.coinSprite);
            }
         }
         this.starGemLayer.Update();
         this.UpdateSounds();
      }
      
      public function Draw() : void
      {
         this.UpdateSprites();
         this.DrawGems();
         this.DrawEffects();
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
         var sprite:GemSprite = null;
         var gem:Gem = null;
         var board:Board = this.m_App.logic.board;
         var gems:Vector.<Gem> = board.freshGems;
         if(gems.length == 0)
         {
            return;
         }
         while(this.m_GemSprites.length <= board.gemCount)
         {
            sprite = new GemSprite();
            this.m_FrontGemLayer.addChild(sprite);
            this.m_GemSprites.push(sprite);
         }
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            sprite = this.m_GemSprites[gem.id];
            sprite.gem = gem;
         }
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
      }
      
      public function HandleCoinCreated(token:CoinToken) : void
      {
         var coinSprite:CoinSprite = new CoinSprite(this.m_App,token.value);
         this.m_CoinSprites[token.id] = coinSprite;
         if(token.host != null)
         {
            this.m_GemSprites[token.host.id].addChild(coinSprite);
         }
         else if(token.isBonus && this.m_App.ui.game.phoenixPrism.AwardFeather)
         {
            this.m_App.ui.game.phoenixPrism.AwardFeather.addChild(coinSprite);
         }
      }
      
      public function HandleCoinCollected(token:CoinToken) : void
      {
         var point:Point = null;
         var coinSprite:CoinSprite = this.m_CoinSprites[token.id];
         coinSprite.isSpinning = true;
         if(coinSprite.parent == null)
         {
            point = new Point(this.m_App.ui.game.sidebar.score.x,this.m_App.ui.game.sidebar.score.y);
            point = this.m_App.globalToLocal(this.m_App.ui.game.sidebar.score.localToGlobal(point));
            coinSprite.x = point.x;
            coinSprite.y = point.y;
         }
         this.m_CoinAnims.push(this.m_App.uiFactory.GetCoinTokenCollectAnim(coinSprite));
      }
      
      public function HandleFlameGemCreated(event:FlameGemCreateEvent) : void
      {
         this.m_Effects.push(new FlameGemCreateEffect(this.m_App,event));
      }
      
      public function HandleFlameGemExploded(event:FlameGemExplodeEvent) : void
      {
         this.m_Effects.push(new FlameGemExplodeEffect(this.m_App,event.GetLocus()));
      }
      
      public function HandleHypercubeCreated(event:HypercubeCreateEvent) : void
      {
         this.m_Effects.push(new HyperGemCreateEffect(this.m_App,event));
      }
      
      public function HandleHypercubeExploded(event:HypercubeExplodeEvent) : void
      {
         this.m_Effects.push(new HyperGemExplodeEffect(this.m_App,event));
      }
      
      public function HandlePhoenixPrismCreated(event:PhoenixPrismCreateEvent) : void
      {
         this.m_Effects.push(new PhoenixPrismCreateEffect(this.m_App,event));
      }
      
      public function HandlePhoenixPrismExploded(event:PhoenixPrismExplodeEvent) : void
      {
         this.m_Effects.push(new PhoenixPrismExplodeEffect(this.m_App,event.GetLocus()));
      }
      
      public function HandlePhoenixPrismHurrahExploded(event:PhoenixPrismHurrahExplodeEvent) : void
      {
         this.m_Effects.push(new PhoenixPrismHurrahExplodeEffect(this.m_App));
      }
      
      public function HandleStarGemCreated(event:StarGemCreateEvent) : void
      {
         this.m_Effects.push(new StarGemCreateEffect(this.m_App,event));
      }
      
      public function HandleStarGemExploded(event:StarGemExplodeEvent) : void
      {
         this.m_Effects.push(new StarGemExplodeEffect(this.m_App,event.GetLocus()));
      }
      
      private function UpdateSprites() : void
      {
         var board:Board = this.m_App.logic.board;
         var gems:Vector.<Gem> = board.mGems;
         var i:int = 0;
         var gem:Gem = null;
         var sprite:GemSprite = null;
         var numGems:int = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.m_GemSprites[gem.id];
               sprite.gem = gem;
               if(sprite.parent == null)
               {
                  this.m_BackGemLayer.addChild(sprite);
               }
            }
         }
         var numSprites:int = this.m_GemSprites.length;
         for(i = 0; i < numSprites; i++)
         {
            sprite = this.m_GemSprites[i];
            gem = sprite.gem;
            if(gem == null || gem.IsDead())
            {
               if(sprite.parent != null)
               {
                  sprite.parent.removeChild(sprite);
               }
            }
         }
      }
      
      private function DrawGems() : void
      {
         var blocking:IBlitzEvent = null;
         var hyper:HypercubeExplodeEvent = null;
         var postFXGems:Vector.<Gem> = null;
         var swap:SwapData = null;
         var gem1:Gem = null;
         var gem2:Gem = null;
         var sprite1:GemSprite = null;
         var sprite2:GemSprite = null;
         this.m_SelectSprite.visible = false;
         var gems:Vector.<Gem> = this.m_App.logic.board.mGems;
         var numGems:int = gems.length;
         var gem:Gem = null;
         var sprite:GemSprite = null;
         var i:int = 0;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.m_GemSprites[gem.id];
               if(gem.IsDead())
               {
                  sprite.Hide();
               }
               else
               {
                  sprite.postFX = false;
                  sprite.Show();
                  if(gem.IsSelected())
                  {
                     this.m_SelectSprite.visible = true;
                     sprite.addChild(this.m_SelectSprite);
                  }
               }
            }
         }
         for each(blocking in this.m_App.logic.mBlockingEvents)
         {
            if(blocking is HypercubeExplodeEvent)
            {
               hyper = blocking as HypercubeExplodeEvent;
               postFXGems = hyper.GetMatchingGems();
               for each(gem in postFXGems)
               {
                  sprite = this.m_GemSprites[gem.id];
                  sprite.postFX = true;
               }
            }
         }
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.m_GemSprites[gem.id];
               this.DrawGem(gem,sprite);
            }
         }
         var numSwaps:int = this.m_App.logic.swaps.length;
         for(i = 0; i < numSwaps; i++)
         {
            swap = this.m_App.logic.swaps[i];
            if(!swap.IsDone())
            {
               gem1 = swap.moveData.sourceGem;
               gem2 = swap.moveData.swapGem;
               sprite1 = this.m_GemSprites[gem1.id];
               sprite2 = this.m_GemSprites[gem2.id];
               if(!gem2.IsDead())
               {
                  this.m_BackGemLayer.addChild(sprite2);
               }
               if(!gem1.IsDead())
               {
                  this.m_BackGemLayer.addChild(sprite1);
               }
            }
         }
      }
      
      private function DrawGem(gem:Gem, sprite:GemSprite) : void
      {
         var screenX:Number = gem.x * GemSprite.GEM_SIZE + 20;
         var screenY:Number = gem.y * GemSprite.GEM_SIZE + 20;
         if(gem.IsSelected())
         {
            if(sprite.animTime == 0)
            {
               sprite.animTime = 80;
            }
         }
         if(gem.IsElectric() && this.m_App.logic.frameID > this.m_UpdateCount)
         {
            screenX += Math.random() * 2 - 1;
            screenY += Math.random() * 2 - 1;
         }
         var shadowImg:ImageInst = this.GetShadowImage(gem,sprite);
         var mainImg:ImageInst = this.GetMainImage(gem,sprite);
         var effectImg:ImageInst = this.GetEffectImage(gem,sprite);
         sprite.SetRenderState(screenX,screenY,gem.scale,shadowImg,mainImg,effectImg);
         if(sprite.postFX && sprite.parent != this.m_FrontGemLayer)
         {
            this.m_FrontGemLayer.addChild(sprite);
         }
         else if(!sprite.postFX && sprite.parent != this.m_BackGemLayer)
         {
            this.m_BackGemLayer.addChild(sprite);
         }
      }
      
      private function GetShadowImage(gem:Gem, sprite:GemSprite) : ImageInst
      {
         var image:ImageInst = null;
         if(gem.type == Gem.TYPE_STANDARD)
         {
            image = this.m_ShadowImages[gem.color];
            image.mFrame = sprite.animTime * 0.25 % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_FLAME)
         {
            image = this.m_ShadowImages[gem.color];
            image.mFrame = 0;
         }
         else if(gem.type == Gem.TYPE_HYPERCUBE)
         {
            image = this.m_HypercubeShadow;
            image.mFrame = int(gem.lifetime * 0.01 * (70 * 0.333)) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_PHOENIXPRISM)
         {
            image = this.m_PhoenixPrismShadow;
            image.mFrame = int(gem.lifetime * 0.01 * (70 * 0.333)) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.m_ShadowImages[gem.color];
            image.mFrame = 0;
         }
         else if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.m_MultiShadow;
            image.mFrame = 0;
         }
         else if(gem.type == Gem.TYPE_DETONATE)
         {
            image = null;
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            image = null;
         }
         return image;
      }
      
      private function GetMainImage(gem:Gem, sprite:GemSprite) : ImageInst
      {
         var image:ImageInst = null;
         if(gem.type == Gem.TYPE_STANDARD)
         {
            image = this.m_GemImages[gem.color];
            image.mFrame = sprite.animTime * 0.25 % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_FLAME)
         {
            image = this.m_FlameImages[gem.color];
            image.mFrame = int(gem.lifetime * 0.01 * 26) % image.mSource.mNumFrames;
            image.y = -6;
         }
         else if(gem.type == Gem.TYPE_HYPERCUBE)
         {
            image = this.m_HypercubeImage;
            image.mFrame = int(gem.lifetime * 0.01 * (70 * 0.333)) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_PHOENIXPRISM)
         {
            image = this.m_PhoenixPrismImage.GetImageInst(sprite,this.m_UpdateCount);
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.m_StarImages[gem.color];
            image.mFrame = int(gem.lifetime * 0.01 * 30) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.m_MultiImages[gem.color];
            image.mFrame = int(gem.lifetime * 0.01 * 30) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_DETONATE)
         {
            image = this.m_BoostButtonUp;
            if(gem.row == this.mouseOver.y && gem.col == this.mouseOver.x && this.m_App.logic.timerLogic.GetTimeRemaining() > 0)
            {
               image = this.m_BoostButtonOver;
            }
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            image = this.m_BoostButtonUp;
            if(gem.row == this.mouseOver.y && gem.col == this.mouseOver.x && this.m_App.logic.timerLogic.GetTimeRemaining() > 0)
            {
               image = this.m_BoostButtonOver;
            }
         }
         return image;
      }
      
      private function GetEffectImage(gem:Gem, sprite:GemSprite) : ImageInst
      {
         if(gem.IsMatched() && !gem.IsElectric())
         {
            return null;
         }
         var image:ImageInst = null;
         if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.m_MultiNumberImage;
            image.mFrame = gem.multiValue - 2;
         }
         else if(gem.type == Gem.TYPE_PHOENIXPRISM)
         {
            image = this.m_PhoenixPrismEffect;
            image.mFrame = int(gem.lifetime * 0.01 * 15) % image.mSource.mNumFrames;
            image.mIsAdditive = true;
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.m_StarEffect;
            image.mFrame = int(gem.lifetime * 0.01 * 15) % image.mSource.mNumFrames;
            image.mIsAdditive = true;
         }
         else if(gem.type == Gem.TYPE_DETONATE)
         {
            image = this.m_DetonateEffect;
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            image = this.m_ScrambleEffect;
         }
         return image;
      }
      
      private function DrawEffects() : void
      {
         var effect:SpriteEffect = null;
         var allDone:Boolean = true;
         var numEffects:int = this.m_Effects.length;
         for(var i:int = 0; i < numEffects; i++)
         {
            effect = this.m_Effects[i];
            if(effect.parent == null)
            {
               this.m_EffectLayer.addChild(effect);
            }
            if(!effect.IsDone())
            {
               allDone = false;
            }
            else
            {
               if(effect is HintEffect)
               {
                  this.m_HintAvailable = true;
               }
               if(effect.parent != null)
               {
                  this.m_EffectLayer.removeChild(effect);
               }
            }
            effect.Draw();
         }
         if(allDone)
         {
            this.m_Effects.length = 0;
         }
      }
      
      private function UpdateSounds() : void
      {
         var speedBonus:BlitzSpeedBonus = null;
         if(this.m_UpdateCount == this.m_App.logic.frameID)
         {
            return;
         }
         this.m_UpdateCount = this.m_App.logic.frameID;
         if(this.m_App.logic.gemsHit)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_HIT);
         }
         if(this.m_App.logic.badMove)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_BAD_MOVE);
         }
         if(this.m_App.logic.startedMove)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_START_MOVE);
         }
         if(this.m_App.logic.multiLogic.spawned)
         {
            this.m_App.logic.multiLogic.spawned = false;
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_MULTI_APPEAR);
         }
         var scoreKeeper:BlitzScoreKeeper = this.m_App.logic.scoreKeeper;
         if(scoreKeeper.matchesMade > 0)
         {
            if(scoreKeeper.bestCascade == 2)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_1);
            }
            else if(scoreKeeper.bestCascade == 3)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_2);
            }
            else if(scoreKeeper.bestCascade == 4)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_3);
            }
            else if(scoreKeeper.bestCascade == 5)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_4);
            }
            else if(scoreKeeper.bestCascade >= 6)
            {
               this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_5);
            }
            else
            {
               speedBonus = this.m_App.logic.speedBonus;
               if(speedBonus.GetLevel() == 0)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_MATCH_ONE);
               }
               else if(speedBonus.GetLevel() == 1)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_1);
               }
               else if(speedBonus.GetLevel() == 2)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_2);
               }
               else if(speedBonus.GetLevel() == 3)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_3);
               }
               else if(speedBonus.GetLevel() == 4)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_4);
               }
               else if(speedBonus.GetLevel() == 5)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_5);
               }
               else if(speedBonus.GetLevel() == 6)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_6);
               }
               else if(speedBonus.GetLevel() == 7)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_7);
               }
               else if(speedBonus.GetLevel() == 8)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_8);
               }
               else if(speedBonus.GetLevel() == 9 || speedBonus.GetLevel() == 10)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_9);
               }
               else if(speedBonus.GetLevel() >= 11)
               {
                  this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_FLAME_SPEED_1);
               }
            }
         }
      }
   }
}
