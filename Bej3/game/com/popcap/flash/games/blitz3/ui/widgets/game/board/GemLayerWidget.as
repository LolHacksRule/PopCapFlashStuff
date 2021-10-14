package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.framework.events.EventBus;
   import com.popcap.flash.framework.events.EventContext;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.SwapData;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.bej3.blitz.BlitzScoreKeeper;
   import com.popcap.flash.games.bej3.blitz.BlitzSpeedBonus;
   import com.popcap.flash.games.bej3.gems.flame.FlameGemCreateEvent;
   import com.popcap.flash.games.bej3.gems.flame.FlameGemExplodeEvent;
   import com.popcap.flash.games.bej3.gems.hypercube.HypercubeCreateEvent;
   import com.popcap.flash.games.bej3.gems.hypercube.HypercubeExplodeEvent;
   import com.popcap.flash.games.bej3.gems.star.StarGemCreateEvent;
   import com.popcap.flash.games.bej3.gems.star.StarGemExplodeEvent;
   import com.popcap.flash.games.bej3.tokens.CoinToken;
   import com.popcap.flash.games.bej3.tokens.CoinTokenCollectedEvent;
   import com.popcap.flash.games.bej3.tokens.CoinTokenSpawnedEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.Blitz3UI;
   import com.popcap.flash.games.blitz3.ui.sprites.CoinSprite;
   import com.popcap.flash.games.blitz3.ui.sprites.GemSprite;
   import com.popcap.flash.games.blitz3.ui.widgets.anims.CoinTokenCollectAnim;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.FlameGemCreateEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.FlameGemExplodeEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.GemShatterEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.HintEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.HyperGemCreateEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.HyperGemExplodeEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.SpriteEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.StarGemCreateEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.effects.StarGemExplodeEffect;
   import com.popcap.flash.games.blitz3.ui.widgets.game.sidebar.CoinBankWidget;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class GemLayerWidget extends Sprite
   {
       
      
      public var GEM_SIZE:int = 40;
      
      public var fade:Sprite;
      
      public var lightning:LightningLayerWidget;
      
      public var mouseOver:Point;
      
      private var mApp:Blitz3UI;
      
      private var mIsInited:Boolean = false;
      
      private var mGemImages:Vector.<ImageInst>;
      
      private var mShadowImages:Vector.<ImageInst>;
      
      private var mFlameImages:Vector.<ImageInst>;
      
      private var mStarImages:Vector.<ImageInst>;
      
      private var mMultiImages:Vector.<ImageInst>;
      
      private var mMultiNumberImages:Vector.<ImageInst>;
      
      private var mSelector:ImageInst;
      
      private var mRainbowImage:ImageInst;
      
      private var mRainbowShadow:ImageInst;
      
      private var mMultiShadow:ImageInst;
      
      private var mStarEffect:ImageInst;
      
      private var mBoostButtonUp:ImageInst;
      
      private var mBoostButtonOver:ImageInst;
      
      private var mScrambleEffect:ImageInst;
      
      private var mDetonateEffect:ImageInst;
      
      private var mShadowLayer:Sprite;
      
      private var mBackGemLayer:Sprite;
      
      private var mDarkLayer:Sprite;
      
      private var mFrontGemLayer:Sprite;
      
      private var mEffectLayer:Sprite;
      
      private var mParticleLayer:Sprite;
      
      private var mScoreLayer:Sprite;
      
      private var mGemId:int = 0;
      
      private var mGemSprites:Vector.<GemSprite>;
      
      private var mCoinSprites:Vector.<CoinSprite>;
      
      private var mSelectSprite:Sprite;
      
      private var mCoinAnims:Array;
      
      private var mEffects:Vector.<SpriteEffect>;
      
      private var mUpdateCount:int = -1;
      
      public function GemLayerWidget(app:Blitz3UI)
      {
         this.mouseOver = new Point();
         this.mCoinAnims = [];
         super();
         this.mApp = app;
         this.lightning = new LightningLayerWidget(app);
      }
      
      public function Init() : void
      {
         this.mEffects = new Vector.<SpriteEffect>();
         this.mShadowLayer = new Sprite();
         this.mBackGemLayer = new Sprite();
         this.mDarkLayer = new Sprite();
         this.mFrontGemLayer = new Sprite();
         this.mEffectLayer = new Sprite();
         this.mParticleLayer = new Sprite();
         this.mScoreLayer = new Sprite();
         this.mDarkLayer.graphics.beginFill(0,0.5);
         this.mDarkLayer.graphics.drawRect(0,0,Blitz3App.SCREEN_WIDTH,Blitz3App.SCREEN_HEIGHT);
         this.mDarkLayer.graphics.endFill();
         this.mDarkLayer.alpha = 0;
         this.mDarkLayer.visible = false;
         addChild(this.mShadowLayer);
         addChild(this.mBackGemLayer);
         addChild(this.mDarkLayer);
         addChild(this.mFrontGemLayer);
         addChild(this.mEffectLayer);
         addChild(this.mParticleLayer);
         addChild(this.mScoreLayer);
         this.mApp.logic.flameGemLogic.addEventListener(FlameGemCreateEvent.ID,this.HandleFlameGemCreateEvent);
         this.mApp.logic.flameGemLogic.addEventListener(FlameGemExplodeEvent.ID,this.HandleFlameGemExplodeEvent);
         this.mApp.logic.starGemLogic.addEventListener(StarGemCreateEvent.ID,this.HandleStarGemCreateEvent);
         this.mApp.logic.starGemLogic.addEventListener(StarGemExplodeEvent.ID,this.HandleStarGemExplodeEvent);
         this.mApp.logic.hypercubeLogic.addEventListener(HypercubeCreateEvent.ID,this.HandleHypercubeCreateEvent);
         this.mApp.logic.hypercubeLogic.addEventListener(HypercubeExplodeEvent.ID,this.HandleHypercubeExplodeEvent);
         var imgMan:ImageManager = this.mApp.imageManager;
         this.mGemImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mShadowImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mFlameImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mStarImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mMultiImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mMultiNumberImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this.mGemImages[Gem.COLOR_NONE] = null;
         this.mGemImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_RED);
         this.mGemImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_ORANGE);
         this.mGemImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_YELLOW);
         this.mGemImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_GREEN);
         this.mGemImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_BLUE);
         this.mGemImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_PURPLE);
         this.mGemImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_WHITE);
         this.mShadowImages[Gem.COLOR_NONE] = null;
         this.mShadowImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_RED);
         this.mShadowImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_ORANGE);
         this.mShadowImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_YELLOW);
         this.mShadowImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_GREEN);
         this.mShadowImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_BLUE);
         this.mShadowImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_PURPLE);
         this.mShadowImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_SHADOW_WHITE);
         this.mFlameImages[Gem.COLOR_NONE] = null;
         this.mFlameImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_RED);
         this.mFlameImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_ORANGE);
         this.mFlameImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_YELLOW);
         this.mFlameImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_GREEN);
         this.mFlameImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_BLUE);
         this.mFlameImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_PURPLE);
         this.mFlameImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_FLAME_WHITE);
         this.mStarImages[Gem.COLOR_NONE] = null;
         this.mStarImages[Gem.COLOR_RED] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_RED);
         this.mStarImages[Gem.COLOR_ORANGE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_ORANGE);
         this.mStarImages[Gem.COLOR_YELLOW] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_YELLOW);
         this.mStarImages[Gem.COLOR_GREEN] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_GREEN);
         this.mStarImages[Gem.COLOR_BLUE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_BLUE);
         this.mStarImages[Gem.COLOR_PURPLE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_PURPLE);
         this.mStarImages[Gem.COLOR_WHITE] = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_WHITE);
         this.mSelector = imgMan.getImageInst(Blitz3Images.IMAGE_SELECTOR);
         this.mRainbowImage = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_RAINBOW);
         this.mRainbowShadow = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_RAINBOW_SHADOW);
         this.mMultiShadow = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_MULTI_SHADOW);
         this.mStarEffect = imgMan.getImageInst(Blitz3Images.IMAGE_GEM_STAR_EFFECT);
         this.mGemSprites = new Vector.<GemSprite>();
         this.mCoinSprites = new Vector.<CoinSprite>();
         this.mSelectSprite = new Sprite();
         var selectBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_SELECTOR));
         selectBitmap.x = -(selectBitmap.width / 2);
         selectBitmap.y = -(selectBitmap.height / 2);
         this.mSelectSprite.addChild(selectBitmap);
         this.lightning.Init();
         addChild(this.lightning);
         var eventBus:EventBus = EventBus.GetGlobal();
         eventBus.OnEvent("SpawnEndEvent",this.HandleSpawnPhaseEndEvent,10);
         eventBus.OnEvent(CoinTokenSpawnedEvent.ID,this.HandleCoinTokenSpawnedEvent);
         eventBus.OnEvent(CoinTokenCollectedEvent.ID,this.HandleCoinTokenCollectedEvent);
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
         var sprite:GemSprite = null;
         var effect:SpriteEffect = null;
         var coinSprite:CoinSprite = null;
         this.mGemId = 0;
         this.mUpdateCount = -1;
         this.mDarkLayer.alpha = 0;
         for each(sprite in this.mGemSprites)
         {
            sprite.Hide();
         }
         for each(effect in this.mEffects)
         {
            if(effect.parent != null)
            {
               effect.parent.removeChild(effect);
            }
         }
         for each(coinSprite in this.mCoinSprites)
         {
            coinSprite.Reset();
         }
         this.mCoinSprites.length = 0;
         this.mCoinAnims.length = 0;
         this.mEffects.length = 0;
         this.lightning.Reset();
      }
      
      public function Update() : void
      {
         var event:BlitzEvent = null;
         var sprite:GemSprite = null;
         var i:int = 0;
         var gems:Vector.<Gem> = null;
         var numGems:int = 0;
         var coinSprite:CoinSprite = null;
         var numCoinAnims:int = 0;
         var gem:Gem = null;
         var effect:SpriteEffect = null;
         var anim:CoinTokenCollectAnim = null;
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         this.mDarkLayer.x = -this.mApp.ui.game.board.x;
         this.mDarkLayer.y = -this.mApp.ui.game.board.y;
         var isDark:Boolean = false;
         for each(event in this.mApp.logic.mBlockingEvents)
         {
            isDark = isDark || event is HypercubeExplodeEvent;
            isDark = isDark || event is StarGemExplodeEvent;
         }
         if(isDark)
         {
            this.mDarkLayer.visible = true;
            if(this.mDarkLayer.alpha < 1)
            {
               this.mDarkLayer.alpha += 0.02;
            }
         }
         else if(this.mDarkLayer.alpha > 0)
         {
            this.mDarkLayer.alpha -= 0.02;
         }
         else
         {
            this.mDarkLayer.visible = false;
         }
         for each(sprite in this.mGemSprites)
         {
            sprite.Update();
         }
         gems = this.mApp.logic.board.mGems;
         numGems = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               if(gem.isShattering)
               {
                  this.mEffects.push(new GemShatterEffect(this.mApp,gem));
               }
               if(gem.mIsHinted)
               {
                  gem.mIsHinted = false;
                  this.mEffects.push(new HintEffect(this.mApp,gem));
               }
            }
         }
         var numEffects:int = this.mEffects.length;
         for(i = 0; i < numEffects; i++)
         {
            effect = this.mEffects[i];
            effect.Update();
         }
         this.lightning.Update();
         for each(coinSprite in this.mCoinSprites)
         {
            coinSprite.Update();
         }
         numCoinAnims = this.mCoinAnims.length;
         for(i = 0; i < numCoinAnims; i++)
         {
            anim = this.mCoinAnims[i];
            anim.Update();
         }
         this.UpdateSounds();
      }
      
      public function Draw() : void
      {
         this.UpdateSprites();
         this.DrawGems();
         this.DrawEffects(false);
         this.lightning.Draw();
      }
      
      private function UpdateSprites() : void
      {
         var board:Board = this.mApp.logic.board;
         var gems:Vector.<Gem> = board.mGems;
         var i:int = 0;
         var gem:Gem = null;
         var sprite:GemSprite = null;
         while(this.mGemSprites.length <= board.gemCount)
         {
            sprite = new GemSprite(this.mApp);
            sprite.gem = board.GetGem(this.mGemSprites.length);
            this.mShadowLayer.addChild(sprite.shadow);
            this.mFrontGemLayer.addChild(sprite.main);
            this.mGemSprites[this.mGemSprites.length] = sprite;
         }
         var numGems:int = gems.length;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.mGemSprites[gem.id];
               sprite.gem = gem;
               if(sprite.shadow.parent == null)
               {
                  this.mShadowLayer.addChild(sprite.shadow);
               }
               if(sprite.main.parent == null)
               {
                  this.mBackGemLayer.addChild(sprite.main);
               }
            }
         }
         var numSprites:int = this.mGemSprites.length;
         for(i = 0; i < numSprites; i++)
         {
            sprite = this.mGemSprites[i];
            gem = sprite.gem;
            if(gem == null || gem.isDead)
            {
               if(sprite.shadow.parent != null)
               {
                  sprite.shadow.parent.removeChild(sprite.shadow);
               }
               if(sprite.main.parent != null)
               {
                  sprite.main.parent.removeChild(sprite.main);
               }
            }
         }
      }
      
      private function DrawGems() : void
      {
         var blocking:BlitzEvent = null;
         var hyper:HypercubeExplodeEvent = null;
         var postFXGems:Vector.<Gem> = null;
         var g:Gem = null;
         var spr:GemSprite = null;
         var swap:SwapData = null;
         var gem1:Gem = null;
         var gem2:Gem = null;
         var sprite1:GemSprite = null;
         var sprite2:GemSprite = null;
         var gems:Vector.<Gem> = this.mApp.logic.board.mGems;
         var numGems:int = gems.length;
         var gem:Gem = null;
         var sprite:GemSprite = null;
         var i:int = 0;
         this.mSelectSprite.visible = false;
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.mGemSprites[gem.id];
               if(gem.isDead)
               {
                  sprite.Hide();
               }
               else
               {
                  sprite.postFX = false;
                  sprite.Show();
                  if(gem.isSelected)
                  {
                     this.mSelectSprite.visible = true;
                     sprite.main.addChild(this.mSelectSprite);
                  }
               }
            }
         }
         for each(blocking in this.mApp.logic.mBlockingEvents)
         {
            if(blocking is HypercubeExplodeEvent)
            {
               hyper = blocking as HypercubeExplodeEvent;
               postFXGems = hyper.GetMatchingGems();
               for each(g in postFXGems)
               {
                  spr = this.mGemSprites[g.id];
                  spr.postFX = true;
               }
            }
         }
         for(i = 0; i < numGems; i++)
         {
            gem = gems[i];
            if(gem != null)
            {
               sprite = this.mGemSprites[gem.id];
               this.DrawGem(gem,sprite);
            }
         }
         var numSwaps:int = this.mApp.logic.swaps.length;
         for(i = 0; i < numSwaps; i++)
         {
            swap = this.mApp.logic.swaps[i];
            if(!swap.isDone())
            {
               gem1 = swap.moveData.sourceGem;
               gem2 = swap.moveData.swapGem;
               sprite1 = this.mGemSprites[gem1.id];
               sprite2 = this.mGemSprites[gem2.id];
               if(!gem2.isDead)
               {
                  this.mBackGemLayer.addChild(sprite2.main);
               }
               if(!gem1.isDead)
               {
                  this.mBackGemLayer.addChild(sprite1.main);
               }
            }
         }
      }
      
      private function DrawGem(gem:Gem, sprite:GemSprite) : void
      {
         var screenX:Number = gem.x * this.GEM_SIZE + 20;
         var screenY:Number = gem.y * this.GEM_SIZE + 20;
         if(gem.isSelected)
         {
            if(sprite.animTime == 0)
            {
               sprite.animTime = 80;
            }
         }
         if(gem.isElectric && this.mApp.logic.frameID > this.mUpdateCount)
         {
            screenX += Math.random() * 2 - 1;
            screenY += Math.random() * 2 - 1;
         }
         var shadowImg:ImageInst = this.GetShadowImage(gem,sprite);
         var mainImg:ImageInst = this.GetMainImage(gem,sprite);
         var effectImg:ImageInst = this.GetEffectImage(gem,sprite);
         sprite.SetRenderState(screenX,screenY,gem.scale,shadowImg,mainImg,effectImg);
         if(sprite.postFX && sprite.main.parent != this.mFrontGemLayer)
         {
            this.mFrontGemLayer.addChild(sprite.main);
         }
         else if(!sprite.postFX && sprite.main.parent != this.mBackGemLayer)
         {
            this.mBackGemLayer.addChild(sprite.main);
         }
      }
      
      private function GetShadowImage(gem:Gem, sprite:GemSprite) : ImageInst
      {
         var image:ImageInst = null;
         if(gem.type == Gem.TYPE_STANDARD)
         {
            image = this.mShadowImages[gem.color];
            image.mFrame = sprite.animTime / 4 % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_FLAME)
         {
            image = this.mShadowImages[gem.color];
            image.mFrame = 0;
         }
         else if(gem.type == Gem.TYPE_RAINBOW)
         {
            image = this.mRainbowShadow;
            image.mFrame = int(gem.lifetime / 100 * (70 / 3)) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.mShadowImages[gem.color];
            image.mFrame = 0;
         }
         else if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.mMultiShadow;
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
            image = this.mGemImages[gem.color];
            image.mFrame = sprite.animTime / 4 % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_FLAME)
         {
            image = this.mFlameImages[gem.color];
            image.mFrame = int(gem.lifetime / 100 * 26) % image.mSource.mNumFrames;
            image.y = -6;
         }
         else if(gem.type == Gem.TYPE_RAINBOW)
         {
            image = this.mRainbowImage;
            image.mFrame = int(gem.lifetime / 100 * (70 / 3)) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.mStarImages[gem.color];
            image.mFrame = int(gem.lifetime / 100 * 30) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.mMultiImages[gem.color];
            image.mFrame = int(gem.lifetime / 100 * 30) % image.mSource.mNumFrames;
         }
         else if(gem.type == Gem.TYPE_DETONATE)
         {
            image = this.mBoostButtonUp;
            if(gem.row == this.mouseOver.y && gem.col == this.mouseOver.x && this.mApp.logic.timerLogic.GetTimeRemaining() > 0)
            {
               image = this.mBoostButtonOver;
            }
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            image = this.mBoostButtonUp;
            if(gem.row == this.mouseOver.y && gem.col == this.mouseOver.x && this.mApp.logic.timerLogic.GetTimeRemaining() > 0)
            {
               image = this.mBoostButtonOver;
            }
         }
         return image;
      }
      
      private function GetEffectImage(gem:Gem, sprite:GemSprite) : ImageInst
      {
         if(gem.isMatched)
         {
            return null;
         }
         var image:ImageInst = null;
         if(gem.type == Gem.TYPE_MULTI)
         {
            image = this.mMultiNumberImages[Gem.COLOR_WHITE];
            image.mFrame = gem.multiValue - 2;
         }
         else if(gem.type == Gem.TYPE_STAR)
         {
            image = this.mStarEffect;
            image.mFrame = int(gem.lifetime / 100 * 15) % image.mSource.mNumFrames;
            image.mIsAdditive = true;
         }
         else if(gem.type == Gem.TYPE_DETONATE)
         {
            image = this.mDetonateEffect;
         }
         else if(gem.type == Gem.TYPE_SCRAMBLE)
         {
            image = this.mScrambleEffect;
         }
         return image;
      }
      
      private function DrawEffects(postFX:Boolean) : void
      {
         var effect:SpriteEffect = null;
         var allDone:Boolean = true;
         var numEffects:int = this.mEffects.length;
         for(var i:int = 0; i < numEffects; i++)
         {
            effect = this.mEffects[i];
            if(effect.parent == null)
            {
               this.mEffectLayer.addChild(effect);
            }
            if(!effect.IsDone())
            {
               allDone = false;
            }
            else if(effect.parent != null)
            {
               this.mEffectLayer.removeChild(effect);
            }
            effect.Draw(postFX);
         }
         if(allDone)
         {
            this.mEffects.length = 0;
         }
      }
      
      private function UpdateSounds() : void
      {
         var speedBonus:BlitzSpeedBonus = null;
         if(this.mUpdateCount == this.mApp.logic.frameID)
         {
            return;
         }
         this.mUpdateCount = this.mApp.logic.frameID;
         if(this.mApp.logic.gemsHit)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_HIT);
         }
         if(this.mApp.logic.badMove)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BAD_MOVE);
         }
         if(this.mApp.logic.startedMove)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_START_MOVE);
         }
         if(this.mApp.logic.multiLogic.spawned)
         {
            this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_MULTI_APPEAR);
         }
         var scoreKeeper:BlitzScoreKeeper = this.mApp.logic.scoreKeeper;
         if(scoreKeeper.matchesMade > 0)
         {
            if(scoreKeeper.bestCascade == 2)
            {
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COMBO_1);
            }
            else if(scoreKeeper.bestCascade == 3)
            {
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COMBO_2);
            }
            else if(scoreKeeper.bestCascade == 4)
            {
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COMBO_3);
            }
            else if(scoreKeeper.bestCascade == 5)
            {
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COMBO_4);
            }
            else if(scoreKeeper.bestCascade >= 6)
            {
               this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_COMBO_5);
            }
            else
            {
               speedBonus = this.mApp.logic.speedBonus;
               if(speedBonus.GetLevel() == 0)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_MATCH_ONE);
               }
               else if(speedBonus.GetLevel() == 1)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_1);
               }
               else if(speedBonus.GetLevel() == 2)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_2);
               }
               else if(speedBonus.GetLevel() == 3)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_3);
               }
               else if(speedBonus.GetLevel() == 4)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_4);
               }
               else if(speedBonus.GetLevel() == 5)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_5);
               }
               else if(speedBonus.GetLevel() == 6)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_6);
               }
               else if(speedBonus.GetLevel() == 7)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_7);
               }
               else if(speedBonus.GetLevel() == 8)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_8);
               }
               else if(speedBonus.GetLevel() == 9 || speedBonus.GetLevel() == 10)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_SPEED_MATCH_9);
               }
               else if(speedBonus.GetLevel() >= 11)
               {
                  this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_FLAME_SPEED_1);
               }
            }
         }
      }
      
      private function HandleFlameGemCreateEvent(e:FlameGemCreateEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_FLAME_APPEAR);
         this.mEffects.push(new FlameGemCreateEffect(e));
      }
      
      private function HandleFlameGemExplodeEvent(e:FlameGemExplodeEvent) : void
      {
         this.mEffects.push(new FlameGemExplodeEffect(this.mApp,e.locus));
      }
      
      private function HandleStarGemCreateEvent(e:StarGemCreateEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_STAR_APPEAR);
         this.mEffects.push(new StarGemCreateEffect(e));
      }
      
      private function HandleStarGemExplodeEvent(e:StarGemExplodeEvent) : void
      {
         this.mEffects.push(new StarGemExplodeEffect(this.mApp,e.locus));
      }
      
      private function HandleHypercubeCreateEvent(e:HypercubeCreateEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_GEM_RAINBOW_APPEAR);
         this.mEffects.push(new HyperGemCreateEffect(e));
      }
      
      private function HandleHypercubeExplodeEvent(e:HypercubeExplodeEvent) : void
      {
         this.mEffects.push(new HyperGemExplodeEffect(this.mApp,e,x,y));
      }
      
      private function HandleSpawnPhaseEndEvent(ctx:EventContext) : void
      {
         var newSprite:GemSprite = null;
         var gem:Gem = null;
         var sprite:GemSprite = null;
         var board:Board = this.mApp.logic.board;
         var gems:Vector.<Gem> = board.freshGems;
         if(gems.length == 0)
         {
            return;
         }
         while(this.mGemSprites.length <= board.gemCount)
         {
            newSprite = new GemSprite(this.mApp);
            this.mShadowLayer.addChild(newSprite.shadow);
            this.mFrontGemLayer.addChild(newSprite.main);
            this.mGemSprites[this.mGemSprites.length] = newSprite;
         }
         var numGems:int = gems.length;
         for(var i:int = 0; i < numGems; i++)
         {
            gem = gems[i];
            sprite = this.mGemSprites[gem.id];
            sprite.gem = gem;
         }
      }
      
      private function HandleCoinTokenSpawnedEvent(ctx:EventContext) : void
      {
         var sprite:GemSprite = null;
         var coin:CoinToken = ctx.GetData() as CoinToken;
         var coinSprite:CoinSprite = new CoinSprite();
         this.mCoinSprites[coin.id] = coinSprite;
         var gem:Gem = coin.host;
         if(gem != null)
         {
            sprite = this.mGemSprites[gem.id];
            sprite.main.addChild(coinSprite);
         }
      }
      
      private function HandleCoinTokenCollectedEvent(ctx:EventContext) : void
      {
         var coin:CoinToken = ctx.GetData() as CoinToken;
         var coinSprite:CoinSprite = this.mCoinSprites[coin.id];
         var gem:Gem = coin.host;
         coinSprite.isSpinning = true;
         if(gem == null)
         {
            coinSprite.x = this.mApp.ui.game.sidebar.score.x - this.mApp.ui.game.board.x + 60;
            coinSprite.y = this.mApp.ui.game.sidebar.score.y - this.mApp.ui.game.board.y + 44;
         }
         else
         {
            coinSprite.x = gem.x * this.GEM_SIZE + (this.GEM_SIZE >> 1);
            coinSprite.y = gem.y * this.GEM_SIZE + (this.GEM_SIZE >> 1);
         }
         coinSprite.scaleX = 0.5;
         coinSprite.scaleY = 0.5;
         this.mParticleLayer.addChild(coinSprite);
         var coinBank:CoinBankWidget = this.mApp.ui.game.sidebar.coinBank;
         var rect:Rectangle = coinBank.getRect(coinBank);
         var x:int = coinBank.x + rect.width * 0.5 - this.mApp.ui.game.board.x;
         var y:int = coinBank.y + rect.height * 0.5 - this.mApp.ui.game.board.y - 50;
         var anim:CoinTokenCollectAnim = new CoinTokenCollectAnim(coinSprite,x,y);
         anim.Start();
         this.mCoinAnims.push(anim);
      }
   }
}
