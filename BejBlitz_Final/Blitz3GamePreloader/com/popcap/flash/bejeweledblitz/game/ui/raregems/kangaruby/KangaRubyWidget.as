package com.popcap.flash.bejeweledblitz.game.ui.raregems.kangaruby
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.Constants;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.sidebar.RareGemWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.text.TextFieldRollUpAdapter;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreValue;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IKangaRubyRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IKangaRubyRGLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyFirstRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubySecondRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.KangaRubyThirdRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.kangaruby.KangaRubyAttackPatternsFirst;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class KangaRubyWidget extends Sprite implements IKangaRubyRGLogicHandler, IBlitzLogicHandler
   {
      
      private static const STATE_INACTIVE:String = "STATE_INACTIVE";
      
      private static const STATE_INTRO:String = "STATE_INTRO";
      
      private static const STATE_ARMING:String = "STATE_ARMING";
      
      private static const STATE_RETREATING:String = "STATE_RETREATING";
      
      private static const STATE_PRESTIGE:String = "STATE_PRESTIGE";
      
      private static const STATE_RETREATING_PRESTIGE:String = "STATE_RETREATING_PRESTIGE";
      
      private static const STATE_PRESTIGE_COIN_TIME:String = "STATE_PRESTIGE_COINS";
      
      private static const STATE_PAUSED:String = "STATE_PAUSED";
      
      private static const TIMER_BASED_ANIMATION:Boolean = false;
       
      
      private var _app:Blitz3App;
      
      private var _kangaRubyFirstLogic:KangaRubyFirstRGLogic;
      
      private var _kangaRubySecondLogic:KangaRubySecondRGLogic;
      
      private var _kangaRubyThirdLogic:KangaRubyThirdRGLogic;
      
      private var _animationState:String;
      
      private var _currentAnimation:MovieClip;
      
      private var _attackType:String;
      
      private var _attackIndex:int;
      
      private var _coinPrestigeMC:MovieClip;
      
      private var _coinTallyStarted:Boolean = false;
      
      private var _prestigeIndex:int;
      
      private var _justLeftHitFrame:Boolean;
      
      private var _currentRound:int;
      
      private var _coinPrestigePauseCounter:int;
      
      private var _kangaContainer:Sprite;
      
      private var _animationHitTimer:int;
      
      private var _animationFrameCounter:int;
      
      private var _boardTextNumber:TextField;
      
      private var _currentKangaRubyRGLogic:IKangaRubyRGLogic;
      
      private var _currentCoinsPerRubyPayout:Number;
      
      private var _progressMeter:Progressbar;
      
      private var _isIconforProgressBarAttached:Boolean = false;
      
      public function KangaRubyWidget(param1:Blitz3App, param2:Progressbar)
      {
         super();
         this._app = param1;
         this._kangaContainer = new MovieClip();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._boardTextNumber = new TextField();
         this._progressMeter = param2;
         if(this._progressMeter)
         {
            this._progressMeter.visible = false;
         }
      }
      
      private function addKangaContainer() : void
      {
         addChild(this._kangaContainer);
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this._kangaContainer.visible = param1;
      }
      
      public function isRunning() : Boolean
      {
         return this._animationState != STATE_INACTIVE;
      }
      
      private function fireHit() : void
      {
         this._animationState = STATE_RETREATING;
         this.explodeGems();
      }
      
      private function playSmallAttackAnimation(param1:int) : void
      {
         this.removeKangaRubyAnimation();
         if(param1 == 0)
         {
            this._currentAnimation = new kangaLightAttack0();
         }
         else if(param1 == 1)
         {
            this._currentAnimation = new kangaLightAttack1();
         }
         else if(param1 == 2)
         {
            this._currentAnimation = new kangaLightAttack2();
         }
         else
         {
            if(param1 != 3)
            {
               throw new Error("playSmallAttackAnimation index off");
            }
            this._currentAnimation = new kangaLightAttack3();
         }
         this.addKangaContainer();
         this._kangaContainer.addChild(this._currentAnimation);
         if(TIMER_BASED_ANIMATION)
         {
            this._currentAnimation.stop();
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_KANGARUBY);
         this._animationHitTimer = 99;
      }
      
      private function playBigAttackAnimation(param1:int) : void
      {
         this.removeKangaRubyAnimation();
         if(param1 == 0)
         {
            this._currentAnimation = new kangaMedAttack0();
         }
         else
         {
            if(param1 != 1)
            {
               throw new Error("playBigAttackAnimation index off");
            }
            this._currentAnimation = new kangaMedAttack1();
         }
         this.addKangaContainer();
         this._kangaContainer.addChild(this._currentAnimation);
         if(TIMER_BASED_ANIMATION)
         {
            this._currentAnimation.stop();
         }
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_KANGARUBY);
         this._animationHitTimer = 122;
      }
      
      private function playPrestigeAnimation() : void
      {
         this.removeKangaRubyAnimation();
         this._prestigeIndex = 0;
         this._justLeftHitFrame = false;
         switch(this.getKangaIndex())
         {
            case 0:
               this._currentAnimation = new kangaPrestige();
               break;
            case 1:
               this._currentAnimation = new kangaPrestige2();
               break;
            case 2:
               this._currentAnimation = new kangaPrestige3();
               break;
            default:
               this._currentAnimation = new kangaPrestige();
         }
         this.addKangaContainer();
         this._kangaContainer.addChild(this._currentAnimation);
         if(TIMER_BASED_ANIMATION)
         {
            this._currentAnimation.stop();
         }
      }
      
      private function playIntroAnimation() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         this.removeKangaRubyAnimation();
         this._currentAnimation = new kangaEnter1();
         this.addKangaContainer();
         this._kangaContainer.addChild(this._currentAnimation);
         this._progressMeter.gotoAndStop(1);
         this._animationHitTimer = 400;
         if(Constants.IS_BETA)
         {
            _loc1_ = this._currentKangaRubyRGLogic.getCurrentBoardPatternsIndex();
            _loc2_ = "Seed ";
            this._boardTextNumber.text = String(_loc2_ + _loc1_);
            this._boardTextNumber.x = 283;
            this._boardTextNumber.y = 402;
            this._boardTextNumber.mouseEnabled = false;
            Blitz3Game(this._app).metaUI.addChild(this._boardTextNumber);
         }
      }
      
      private function removeKangaRubyAnimation() : void
      {
         if(this._currentAnimation && this._kangaContainer.contains(this._currentAnimation))
         {
            this._kangaContainer.removeChild(this._currentAnimation);
         }
         this._currentAnimation = null;
      }
      
      private function removeDigeridooAnimation() : void
      {
         this._progressMeter.gotoAndStop(1);
      }
      
      private function getKangaIndex() : int
      {
         var _loc1_:RGLogic = this._app.logic.rareGemsLogic.currentRareGem;
         if(_loc1_ != null)
         {
            if(_loc1_.getStringID() == KangaRubySecondRGLogic.ID)
            {
               return 1;
            }
            if(_loc1_.getStringID() == KangaRubyThirdRGLogic.ID)
            {
               return 2;
            }
         }
         return 0;
      }
      
      public function init() : void
      {
         this._kangaRubyFirstLogic = this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubyFirstRGLogic.ID) as KangaRubyFirstRGLogic;
         this._kangaRubyFirstLogic.AddHandler(this);
         this._kangaRubySecondLogic = this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubySecondRGLogic.ID) as KangaRubySecondRGLogic;
         this._kangaRubySecondLogic.AddHandler(this);
         this._kangaRubyThirdLogic = this._app.logic.rareGemsLogic.GetRareGemByStringID(KangaRubyThirdRGLogic.ID) as KangaRubyThirdRGLogic;
         this._kangaRubyThirdLogic.AddHandler(this);
         this._currentKangaRubyRGLogic = this._kangaRubyFirstLogic;
         this._currentCoinsPerRubyPayout = KangaRubyRGLogic.COINS_PER_RUBY_PAYOUT;
         this._app.logic.AddHandler(this);
         this._animationState = STATE_INACTIVE;
         this._coinPrestigePauseCounter = 5;
         this._animationHitTimer = 0;
         this.removeKangaRubyAnimation();
      }
      
      public function reset() : void
      {
         this._currentRound = 0;
         this._coinPrestigePauseCounter = 5;
      }
      
      public function destroy() : void
      {
         this._isIconforProgressBarAttached = false;
         this._currentRound = 0;
         this._coinPrestigePauseCounter = 5;
         this.removeKangaRubyAnimation();
         this.removeDigeridooAnimation();
         this._animationState = STATE_INACTIVE;
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         if(this._animationState != STATE_PRESTIGE && this._animationState != STATE_PRESTIGE_COIN_TIME && this._isIconforProgressBarAttached)
         {
            --this._coinPrestigePauseCounter;
            _loc1_ = Math.round(this._currentKangaRubyRGLogic.getTimeLeftBeforeAttack() * 100);
            this._progressMeter.gotoAndStop(_loc1_);
         }
         if(this._animationState == STATE_INACTIVE || this._animationState == STATE_PAUSED)
         {
            return;
         }
         ++this._animationFrameCounter;
         if(this._currentAnimation && this._animationFrameCounter % 3 == 0)
         {
            this._currentAnimation.nextFrame();
         }
         if(this._animationState == STATE_INTRO)
         {
            --this._animationHitTimer;
            if(this._animationHitTimer == 0)
            {
               this.removeIntroAnimation();
            }
         }
         else if(this._animationState == KangaRubyRGLogic.SMALL_ATTACK || this._animationState == KangaRubyRGLogic.MEDIUM_ATTACK)
         {
            --this._animationHitTimer;
            if(this._animationHitTimer == 0)
            {
               this.fireHit();
            }
         }
         else if(this._animationState == STATE_RETREATING)
         {
            if(this._currentAnimation.currentFrame == this._currentAnimation.totalFrames)
            {
               this._animationState = STATE_INACTIVE;
               this.removeKangaRubyAnimation();
            }
         }
         else if(this._animationState == STATE_PRESTIGE)
         {
            if(!this._currentAnimation)
            {
               return;
            }
            if(!this._currentAnimation.currentFrameLabel)
            {
               this._justLeftHitFrame = false;
               if(this._currentAnimation.currentFrame == this._currentAnimation.totalFrames)
               {
                  if(this._app.logic.board.IsStill())
                  {
                     this._animationState = STATE_PRESTIGE_COIN_TIME;
                     this.showRubyBonus();
                  }
               }
               return;
            }
            _loc2_ = this._currentAnimation.currentFrameLabel.substr(0,3);
            if(_loc2_ == "hit" && !this._justLeftHitFrame)
            {
               if(this._prestigeIndex >= KangaRubyAttackPatternsFirst.NUM_PRESTIGE_HITS)
               {
                  return;
               }
               this.explodePrestigeGems(this._prestigeIndex);
               ++this._prestigeIndex;
               this._justLeftHitFrame = true;
            }
            else if(_loc2_ == "sha" && !this._justLeftHitFrame)
            {
               this.shakeBoard();
               this._justLeftHitFrame = true;
            }
            else
            {
               this._currentAnimation.play();
            }
         }
         else if(this._animationState == STATE_PRESTIGE_COIN_TIME)
         {
            _loc3_ = this._app.sessionData.configManager.GetInt(ConfigManager.INT_TIP_KANGA_RUBY_END);
            if(this._coinPrestigeMC.currentFrameLabel == "numbers increase" || this._coinPrestigeMC.currentFrameLabel == "numbers increasing")
            {
               if(!this._coinTallyStarted)
               {
                  this.startCoinTally();
               }
            }
            else if(this._coinPrestigeMC.currentFrameLabel == "tutorial")
            {
               if(_loc3_ >= 2)
               {
                  this._coinPrestigeMC.gotoAndPlay("fadeOut");
               }
            }
            else if(this._coinPrestigeMC.currentFrameLabel == "end")
            {
               _loc3_++;
               this._app.sessionData.configManager.SetInt(ConfigManager.INT_TIP_KANGA_RUBY_END,_loc3_);
               if(this._coinPrestigeMC)
               {
                  this._coinPrestigeMC.parent.removeChild(this._coinPrestigeMC);
                  this._app.topLayer.removeChild((this._app.ui as MainWidgetGame).game.KangarubyAlignment);
               }
               this._coinPrestigeMC = null;
               this._currentKangaRubyRGLogic.AttackAnimationComplete();
               this._animationState = STATE_INACTIVE;
               this.removeKangaRubyAnimation();
               this.removeDigeridooAnimation();
            }
         }
      }
      
      private function shakeBoard() : void
      {
         var _loc1_:Sprite = (this._app.ui as MainWidgetGame).game.board as Sprite;
         var _loc3_:Number = _loc1_.y;
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_ - 8,
            "rotation":-0.3 + Math.random() * 0.3 * 2
         });
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_,
            "rotation":0,
            "delay":0.1
         });
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_ - 8 / 2,
            "rotation":-0.3 / 2 + Math.random() * 0.3,
            "delay":0.1 * 2
         });
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_,
            "rotation":0,
            "delay":0.1 * 3
         });
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_ - 8 / 4,
            "rotation":-0.3 / 4 + Math.random() * 0.3 / 2,
            "delay":0.1 * 4
         });
         Tweener.addTween(_loc1_,{
            "time":0.1,
            "y":_loc3_,
            "rotation":0,
            "delay":0.1 * 5
         });
      }
      
      private function removeIntroAnimation() : void
      {
         this._animationState = STATE_INACTIVE;
         this.removeKangaRubyAnimation();
         this._currentKangaRubyRGLogic.AttackAnimationComplete();
      }
      
      private function showRubyBonus() : void
      {
         this._coinTallyStarted = false;
         this._coinPrestigeMC = new PrestigeScreen();
         this._coinPrestigeMC.belt.rubyT.text = "0";
         this._coinPrestigeMC.belt.coinsMC.coinsT.text = "0";
         this.adjustCoinsTextFieldPositioning();
         this._app.topLayer.addChild((this._app.ui as MainWidgetGame).game.KangarubyAlignment);
         (this._app.ui as MainWidgetGame).game.KangarubyAlignment.addChild(this._coinPrestigeMC);
      }
      
      private function adjustCoinsTextFieldPositioning() : void
      {
         var _loc1_:Number = this._coinPrestigeMC.belt.coinsMC.coinMC.width + 2 + this._coinPrestigeMC.belt.coinsMC.coinsT.textWidth;
         var _loc2_:Number = -(_loc1_ / 2) + this._coinPrestigeMC.belt.coinsMC.coinMC.width / 2;
         this._coinPrestigeMC.belt.coinsMC.coinMC.x = _loc2_;
         this._coinPrestigeMC.belt.coinsMC.coinsT.x = _loc2_ + 19;
      }
      
      private function startCoinTally() : void
      {
         var rubyRollUp:TextFieldRollUpAdapter = null;
         var coinRollUp:TextFieldRollUpAdapter = null;
         var rubyBonus:int = this._currentKangaRubyRGLogic.NumberOfRubysDestroyed();
         var coinBonus:int = this._currentCoinsPerRubyPayout * rubyBonus;
         rubyRollUp = new TextFieldRollUpAdapter(this._coinPrestigeMC.belt.rubyT,rubyBonus,800);
         rubyRollUp.start();
         coinRollUp = new TextFieldRollUpAdapter(this._coinPrestigeMC.belt.coinsMC.coinsT,coinBonus,800,this.adjustCoinsTextFieldPositioning,function():void
         {
            _coinPrestigeMC.gotoAndPlay("outro");
            _coinPrestigeMC.belt.gotoAndPlay("outro");
         });
         coinRollUp.start();
         this._coinTallyStarted = true;
      }
      
      public function Pause() : void
      {
      }
      
      public function Resume() : void
      {
      }
      
      public function HandleKangaRubyAnimation(param1:String, param2:int) : void
      {
         (this._app.ui as MainWidgetGame).game.kangaRuby.setVisible(true);
         this._currentCoinsPerRubyPayout = KangaRubyRGLogic.COINS_PER_RUBY_PAYOUT;
         switch(this.getKangaIndex())
         {
            case 0:
               this._currentKangaRubyRGLogic = this._kangaRubyFirstLogic;
               break;
            case 1:
               this._currentKangaRubyRGLogic = this._kangaRubySecondLogic;
               break;
            case 2:
               this._currentKangaRubyRGLogic = this._kangaRubyThirdLogic;
               break;
            default:
               this._currentKangaRubyRGLogic = this._kangaRubyFirstLogic;
         }
         this._animationState = param1;
         this._attackType = param1;
         this._attackIndex = param2;
         this._animationFrameCounter = 0;
         if(param1 == KangaRubyRGLogic.SMALL_ATTACK)
         {
            this.playSmallAttackAnimation(param2);
         }
         else if(param1 == KangaRubyRGLogic.MEDIUM_ATTACK)
         {
            this.playBigAttackAnimation(param2);
         }
         else if(param1 == KangaRubyRGLogic.PRESTIGE_ATTACK)
         {
            this._animationState = STATE_PRESTIGE;
            this.playPrestigeAnimation();
         }
         else if(param1 == KangaRubyRGLogic.INTRO_ATTACK)
         {
            this._animationState = STATE_INTRO;
            this.playIntroAnimation();
         }
         ++this._currentRound;
      }
      
      private function explodeGems() : void
      {
         this._currentKangaRubyRGLogic.ExplodeCurrentPattern();
      }
      
      private function explodePrestigeGems(param1:int) : void
      {
         this._currentKangaRubyRGLogic.ExplodePrestigePattern(param1);
      }
      
      private function attachProgressBarIcon() : void
      {
         var _loc2_:RareGemWidget = null;
         if(this._isIconforProgressBarAttached)
         {
            return;
         }
         if(this._app.logic.rareGemsLogic.currentRareGem == null)
         {
            return;
         }
         this._progressMeter.visible = true;
         var _loc1_:String = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         if(_loc1_ != "" && this._app.sessionData.rareGemManager.GetCatalog()[_loc1_] != null)
         {
            _loc2_ = new RareGemWidget(this._app,new DynamicRareGemLoader(this._app),"small",0,0);
            _loc2_.reset(this._app.logic.rareGemsLogic.GetRareGemByStringID(_loc1_));
            Utils.removeAllChildrenFrom(this._progressMeter.RGPlaceholder);
            this._progressMeter.RGPlaceholder.addChild(_loc2_);
            this._isIconforProgressBarAttached = true;
         }
      }
      
      public function HandleGameLoad() : void
      {
      }
      
      public function HandleGameBegin() : void
      {
         if(this._animationState == STATE_INACTIVE)
         {
            return;
         }
         this.attachProgressBarIcon();
      }
      
      public function HandleGameEnd() : void
      {
         this.destroy();
         this._progressMeter.visible = false;
      }
      
      public function HandleGameAbort() : void
      {
         this.destroy();
      }
      
      public function HandleGamePaused() : void
      {
         this.Pause();
      }
      
      public function HandleGameResumed() : void
      {
         this.Resume();
      }
      
      public function HandleScore(param1:ScoreValue) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
      }
      
      public function HandleGameTimeDelayed() : void
      {
      }
   }
}
