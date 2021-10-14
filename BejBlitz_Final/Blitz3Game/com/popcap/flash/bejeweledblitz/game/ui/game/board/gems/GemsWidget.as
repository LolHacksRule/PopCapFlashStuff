package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems
{
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.coins.CoinTokenCollectAnim;
   import com.popcap.flash.bejeweledblitz.game.ui.currency.CurrencyAnimToken;
   import com.popcap.flash.bejeweledblitz.game.ui.currency.ICurrencyTrailAnimHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.ClockWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.DynamicExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.FlameGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.FlameGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.FlameSteedGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.GemShatterEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HintEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HyperGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.HyperGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.KpowEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.PhoenixPrismHurrahExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.SpriteEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemCreateEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemExplodeEffect;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects.StarGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.RareGemTokenSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token.TokenSpriteBehavior;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.token.TokenSpriteBehaviorFactory;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzScoreKeeper;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzSpeedBonus;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzEvent;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicSpawnHandler;
   import com.popcap.flash.bejeweledblitz.logic.gems.colorchanger.ColorChangerEvent;
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
   import com.popcap.flash.bejeweledblitz.logic.raregems.BlazingSteedRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RareGemsLogic;
   import com.popcap.flash.bejeweledblitz.logic.tokens.CoinToken;
   import com.popcap.flash.bejeweledblitz.logic.tokens.ICoinTokenLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.tokens.IRareGemTokenLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.tokens.RareGemToken;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GemsWidget extends Sprite implements ICurrencyTrailAnimHandler, IBlitzLogicSpawnHandler, ICoinTokenLogicHandler, IFlameGemLogicHandler, IHypercubeLogicHandler, IPhoenixPrismLogicHandler, IStarGemLogicHandler, IRareGemTokenLogicHandler
   {
      
      private static const _GEM_ANIMATION_TICKS:int = 80;
      
      private static const _GEM_ANIMATION_RATE:int = 4;
       
      
      private var _app:Blitz3App;
      
      private var _tokenSpriteBehaviorFactory:TokenSpriteBehaviorFactory;
      
      private var _gemImages:Vector.<ImageInst>;
      
      private var _multiImages:Vector.<ImageInst>;
      
      private var _multiShadow:ImageInst;
      
      private var _hypercubeImage:ImageInst;
      
      private var _boostButtonUp:ImageInst;
      
      private var _boostButtonOver:ImageInst;
      
      private var _scrambleEffect:ImageInst;
      
      private var _detonateEffect:ImageInst;
      
      private var _backGemLayer:Sprite;
      
      private var _darkLayer:Shape;
      
      private var _frontGemLayer:Sprite;
      
      private var _effectLayer:Sprite;
      
      public var _gemSprites:Vector.<GemSprite>;
      
      private var _effects:Vector.<SpriteEffect>;
      
      private var _coinSprites:Vector.<CoinSprite>;
      
      private var _currencySprites:Vector.<CoinSprite>;
      
      private var _selectSprite:Sprite;
      
      private var _selector:BitmapData;
      
      private var _updateCount:int = -1;
      
      private var _hintAvailable:Boolean = true;
      
      private var _animationTimer:int = 0;
      
      private var _rgTokenSprites:Vector.<RareGemTokenSprite>;
      
      private var _coinAnims:Vector.<CoinTokenCollectAnim>;
      
      private var _currencyAnims:Vector.<CoinTokenCollectAnim>;
      
      public var mouseOver:Point;
      
      public var starGemLayer:StarGemWidget;
      
      public function GemsWidget(param1:Blitz3App, param2:TokenSpriteBehaviorFactory)
      {
         this.mouseOver = new Point();
         super();
         this._app = param1;
         this._tokenSpriteBehaviorFactory = param2;
      }
      
      public function Init() : void
      {
         var _loc2_:Bitmap = null;
         this._gemSprites = new Vector.<GemSprite>();
         this._effects = new Vector.<SpriteEffect>();
         this._coinSprites = new Vector.<CoinSprite>();
         this._coinAnims = new Vector.<CoinTokenCollectAnim>();
         this._currencySprites = new Vector.<CoinSprite>();
         this._currencyAnims = new Vector.<CoinTokenCollectAnim>();
         this._rgTokenSprites = new Vector.<RareGemTokenSprite>();
         this._backGemLayer = new Sprite();
         this._effectLayer = new Sprite();
         this.starGemLayer = new StarGemWidget(this._app);
         this.starGemLayer.Init();
         addChild(this._backGemLayer);
         if(!this._app.isLQMode)
         {
            this._darkLayer = new Shape();
            this._frontGemLayer = new Sprite();
            this._darkLayer.graphics.beginFill(0,0.5);
            this._darkLayer.graphics.drawRect(0,0,Dimensions.GAME_BOARD_SIZE,Dimensions.GAME_BOARD_SIZE);
            this._darkLayer.graphics.endFill();
            this._darkLayer.alpha = 0;
            this._darkLayer.x = -(this._app.ui as MainWidgetGame).game.board.x;
            this._darkLayer.y = -(this._app.ui as MainWidgetGame).game.board.y;
            this._darkLayer.visible = false;
            this._darkLayer.cacheAsBitmap = true;
            addChild(this._darkLayer);
            addChild(this._frontGemLayer);
         }
         addChild(this._effectLayer);
         addChild(this.starGemLayer);
         this._app.logic.flameGemLogic.AddHandler(this);
         this._app.logic.starGemLogic.AddHandler(this);
         this._app.logic.hypercubeLogic.AddHandler(this);
         this._app.logic.phoenixPrismLogic.AddHandler(this);
         var _loc1_:BaseImageManager = this._app.ImageManager;
         this._gemImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this._multiImages = new Vector.<ImageInst>(Gem.NUM_COLORS,true);
         this._gemImages[Gem.COLOR_NONE] = null;
         this._gemImages[Gem.COLOR_RED] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_RED);
         this._gemImages[Gem.COLOR_ORANGE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_ORANGE);
         this._gemImages[Gem.COLOR_YELLOW] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_YELLOW);
         this._gemImages[Gem.COLOR_GREEN] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_GREEN);
         this._gemImages[Gem.COLOR_BLUE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_BLUE);
         this._gemImages[Gem.COLOR_PURPLE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_PURPLE);
         this._gemImages[Gem.COLOR_WHITE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_WHITE);
         this._multiImages[Gem.COLOR_NONE] = null;
         this._multiImages[Gem.COLOR_RED] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_RED);
         this._multiImages[Gem.COLOR_ORANGE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_ORANGE);
         this._multiImages[Gem.COLOR_YELLOW] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_YELLOW);
         this._multiImages[Gem.COLOR_GREEN] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_GREEN);
         this._multiImages[Gem.COLOR_BLUE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_BLUE);
         this._multiImages[Gem.COLOR_PURPLE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_PURPLE);
         this._multiImages[Gem.COLOR_WHITE] = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_MULTI_WHITE);
         this._hypercubeImage = _loc1_.getImageInst(Blitz3GameImages.IMAGE_GEM_HYPERCUBE);
         this._boostButtonUp = _loc1_.getImageInst(Blitz3GameImages.IMAGE_BOOST_BUTTON_UP);
         this._boostButtonOver = _loc1_.getImageInst(Blitz3GameImages.IMAGE_BOOST_BUTTON_OVER);
         this._scrambleEffect = _loc1_.getImageInst(Blitz3GameImages.IMAGE_SCRAMBLE_EFFECT);
         this._detonateEffect = _loc1_.getImageInst(Blitz3GameImages.IMAGE_DETONATE_EFFECT);
         this._selector = _loc1_.getBitmapData(Blitz3GameImages.IMAGE_SELECTOR);
         this._selectSprite = new Sprite();
         _loc2_ = new Bitmap(this._selector);
         _loc2_.x = -(_loc2_.width * 0.5);
         _loc2_.y = -(_loc2_.height * 0.5);
         this._selectSprite.addChild(_loc2_);
         this._app.logic.AddSpawnHandler(this);
         this._app.logic.coinTokenLogic.AddHandler(this);
         this._app.logic.rareGemTokenLogic.AddHandler(this);
         this._app.sessionData.userData.currencyManager.AddAnimHandler(this);
      }
      
      public function Reset() : void
      {
         var _loc1_:GemSprite = null;
         var _loc2_:SpriteEffect = null;
         var _loc3_:CoinSprite = null;
         var _loc4_:CoinSprite = null;
         var _loc5_:Vector.<RareGemToken> = null;
         var _loc6_:int = 0;
         var _loc7_:RareGemTokenSprite = null;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this._updateCount = -1;
         if(!this._app.isLQMode)
         {
            this._animationTimer = 0;
            this._darkLayer.alpha = 0;
         }
         for each(_loc1_ in this._gemSprites)
         {
            _loc1_.Hide();
         }
         for each(_loc2_ in this._effects)
         {
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         for each(_loc3_ in this._coinSprites)
         {
            _loc3_.Reset();
         }
         for each(_loc4_ in this._currencySprites)
         {
            _loc4_.Reset();
         }
         _loc6_ = (_loc5_ = this._app.logic.rareGemTokenLogic.rareGemTokenArray).length;
         for each(_loc7_ in this._rgTokenSprites)
         {
            _loc8_ = this._rgTokenSprites.indexOf(_loc7_);
            _loc9_ = false;
            _loc10_ = 0;
            while(_loc10_ < _loc6_)
            {
               _loc11_ = _loc5_[_loc10_].id;
               if(_loc8_ == _loc11_)
               {
                  _loc9_ = true;
                  break;
               }
               _loc10_++;
            }
            if(!_loc9_)
            {
               _loc7_.Reset();
            }
         }
         this._effects = new Vector.<SpriteEffect>();
         this._coinSprites = new Vector.<CoinSprite>();
         this._coinAnims = new Vector.<CoinTokenCollectAnim>();
         this._currencySprites = new Vector.<CoinSprite>();
         this._currencyAnims = new Vector.<CoinTokenCollectAnim>();
         this._hintAvailable = true;
         this.starGemLayer.Reset();
      }
      
      public function Update() : void
      {
         var _loc2_:int = 0;
         var _loc5_:GemSprite = null;
         var _loc6_:SpriteEffect = null;
         var _loc8_:Vector.<Gem> = null;
         var _loc9_:RareGemsLogic = null;
         var _loc10_:CoinSprite = null;
         var _loc12_:CoinTokenCollectAnim = null;
         var _loc13_:CoinSprite = null;
         var _loc14_:CoinTokenCollectAnim = null;
         var _loc15_:RareGemTokenSprite = null;
         var _loc17_:Gem = null;
         var _loc18_:RGLogic = null;
         if(this._app.logic.timerLogic.IsPaused())
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc3_:Vector.<IBlitzEvent> = this._app.logic.mBlockingEvents;
         var _loc4_:int = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc1_ = _loc1_ || _loc3_[_loc2_].isDarkEnabled();
            _loc2_++;
         }
         _loc3_ = this._app.logic.mTimeBlockingEvents;
         _loc4_ = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc1_ = _loc1_ || _loc3_[_loc2_].isDarkEnabled();
            _loc2_++;
         }
         this.UpdateSounds();
         if(!this._app.isLQMode)
         {
            if(_loc1_)
            {
               this._darkLayer.visible = true;
               if(this._darkLayer.alpha < 1)
               {
                  this._darkLayer.alpha += 0.02;
               }
            }
            else if(this._darkLayer.alpha > 0)
            {
               this._darkLayer.alpha -= 0.02;
            }
            else
            {
               this._darkLayer.visible = false;
            }
            for each(_loc5_ in this._gemSprites)
            {
               _loc5_.Update();
            }
         }
         var _loc7_:Boolean = false;
         for each(_loc6_ in this._effects)
         {
            if(_loc6_ is KpowEffect)
            {
               _loc7_ = true;
            }
         }
         _loc4_ = (_loc8_ = this._app.logic.board.mGems).length;
         _loc9_ = this._app.logic.rareGemsLogic;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            if((_loc17_ = _loc8_[_loc2_]) != null)
            {
               if(_loc17_.IsShattering() && _loc17_.shatterType != Gem.TYPE_FLAME)
               {
                  if(_loc9_.showcurrency3())
                  {
                     this._effects.push(new GemShatterEffect(this._app,_loc17_));
                  }
                  else if((_loc18_ = _loc9_.currentRareGem) != null && SoundPlayer.isPlaying(_loc18_.getStringID() + "DynamicSound" + DynamicRareGemSound.EXPLOSION_ID))
                  {
                     this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_SHATTER,1,Blitz3App.REDUCED_EXPLOSION_VOLUME);
                  }
                  else
                  {
                     this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_STAR_SHATTER);
                  }
               }
               if(!_loc7_ && _loc17_.IsPunched())
               {
                  this._effects.push(new KpowEffect(this._app,_loc17_));
               }
               if(Constants.SHOW_ALL_HINTS)
               {
                  if(_loc17_.isHinted)
                  {
                     _loc17_.isHinted = false;
                     this._effects.push(new HintEffect(this._app,_loc17_));
                  }
               }
               else if(_loc17_.isHinted && this._hintAvailable)
               {
                  this._hintAvailable = false;
                  _loc17_.isHinted = false;
                  this._effects.push(new HintEffect(this._app,_loc17_));
               }
            }
            _loc2_++;
         }
         _loc4_ = this._effects.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            (_loc6_ = this._effects[_loc2_]).Update();
            _loc2_++;
         }
         var _loc11_:int = this._coinSprites.length;
         _loc2_ = 0;
         while(_loc2_ < _loc11_)
         {
            (_loc10_ = this._coinSprites[_loc2_]).Update();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._coinAnims.length)
         {
            (_loc12_ = this._coinAnims[_loc2_]).Update();
            if(_loc12_.IsDone())
            {
               this._coinAnims.splice(this._coinAnims.indexOf(_loc12_),1);
               _loc12_.coinSprite.parent.removeChild(_loc12_.coinSprite);
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._currencySprites.length)
         {
            (_loc13_ = this._currencySprites[_loc2_]).Update();
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this._currencyAnims.length)
         {
            (_loc14_ = this._currencyAnims[_loc2_]).Update();
            if(_loc14_.IsDone())
            {
               this._currencyAnims.splice(this._currencyAnims.indexOf(_loc14_),1);
               _loc14_.coinSprite.parent.removeChild(_loc14_.coinSprite);
            }
            _loc2_++;
         }
         var _loc16_:int = this._rgTokenSprites.length;
         _loc2_ = 0;
         while(_loc2_ < _loc16_)
         {
            (_loc15_ = this._rgTokenSprites[_loc2_]).Update();
            _loc2_++;
         }
         this.starGemLayer.Update();
      }
      
      public function Draw() : void
      {
         this.UpdateSprites();
         this.DrawGems();
         if(this._app.isLQMode)
         {
            ++this._animationTimer;
            if(this._animationTimer % 2 == 0)
            {
               return;
            }
         }
         this.DrawEffects();
      }
      
      public function HandleLogicSpawnPhaseBegin() : void
      {
      }
      
      public function HandleLogicSpawnPhaseEnd() : void
      {
         var _loc3_:GemSprite = null;
         var _loc4_:Gem = null;
         var _loc1_:Board = this._app.logic.board;
         var _loc2_:Vector.<Gem> = _loc1_.freshGems;
         if(_loc2_.length == 0)
         {
            return;
         }
         while(this._gemSprites.length <= _loc1_.gemCount)
         {
            _loc3_ = new GemSprite();
            if(!this._app.isLQMode)
            {
               this._frontGemLayer.addChild(_loc3_);
            }
            this._gemSprites.push(_loc3_);
         }
         var _loc5_:int = _loc2_.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = _loc2_[_loc6_];
            _loc3_ = this._gemSprites[_loc4_.id];
            _loc3_.gem = _loc4_;
            _loc6_++;
         }
      }
      
      public function HandlePostLogicSpawnPhase() : void
      {
      }
      
      public function HandleCoinCreated(param1:CoinToken) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:CoinSprite = new CoinSprite(this._app,param1.value);
         this._coinSprites[param1.id] = _loc2_;
         if(param1.host != null)
         {
            this._gemSprites[param1.host.id].addChild(_loc2_);
         }
         else if(param1.isBonus && (this._app.ui as MainWidgetGame).game.phoenixPrism.AwardFeather)
         {
            (this._app.ui as MainWidgetGame).game.phoenixPrism.AwardFeather.addChild(_loc2_);
         }
         if(param1.container != null)
         {
            _loc3_ = param1.container.localToGlobal(new Point(0,0));
            _loc4_ = this._app.topLayer.globalToLocal(new Point(_loc3_.x,_loc3_.y));
            _loc2_.x = _loc4_.x;
            _loc2_.y = _loc4_.y;
            this._app.topLayer.addChild(_loc2_);
         }
      }
      
      public function HandleCoinCollected(param1:CoinToken) : void
      {
         var _loc3_:Point = null;
         var _loc2_:CoinSprite = this._coinSprites[param1.id];
         if(_loc2_.parent == null)
         {
            _loc3_ = (this._app.ui as MainWidgetGame).game.getCoinTrailStartPosition();
            _loc3_ = this._app.globalToLocal((this._app.ui as MainWidgetGame).game.localToGlobal(_loc3_));
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
         }
         this._coinAnims.push(this._app.uiFactory.GetCoinTokenCollectAnim(_loc2_));
      }
      
      public function HandleMultiCoinCollectionSkipped(param1:int) : void
      {
      }
      
      public function HandleCurrencyCreated(param1:CurrencyAnimToken) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:CoinSprite = new CoinSprite(this._app,param1.value,param1.type);
         this._currencySprites[param1.id] = _loc2_;
         if(param1.container != null)
         {
            _loc3_ = param1.container.localToGlobal(new Point(0,0));
            _loc4_ = this._app.topLayer.globalToLocal(new Point(_loc3_.x,_loc3_.y));
            _loc2_.x = _loc4_.x;
            _loc2_.y = _loc4_.y;
            this._app.topLayer.addChild(_loc2_);
         }
      }
      
      public function HandleCurrencyCollected(param1:CurrencyAnimToken) : void
      {
         var _loc3_:Point = null;
         var _loc2_:CoinSprite = this._currencySprites[param1.id];
         if(_loc2_.parent == null)
         {
            _loc3_ = (this._app.ui as MainWidgetGame).game.getCoinTrailStartPosition();
            _loc3_ = this._app.globalToLocal((this._app.ui as MainWidgetGame).game.localToGlobal(_loc3_));
            _loc2_.x = _loc3_.x;
            _loc2_.y = _loc3_.y;
         }
         this._currencyAnims.push(this._app.uiFactory.GetCoinTokenCollectAnim(_loc2_));
      }
      
      public function HandleRareGemTokenCreated(param1:RareGemToken) : void
      {
         var _loc3_:Point = null;
         var _loc4_:Point = null;
         var _loc2_:RareGemTokenSprite = new RareGemTokenSprite(this._app,param1.value);
         this._rgTokenSprites[param1.id] = _loc2_;
         if(param1.host != null)
         {
            this._gemSprites[param1.host.id].addChild(_loc2_);
         }
         if(param1.container != null)
         {
            _loc3_ = param1.container.localToGlobal(new Point(0,0));
            _loc4_ = this._app.topLayer.globalToLocal(new Point(_loc3_.x,_loc3_.y));
            _loc2_.x = _loc4_.x;
            _loc2_.y = _loc4_.y;
            this._app.topLayer.addChild(_loc2_);
         }
      }
      
      public function HandleRareGemTokenCollected(param1:RareGemToken) : void
      {
         var _loc2_:RareGemTokenSprite = this._rgTokenSprites[param1.id];
         var _loc3_:Point = this._app.topLayer.globalToLocal(_loc2_.localToGlobal(new Point(_loc2_.x,_loc2_.y)));
         _loc2_.x = _loc3_.x;
         _loc2_.y = _loc3_.y;
         this._app.topLayer.addChild(_loc2_);
         var _loc4_:ClockWidget = (this._app.ui as MainWidgetGame).game.board.clock;
         var _loc5_:Point = this._app.topLayer.globalToLocal((this._app.ui as MainWidgetGame).game.board.localToGlobal(new Point(_loc4_.x,_loc4_.y)));
         var _loc6_:TokenSpriteBehavior = this._tokenSpriteBehaviorFactory.generate(param1,_loc2_,this.destroyTheToken,_loc5_);
         if(this._app.logic.lastHurrahLogic.IsRunning())
         {
            _loc6_.onLastHurrahCollection();
            this._app.logic.rareGemTokenLogic.incrementTokensCollectedInLastHurrah();
         }
         else
         {
            _loc6_.onGameCollection();
            this._app.logic.rareGemTokenLogic.incrementTokensCollectedInGame();
         }
         var _loc7_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         var _loc8_:GemSprite = this._gemSprites[param1.host.id];
         this._effects.push(new DynamicExplodeEffect(this._app,_loc8_,_loc7_.getStringID()));
      }
      
      private function destroyTheToken(param1:RareGemTokenSprite, param2:RareGemToken) : void
      {
         param1.visible = false;
         this._app.logic.rareGemTokenLogic.TokenDidFinishCollectionAnimation(param2);
         var _loc3_:String = this._app.logic.rareGemsLogic.currentRareGem.getTokenGemEffectType();
         if(_loc3_ == RGLogic.TOKEN_GEM_EFFECT_TIME && !this._app.logic.lastHurrahLogic.IsRunning())
         {
            (this._app.ui as MainWidgetGame).game.board.frame.flashTimerBar();
            DynamicRareGemSound.play(this._app.logic.rareGemsLogic.currentRareGem.getStringID(),DynamicRareGemSound.TIMEBAR_ID);
         }
      }
      
      public function handleFlameGemCreated(param1:FlameGemCreateEvent) : void
      {
         var _loc2_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         if(_loc2_ != null && _loc2_.getStringID() == BlazingSteedRGLogic.ID)
         {
            this._effects.push(new FlameGemCreateEffect(this._app,param1,Blitz3GameSounds.SOUND_BLAZING_STEED_FLAME));
         }
         else if(param1.isForced() && this._app.logic.rareGemsLogic.currentRareGem != null && this._app.logic.rareGemsLogic.currentRareGem.isFlamePromoter() && this._app.logic.rareGemsLogic.currentRareGem.getFlameColor() == param1.GetLocus().color)
         {
            this._effects.push(new FlameGemCreateEffect(this._app,param1,""));
         }
         else
         {
            this._effects.push(new FlameGemCreateEffect(this._app,param1));
         }
      }
      
      public function handleFlameGemExploded(param1:FlameGemExplodeEvent) : void
      {
         var _loc2_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         var _loc3_:Gem = param1.GetLocus();
         var _loc4_:GemSprite = this._gemSprites[_loc3_.id];
         if(_loc2_ != null)
         {
            if(_loc2_.isTokenRareGem() && _loc3_.HasToken())
            {
               return;
            }
            if(_loc2_.getStringID() == BlazingSteedRGLogic.ID)
            {
               this._effects.push(new FlameSteedGemExplodeEffect(this._app,_loc4_));
            }
            else if(_loc2_.isDynamicGem() && _loc2_.isFlamePromoter() && param1.GetLocus().color == _loc2_.getFlameColor())
            {
               this._effects.push(new DynamicExplodeEffect(this._app,_loc4_,_loc2_.getStringID()));
            }
            else
            {
               this.showGenericExplosion(_loc4_);
            }
         }
         else
         {
            this.showGenericExplosion(_loc4_);
         }
      }
      
      private function showGenericExplosion(param1:GemSprite) : void
      {
         this._effects.push(new FlameGemExplodeEffect(this._app,param1));
      }
      
      public function handleFlameGemExplosionRange(param1:Gem, param2:Vector.<Gem>) : void
      {
      }
      
      public function HandleHypercubeCreated(param1:HypercubeCreateEvent) : void
      {
         this._effects.push(new HyperGemCreateEffect(this._app,param1));
      }
      
      public function HandleHypercubeExploded(param1:HypercubeExplodeEvent) : void
      {
         this._effects.push(new HyperGemExplodeEffect(this._app,param1));
      }
      
      public function HandlePhoenixPrismCreated(param1:PhoenixPrismCreateEvent) : void
      {
         this._effects.push(new PhoenixPrismCreateEffect(this._app,param1));
      }
      
      public function HandlePhoenixPrismExploded(param1:PhoenixPrismExplodeEvent) : void
      {
         this._effects.push(new PhoenixPrismExplodeEffect(this._app,param1.GetLocus()));
      }
      
      public function HandlePhoenixPrismHurrahExploded(param1:PhoenixPrismHurrahExplodeEvent) : void
      {
         this._effects.push(new PhoenixPrismHurrahExplodeEffect(this._app));
      }
      
      public function HandleStarGemCreated(param1:StarGemCreateEvent) : void
      {
         this._effects.push(new StarGemCreateEffect(this._app,param1));
      }
      
      public function HandleStarGemExploded(param1:StarGemExplodeEvent) : void
      {
         this._effects.push(new StarGemExplodeEffect(this._app,param1.GetLocus()));
      }
      
      private function UpdateSprites() : void
      {
         var _loc1_:Board = this._app.logic.board;
         var _loc2_:Vector.<Gem> = _loc1_.mGems;
         var _loc3_:int = 0;
         var _loc4_:Gem = null;
         var _loc5_:GemSprite = null;
         var _loc6_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            if((_loc4_ = _loc2_[_loc3_]) != null)
            {
               (_loc5_ = this._gemSprites[_loc4_.id]).gem = _loc4_;
               if(_loc5_.parent == null)
               {
                  this._backGemLayer.addChild(_loc5_);
               }
            }
            _loc3_++;
         }
         var _loc7_:int = this._gemSprites.length;
         _loc3_ = 0;
         while(_loc3_ < _loc7_)
         {
            if((_loc4_ = (_loc5_ = this._gemSprites[_loc3_]).gem) == null || _loc4_.IsDead())
            {
               if(_loc5_.parent != null)
               {
                  _loc5_.parent.removeChild(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      private function DrawGems() : void
      {
         var _loc6_:IBlitzEvent = null;
         var _loc8_:SwapData = null;
         var _loc9_:Gem = null;
         var _loc10_:Gem = null;
         var _loc11_:GemSprite = null;
         var _loc12_:GemSprite = null;
         var _loc13_:HypercubeExplodeEvent = null;
         var _loc14_:Vector.<Gem> = null;
         var _loc15_:ColorChangerEvent = null;
         var _loc16_:Vector.<Gem> = null;
         this._selectSprite.visible = false;
         var _loc1_:Vector.<Gem> = this._app.logic.board.mGems;
         var _loc2_:int = _loc1_.length;
         var _loc3_:Gem = null;
         var _loc4_:GemSprite = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if(_loc3_ != null)
            {
               _loc4_ = this._gemSprites[_loc3_.id];
               if(_loc3_.IsDead())
               {
                  _loc4_.Hide();
               }
               else
               {
                  _loc4_.postFX = false;
                  _loc4_.Show();
                  if(_loc3_.IsSelected())
                  {
                     this._selectSprite.visible = true;
                     _loc4_.addChild(this._selectSprite);
                  }
               }
            }
            _loc5_++;
         }
         for each(_loc6_ in this._app.logic.mBlockingEvents)
         {
            if(_loc6_ is HypercubeExplodeEvent)
            {
               _loc14_ = (_loc13_ = _loc6_ as HypercubeExplodeEvent).GetMatchingGems();
               for each(_loc3_ in _loc14_)
               {
                  (_loc4_ = this._gemSprites[_loc3_.id]).postFX = true;
               }
            }
            else if(_loc6_ is ColorChangerEvent)
            {
               _loc16_ = (_loc15_ = _loc6_ as ColorChangerEvent).GetGems();
               for each(_loc3_ in _loc14_)
               {
                  (_loc4_ = this._gemSprites[_loc3_.id]).postFX = true;
               }
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if(_loc3_ != null)
            {
               _loc4_ = this._gemSprites[_loc3_.id];
               this.DrawGem(_loc3_,_loc4_);
            }
            _loc5_++;
         }
         var _loc7_:int = this._app.logic.swaps.length;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            if(!(_loc8_ = this._app.logic.swaps[_loc5_]).IsDone())
            {
               _loc9_ = _loc8_.moveData.sourceGem;
               _loc10_ = _loc8_.moveData.swapGem;
               _loc11_ = this._gemSprites[_loc9_.id];
               _loc12_ = this._gemSprites[_loc10_.id];
               if(!_loc10_.IsDead())
               {
                  this._backGemLayer.addChild(_loc12_);
               }
               if(!_loc9_.IsDead())
               {
                  this._backGemLayer.addChild(_loc11_);
               }
            }
            _loc5_++;
         }
      }
      
      private function DrawGem(param1:Gem, param2:GemSprite) : void
      {
         var mainImg:ImageInst = null;
         var effectImg:ImageInst = null;
         var gem:Gem = param1;
         var sprite:GemSprite = param2;
         var screenX:Number = gem.x * GemSprite.GEM_SIZE + 20;
         var screenY:Number = gem.y * GemSprite.GEM_SIZE + 20;
         if(gem.IsSelected() || gem.IsGemRotating())
         {
            if(sprite.animTime <= 0)
            {
               sprite.animTime = _GEM_ANIMATION_TICKS;
            }
         }
         if(gem.IsElectric() && this._app.logic.frameID > this._updateCount)
         {
            screenX += Math.random() * 2 - 1;
            screenY += Math.random() * 2 - 1;
         }
         var redrawSprite:Boolean = false;
         if(!this._app.isLQMode)
         {
            redrawSprite = true;
         }
         else if(this._animationTimer % 10 == 0)
         {
            redrawSprite = true;
         }
         if(redrawSprite)
         {
            mainImg = this.GetMainImage(gem,sprite);
            effectImg = this.GetEffectImage(gem,sprite);
            try
            {
               sprite.SetRenderState(screenX,screenY,gem.scale,null,mainImg,effectImg);
            }
            catch(e:Error)
            {
               ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_RUNTIME,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"Gem Sprite Render State Error : " + e.toString() + " stack " + e.getStackTrace());
            }
            if(!this._app.isLQMode)
            {
               if(sprite.postFX && sprite.parent != this._frontGemLayer)
               {
                  this._frontGemLayer.addChild(sprite);
               }
               else if(!sprite.postFX && sprite.parent != this._backGemLayer)
               {
                  this._backGemLayer.addChild(sprite);
               }
            }
         }
         else
         {
            sprite.SetPos(screenX,screenY,gem.scale);
         }
      }
      
      private function GetStandardImage(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc4_:int = 0;
         var _loc3_:ImageInst = null;
         _loc3_ = this._gemImages[param1.color];
         _loc4_ = _loc3_.mSource.mNumFrames;
         if(this._app.isLQMode)
         {
            return _loc3_;
         }
         _loc3_.mFrame = int((_GEM_ANIMATION_TICKS - param2.animTime) / _GEM_ANIMATION_RATE) % _loc4_;
         return _loc3_;
      }
      
      private function GetFlameImage(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc4_:int = 0;
         var _loc3_:ImageInst = null;
         _loc3_ = this._app.flameGemFactory.GetFlameGem(param1);
         _loc4_ = _loc3_.mSource.mNumFrames;
         _loc3_.mFrame = int(param1.lifetime * 0.01 * _loc4_) % _loc4_;
         return _loc3_;
      }
      
      private function GetDynamicFlameImage(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc4_:int = 0;
         var _loc3_:ImageInst = null;
         _loc3_ = this._app.flameGemFactory.getDynamicRareGemImage();
         _loc4_ = _loc3_.mSource.mNumFrames;
         _loc3_.mFrame = Math.floor((_GEM_ANIMATION_TICKS - param2.animTime) / _GEM_ANIMATION_RATE) % _loc4_;
         return _loc3_;
      }
      
      private function GetMainImage(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc4_:int = 0;
         var _loc3_:ImageInst = null;
         if(param1.type == Gem.TYPE_STANDARD)
         {
            _loc3_ = this.GetStandardImage(param1,param2);
         }
         else if(param1.type == Gem.TYPE_STAR)
         {
            if(param1.color == 0)
            {
               return _loc3_;
            }
            _loc3_ = this._app.starGemFactory.GetStarGem(param1.color);
            _loc4_ = _loc3_.mSource.mNumFrames;
            _loc3_.mFrame = int(param1.lifetime * 0.01 * _loc4_) % _loc4_;
         }
         else
         {
            if(param1.type == Gem.TYPE_FLAME)
            {
               if(this._app.logic.rareGemsLogic != null && this._app.logic.rareGemsLogic.currentRareGem != null)
               {
                  if(this._app.logic.rareGemsLogic.currentRareGem.isTokenRareGem())
                  {
                     if(param1.HasToken())
                     {
                        return this.GetStandardImage(param1,param2);
                     }
                  }
                  else if(this._app.logic.rareGemsLogic.currentRareGem.isFlamePromoter() && this._app.logic.rareGemsLogic.currentRareGem.getFlameColor() == param1.color)
                  {
                     return this.GetDynamicFlameImage(param1,param2);
                  }
               }
               return this.GetFlameImage(param1,param2);
            }
            if(param1.type == Gem.TYPE_PHOENIXPRISM)
            {
               _loc3_ = this._app.phoenixPrismGemFactory.GetPhoenixPrismGem();
               _loc4_ = _loc3_.mSource.mNumFrames;
               _loc3_.mFrame = int(param1.lifetime * 0.005 * _loc4_) % _loc4_;
            }
            else if(param1.type == Gem.TYPE_HYPERCUBE)
            {
               _loc3_ = this._hypercubeImage;
               _loc3_.mFrame = int(param1.lifetime * 0.01 * (70 * 0.333)) % _loc3_.mSource.mNumFrames;
            }
            else if(param1.type == Gem.TYPE_MULTI)
            {
               _loc3_ = this._multiImages[param1.color];
               _loc3_.mFrame = int(param1.lifetime * 0.3) % _loc3_.mSource.mNumFrames;
            }
            else if(param1.type == Gem.TYPE_DETONATE)
            {
               _loc3_ = this._boostButtonUp;
               if(param1.row == this.mouseOver.y && param1.col == this.mouseOver.x && this._app.logic.timerLogic.GetTimeRemaining() > 0)
               {
                  _loc3_ = this._boostButtonOver;
               }
            }
            else if(param1.type == Gem.TYPE_SCRAMBLE)
            {
               _loc3_ = this._boostButtonUp;
               if(param1.row == this.mouseOver.y && param1.col == this.mouseOver.x && this._app.logic.timerLogic.GetTimeRemaining() > 0)
               {
                  _loc3_ = this._boostButtonOver;
               }
            }
         }
         return _loc3_;
      }
      
      private function GetEffectImage(param1:Gem, param2:GemSprite) : ImageInst
      {
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.IsMatched() && !param1.IsElectric())
         {
            return null;
         }
         var _loc3_:ImageInst = null;
         if(param1.type == Gem.TYPE_MULTI)
         {
            _loc4_ = param1.IsMatched();
            _loc5_ = this._app.logic.config.multiplierGemLogicThresholdMaxMultiplier;
            _loc6_ = !!_loc4_ ? int(Math.min(_loc5_,param1.multiValue - 1)) : int(Math.min(_loc5_,this._app.logic.multiLogic.multiplier));
            param2.multiTextField.text = "x" + (_loc6_ + 1).toString();
         }
         else if(param1.type == Gem.TYPE_DETONATE)
         {
            _loc3_ = this._detonateEffect;
         }
         else if(param1.type == Gem.TYPE_SCRAMBLE)
         {
            _loc3_ = this._scrambleEffect;
         }
         if(param1.type != Gem.TYPE_MULTI)
         {
            param2.multiTextField.text = "";
         }
         return _loc3_;
      }
      
      private function DrawEffects() : void
      {
         var _loc3_:SpriteEffect = null;
         var _loc1_:int = this._effects.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._effects[_loc2_];
            if(_loc3_.parent == null)
            {
               this._effectLayer.addChild(_loc3_);
            }
            if(_loc3_.IsDone())
            {
               if(_loc3_ is HintEffect)
               {
                  this._hintAvailable = true;
               }
               if(_loc3_.parent != null)
               {
                  this._effectLayer.removeChild(_loc3_);
               }
               this._effects.splice(_loc2_,1);
               _loc1_ = this._effects.length;
            }
            else
            {
               _loc3_.Draw();
            }
            _loc2_++;
         }
      }
      
      public function GetGemSprite(param1:int) : GemSprite
      {
         return this._gemSprites[param1];
      }
      
      private function UpdateSounds() : void
      {
         var _loc2_:BlitzSpeedBonus = null;
         if(this._updateCount == this._app.logic.frameID)
         {
            return;
         }
         this._updateCount = this._app.logic.frameID;
         if(this._app.logic.gemsHit)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_HIT);
         }
         else if(this._app.logic.badMove)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BAD_MOVE);
         }
         else if(this._app.logic.startedMove)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_START_MOVE);
         }
         else if(this._app.logic.multiLogic.spawned)
         {
            this._app.logic.multiLogic.spawned = false;
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GEM_MULTI_APPEAR);
         }
         var _loc1_:BlitzScoreKeeper = this._app.logic.GetScoreKeeper();
         if(_loc1_.matchesMade > 0)
         {
            if(_loc1_.bestCascade == 2)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_1);
            }
            else if(_loc1_.bestCascade == 3)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_2);
            }
            else if(_loc1_.bestCascade == 4)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_3);
            }
            else if(_loc1_.bestCascade == 5)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_4);
            }
            else if(_loc1_.bestCascade >= 6)
            {
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_COMBO_5);
            }
            else
            {
               _loc2_ = this._app.logic.speedBonus;
               if(_loc2_.GetLevel() == 0)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_MATCH_ONE);
               }
               else if(_loc2_.GetLevel() == 1)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_1);
               }
               else if(_loc2_.GetLevel() == 2)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_2);
               }
               else if(_loc2_.GetLevel() == 3)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_3);
               }
               else if(_loc2_.GetLevel() == 4)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_4);
               }
               else if(_loc2_.GetLevel() == 5)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_5);
               }
               else if(_loc2_.GetLevel() == 6)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_6);
               }
               else if(_loc2_.GetLevel() == 7)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_7);
               }
               else if(_loc2_.GetLevel() == 8)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_8);
               }
               else if(_loc2_.GetLevel() == 9 || _loc2_.GetLevel() == 10)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_SPEED_MATCH_9);
               }
               else if(_loc2_.GetLevel() >= 11)
               {
                  this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_FLAME_SPEED_1);
               }
            }
         }
      }
   }
}
