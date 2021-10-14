package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.finisher.FinisherConfig;
   import com.popcap.flash.bejeweledblitz.game.session.ThrottleManager;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.game.ui.pause.IPauseMenuHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemWidget;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.Point2D;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherActor;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherEvent;
   import com.popcap.flash.bejeweledblitz.logic.finisher.FinisherProp;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherAnimHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherEntryIntroHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherIndicator;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherIntroHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherPopupHandler;
   import com.popcap.flash.bejeweledblitz.logic.finisher.interfaces.IFinisherUI;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.RGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class FinisherFacade implements IFinisherUI, IFinisherIndicator, IPauseMenuHandler
   {
      
      public static const INTRO_ANIM:String = "Intro";
      
      public static const EXIT_ANIM:String = "Exit";
      
      public static const FINISHER_ACTOR:String = "Action";
      
      public static const FINISHER_PROP:String = "Prop";
      
      public static const FINISHER_AWESOME_GAME_INTRO:String = "AwesomeGame";
      
      public static const FINISHER_POPUP:String = "Popup";
      
      public static const FINISHER_SHOW:String = "Show";
      
      public static const FINISHER_FRAME_INDICATOR:String = "Frame";
      
      public static const FINISHER_BADGE:String = "Badge";
      
      public static const FINISHER_PROGRESS:String = "Progressbar";
      
      public static const FINISHER_PREPRESTIGE:String = "Lasthurrah";
       
      
      private var finisherWidget:FinisherWidget = null;
      
      private var app:Blitz3App = null;
      
      private var stateCount:int = -1;
      
      private var logic:BlitzLogic = null;
      
      private var loader:FinisherItemLoader;
      
      private var currentFinisherId:String;
      
      private var finisherEvent:FinisherEvent;
      
      private var finisherConfig:FinisherConfig;
      
      private var finisherEntryIntroWidget:FinisherEntryIntroWidget = null;
      
      private var finisherIntroWidget:FinisherIntroWidget = null;
      
      private var finisherPopupWidget:FinisherPopupWidget = null;
      
      private var finisherActorWidget:FinisherActorWidget = null;
      
      private var finisherPropSafeHandler:MovieClip = null;
      
      private var propVsWidget:Dictionary;
      
      private var isCharacterAnimPreprestige:Boolean = false;
      
      private var isPrimaryPopup:Boolean = false;
      
      private var finisherPopupHandler:IFinisherPopupHandler = null;
      
      public function FinisherFacade(param1:Blitz3App)
      {
         super();
         this.app = param1;
         this.logic = this.app.logic;
         this.finisherEvent = null;
         this.propVsWidget = new Dictionary();
         (this.app.ui as MainWidgetGame).pause.AddHandler(this);
      }
      
      public function AddAsIndicatorHandler() : void
      {
         this.logic.finisherIndicatorLogic.AddIndicatorHandler(this);
         var _loc1_:MovieClip = this.finisherWidget.getFinisherIndicatorWidget();
         if(_loc1_ == null)
         {
            return;
         }
         (this.app.ui as MainWidgetGame).game.board.frame.CreateFinisherFrameIndicators(_loc1_);
      }
      
      public function RemoveAsIndicatorHandler() : void
      {
         this.logic.finisherIndicatorLogic.RemoveIndicatorHandler(this);
         (this.app.ui as MainWidgetGame).game.board.frame.RemoveFinisherFrameIndicator();
      }
      
      public function HandleFinisherIndicatorBegin() : void
      {
         this.finisherWidget.playSound("BoardChange");
         (this.app.ui as MainWidgetGame).game.board.forceFinisherIndiciatorEffects = true;
      }
      
      public function HandleFinisherIndicatorEnd() : void
      {
         (this.app.ui as MainWidgetGame).game.board.forceFinisherIndiciatorEffects = false;
      }
      
      public function HandleFinisherIndicatorReset() : void
      {
      }
      
      public function HandleFinisherIndicatorPercentChanged(param1:Number) : void
      {
      }
      
      public function IsLoaded() : Boolean
      {
         return this.finisherWidget != null && this.finisherConfig != null;
      }
      
      public function setCurrentStateId(param1:int) : void
      {
         this.stateCount = param1;
      }
      
      public function showGo() : void
      {
         this.app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_GO);
         (this.app.ui as MainWidgetGame).game.board.compliments.showGo();
      }
      
      public function showBonusTime(param1:int, param2:int) : void
      {
         var _loc3_:Array = new Array();
         var _loc4_:String = param1.toString();
         if(param1 < 10)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:String = param2.toString();
         if(param2 < 10)
         {
            _loc5_ = "0" + _loc5_;
         }
         _loc3_.push(_loc4_);
         _loc3_.push(_loc5_);
         (this.app.ui as MainWidgetGame).game.board.compliments.showTime(_loc3_,"EXTRA TIME");
      }
      
      public function showEntryIntroWidget() : void
      {
         this.finisherEntryIntroWidget = this.finisherWidget.getFinisherEntryIntroWidget();
         if(this.finisherEntryIntroWidget == null)
         {
            return;
         }
         this.playActorSoundForAnim(FinisherActor.FINISHER_ACTOR_ANIM_SHOW);
         this.finisherEntryIntroWidget.AddToStage();
      }
      
      public function updateEntryIntroWidget() : void
      {
         if(this.finisherEntryIntroWidget == null)
         {
            return;
         }
         this.finisherEntryIntroWidget.Update();
      }
      
      public function hideEntryIntroWidget() : void
      {
         if(this.finisherEntryIntroWidget == null)
         {
            return;
         }
         this.finisherEntryIntroWidget.RemoveFromStage();
         this.finisherEntryIntroWidget = null;
      }
      
      public function showIntroWidget() : void
      {
         this.finisherIntroWidget = this.finisherWidget.getFinisherIntroWidget();
         if(this.finisherIntroWidget == null)
         {
            return;
         }
         this.finisherIntroWidget.AddToStage();
      }
      
      public function hideIntroWidget() : void
      {
         if(this.finisherIntroWidget == null)
         {
            return;
         }
         this.finisherIntroWidget.RemoveFromStage();
         this.finisherIntroWidget = null;
      }
      
      public function updateIntroWidget() : void
      {
         if(this.finisherIntroWidget != null)
         {
            this.finisherIntroWidget.Update();
         }
      }
      
      public function AddEntryIntroAnimHandler(param1:IFinisherEntryIntroHandler) : void
      {
         if(this.finisherEntryIntroWidget != null)
         {
            this.finisherEntryIntroWidget.AddAnimationCompleteHandler(param1);
         }
      }
      
      public function RemoveEntryIntroAnimHandler(param1:IFinisherEntryIntroHandler) : void
      {
         if(this.finisherEntryIntroWidget != null)
         {
            this.finisherEntryIntroWidget.RemoveAnimationCompleteHandler(param1);
         }
      }
      
      public function AddIntroAnimHandler(param1:IFinisherIntroHandler) : void
      {
         if(this.finisherIntroWidget != null)
         {
            this.finisherIntroWidget.AddAnimationCompleteHandler(param1);
         }
      }
      
      public function RemoveIntroAnimHandler(param1:IFinisherIntroHandler) : void
      {
         if(this.finisherIntroWidget != null)
         {
            this.finisherIntroWidget.RemoveAnimationCompleteHandler(param1);
         }
      }
      
      public function generateProp(param1:FinisherActor, param2:Gem, param3:Number, param4:Boolean) : FinisherProp
      {
         if(this.finisherActorWidget == null)
         {
            return null;
         }
         if(this.finisherPropSafeHandler == null)
         {
            this.finisherPropSafeHandler = new MovieClip();
            this.app.addChild(this.finisherPropSafeHandler);
         }
         if(param4)
         {
            this.finisherWidget.playSound(FinisherFacade.FINISHER_PROP);
         }
         var _loc5_:FinisherPropWidget;
         if((_loc5_ = this.finisherWidget.getFinisherPropWidget()) == null)
         {
            return null;
         }
         this.finisherPropSafeHandler.addChild(_loc5_.getBaseMovie());
         _loc5_.setPosition(this.finisherActorWidget.getPropSpawningPosition());
         var _loc6_:FinisherProp = new FinisherProp(this as IFinisherUI,param1);
         var _loc7_:Point = new Point(param2.x * GemSprite.GEM_SIZE + 20,param2.y * GemSprite.GEM_SIZE + 20);
         var _loc8_:Point = (this.app.ui as MainWidgetGame).game.board.gemLayer.localToGlobal(_loc7_);
         var _loc9_:Point2D;
         (_loc9_ = new Point2D()).Set(_loc8_.x,_loc8_.y);
         var _loc10_:Point2D;
         (_loc10_ = new Point2D()).Set(_loc5_.getPosition().x,_loc5_.getPosition().y);
         var _loc11_:Number = -Math.atan2(_loc9_.x - _loc10_.x,_loc9_.y - _loc10_.y) * 180 / Math.PI;
         _loc5_.setRotation(_loc11_);
         _loc5_.SetVisible(param4);
         _loc6_.MoveTo(param2,param3);
         this.propVsWidget[_loc6_] = _loc5_;
         return _loc6_;
      }
      
      public function updatePropPosition(param1:FinisherProp, param2:Gem, param3:Number, param4:Number) : void
      {
         var _loc5_:FinisherPropWidget = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc8_:Point = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Point = null;
         var _loc13_:Number = NaN;
         if(this.propVsWidget[param1] != null)
         {
            _loc5_ = this.propVsWidget[param1] as FinisherPropWidget;
            _loc6_ = new Point(param2.x * GemSprite.GEM_SIZE + 20,param2.y * GemSprite.GEM_SIZE + 20);
            _loc7_ = (this.app.ui as MainWidgetGame).game.board.gemLayer.localToGlobal(_loc6_);
            _loc8_ = _loc5_.getPosition();
            _loc9_ = Utils.GetDistanceBetweenPoints(_loc7_,_loc8_);
            _loc11_ = (_loc10_ = param3 / _loc9_) * param4;
            (_loc12_ = new Point()).x = _loc8_.x + (_loc7_.x - _loc8_.x) * _loc11_;
            _loc12_.y = _loc8_.y + (_loc7_.y - _loc8_.y) * _loc11_;
            _loc5_.setPosition(_loc12_);
            _loc13_ = -Math.atan2(_loc7_.x - _loc8_.x,_loc7_.y - _loc8_.y) * 180 / Math.PI;
            _loc5_.setRotation(_loc13_);
            if(_loc11_ >= 1)
            {
               param1.actor.OnCollide(param1);
            }
         }
      }
      
      public function destroyProp(param1:FinisherProp) : void
      {
         var _loc2_:FinisherPropWidget = null;
         if(this.propVsWidget[param1] != null)
         {
            _loc2_ = this.propVsWidget[param1] as FinisherPropWidget;
            _loc2_.RemoveFromStage();
            _loc2_ = null;
            delete this.propVsWidget[param1];
         }
      }
      
      public function showActor() : void
      {
         this.finisherActorWidget = this.finisherWidget.getFinisherActorWidget();
         if(this.finisherActorWidget == null)
         {
            return;
         }
         this.finisherActorWidget.SetAudioPlayfn(this.playActorSoundForAnim);
         this.finisherWidget.playSound(FinisherFacade.FINISHER_ACTOR);
         this.finisherActorWidget.AddToStage();
         this.ShowFinisherProgress();
      }
      
      public function updateActor() : void
      {
         if(this.finisherActorWidget != null)
         {
            this.finisherActorWidget.Update();
         }
      }
      
      public function hideActor() : void
      {
         this.finisherActorWidget.RemoveFromStage();
         this.finisherActorWidget = null;
      }
      
      public function showPopupWidget() : Boolean
      {
         if(this.finisherConfig.GetFinisherPopupConfig() == null)
         {
            return false;
         }
         this.finisherPopupWidget = this.finisherWidget.getFinisherPopupWidget(this.finisherConfig.GetFinisherPopupConfig());
         if(this.finisherPopupWidget == null)
         {
            return false;
         }
         this.finisherPopupWidget.SetInfo(this);
         this.finisherPopupWidget.AddToStage();
         return true;
      }
      
      public function getPopupWidget() : FinisherPopupWidget
      {
         return this.finisherPopupWidget;
      }
      
      public function hidePopupWidget(param1:Boolean) : void
      {
         if(param1)
         {
            this.app.SoundManager.playSound(Blitz3GameSounds.SOUND_VOICE_EXTRA_TIME);
         }
         if(this.finisherPopupWidget != null)
         {
            this.finisherPopupWidget.RemoveFromStage();
            this.finisherPopupWidget = null;
         }
      }
      
      public function updatePopup(param1:Number) : void
      {
         if(this.finisherPopupWidget != null)
         {
            this.finisherPopupWidget.Update(param1);
         }
      }
      
      public function AddPopupHandler(param1:IFinisherPopupHandler) : void
      {
         if(this.finisherPopupWidget == null)
         {
            return;
         }
         this.finisherPopupWidget.AddHandler(param1);
         this.finisherPopupWidget.AddHandler(this.app.sessionData.finisherManager);
      }
      
      public function RemovePopupHandler(param1:IFinisherPopupHandler) : void
      {
         if(this.finisherPopupWidget == null)
         {
            return;
         }
         this.finisherPopupWidget.RemoveHandler(param1);
         this.finisherPopupWidget.RemoveHandler(this.app.sessionData.finisherManager);
      }
      
      public function AddActorAnimationCompleteHandler(param1:IFinisherAnimHandler) : void
      {
         if(this.finisherActorWidget == null)
         {
            return;
         }
         this.finisherActorWidget.AddAnimationCompleteHandler(param1);
      }
      
      public function RemoveActorAnimationCompleteHandler(param1:IFinisherAnimHandler) : void
      {
         if(this.finisherActorWidget == null)
         {
            return;
         }
         this.finisherActorWidget.RemoveAnimationCompleteHandler(param1);
      }
      
      public function playActor(param1:int, param2:int, param3:int) : void
      {
         if(this.finisherActorWidget == null)
         {
            return;
         }
         this.finisherActorWidget.Parse(param1,param2);
         this.finisherActorWidget.Play(param3);
      }
      
      public function disableTimeUpSound() : void
      {
         this.app.logic.timerLogic.RemoveTimeChangeHandler((this.app.ui as MainWidgetGame).game.soundDirector);
      }
      
      public function enableTimeUpSound() : void
      {
         this.app.logic.timerLogic.AddTimeChangeHandler((this.app.ui as MainWidgetGame).game.soundDirector);
      }
      
      public function getFinisherBadge() : MovieClip
      {
         if(this.finisherWidget != null)
         {
            return this.finisherWidget.getFinisherBadgeWidget();
         }
         return null;
      }
      
      public function ShowFinisherProgress() : void
      {
         if(this.finisherIntroWidget == null)
         {
            return;
         }
         this.finisherIntroWidget.AddToStage();
      }
      
      public function LoadFinisher(param1:String, param2:String) : void
      {
         this.currentFinisherId = param1;
         this.loader = new FinisherItemLoader(this.app);
         this.loader.load(param2,this.OnLoadProgress,this.OnLoadComplete);
      }
      
      public function IsCompleted() : Boolean
      {
         return this.finisherEvent != null && this.finisherEvent.IsDone();
      }
      
      public function SetFinisherState(param1:String) : void
      {
         this.finisherEvent.SetStartState(param1);
      }
      
      public function Reset() : void
      {
         if(this.finisherEvent != null)
         {
            this.finisherEvent.Reset();
            this.finisherEvent = null;
            this.ResetCharacterConfig();
         }
         this.propVsWidget = new Dictionary();
      }
      
      public function OnLoadProgress(param1:Number) : void
      {
      }
      
      public function OnLoadComplete() : void
      {
         this.finisherConfig = this.app.sessionData.finisherManager.GetConfigFor(this.currentFinisherId);
         this.finisherWidget = this.loader.getFinisherWidget(this.finisherConfig.GetAssetID());
         this.loader = null;
      }
      
      public function ShouldShowFinisher(param1:Boolean = false) : Boolean
      {
         var _loc2_:Boolean = this.app.sessionData.throttleManager.IsEnabled(ThrottleManager.THROTTLE_ENABLE_FINISHER);
         var _loc3_:Boolean = _loc2_ && this.finisherWidget != null && this.finisherEvent == null;
         if(!param1)
         {
            _loc3_ = _loc3_ && this.finisherConfig.ShouldShowFinisher();
         }
         return _loc3_;
      }
      
      public function ShowFinisher(param1:Function = null, param2:Boolean = false, param3:IFinisherPopupHandler = null) : void
      {
         this.finisherEvent = new FinisherEvent(this as IFinisherUI,this.logic,this.GetFinisherConfig());
         this.app.logic.AddBlockingButStillUpdateEvent(this.finisherEvent);
         this.app.network.HandleFinisherLunched(true);
         this.app.sessionData.finisherSessionData.Reset();
         this.app.sessionData.finisherSessionData.FinisherIsSurfaced();
         this.finisherEvent.SetEndCallback(param1);
         this.isPrimaryPopup = param2;
         this.finisherPopupHandler = param3;
      }
      
      public function SetEndCallBackForCharacterEvent(param1:Function = null) : void
      {
         this.finisherEvent.SetEndCallback(param1);
      }
      
      public function GetFinisherConfig() : FinisherConfig
      {
         return this.finisherConfig;
      }
      
      public function IsPrimaryPopup() : Boolean
      {
         return this.isPrimaryPopup;
      }
      
      public function SetConfigForPrePrestigeAnimation() : Boolean
      {
         this.isCharacterAnimPreprestige = true;
         DynamicRareGemWidget.destroyProgressBar();
         return this.finisherConfig.SetConfigForPrePrestige();
      }
      
      public function ResetCharacterConfig() : void
      {
         this.isCharacterAnimPreprestige = false;
         this.finisherConfig.ResetConfig();
      }
      
      private function playActorSoundForAnim(param1:int) : void
      {
         var _loc2_:* = null;
         if(this.isCharacterAnimPreprestige)
         {
            _loc2_ = FinisherFacade.FINISHER_PREPRESTIGE;
            if(param1 == FinisherActor.FINISHER_ACTOR_ANIM_GLOBAL_INTRO)
            {
               this.PlaySound(_loc2_);
            }
            return;
         }
         _loc2_ = FinisherFacade.FINISHER_ACTOR;
         switch(param1)
         {
            case FinisherActor.FINISHER_ACTOR_ANIM_GLOBAL_INTRO:
               _loc2_ += "Enter";
               break;
            case FinisherActor.FINISHER_ACTOR_ANIM_GLOBAL_EXIT:
               _loc2_ += "Exit";
               break;
            case FinisherActor.FINISHER_ACTOR_ANIM_SHOW:
               _loc2_ += "Intro";
               break;
            case FinisherActor.FINISHER_ACTOR_ANIM_STATE_INTRO:
               _loc2_ += "State";
               break;
            case FinisherActor.FINISHER_ACTOR_ANIM_STATE_ACTION:
            case FinisherActor.FINISHER_ACTOR_ANIM_STATE_EXIT:
            default:
               return;
         }
         this.PlaySound(_loc2_);
      }
      
      public function PlaySound(param1:String) : void
      {
         this.finisherWidget.playSound(param1);
      }
      
      public function HandlePauseMenuOpened() : void
      {
         var _loc1_:FinisherPropWidget = null;
         if(this.finisherEntryIntroWidget)
         {
            this.finisherEntryIntroWidget.SetVisible(false);
         }
         if(this.finisherIntroWidget)
         {
            this.finisherIntroWidget.SetVisible(false);
         }
         if(this.finisherPopupWidget)
         {
            this.finisherPopupWidget.SetVisible(false);
         }
         if(this.finisherActorWidget)
         {
            this.finisherActorWidget.SetVisible(false);
         }
         for each(_loc1_ in this.propVsWidget)
         {
            _loc1_.SetVisible(false);
         }
      }
      
      public function HandlePauseMenuCloseClicked() : void
      {
         var _loc1_:FinisherPropWidget = null;
         if(this.finisherEntryIntroWidget)
         {
            this.finisherEntryIntroWidget.SetVisible(true);
         }
         if(this.finisherIntroWidget)
         {
            this.finisherIntroWidget.SetVisible(true);
         }
         if(this.finisherPopupWidget)
         {
            this.finisherPopupWidget.SetVisible(true);
         }
         if(this.finisherActorWidget)
         {
            this.finisherActorWidget.SetVisible(true);
         }
         for each(_loc1_ in this.propVsWidget)
         {
            _loc1_.SetVisible(true);
         }
      }
      
      private function RemoveFinisher() : void
      {
         var _loc1_:FinisherPropWidget = null;
         if(this.finisherEntryIntroWidget)
         {
            this.finisherEntryIntroWidget.RemoveFromStage();
            this.finisherEntryIntroWidget = null;
         }
         if(this.finisherIntroWidget)
         {
            this.finisherIntroWidget.RemoveFromStage();
            this.finisherIntroWidget = null;
         }
         if(this.finisherPopupWidget)
         {
            this.finisherPopupWidget.RemoveFromStage();
            this.finisherPopupWidget = null;
         }
         if(this.finisherActorWidget)
         {
            this.finisherActorWidget.RemoveFromStage();
            this.finisherActorWidget = null;
         }
         for each(_loc1_ in this.propVsWidget)
         {
            _loc1_.RemoveFromStage();
         }
         if(this.finisherPropSafeHandler)
         {
            this.app.removeChild(this.finisherPropSafeHandler);
            this.finisherPropSafeHandler = null;
         }
      }
      
      public function HandlePauseMenuResetClicked() : void
      {
         this.ResetInGame();
      }
      
      public function ResetInGame() : void
      {
         this.app.sessionData.finisherManager.Reset();
         this.RemoveFinisher();
      }
      
      public function HandlePauseMenuMainClicked() : void
      {
         this.ResetInGame();
      }
      
      public function ShouldBlockWaitState() : Boolean
      {
         var _loc1_:RGLogic = Blitz3App.app.logic.rareGemsLogic.currentRareGem;
         if(_loc1_ && _loc1_.getLinkedCharacter())
         {
            return _loc1_.getLinkedCharacter().IsPlyingOnScreen();
         }
         return false;
      }
   }
}
