package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PhoenixPrismPrestige extends Sprite
   {
      
      private static const _STATE_INACTIVE:int = 0;
      
      private static const _STATE_ACTIVE:int = 1;
      
      private static const _STATE_PAUSED:int = 2;
      
      private static const _BASE_BONUS_POINTS:int = 1500;
      
      private static const _ANIM_NAME:String = "PRIMARY";
       
      
      private var _state:int = 0;
      
      private var _lastState:int = 0;
      
      private var _frame:int = 0;
      
      private var _hitJackpot:Boolean = false;
      
      private var _app:Blitz3App;
      
      private var _phoenix:Phoenix;
      
      private var _coinPrestige:CoinPrestige;
      
      private var _explosion:PhoenixPrismExplosion;
      
      private var _bonusTextSprite:AnimatedSprite;
      
      private var _bonusText:TextField;
      
      private var m_Feathers:Vector.<PhoenixFeather>;
      
      private var m_AwardFeather:PhoenixFeather;
      
      private var m_DarkLayer:Shape;
      
      public function PhoenixPrismPrestige(param1:Blitz3App)
      {
         this.m_Feathers = new Vector.<PhoenixFeather>(0);
         super();
         this._app = param1;
         this.m_DarkLayer = new Shape();
         this._phoenix = new Phoenix(param1);
         this._coinPrestige = new CoinPrestige(this._app,this);
         this._explosion = new PhoenixPrismExplosion(this._app,true);
         this._bonusTextSprite = new AnimatedSprite();
         this._bonusTextSprite.addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
         this._bonusTextSprite.visible = false;
         var _loc2_:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,32);
         _loc2_.align = TextFormatAlign.CENTER;
         this._bonusText = new TextField();
         this._bonusText.selectable = false;
         this._bonusText.embedFonts = true;
         this._bonusText.defaultTextFormat = _loc2_;
         this._bonusText.autoSize = TextFieldAutoSize.CENTER;
         this._bonusText.filters = [new GlowFilter(16777215,0.5,10,10),new BevelFilter(2),new DropShadowFilter(2)];
         this._bonusTextSprite.addChild(this._bonusText);
      }
      
      public function Init() : void
      {
         var _loc1_:Point = null;
         var _loc2_:PhoenixFeather = null;
         addChild(this.m_DarkLayer);
         addChild(this._explosion);
         addChild(this._phoenix);
         addChild(this._bonusTextSprite);
         addChild(this._coinPrestige);
         _loc1_ = new Point((this._app.ui as MainWidgetGame).game.AlignmentAnchor.x,(this._app.ui as MainWidgetGame).game.AlignmentAnchor.y);
         this.m_DarkLayer.graphics.beginFill(0,0.5);
         this.m_DarkLayer.graphics.drawRect(-_loc1_.x,-_loc1_.y,Dimensions.PRELOADER_WIDTH + _loc1_.x,Dimensions.PRELOADER_HEIGHT + _loc1_.y);
         this.m_DarkLayer.graphics.endFill();
         this.m_DarkLayer.x = -_loc1_.x;
         this.m_DarkLayer.y = -_loc1_.y;
         this.m_DarkLayer.cacheAsBitmap = true;
         this._explosion.x = (this._app.ui as MainWidgetGame).game.board.width / 2;
         this._phoenix.x = (this._app.ui as MainWidgetGame).game.Gameboardplaceholder.x;
         this._phoenix.y = Dimensions.PHOENIX_Y;
         this._phoenix.Init();
         this._coinPrestige.x = -(this._app.ui as MainWidgetGame).game.board.x;
         this._coinPrestige.y = -(this._app.ui as MainWidgetGame).game.board.y - 20;
         this._coinPrestige.Init();
         for each(_loc2_ in this.m_Feathers)
         {
            _loc2_.x = (this._app.ui as MainWidgetGame).game.Gameboardplaceholder.x;
            _loc2_.y = (this._app.ui as MainWidgetGame).game.Gameboardplaceholder.y;
            _loc2_.Init();
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         var _loc1_:PhoenixFeather = null;
         visible = false;
         this._state = _STATE_INACTIVE;
         this._bonusTextSprite.visible = false;
         this._frame = 0;
         this._hitJackpot = false;
         this._phoenix.Reset();
         this._coinPrestige.Reset();
         for each(_loc1_ in this.m_Feathers)
         {
            _loc1_.Reset(false);
         }
         this.m_AwardFeather = null;
      }
      
      public function Update() : void
      {
         if(this._state == _STATE_INACTIVE || this._state == _STATE_PAUSED)
         {
            return;
         }
         ++this._frame;
         if(this._frame == 1 || this._frame == 200)
         {
            this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_PHOENIXPRISM);
         }
         if(this._frame < 200 || this._frame > 200 && this._frame < 300)
         {
            this._explosion.UpdatePrestige();
         }
         else if(this._frame == 200 || this._frame == 300)
         {
            this._explosion.Reset();
         }
         if(this._frame < 1000)
         {
            this._phoenix.Update();
            this._bonusTextSprite.Update();
         }
         if(this._frame > 410 && this._frame < 1300)
         {
            this._coinPrestige.Update();
         }
         if(this._frame > 350 && this._frame < 1300)
         {
            this.UpdateFeathers();
         }
         if(this._frame >= 1000 && this._hitJackpot)
         {
            this._coinPrestige.ExplodeCoins();
         }
         if(this._frame >= 1200 && this._hitJackpot)
         {
            this._coinPrestige.OfferShare();
         }
         else if(this._frame >= 1350)
         {
            this.Done();
         }
      }
      
      public function ShowBonusText(param1:int, param2:int) : void
      {
         this._bonusTextSprite.visible = true;
         var _loc3_:String = this._app.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS);
         _loc3_ = _loc3_.replace("%s",StringUtils.InsertNumberCommas(param1));
         _loc3_ = _loc3_.replace("%s",param2);
         _loc3_ = _loc3_.replace(/<[bB][rR]>/,"\n");
         this._bonusText.selectable = false;
         this._bonusText.htmlText = _loc3_;
         this._bonusText.x = this._bonusText.textWidth * -0.5;
         this._bonusText.y = this._bonusText.textHeight * -0.5;
         var _loc4_:Rectangle = (this._app.ui as MainWidgetGame).game.scoreWidget.getRect(this);
         var _loc5_:Number = this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX).height;
         this._bonusTextSprite.ClearAnims();
         var _loc6_:Vector.<KeyframeData>;
         (_loc6_ = new Vector.<KeyframeData>()).push(new KeyframeData(0,this._phoenix.x,this._phoenix.y - _loc5_ * 0.33,0,0));
         _loc6_.push(new KeyframeData(50,this._phoenix.x,this._phoenix.y - _loc5_ * 0.33,1,1));
         _loc6_.push(new KeyframeData(150,this._phoenix.x,this._phoenix.y - _loc5_ * 0.33,1,1));
         _loc6_.push(new KeyframeData(400,_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.25,0,0));
         this._bonusTextSprite.AddAnimation(_ANIM_NAME,_loc6_);
         this._bonusTextSprite.PlayAnimation(_ANIM_NAME);
      }
      
      public function GetAwardFeather() : PhoenixFeather
      {
         var _loc1_:int = DynamicRareGemWidget.getWinningPrizeIndex();
         if(_loc1_ < 0 || _loc1_ > this.m_Feathers.length - 1)
         {
            _loc1_ = 0;
         }
         return this.m_Feathers[_loc1_];
      }
      
      public function Show() : void
      {
         visible = true;
         this._state = _STATE_ACTIVE;
         this.PreenFeathers();
      }
      
      public function Done() : void
      {
         this.Reset();
         this._state = _STATE_INACTIVE;
      }
      
      public function IsDone() : Boolean
      {
         return this._state == _STATE_INACTIVE;
      }
      
      public function GameEnd() : void
      {
         this.Done();
      }
      
      public function GameAbort() : void
      {
         this.Done();
      }
      
      public function Pause() : void
      {
         if(this._state == _STATE_ACTIVE)
         {
            this._lastState = this._state;
            this._state = _STATE_PAUSED;
            this._coinPrestige.visible = false;
         }
      }
      
      public function Resume() : void
      {
         if(this._state == _STATE_PAUSED)
         {
            this._state = this._lastState;
            this._coinPrestige.visible = true;
         }
      }
      
      private function UpdateFeathers() : void
      {
         var _loc2_:PhoenixFeather = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this.m_Feathers)
         {
            _loc2_.Update();
            _loc1_ += _loc2_.State;
         }
      }
      
      private function PreenFeathers() : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:PhoenixFeather = null;
         var _loc8_:PhoenixFeather = null;
         var _loc9_:int = 0;
         var _loc10_:* = false;
         var _loc11_:Point = null;
         var _loc1_:Vector.<int> = DynamicRareGemWidget.getCoinArray();
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = this.m_Feathers.length;
         if(_loc2_ < _loc3_)
         {
            _loc4_ = _loc2_;
            while(_loc4_ < _loc3_)
            {
               if(this.contains(this.m_Feathers[_loc4_]))
               {
                  this.removeChild(this.m_Feathers[_loc4_]);
               }
               _loc4_++;
            }
            this.m_Feathers.length = _loc2_;
         }
         else if(_loc2_ > _loc3_)
         {
            this.m_Feathers.length = _loc2_;
            _loc4_ = _loc3_;
            while(_loc4_ < _loc2_)
            {
               (_loc7_ = new PhoenixFeather(this._app,_loc4_)).x = (this._app.ui as MainWidgetGame).game.Gameboardplaceholder.x;
               _loc7_.y = (this._app.ui as MainWidgetGame).game.Gameboardplaceholder.y;
               _loc7_.Init();
               this.m_Feathers[_loc4_] = _loc7_;
               addChildAt(_loc7_,numChildren - 1);
               _loc4_++;
            }
         }
         var _loc5_:int = 0;
         for each(_loc6_ in _loc1_)
         {
            if(_loc6_ > _loc5_)
            {
               _loc5_ = _loc6_;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc8_ = this.m_Feathers[_loc4_];
            if((_loc9_ = DynamicRareGemWidget.getWinningPrizeIndex()) < 0 || _loc9_ > this.m_Feathers.length - 1)
            {
               _loc9_ = 0;
            }
            _loc10_ = _loc4_ == _loc9_;
            _loc8_.visible = true;
            if(_loc1_[_loc4_] <= 0)
            {
               _loc8_.visible = false;
            }
            _loc8_.Reset(_loc10_);
            _loc8_.SetValue(_loc1_[_loc4_]);
            if(_loc1_[_loc4_] == _loc5_)
            {
               _loc8_.SetJackpot(true);
               if(_loc10_)
               {
                  this._hitJackpot = true;
               }
            }
            if(_loc8_.parent != this)
            {
               addChildAt(_loc8_,numChildren - 1);
            }
            if(_loc10_)
            {
               _loc11_ = new Point(_loc8_.x,_loc8_.y);
               _loc11_ = this._coinPrestige.globalToLocal(localToGlobal(_loc11_));
               _loc8_.x = _loc11_.x;
               _loc8_.y = _loc11_.y;
               this._coinPrestige.addChild(_loc8_);
               this.m_AwardFeather = _loc8_;
            }
            _loc4_++;
         }
      }
      
      public function get AwardFeather() : PhoenixFeather
      {
         return this.m_AwardFeather;
      }
      
      private function HandleAnimComplete(param1:AnimationEvent) : void
      {
         if(param1.animationName == _ANIM_NAME)
         {
            this._bonusTextSprite.visible = false;
         }
      }
   }
}
