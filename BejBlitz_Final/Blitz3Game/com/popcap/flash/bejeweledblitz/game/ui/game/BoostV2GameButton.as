package com.popcap.flash.bejeweledblitz.game.ui.game
{
   import com.boosts.BoostExplosion;
   import com.boosts.BoostFormation;
   import com.boosts.trail;
   import com.boosts.trailBlue;
   import com.boosts.trailGreen;
   import com.boosts.trailOrange;
   import com.boosts.trailPurple;
   import com.boosts.trailRed;
   import com.boosts.trailWhite;
   import com.boosts.trailYellow;
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.BoostAssetLoaderInterface;
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostInGameInfo;
   import com.popcap.flash.bejeweledblitz.game.boostV2.parser.BoostParticleInfo;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.BoardWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.ClockWidget;
   import com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.GemSprite;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.GemColors;
   import com.popcap.flash.bejeweledblitz.logic.SwapData;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.IBoostV2Handler;
   import com.popcap.flash.bejeweledblitz.logic.game.ActionQueue;
   import com.popcap.flash.bejeweledblitz.logic.game.ICharacterEventsHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ITimerLogicTimeDurationChangeHandler;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.NumberDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterHolderNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.particles.ColorBlast_PulseStarField;
   import com.popcap.flash.games.blitz3.Boost;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class BoostV2GameButton extends Boost implements IBoostV2Handler, ITimerLogicTimeChangeHandler, ITimerLogicTimeDurationChangeHandler, ICharacterEventsHandler
   {
      
      public static const BOOST_INVALID:String = "INVALID";
      
      public static const BOOST_INTERACTIVE_INACTIVE:String = "INTERACTIVE_INACTIVE";
      
      public static const BOOST_INTERACTIVE_ACTIVE:String = "INTERACTIVE_ACTIVE";
      
      public static const BOOST_INTERACTIVE_ONPRESS:String = "INTERACTIVE_ONPRESS";
      
      public static const BOOST_INTERACTIVE_SUPERCHARGED_ACTIVE:String = "INTERACTIVE_SUPERCHARGED_ACTIVE";
      
      public static const BOOST_INTERACTIVE_SUPERCHARGED_ONPRESS:String = "INTERACTIVE_SUPERCHARGED_ONPRESS";
      
      public static const BOOST_INTERACTIVE_UNAVAILABLE:String = "INTERACTIVE_UNAVAILABLE";
      
      public static const BOOST_INTERACTIVE_CONDITION_MOVES:String = "INTERACTIVE_CONDITION_MOVES";
      
      public static const BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE:String = "INTERACTIVE_CONDITION_MOVES_ACTIVE";
      
      public static const BOOST_INTERACTIVE_CONDITION_MOVES_ONPRESS:String = "INTERACTIVE_CONDITION_MOVES_ONPRESS";
      
      public static const BOOST_INTERACTIVE_CONDITION_TIMER:String = "INTERACTIVE_CONDITION_TIMER";
      
      public static const BOOST_INTERACTIVE_CONDITION_TIMER_ACTIVE:String = "INTERACTIVE_CONDITION_TIMER_ACTIVE";
      
      public static const BOOST_INTERACTIVE_CONDITION_TIMER_ONPRESS:String = "INTERACTIVE_CONDITION_TIMER_ONPRESS";
      
      public static const BOOST_NONINTERACTIVE_INACTIVE:String = "NONINTERACTIVE_INACTIVE";
      
      public static const BOOST_NONINTERACTIVE_CONDITION_TIMER:String = "NONINTERACTIVE_CONDITION_TIMER";
      
      public static const BOOST_NONINTERACTIVE_CONDITION_MOVES:String = "NONINTERACTIVE_CONDITION_MOVES";
      
      public static const BOOST_NONINTERACTIVE_CONDITION_ACTIVE:String = "NONINTERACTIVE_CONDITION_ACTIVE";
      
      public static const BOOST_NONINTERACTIVE_ACTIVE:String = "NONINTERACTIVE_ACTIVE";
      
      public static const BOOST_NONINTERACTIVE_PROC:String = "NONINTERACTIVE_PROC";
      
      public static const BOOST_NONINTERACTIVE_NOPROC:String = "NONINTERACTIVE_NOPROC";
      
      public static const BOOST_NONINTERACTIVE_UNAVAILABLE:String = "NONINTERACTIVE_UNAVAILABLE";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_CONDITION_MOVES:String = "animation_Interactive_Condition_Moves";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_CONDITION_TIMER:String = "animation_Interactive_Condition_Timer";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_ACTIVE:String = "animation_Interactive_Active";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_ONPRESS:String = "animation_Interactive_OnPress";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ACTIVE:String = "animation_Interactive_SuperCharged_Active";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ONPRESS:String = "animation_Interactive_SuperCharged_OnPress";
      
      public static const BOOST_ANIM_STATE_INTERACTIVE_UNAVAILABLE:String = "animation_Interactive_Unavailable";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_INACTIVE:String = "animation_NonInteractive_Inactive";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_CONDITION_TIMER:String = "animation_NonInteractive_Condition_Timer";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_CONDITION_MOVES:String = "animation_NonInteractive_Condition_Moves";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_ACTIVE:String = "animation_NonInteractive_Active";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_NOPROC:String = "animation_NonInteractive_NoProc";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_PROC:String = "animation_NonInteractive_Proc";
      
      public static const BOOST_ANIM_STATE_NONINTERACTIVE_UNAVAILABLE:String = "animation_NonInteractive_Unavailable";
      
      public static const BOOST_ANIM_STATE_TIMETICK:String = "animation_TimerTicking";
      
      public static const BOOST_ANIM_STATE_GLOW:String = "animation_Glow";
      
      public static const BOOST_ANIM_STATE_STRIKE:String = "animation_Strike";
      
      public static const BOOST_FEEDBACK_PARTICLE_EXPLOSION:String = "BoostExplosion";
      
      public static const BOOST_FEEDBACK_PARTICLE_FORMATION:String = "BoostFormation";
      
      public static const BOOST_PANEL_INFOTYPE_TIMELOOP:int = 1;
      
      public static const BOOST_PANEL_INFOTYPE_UNLIMITEDMOVES:int = 2;
      
      public static const BOOST_PANEL_INFOTYPE_USAGECOUNT:int = 3;
      
      public static const BOOST_PANEL_INFOTYPE_USAGECOUNTOFF:int = 4;
      
      public static const BOOST_PANEL_INFOTYPE_INFINITE:int = 5;
      
      public static const LOOPTYPE_ONCE:int = 0;
      
      public static const LOOPTYPE_INFINITE:int = -1;
      
      public static const PROGRESSTYPE_BAR:int = 0;
      
      public static const PROGRESSTYPE_RADIAL:int = 1;
       
      
      private var _boost:BoostV2;
      
      private var _app:Blitz3App;
      
      private var panelInfo:MovieClip = null;
      
      private var mProgressTimer:MovieClip = null;
      
      private var mProgressType:int = -1;
      
      private var mCrossCollectorFeedback:MovieClip = null;
      
      private var mCrossCollectorCollectLastFrame:int = -1;
      
      private var mCrossCollectorActivatedLastFrame:int = -1;
      
      private var mState:String = "INVALID";
      
      private var mNextState:String = "INVALID";
      
      private var mPrevState:String = "INVALID";
      
      private var mHandlingMultiplierBonus:Boolean = false;
      
      private var mClickIsEnabled:Boolean = true;
      
      private var mAnimLastFrame:int = -1;
      
      private var mPlayingAnimName:String = "";
      
      private var mAnimLoop:int = 0;
      
      private var mGemColors:GemColors = null;
      
      private var mColorBlastParticle:ColorBlast_PulseStarField = null;
      
      private var mCrossCollectorProgressParticle:Bitmap = null;
      
      private var mBoardWidget:BoardWidget = null;
      
      private var vfxTimer:Timer = null;
      
      private var vfxProgress:Number = 0;
      
      private var vfxInitTimer:Timer = null;
      
      private var vfxTimerHapenned:Boolean = false;
      
      private var mProgressPerc:int = 0;
      
      private var mBoostAssetsDict:Dictionary;
      
      private var mDriveStateFromConfig:Boolean = false;
      
      private var mBoostStateMap:Dictionary;
      
      private var mInfoTypesMap:Dictionary;
      
      private var mProgressTypesMap:Dictionary;
      
      private var mCharacterShownOnScreen:Boolean = false;
      
      private var mPanelWasVisible:Boolean = false;
      
      private var mBlockInitOrUpdateState:Boolean = false;
      
      private var pNode:ParameterNode;
      
      private var paramName:String;
      
      private var paramValue:Number;
      
      private var valParam:ParameterNode;
      
      private var valParamAsNumber:NumberDataTypeNode;
      
      var deg_to_rad:Number = 0.0174532925;
      
      var power:int = 0;
      
      public function BoostV2GameButton(param1:Blitz3App, param2:BoostV2)
      {
         super();
         this._app = param1;
         this._boost = param2;
         this.mBoardWidget = (this._app.ui as MainWidgetGame).game.board;
         this.panelInfo = this.Panelcondition;
         this.panelInfo.visible = false;
         this.ImagegemBacker.visible = false;
         if(this._boost == null)
         {
            return;
         }
         this.mBoostAssetsDict = new Dictionary();
         param2.AddHandler(this);
         this._app.logic.timerLogic.AddTimeChangeHandler(this);
         this._app.logic.timerLogic.AddGameDurationChangeHandler(this);
         this._app.logic.AddCharacterEventHandler(this);
         this.addEventListener(MouseEvent.CLICK,this.onIconClicked);
         this.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.Cleanup);
         this.mProgressTimer = new MovieClip();
         addChild(this.mProgressTimer);
         this.mProgressTimer.x = this.Boosticonplaceholder.x;
         this.mProgressTimer.y = this.Boosticonplaceholder.y;
         swapChildren(this.hitboxMC,this.mProgressTimer);
         this.SetProgressVisibility(false);
         this.SetProgressTimerType(PROGRESSTYPE_BAR);
         this.SetProgressTimerPercentage(0);
         this.ModifyBoostAssset(this._boost.getId(),"Active",this.Boosticonplaceholder);
         this.mGemColors = new GemColors();
         this.mDriveStateFromConfig = false;
         this.SetDisabledState();
         this.mState = BOOST_INVALID;
         this.mPrevState = BOOST_INVALID;
         this.mNextState = BOOST_INVALID;
         this.mBoostStateMap = new Dictionary();
         this.mBoostStateMap["INVALID"] = "INVALID";
         this.mBoostStateMap["INTERACTIVE_INACTIVE"] = "INTERACTIVE_INACTIVE";
         this.mBoostStateMap["INTERACTIVE_CONDITION_MOVES"] = "INTERACTIVE_CONDITION_MOVES";
         this.mBoostStateMap["INTERACTIVE_CONDITION_MOVES_ACTIVE"] = "INTERACTIVE_CONDITION_MOVES_ACTIVE";
         this.mBoostStateMap["INTERACTIVE_CONDITION_MOVES_ONPRESS"] = "INTERACTIVE_CONDITION_MOVES_ONPRESS";
         this.mBoostStateMap["INTERACTIVE_CONDITION_TIMER"] = "INTERACTIVE_CONDITION_TIMER";
         this.mBoostStateMap["INTERACTIVE_CONDITION_TIMER_ACTIVE"] = "INTERACTIVE_CONDITION_TIMER_ACTIVE";
         this.mBoostStateMap["INTERACTIVE_CONDITION_TIMER_ONPRESS"] = "INTERACTIVE_CONDITION_TIMER_ONPRESS";
         this.mBoostStateMap["INTERACTIVE_ACTIVE"] = "INTERACTIVE_ACTIVE";
         this.mBoostStateMap["INTERACTIVE_ONPRESS"] = "INTERACTIVE_ONPRESS";
         this.mBoostStateMap["INTERACTIVE_SUPERCHARGED_ACTIVE"] = "INTERACTIVE_SUPERCHARGED_ACTIVE";
         this.mBoostStateMap["INTERACTIVE_SUPERCHARGED_ONPRESS"] = "INTERACTIVE_SUPERCHARGED_ONPRESS";
         this.mBoostStateMap["INTERACTIVE_UNAVAILABLE"] = "INTERACTIVE_UNAVAILABLE";
         this.mBoostStateMap["NONINTERACTIVE_INACTIVE"] = "NONINTERACTIVE_INACTIVE";
         this.mBoostStateMap["NONINTERACTIVE_CONDITION_TIMER"] = "NONINTERACTIVE_CONDITION_TIMER";
         this.mBoostStateMap["NONINTERACTIVE_CONDITION_MOVES"] = "NONINTERACTIVE_CONDITION_MOVES";
         this.mBoostStateMap["NONINTERACTIVE_CONDITION_ACTIVE"] = "NONINTERACTIVE_CONDITION_ACTIVE";
         this.mBoostStateMap["NONINTERACTIVE_ACTIVE"] = "NONINTERACTIVE_ACTIVE";
         this.mBoostStateMap["NONINTERACTIVE_PROC"] = "NONINTERACTIVE_PROC";
         this.mBoostStateMap["NONINTERACTIVE_NOPROC"] = "NONINTERACTIVE_NOPROC";
         this.mBoostStateMap["NONINTERACTIVE_UNAVAILABLE"] = "NONINTERACTIVE_UNAVAILABLE";
         this.mInfoTypesMap = new Dictionary();
         this.mInfoTypesMap["INFOTYPE_NONE"] = "INFOTYPE_NONE";
         this.mInfoTypesMap["INFOTYPE_TIMELOOP"] = "INFOTYPE_TIMELOOP";
         this.mInfoTypesMap["INFOTYPE_UNLIMITEDMOVES"] = "INFOTYPE_UNLIMITEDMOVES";
         this.mInfoTypesMap["INFOTYPE_USAGECOUNT"] = "INFOTYPE_USAGECOUNT";
         this.mInfoTypesMap["INFOTYPE_USAGECOUNTOFF"] = "INFOTYPE_USAGECOUNTOFF";
         this.mProgressTypesMap = new Dictionary();
         this.mProgressTypesMap["PROGRESSTYPE_NONE"] = "PROGRESSTYPE_NONE";
         this.mProgressTypesMap["PROGRESSTYPE_BAR"] = "PROGRESSTYPE_BAR";
         this.mProgressTypesMap["PROGRESSTYPE_RADIAL"] = "PROGRESSTYPE_RADIAL";
      }
      
      public function Cleanup(param1:Event) : void
      {
         var _loc2_:* = null;
         this.resetExtraTimeDetails();
         this.removeEventListener(MouseEvent.CLICK,this.onIconClicked);
         this.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.Cleanup);
         if(this.vfxInitTimer != null)
         {
            this.vfxInitTimer.removeEventListener(TimerEvent.TIMER,this.initVFXTimer);
            this.vfxInitTimer.stop();
            this.vfxInitTimer = null;
         }
         if(this.vfxTimer != null)
         {
            this.vfxTimer.removeEventListener(TimerEvent.TIMER,this.DoVFXTimer);
            this.vfxTimer.stop();
            this.vfxTimer = null;
         }
         for(_loc2_ in this.mBoostAssetsDict)
         {
            this.mBoostAssetsDict[_loc2_] = null;
            delete this.mBoostAssetsDict[_loc2_];
         }
         if(this._boost != null)
         {
            this._boost.DoCleanUp();
            this._app.logic.timerLogic.RemoveTimeChangeHandler(this);
            this._app.logic.timerLogic.RemoveGameDurationChangeHandler(this);
            this._app.logic.RemoveCharacterEventHandler(this);
         }
      }
      
      private function SetUsageCount(param1:int) : void
      {
         this.panelInfo.boosttext.text = param1.toString();
      }
      
      public function ActivateBoost() : void
      {
         if(this._boost == null)
         {
            return;
         }
         if(this._app.logic.timerLogic.GetTimeRemaining() == 0)
         {
            return;
         }
         this.InitOrUpdateState();
      }
      
      private function InitOrUpdateState() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         if(this._app.logic.rareGemsLogic.currentRareGem)
         {
            if(this.mCharacterShownOnScreen && !this._boost.IsBlockingEventImmuned())
            {
               return;
            }
         }
         if(this.mBlockInitOrUpdateState)
         {
            return;
         }
         var _loc1_:Vector.<ParameterHolderNode> = (this._boost as BoostInGameInfo).GetParams();
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.pNode = _loc1_[_loc4_];
            this.paramName = this.pNode.GetName();
            this.paramValue = 0;
            this.valParam = this.pNode.GetValue();
            if(this.valParam != null)
            {
               this.valParamAsNumber = this.valParam as NumberDataTypeNode;
               if(this.valParamAsNumber != null)
               {
                  this.paramValue = this.valParamAsNumber.dataValue;
               }
            }
            _loc2_[this.paramName] = this.paramValue;
            _loc4_++;
         }
         if(!this.mDriveStateFromConfig)
         {
            if(_loc2_["usageCount"])
            {
               _loc5_ = _loc2_["usageCount"] - _loc2_["currentUsageCount"];
               this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
               this.SetUsageCount(_loc5_);
               if(_loc5_ > 0 && this._app.logic.mBlockingEvents.length == 0)
               {
                  if(_loc2_["maxCharge"] && _loc2_["currentCharge"] >= _loc2_["maxCharge"])
                  {
                     this.SetState(BOOST_INTERACTIVE_SUPERCHARGED_ACTIVE);
                  }
                  else
                  {
                     this.SetState(BOOST_INTERACTIVE_ACTIVE);
                  }
               }
               else
               {
                  this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
               }
            }
            else if(_loc2_["manualMoveLimit"])
            {
               if(this.mHandlingMultiplierBonus)
               {
                  return;
               }
               if(this._app.logic.mBlockingEvents.length > 0)
               {
                  this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
               }
               else if(this.mState == BOOST_INVALID || this.mState == BOOST_INTERACTIVE_CONDITION_MOVES || this.mState == BOOST_INTERACTIVE_UNAVAILABLE)
               {
                  this.SetState(BOOST_INTERACTIVE_CONDITION_MOVES);
                  _loc6_ = _loc2_["moveCounter"] / _loc2_["manualMoveLimit"] * 100;
                  if(this.mColorBlastParticle == null)
                  {
                     this.mColorBlastParticle = new ColorBlast_PulseStarField();
                     addChild(this.mColorBlastParticle);
                     this.mColorBlastParticle.x = this.Boosticonplaceholder.x;
                     this.mColorBlastParticle.y = this.Boosticonplaceholder.y;
                  }
                  if(_loc6_ > 0 && _loc6_ < 100)
                  {
                     this.mColorBlastParticle.visible = true;
                  }
                  else
                  {
                     this.mColorBlastParticle.visible = false;
                  }
                  this.SetProgressVisibility(true);
                  this.SetProgressTimerPercentage(_loc6_);
                  this.panelInfo.visible = true;
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_UNLIMITEDMOVES);
                  if(_loc6_ >= 100)
                  {
                     this.SetState(BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE);
                     this.SetProgressVisibility(false);
                  }
                  else
                  {
                     this.ImagegemBacker.visible = false;
                  }
               }
               if(this.mState == BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE)
               {
                  if(this._app.logic.mBlockingEvents.length == 0)
                  {
                     this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
                     this.SetUsageCount(1);
                     if((_loc7_ = this._app.logic.GetLastMatchedGemColor()) > 0)
                     {
                        this.ImagegemBacker.BoostGemplaceholder.gotoAndStop("gem_" + this.mGemColors.getColorNameFromIndex(_loc7_));
                        this.ImagegemBacker.visible = true;
                     }
                  }
                  else
                  {
                     this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
                  }
               }
            }
            else if(_loc2_["timeDelta"] || _loc2_["coolOffTimeLimit"])
            {
               _loc8_ = "";
               _loc9_ = "";
               if(_loc2_["timeDelta"] != null)
               {
                  _loc8_ = "timeCounter";
                  _loc9_ = "timeDelta";
               }
               else if(_loc2_["coolOffTimeLimit"] != null)
               {
                  _loc8_ = "coolOffCounter";
                  _loc9_ = "coolOffTimeLimit";
               }
               if(_loc2_[_loc9_] == -1)
               {
                  this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
                  this.SetUsageCount(0);
               }
               else if(this._boost.usesEventOfType(BoostV2.EVENT_CLICK))
               {
                  if(this._app.logic.mBlockingEvents.length > 0)
                  {
                     this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
                  }
                  else if(this.mState == BOOST_INVALID || this.mState == BOOST_INTERACTIVE_UNAVAILABLE)
                  {
                     this.SetState(BOOST_INTERACTIVE_CONDITION_TIMER);
                     this.SetProgressTimerType(PROGRESSTYPE_RADIAL);
                     this.SetProgressVisibility(true);
                  }
                  else if(this.mState == BOOST_INTERACTIVE_CONDITION_TIMER)
                  {
                     if(this.Boosticonplaceholder)
                     {
                        _loc10_ = _loc2_[_loc8_] / _loc2_[_loc9_] * 100;
                        this.SetProgressVisibility(true);
                        this.SetProgressTimerPercentage(_loc10_);
                        if(_loc10_ >= 100)
                        {
                           this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_INFINITE);
                           this.SetState(BOOST_INTERACTIVE_CONDITION_TIMER_ACTIVE);
                           this.SetProgressVisibility(false);
                        }
                     }
                  }
               }
               else if(this.mState == BOOST_INVALID)
               {
                  this.SetState(BOOST_NONINTERACTIVE_CONDITION_TIMER);
                  if(this.Boosticonplaceholder)
                  {
                     this.SetProgressTimerType(PROGRESSTYPE_RADIAL);
                     this.SetProgressVisibility(true);
                  }
               }
               else if(this.mState == BOOST_NONINTERACTIVE_CONDITION_TIMER || this.mState == BOOST_NONINTERACTIVE_CONDITION_ACTIVE)
               {
                  if(this.Boosticonplaceholder)
                  {
                     _loc10_ = _loc2_[_loc8_] / _loc2_[_loc9_] * 100;
                     this.SetProgressTimerPercentage(_loc10_);
                     if(this.mState == BOOST_NONINTERACTIVE_CONDITION_ACTIVE && _loc10_ > 0)
                     {
                        this.SetState(BOOST_NONINTERACTIVE_CONDITION_TIMER);
                     }
                  }
               }
            }
            else if(_loc2_["timeToAdd"])
            {
               if((_loc11_ = _loc2_["timeToAdd"] / 100) <= 0)
               {
                  return;
               }
               this.panelInfo.visible = true;
               _loc12_ = this._app.logic.timerLogic.GetTimeRemaining();
               _loc13_ = this._app.logic.timerLogic.getExtraGameTime();
               if(_loc12_ > 100 && _loc13_ > 0)
               {
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
                  this.SetUsageCount(1);
                  this.SetState(BOOST_NONINTERACTIVE_INACTIVE);
               }
               else if(this.Boosticonplaceholder)
               {
                  if(_loc12_ == 1)
                  {
                     if(this.mState == BOOST_NONINTERACTIVE_INACTIVE)
                     {
                        this.SetState(BOOST_NONINTERACTIVE_CONDITION_TIMER);
                        this._app.logic.SetAllowScoreBonus(true);
                        this.SetProgressVisibility(true);
                        this.SetProgressTimerType(PROGRESSTYPE_RADIAL);
                        if(this.vfxTimer == null && this.vfxInitTimer == null && !this.vfxTimerHapenned)
                        {
                           this.createInitVfxTimer();
                        }
                     }
                  }
                  else if(_loc12_ == 0)
                  {
                     this.resetExtraTimeDetails();
                  }
               }
            }
            else if(_loc2_["specialGemBlastLimit"])
            {
               if(this._app.logic.mBlockingEvents.length > 0 && !this._boost.IsBlockingEventImmuned())
               {
                  this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
               }
               else if(this._app.logic.lastHurrahLogic.IsRunning() || this._app.logic.timerLogic.IsDone())
               {
                  this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
                  this.ShowCrossCollectorFrameFeedback(false,"activated");
               }
               else if(this.mState == BOOST_INVALID || this.mState == BOOST_INTERACTIVE_CONDITION_MOVES || this.mState == BOOST_INTERACTIVE_UNAVAILABLE)
               {
                  this.SetState(BOOST_INTERACTIVE_CONDITION_MOVES);
                  _loc6_ = _loc2_["specialGemBlastCounter"] / _loc2_["specialGemBlastLimit"] * 100;
                  if(this.mColorBlastParticle == null)
                  {
                     this.mColorBlastParticle = new ColorBlast_PulseStarField();
                     addChild(this.mColorBlastParticle);
                     this.mColorBlastParticle.x = this.Boosticonplaceholder.x;
                     this.mColorBlastParticle.y = this.Boosticonplaceholder.y;
                  }
                  if(this.mCrossCollectorProgressParticle == null)
                  {
                     this.mCrossCollectorProgressParticle = BoostAssetLoaderInterface.getImage(this._boost.getId(),"FX_Loading");
                     this.mColorBlastParticle.addChild(this.mCrossCollectorProgressParticle);
                     this.mCrossCollectorProgressParticle.width = this.Boosticonplaceholder.width;
                  }
                  if(_loc6_ > 0 && _loc6_ < 100)
                  {
                     this.mColorBlastParticle.visible = true;
                  }
                  else
                  {
                     this.mColorBlastParticle.visible = false;
                  }
                  this.SetProgressVisibility(true);
                  this.SetProgressTimerPercentage(_loc6_);
                  this.panelInfo.visible = true;
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_UNLIMITEDMOVES);
                  if(_loc6_ >= 100)
                  {
                     this.SetProgressVisibility(false);
                     if(this._app.logic.mBlockingEvents.length > 0 && !this._boost.IsBlockingEventImmuned())
                     {
                        this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
                     }
                     else
                     {
                        this.SetState(BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE);
                        _loc14_ = (_loc14_ = "SOUND_BLITZ3GAME_" + this._boost.getId() + "_ACTIVATION").toUpperCase();
                        this._app.SoundManager.playSound(_loc14_);
                        this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
                        this.SetUsageCount(1);
                        this.ShowCrossCollectorFrameFeedback(true,"activated");
                     }
                  }
               }
            }
            else
            {
               this.panelInfo.visible = true;
               this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_INFINITE);
               if(this.mState == BOOST_NONINTERACTIVE_PROC)
               {
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_INFINITE);
               }
               else if(this.mState == BOOST_INVALID)
               {
                  this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_INFINITE);
                  this.SetState(BOOST_NONINTERACTIVE_ACTIVE);
               }
            }
         }
         _loc2_ = null;
      }
      
      private function resetExtraTimeDetails() : void
      {
         this.mBoardWidget.clock.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         this.mBoardWidget.frame.GetTimeBar().filters = [];
         (this._app.ui as MainWidgetGame).game.scoreWidget.ResetScoreTextFilters();
      }
      
      private function createInitVfxTimer() : void
      {
         this.mBoardWidget.clock.SetForceDisplayClockText("0:01");
         this.mBoardWidget.frame.SetForceFill(1 / this._app.logic.timerLogic.GetGameDuration());
         this.vfxInitTimer = new Timer(500);
         this.vfxInitTimer.addEventListener(TimerEvent.TIMER,this.initVFXTimer);
         this.vfxInitTimer.start();
         this.SetState(BOOST_NONINTERACTIVE_ACTIVE);
      }
      
      private function initVFXTimer(param1:TimerEvent) : void
      {
         this.vfxInitTimer.removeEventListener(TimerEvent.TIMER,this.initVFXTimer);
         this.vfxInitTimer.stop();
         this.vfxInitTimer = null;
         this.mBoardWidget.frame.SetForceFill(0);
         var _loc2_:ClockWidget = this.mBoardWidget.clock;
         _loc2_.SetForceDisplayClockText("0:00");
         var _loc3_:Point = this._app.topLayer.globalToLocal(this.parent.localToGlobal(new Point(this.x,this.y)));
         var _loc4_:Point = this._app.topLayer.globalToLocal(this.mBoardWidget.localToGlobal(new Point(_loc2_.x,_loc2_.y)));
         var _loc5_:TextField;
         (_loc5_ = new TextField()).defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215);
         _loc5_.autoSize = TextFieldAutoSize.CENTER;
         _loc5_.embedFonts = true;
         _loc5_.selectable = false;
         _loc5_.mouseEnabled = false;
         _loc5_.filters = [new GlowFilter(0,1,2,2,4)];
         this._app.topLayer.addChild(_loc5_);
         _loc5_.x = _loc3_.x - _loc5_.width / 2;
         _loc5_.y = _loc3_.y - _loc5_.height / 2;
         _loc5_.text = "0:05";
         Tweener.addTween(_loc5_,{
            "x":_loc4_.x + _loc5_.width / 2,
            "y":_loc4_.y - _loc5_.height / 2,
            "time":0.5,
            "transition":"linear",
            "onComplete":this.vfxTimeTextReached,
            "onCompleteParams":[_loc5_]
         });
         this.vfxTimer = new Timer(100,10);
         this.vfxTimer.addEventListener(TimerEvent.TIMER,this.DoVFXTimer);
         this.ModifyBoostAssset(this._boost.getId(),"Active",this.Boosticonplaceholder);
         this.vfxTimer.start();
      }
      
      private function vfxTimeTextReached(param1:TextField) : void
      {
         this._app.topLayer.removeChild(param1);
         (this._app.ui as MainWidgetGame).game.scoreWidget.MakeScoreTextGreen();
         this.mBoardWidget.clock.defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,65280);
         Utils.applyColorMatrixFilter(this.mBoardWidget.frame.GetTimeBar(),0,1,0);
         this.vfxTimerHapenned = true;
         this.mBoardWidget.clock.SetForceDisplayClockText("");
         this.mBoardWidget.frame.SetForceFill(-1);
      }
      
      private function DoVFXTimer(param1:TimerEvent) : void
      {
         this.vfxProgress += 10;
         this.SetProgressTimerPercentage(this.vfxProgress);
         if(this.vfxProgress >= 100 && this.vfxTimer != null)
         {
            this.SetProgressVisibility(false);
            this.SetUsageCount(0);
            this.vfxTimer.removeEventListener(TimerEvent.TIMER,this.DoVFXTimer);
            this.vfxTimer.stop();
            this.vfxTimer = null;
         }
      }
      
      private function SetState(param1:String) : void
      {
         if(param1 == this.mState)
         {
            return;
         }
         if(this.mHandlingMultiplierBonus)
         {
            if(this._boost.usesEventOfType(BoostV2.EVENT_CLICK))
            {
               param1 = BOOST_INTERACTIVE_UNAVAILABLE;
            }
            else
            {
               param1 = BOOST_NONINTERACTIVE_UNAVAILABLE;
            }
         }
         this.SwapTextures(param1);
         this.mState = param1;
         if(this.mState == BOOST_INTERACTIVE_UNAVAILABLE || this.mState == BOOST_NONINTERACTIVE_UNAVAILABLE || this.mState == BOOST_INTERACTIVE_INACTIVE || this.mState == BOOST_NONINTERACTIVE_INACTIVE)
         {
            this.hideColorBlastParticle();
            this.panelInfo.visible = false;
         }
         else
         {
            this.panelInfo.visible = true;
         }
         if((this.mPrevState == BOOST_INTERACTIVE_UNAVAILABLE || this.mPrevState == BOOST_NONINTERACTIVE_UNAVAILABLE || this.mPrevState == BOOST_INTERACTIVE_INACTIVE || this.mPrevState == BOOST_NONINTERACTIVE_INACTIVE) && this._app.logic.timerLogic.GetTimeRemaining() == 0)
         {
            return;
         }
         this.mClickIsEnabled = true;
         this._boost.SetEnabled(true);
         var _loc2_:String = "";
         var _loc3_:int = LOOPTYPE_ONCE;
         switch(this.mState)
         {
            case BOOST_INTERACTIVE_CONDITION_MOVES:
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_CONDITION_MOVES;
               break;
            case BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE:
               _loc3_ = LOOPTYPE_INFINITE;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ACTIVE;
               this.mNextState = BOOST_INTERACTIVE_CONDITION_MOVES_ONPRESS;
               break;
            case BOOST_INTERACTIVE_CONDITION_MOVES_ONPRESS:
               this.mClickIsEnabled = false;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ONPRESS;
               this.mNextState = BOOST_INTERACTIVE_CONDITION_MOVES;
               break;
            case BOOST_INTERACTIVE_CONDITION_TIMER:
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_CONDITION_TIMER;
               break;
            case BOOST_INTERACTIVE_CONDITION_TIMER_ACTIVE:
               _loc3_ = LOOPTYPE_INFINITE;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ACTIVE;
               this.mNextState = BOOST_INTERACTIVE_CONDITION_TIMER_ONPRESS;
               break;
            case BOOST_INTERACTIVE_CONDITION_TIMER_ONPRESS:
               this.mClickIsEnabled = false;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ONPRESS;
               this.mNextState = BOOST_INTERACTIVE_CONDITION_TIMER;
               break;
            case BOOST_INTERACTIVE_ACTIVE:
               _loc3_ = LOOPTYPE_INFINITE;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ACTIVE;
               this.mNextState = BOOST_INTERACTIVE_ONPRESS;
               break;
            case BOOST_INTERACTIVE_ONPRESS:
               this.mClickIsEnabled = false;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_ONPRESS;
               break;
            case BOOST_INTERACTIVE_SUPERCHARGED_ACTIVE:
               _loc3_ = LOOPTYPE_INFINITE;
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ACTIVE;
               this.mNextState = BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ONPRESS;
               break;
            case BOOST_INTERACTIVE_SUPERCHARGED_ONPRESS:
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ONPRESS;
               break;
            case BOOST_INTERACTIVE_UNAVAILABLE:
               _loc2_ = BOOST_ANIM_STATE_INTERACTIVE_UNAVAILABLE;
               this.mClickIsEnabled = false;
               this._boost.SetEnabled(false);
               break;
            case BOOST_NONINTERACTIVE_INACTIVE:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_INACTIVE;
               break;
            case BOOST_NONINTERACTIVE_CONDITION_MOVES:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_CONDITION_MOVES;
               break;
            case BOOST_NONINTERACTIVE_CONDITION_TIMER:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_CONDITION_TIMER;
               break;
            case BOOST_NONINTERACTIVE_ACTIVE:
            case BOOST_NONINTERACTIVE_CONDITION_ACTIVE:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_ACTIVE;
               break;
            case BOOST_NONINTERACTIVE_PROC:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_PROC;
               break;
            case BOOST_NONINTERACTIVE_NOPROC:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_NOPROC;
               this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_BOOST_ACTIVATION_FAILED);
               break;
            case BOOST_NONINTERACTIVE_UNAVAILABLE:
               _loc2_ = BOOST_ANIM_STATE_NONINTERACTIVE_UNAVAILABLE;
               this.mClickIsEnabled = false;
               this._boost.SetEnabled(false);
         }
         if(_loc2_.length != 0)
         {
            this.mAnimLastFrame = Utils.GetAnimationLastFrame(this,_loc2_);
            if(this.mAnimLastFrame != -1)
            {
               this.mAnimLoop = _loc3_;
               this.mPlayingAnimName = _loc2_;
               this.OnAnimationStart(this.mPlayingAnimName);
               gotoAndPlay(this.mPlayingAnimName);
            }
         }
      }
      
      private function hideColorBlastParticle() : void
      {
         if(this.mColorBlastParticle != null)
         {
            this.mColorBlastParticle.visible = false;
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.mAnimLastFrame == -1 || this.mPlayingAnimName.length == 0)
         {
            return;
         }
         if(currentFrame == this.mAnimLastFrame)
         {
            if(this.mAnimLoop > 0)
            {
               --this.mAnimLoop;
            }
            else if(this.mAnimLoop == 0)
            {
               this.OnAnimationEnd(this.mPlayingAnimName);
               this.mPlayingAnimName = "";
               this.mAnimLastFrame = -1;
            }
            else
            {
               gotoAndPlay(this.mPlayingAnimName);
            }
         }
      }
      
      private function OnAnimationStart(param1:String) : void
      {
      }
      
      private function OnAnimationEnd(param1:String) : void
      {
         if(this.mDriveStateFromConfig)
         {
            if(this.mNextState != BOOST_INVALID)
            {
               this.SetState(this.mNextState);
               this.mNextState = BOOST_INVALID;
            }
            return;
         }
         if(param1 == BOOST_ANIM_STATE_INTERACTIVE_ONPRESS || param1 == BOOST_ANIM_STATE_INTERACTIVE_SUPERCHARGED_ONPRESS)
         {
            if(this._app.logic.mBlockingEvents.length > 0)
            {
               this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
            }
            else
            {
               this.SetState(this.mNextState);
               this.InitOrUpdateState();
            }
         }
         else if(param1 != BOOST_ANIM_STATE_STRIKE)
         {
            if(param1 == BOOST_ANIM_STATE_NONINTERACTIVE_NOPROC || param1 == BOOST_ANIM_STATE_NONINTERACTIVE_PROC)
            {
               this.SetState(BOOST_NONINTERACTIVE_ACTIVE);
            }
         }
      }
      
      private function SuccessfullyClicked() : void
      {
         if(this.mState == BOOST_NONINTERACTIVE_ACTIVE)
         {
            this.SetState(BOOST_NONINTERACTIVE_PROC);
         }
         else if(this.mState == BOOST_NONINTERACTIVE_CONDITION_TIMER)
         {
            this.SetState(BOOST_NONINTERACTIVE_CONDITION_ACTIVE);
         }
         var _loc1_:* = "SOUND_BLITZ3GAME_" + this._boost.getId() + "_ACTIVATED";
         _loc1_ = _loc1_.toUpperCase();
         this._app.SoundManager.playSound(_loc1_);
      }
      
      private function SetProgressVisibility(param1:Boolean) : void
      {
         if(param1)
         {
            this.Boosticonplaceholder.mask = this.mProgressTimer;
            this.mProgressTimer.visible = true;
            this.Boosticonplaceholder.visible = true;
            if(this.mProgressType == PROGRESSTYPE_RADIAL)
            {
               this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_TIMELOOP);
            }
         }
         else
         {
            this.Boosticonplaceholder.mask = null;
            this.mProgressTimer.visible = false;
            this.Boosticonplaceholder.visible = false;
         }
      }
      
      private function SetProgressTimerType(param1:int) : void
      {
         this.mProgressType = param1;
      }
      
      public function draw_arc(param1:MovieClip, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         var _loc8_:Number = param6 - param5;
         var _loc9_:int = Math.round(_loc8_ * param7);
         var _loc10_:Number = param5;
         param1.graphics.moveTo(param2,param3);
         var _loc11_:int = 1;
         while(_loc11_ <= _loc9_)
         {
            _loc10_ = param5 + _loc8_ / _loc9_ * _loc11_;
            param1.graphics.lineTo(param2 + param4 * Math.cos(_loc10_ * this.deg_to_rad),param3 + param4 * Math.sin(_loc10_ * this.deg_to_rad));
            _loc11_++;
         }
      }
      
      private function SetProgressTimerPercentage(param1:int) : void
      {
         var _loc2_:Number = NaN;
         if(this.mProgressPerc == param1)
         {
            return;
         }
         this.mProgressPerc = param1;
         if(this.mProgressType == PROGRESSTYPE_BAR)
         {
            this.mProgressTimer.graphics.clear();
            this.mProgressTimer.graphics.lineStyle(1,0);
            this.mProgressTimer.graphics.beginFill(16711680);
            this.mProgressTimer.graphics.drawRect(0,0,this.Boosticonplaceholder.width,-this.Boosticonplaceholder.height * param1 / 100);
            this.mProgressTimer.graphics.endFill();
            if(this.mColorBlastParticle != null && this.mColorBlastParticle.visible)
            {
               _loc2_ = 75 * param1 / 100;
               this.mColorBlastParticle.y = 40 - _loc2_;
               if(this.mCrossCollectorProgressParticle != null)
               {
                  this.mCrossCollectorProgressParticle.height = this.mProgressTimer.height;
               }
            }
         }
         else if(this.mProgressType == PROGRESSTYPE_RADIAL)
         {
            ++this.power;
            if(this.power >= 120)
            {
               this.power -= 120;
            }
            this.mProgressTimer.graphics.clear();
            this.mProgressTimer.graphics.lineStyle(1,0);
            this.mProgressTimer.graphics.beginFill(65280);
            this.draw_arc(this.mProgressTimer,this.Boosticonplaceholder.width / 2,-this.Boosticonplaceholder.height / 2,this.Boosticonplaceholder.height,270,270 + param1 / 100 * 360,1);
            this.mProgressTimer.graphics.endFill();
         }
      }
      
      private function ModifyBoostAssset(param1:String, param2:String, param3:MovieClip) : void
      {
         var _loc5_:Bitmap = null;
         var _loc4_:BitmapData = null;
         if(this.mBoostAssetsDict[param2] !== undefined)
         {
            _loc4_ = this.mBoostAssetsDict[param2];
         }
         else if((_loc4_ = this._app.sessionData.boostV2Manager.boostV2Icons.getBitmapDataOfInGameBoostState(param1,param2)) != null)
         {
            this.mBoostAssetsDict[param2] = _loc4_;
         }
         if(_loc4_ != null)
         {
            Utils.removeAllChildrenFrom(param3);
            (_loc5_ = new Bitmap()).bitmapData = _loc4_;
            _loc5_.smoothing = true;
            param3.addChild(_loc5_);
            _loc5_.y -= _loc4_.height;
         }
      }
      
      private function SwapTextures(param1:String) : void
      {
         if(this.mState == param1)
         {
            return;
         }
         switch(param1)
         {
            case BOOST_INTERACTIVE_CONDITION_MOVES:
            case BOOST_INTERACTIVE_CONDITION_TIMER:
            case BOOST_INTERACTIVE_INACTIVE:
            case BOOST_NONINTERACTIVE_CONDITION_MOVES:
            case BOOST_NONINTERACTIVE_CONDITION_TIMER:
            case BOOST_NONINTERACTIVE_INACTIVE:
               this.ModifyBoostAssset(this._boost.getId(),"Inactive",this.Boosticonplaceholder_base);
               if(this.mBoostAssetsDict["Inactive"] === undefined)
               {
                  this.ModifyBoostAssset(this._boost.getId(),"Unavailable",this.Boosticonplaceholder_base);
               }
               break;
            case BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE:
            case BOOST_INTERACTIVE_CONDITION_TIMER_ACTIVE:
            case BOOST_INTERACTIVE_ACTIVE:
            case BOOST_NONINTERACTIVE_CONDITION_ACTIVE:
            case BOOST_NONINTERACTIVE_ACTIVE:
               this.ModifyBoostAssset(this._boost.getId(),"Active",this.Boosticonplaceholder_base);
               break;
            case BOOST_INTERACTIVE_ONPRESS:
            case BOOST_INTERACTIVE_CONDITION_MOVES_ONPRESS:
            case BOOST_INTERACTIVE_CONDITION_TIMER_ONPRESS:
               this.ModifyBoostAssset(this._boost.getId(),"Press",this.Boosticonplaceholder_base);
               break;
            case BOOST_INTERACTIVE_SUPERCHARGED_ACTIVE:
               this.ModifyBoostAssset(this._boost.getId(),"SuperCharge",this.Boosticonplaceholder_base);
               break;
            case BOOST_INTERACTIVE_SUPERCHARGED_ONPRESS:
               this.ModifyBoostAssset(this._boost.getId(),"SuperChargePress",this.Boosticonplaceholder_base);
               break;
            case BOOST_NONINTERACTIVE_PROC:
               this.ModifyBoostAssset(this._boost.getId(),"Proc",this.Boosticonplaceholder_base);
               break;
            case BOOST_NONINTERACTIVE_NOPROC:
               this.ModifyBoostAssset(this._boost.getId(),"NoProc",this.Boosticonplaceholder_base);
               break;
            case BOOST_INTERACTIVE_UNAVAILABLE:
            case BOOST_NONINTERACTIVE_UNAVAILABLE:
               this.ModifyBoostAssset(this._boost.getId(),"Unavailable",this.Boosticonplaceholder_base);
               if(this.mBoostAssetsDict["Unavailable"] === undefined)
               {
                  this.ModifyBoostAssset(this._boost.getId(),"Inactive",this.Boosticonplaceholder_base);
               }
         }
         if(param1 == BOOST_INTERACTIVE_UNAVAILABLE || param1 == BOOST_NONINTERACTIVE_UNAVAILABLE)
         {
            this.ModifyBoostAssset(this._boost.getId(),"Unavailable",this.Boosticonplaceholder);
            this.ModifyBoostAssset(this._boost.getId(),"Inactive",this.Boosticonplaceholder);
         }
         else
         {
            this.ModifyBoostAssset(this._boost.getId(),"Active",this.Boosticonplaceholder);
         }
      }
      
      private function IsClickable() : Boolean
      {
         return this.mState == BOOST_INTERACTIVE_ACTIVE || this.mState == BOOST_INTERACTIVE_CONDITION_MOVES_ACTIVE || this.mState == BOOST_INTERACTIVE_CONDITION_TIMER_ACTIVE || this.mState == BOOST_INTERACTIVE_SUPERCHARGED_ACTIVE;
      }
      
      private function IsActive() : Boolean
      {
         return this.IsClickable() || this.mState == BOOST_NONINTERACTIVE_ACTIVE || this.mState == BOOST_NONINTERACTIVE_CONDITION_ACTIVE;
      }
      
      private function StartVFX(param1:Vector.<Gem>, param2:Number, param3:Boolean, param4:MovieClip, param5:ActionQueue) : void
      {
         var _gem:Gem = null;
         var globalButtonPos:Point = null;
         var buttonPosLocalToBoard:Point = null;
         var gemSprite:GemSprite = null;
         var perpendicular:Number = NaN;
         var base:Number = NaN;
         var theta:Number = NaN;
         var angle:Number = NaN;
         var dist:Number = NaN;
         var _particle:MovieClip = null;
         var particle:MovieClip = null;
         var targetDist:Number = NaN;
         var targetX:Number = NaN;
         var targetY:Number = NaN;
         var affectedGems:Vector.<Gem> = param1;
         var duration:Number = param2;
         var showline:Boolean = param3;
         var colorTrail:MovieClip = param4;
         var queue:ActionQueue = param5;
         if(this._app.isLQMode)
         {
            this._boost.DispatchBoostFeedbackComplete(queue);
            return;
         }
         if(duration == 0)
         {
            duration = 400;
         }
         duration /= 100;
         var affectedGemsLength:int = affectedGems.length;
         var i:int = 0;
         while(i < affectedGemsLength)
         {
            _gem = affectedGems[i];
            globalButtonPos = localToGlobal(new Point(this.x,this.y));
            buttonPosLocalToBoard = this.mBoardWidget.globalToLocal(globalButtonPos);
            gemSprite = this.mBoardWidget.gemLayer._gemSprites[_gem.id];
            perpendicular = gemSprite.y - buttonPosLocalToBoard.y;
            base = gemSprite.x - buttonPosLocalToBoard.x;
            theta = Math.atan2(perpendicular,base);
            angle = theta * 180 / Math.PI;
            dist = Math.sqrt(perpendicular * perpendicular + base * base);
            if(showline)
            {
               BoostAssetLoaderInterface.getMovieClip(this._boost.getId(),"Lightning",function(param1:MovieClip):void
               {
                  var _loc2_:Number = param1.width;
                  param1.x = buttonPosLocalToBoard.x;
                  param1.y = buttonPosLocalToBoard.y;
                  mBoardWidget.addChild(param1);
                  param1.rotation = angle;
                  var _loc3_:Number = dist / _loc2_;
                  param1.scaleX = 0;
                  Tweener.addTween(param1,{
                     "scaleX":_loc3_,
                     "time":duration,
                     "transition":"linear",
                     "onComplete":OnLightningAnimationComplete,
                     "onCompleteParams":[param1,queue,new Point(gemSprite.x,gemSprite.y)]
                  });
               });
            }
            else if(colorTrail != null)
            {
               _particle = colorTrail;
               particle = Utils.duplicateObject(_particle);
               this.mBoardWidget.addChild(particle);
               (particle.getChildAt(0) as MovieClip).gotoAndPlay("trail");
               targetDist = dist - particle.width;
               particle.x = buttonPosLocalToBoard.x;
               particle.y = buttonPosLocalToBoard.y;
               particle.rotation = angle;
               targetX = buttonPosLocalToBoard.x + targetDist * Math.cos(theta);
               targetY = buttonPosLocalToBoard.y + targetDist * Math.sin(theta);
               Tweener.addTween(particle,{
                  "x":targetX,
                  "y":targetY,
                  "time":duration,
                  "transition":"linear",
                  "onComplete":this.OnBoostFeedbackParticleComplete,
                  "onCompleteParams":[particle,queue,new Point(gemSprite.x,gemSprite.y)]
               });
            }
            i++;
         }
      }
      
      private function OnBoostFeedbackParticleComplete(param1:MovieClip, param2:ActionQueue, param3:Point) : void
      {
         Utils.removeAfterLastFrame(param1,true);
         (param1.getChildAt(0) as MovieClip).gotoAndPlay("stop");
         this.ShowHitFeedbackAndDispatchQueue(param2,param3,BOOST_FEEDBACK_PARTICLE_FORMATION);
      }
      
      private function OnLightningAnimationComplete(param1:MovieClip, param2:ActionQueue, param3:Point) : void
      {
         this.mBoardWidget.removeChild(param1);
         this.ShowHitFeedbackAndDispatchQueue(param2,param3,BOOST_FEEDBACK_PARTICLE_EXPLOSION);
      }
      
      private function OnBlazingSpeedLightningAnimationComplete(param1:MovieClip, param2:ActionQueue, param3:Point) : void
      {
         (this._app.ui as MainWidgetGame).game.removeChild(param1);
      }
      
      private function OnCrossCollectorLightningAnimationComplete(param1:MovieClip, param2:ActionQueue, param3:Point) : void
      {
         (this._app.ui as MainWidgetGame).game.removeChild(param1);
      }
      
      private function ShowHitFeedbackAndDispatchQueue(param1:ActionQueue, param2:Point, param3:String) : void
      {
         this._boost.DispatchBoostFeedbackComplete(param1);
         this.ShowHitFeedbackParticle(param2,param3);
      }
      
      private function ShowBoostFormationParticle(param1:Point) : void
      {
      }
      
      private function ShowHitFeedbackParticle(param1:Point, param2:String) : void
      {
         var _loc3_:MovieClip = null;
         if(param2 == BOOST_FEEDBACK_PARTICLE_EXPLOSION)
         {
            _loc3_ = new BoostExplosion() as MovieClip;
         }
         else if(param2 == BOOST_FEEDBACK_PARTICLE_FORMATION)
         {
            _loc3_ = new BoostFormation() as MovieClip;
         }
         this.mBoardWidget.addChild(_loc3_);
         _loc3_.x = param1.x;
         _loc3_.y = param1.y;
         Utils.removeAfterLastFrame(_loc3_);
      }
      
      private function StartVFXWithFeedback(param1:Vector.<Gem>, param2:Point, param3:ActionQueue) : void
      {
         var _loc4_:BoostParticleInfo = (this._boost as BoostInGameInfo).GetParticleFeedback();
         var _loc5_:MovieClip = null;
         if(_loc4_ != null)
         {
            if(param3 != null)
            {
               if(param3.mQueueType == ActionQueue.QUEUE_CHANGE_COLOR)
               {
                  _loc5_ = this.modifyFeedbackColor(param3.mValue1);
               }
               else if(param3.mQueueType == ActionQueue.QUEUE_CHANGE_TYPE)
               {
                  if(param3.mValue1 == Gem.TYPE_FLAME && param3.mValue2 != -1)
                  {
                     _loc5_ = this.modifyFeedbackColor(param3.mValue2);
                  }
                  else
                  {
                     _loc5_ = new trail();
                  }
               }
               else if(param3.mQueueType == ActionQueue.SHOW_UNSCRAMBLE_FEEDBACK)
               {
                  _loc5_ = this.modifyFeedbackColor(param3.mValue1);
               }
            }
            if(_loc5_ == null)
            {
               _loc5_ = new trail();
            }
            this.StartVFX(param1,_loc4_.getTime(),_loc4_.getShowline(),_loc5_,param3);
         }
         else
         {
            this.StartVFX(param1,25,false,new trail(),param3);
         }
      }
      
      private function modifyFeedbackColor(param1:int) : MovieClip
      {
         switch(param1)
         {
            case Gem.COLOR_RED:
               return new trailRed();
            case Gem.COLOR_ORANGE:
               return new trailOrange();
            case Gem.COLOR_YELLOW:
               return new trailYellow();
            case Gem.COLOR_GREEN:
               return new trailGreen();
            case Gem.COLOR_BLUE:
               return new trailBlue();
            case Gem.COLOR_PURPLE:
               return new trailPurple();
            case Gem.COLOR_WHITE:
               return new trailWhite();
            default:
               return new trail();
         }
      }
      
      public function SetDisabledState() : void
      {
         if(this._boost != null)
         {
            if(this._boost.usesEventOfType(BoostV2.EVENT_CLICK))
            {
               this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
            }
            else
            {
               this.SetState(BOOST_NONINTERACTIVE_UNAVAILABLE);
            }
         }
      }
      
      private function ShowParticleMovement(param1:Number, param2:Point, param3:Point, param4:String, param5:String, param6:Function, param7:ActionQueue) : void
      {
      }
      
      private function ShowParticleHit(param1:Point) : void
      {
      }
      
      public function onFtueBoostIconClicked() : void
      {
         this.onIconClicked(null);
      }
      
      private function onIconClicked(param1:MouseEvent) : void
      {
         if(this._boost != null && this.IsClickable())
         {
            this.ShowCrossCollectorFrameFeedback(false,"activated");
            this.SetState(this.mNextState);
            this._boost.HandleClickEvent(this._boost.getId());
         }
      }
      
      public function HandleBoostFeedback(param1:String, param2:Vector.<Gem>) : void
      {
         this.SuccessfullyClicked();
         if(param2.length == 0)
         {
            return;
         }
         var _loc3_:Point = new Point(this.x,this.y + this.height / 4);
         this.StartVFXWithFeedback(param2,_loc3_,null);
      }
      
      public function HandleBoostFeedbackQueue(param1:Vector.<ActionQueue>) : void
      {
         var i:int = 0;
         var animDurationInSecs:Number = NaN;
         var globalButtonPos:Point = null;
         var blazingSpeedText:Sprite = null;
         var perpendicular:Number = NaN;
         var base:Number = NaN;
         var theta:Number = NaN;
         var angle:Number = NaN;
         var dist:Number = NaN;
         var soundName:String = null;
         var affectedGems:Vector.<Gem> = null;
         var feedback:BoostParticleInfo = null;
         var multiplierText:Sprite = null;
         var multiplierTextOffset:Sprite = null;
         var endPos:Point = null;
         var queue:Vector.<ActionQueue> = param1;
         var startPos:Point = new Point(this.x,this.y + this.height / 4);
         var queueLength:int = queue.length;
         i = 0;
         while(i < queueLength)
         {
            switch(queue[i].mQueueType)
            {
               case ActionQueue.SHOW_BLAZING_SPEED_FEEDBACK:
                  animDurationInSecs = queue[i].mValue1 / 100;
                  if(animDurationInSecs > 0)
                  {
                     globalButtonPos = localToGlobal(new Point(this.x,this.y));
                     blazingSpeedText = (this._app.ui as MainWidgetGame).game.speedBar;
                     perpendicular = blazingSpeedText.y - globalButtonPos.y;
                     base = blazingSpeedText.x - globalButtonPos.x;
                     theta = Math.atan2(perpendicular,base);
                     angle = theta * 180 / Math.PI;
                     dist = Math.sqrt(perpendicular * perpendicular + base * base);
                     BoostAssetLoaderInterface.getMovieClip(this._boost.getId(),"Blazelightning",function(param1:MovieClip):*
                     {
                        var _loc2_:* = param1.width;
                        param1.x = globalButtonPos.x;
                        param1.y = globalButtonPos.y;
                        (_app.ui as MainWidgetGame).game.addChild(param1);
                        param1.rotation = angle;
                        var _loc3_:Number = dist / _loc2_;
                        param1.scaleX = _loc3_;
                        Tweener.addTween(param1,{
                           "time":animDurationInSecs,
                           "transition":"linear",
                           "onComplete":OnBlazingSpeedLightningAnimationComplete,
                           "onCompleteParams":[param1,queue[i],new Point(blazingSpeedText.x,blazingSpeedText.y)]
                        });
                     });
                     if(queue[i].mValue2)
                     {
                        (this._app.ui as MainWidgetGame).game.ShowBlazingSpeedGlowFeedback(true,this._boost.getId());
                     }
                     this.SuccessfullyClicked();
                  }
                  break;
               case ActionQueue.HIDE_BLAZING_SPEED_FEEDBACK:
                  (this._app.ui as MainWidgetGame).game.ShowBlazingSpeedGlowFeedback(false,this._boost.getId());
                  break;
               case ActionQueue.MODIFY_SCORE_BONUS_DURING_GAME:
                  if(queue[i].mValue1 > 0 || queue[i].mValue2 > 0)
                  {
                     (this._app.ui as MainWidgetGame).game.scoreWidget.MakeScoreTextGreen();
                  }
                  else
                  {
                     (this._app.ui as MainWidgetGame).game.scoreWidget.ResetScoreTextFilters();
                  }
                  break;
               case ActionQueue.SHOW_UNSCRAMBLE_FEEDBACK:
                  if(queue[i].mGem == null && queue[i].mValue1 == 1)
                  {
                     (this._app.ui as MainWidgetGame).game.RainbowGlowActivate(true,this._boost.getId());
                     this.SuccessfullyClicked();
                  }
                  else if(queue[i].mGem == null && queue[i].mValue1 == 2)
                  {
                     soundName = "SOUND_BLITZ3GAME_" + this._boost.getId() + "_COMPLETE";
                     soundName = soundName.toUpperCase();
                     this._app.SoundManager.playSound(soundName);
                  }
                  else
                  {
                     affectedGems = new Vector.<Gem>();
                     affectedGems.push(queue[i].mGem);
                     this.StartVFXWithFeedback(affectedGems,startPos,queue[i]);
                  }
                  break;
               case ActionQueue.SHOW_CROSSCOLLECTOR_FEEDBACK:
                  if(queue[i].mGem == null && queue[i].mValue1 == 1)
                  {
                     this.ShowCrossCollectorFrameFeedback(true,"collect");
                  }
                  else if(queue[i].mGem == null && queue[i].mValue1 == 2)
                  {
                     feedback = (this._boost as BoostInGameInfo).GetParticleFeedback();
                     if(feedback != null)
                     {
                        animDurationInSecs = feedback.getTime() / 100;
                        if(animDurationInSecs > 0)
                        {
                           globalButtonPos = localToGlobal(new Point(this.x,this.y));
                           multiplierText = (this._app.ui as MainWidgetGame).game.multiplier;
                           multiplierTextOffset = (this._app.ui as MainWidgetGame).game.multiplier.MultiplierPlaceholder;
                           endPos = new Point(multiplierText.x + multiplierTextOffset.x,multiplierText.y + multiplierTextOffset.y);
                           perpendicular = endPos.y - globalButtonPos.y;
                           base = endPos.x - globalButtonPos.x;
                           theta = Math.atan2(perpendicular,base);
                           angle = theta * 180 / Math.PI;
                           dist = Math.sqrt(perpendicular * perpendicular + base * base);
                           BoostAssetLoaderInterface.getMovieClip(this._boost.getId(),"CrossCollectorLightning",function(param1:MovieClip):*
                           {
                              var _loc2_:* = param1.width;
                              param1.x = globalButtonPos.x;
                              param1.y = globalButtonPos.y;
                              (_app.ui as MainWidgetGame).game.addChild(param1);
                              param1.rotation = angle;
                              var _loc3_:Number = dist / _loc2_;
                              param1.scaleX = _loc3_;
                              Tweener.addTween(param1,{
                                 "time":animDurationInSecs,
                                 "transition":"linear",
                                 "onComplete":OnCrossCollectorLightningAnimationComplete,
                                 "onCompleteParams":[param1,queue[i],new Point(endPos.x,endPos.y)]
                              });
                           });
                        }
                     }
                     (this._app.ui as MainWidgetGame).game.ShowCrossCollectorFeedback(this._boost.getId());
                     this.SuccessfullyClicked();
                  }
                  break;
               default:
                  affectedGems = new Vector.<Gem>();
                  affectedGems.push(queue[i].mGem);
                  this.StartVFXWithFeedback(affectedGems,startPos,queue[i]);
                  this.SuccessfullyClicked();
                  break;
            }
            i++;
         }
      }
      
      public function HandleBoostFeedbackComplete(param1:ActionQueue) : void
      {
      }
      
      public function HandleBoostActivated(param1:String) : void
      {
         if(this._boost.getId() == param1)
         {
            if(this.IsClickable())
            {
               this.SetState(this.mNextState);
            }
         }
      }
      
      public function HandleBoostActivationFailed(param1:String) : void
      {
         if(this.mState == BOOST_NONINTERACTIVE_ACTIVE)
         {
            this.SetState(BOOST_NONINTERACTIVE_NOPROC);
         }
         else if(this.mState == BOOST_INTERACTIVE_ONPRESS)
         {
            this.SetState(BOOST_INTERACTIVE_UNAVAILABLE);
         }
      }
      
      public function HandleMoveSuccessful(param1:String, param2:SwapData) : void
      {
         var _loc3_:Gem = null;
         var _loc4_:Vector.<Gem> = null;
         var _loc5_:Point = null;
         if(param1 == this._boost.getId())
         {
            if(this.mState == BOOST_NONINTERACTIVE_CONDITION_MOVES || this.mState == BOOST_INTERACTIVE_CONDITION_MOVES)
            {
               _loc3_ = !!param2.moveData.sourceGem.hasMatch ? param2.moveData.sourceGem : param2.moveData.swapGem;
               (_loc4_ = new Vector.<Gem>()).push(_loc3_);
               _loc5_ = new Point(this.x,this.y);
               this.StartVFXWithFeedback(_loc4_,_loc5_,null);
            }
            this.InitOrUpdateState();
         }
      }
      
      public function HandleSpecialGemBlastUpdate(param1:String) : void
      {
         if(param1 == this._boost.getId())
         {
            this.InitOrUpdateState();
         }
      }
      
      public function HandleBoostGameTimeChange(param1:String, param2:int) : void
      {
      }
      
      public function HandleBlockingEvent() : void
      {
         this.InitOrUpdateState();
      }
      
      public function HandleCharacterBoardEntry() : void
      {
         this.mCharacterShownOnScreen = true;
         this.SaveAndDisableState();
      }
      
      public function HandleCharacterBoardExit() : void
      {
         this.mCharacterShownOnScreen = false;
         this.RestoreBeforeDisabledState();
      }
      
      public function HandleGameTimeChange(param1:int) : void
      {
         if(this._app.logic.config.timerLogicBaseGameDuration < param1)
         {
            return;
         }
         this.InitOrUpdateState();
         if(this.visible)
         {
            if(param1 == 0)
            {
               this.SaveAndDisableState();
            }
         }
         else if(this.mPrevState != BOOST_INVALID)
         {
            this.SetState(this.mPrevState);
            if(!this.mDriveStateFromConfig)
            {
               this.mPrevState = BOOST_INVALID;
            }
         }
      }
      
      private function SaveAndDisableState() : void
      {
         if(!this._boost.IsBlockingEventImmuned())
         {
            this.mBlockInitOrUpdateState = true;
            this.mPrevState = this.mState;
            this.mPanelWasVisible = this.panelInfo.visible;
            this.SetDisabledState();
         }
      }
      
      private function RestoreBeforeDisabledState() : void
      {
         this.mBlockInitOrUpdateState = false;
         this.SetState(this.mPrevState);
         this.mPrevState = BOOST_INVALID;
         this.panelInfo.visible = this.mPanelWasVisible;
         this.InitOrUpdateState();
      }
      
      public function HandleGameDurationChange(param1:int, param2:int) : void
      {
         this.RestoreBeforeDisabledState();
      }
      
      public function HandleMultiplierBonus(param1:int) : void
      {
         if(this._boost == null)
         {
            return;
         }
         if(param1 > 0 && !this._boost.IsBlockingEventImmuned())
         {
            this.mHandlingMultiplierBonus = true;
            this.mPrevState = this.mState;
            this.SetDisabledState();
         }
         else
         {
            this.mHandlingMultiplierBonus = false;
            if(this._app.logic.timerLogic.GetTimeRemaining() == 0)
            {
               this.SetDisabledState();
            }
            else
            {
               this.SetState(this.mPrevState);
            }
         }
      }
      
      public function BoardCellsActivate(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
      }
      
      public function BoardCellsDeactivate(param1:String, param2:Boolean) : void
      {
      }
      
      public function ForceStateChange(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:Number, param7:Number) : void
      {
         if(this._boost == null || param1 != this.getId())
         {
            return;
         }
         if(!this._boost.IsEnabled())
         {
            return;
         }
         this.mDriveStateFromConfig = param2;
         if(this.mBoostStateMap[param3])
         {
            this.SetState(this.mBoostStateMap[param3]);
         }
         if(this.mInfoTypesMap[param4])
         {
            this.HandleConditionInfoType(this.mInfoTypesMap[param4]);
         }
         if(this.mProgressTypesMap[param5])
         {
            this.HandleProgressType(this.mProgressTypesMap[param5]);
         }
      }
      
      private function HandleConditionInfoType(param1:String) : void
      {
         this.panelInfo.visible = true;
         if(param1 == "INFOTYPE_NONE")
         {
            this.panelInfo.visible = false;
         }
         else if(param1 == "INFOTYPE_TIMELOOP")
         {
            this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_TIMELOOP);
         }
         else if(param1 == "INFOTYPE_USAGECOUNT")
         {
            this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNT);
         }
         else if(param1 == "INFOTYPE_USAGECOUNTOFF")
         {
            this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_USAGECOUNTOFF);
         }
         else if(param1 == "INFOTYPE_UNLIMITEDMOVES")
         {
            this.panelInfo.gotoAndStop(BOOST_PANEL_INFOTYPE_UNLIMITEDMOVES);
         }
      }
      
      private function HandleProgressType(param1:String) : void
      {
         if(this.mProgressTimer == null)
         {
            return;
         }
         this.mProgressTimer.visible = true;
         if(param1 == "PROGRESSTYPE_NONE")
         {
            this.mProgressTimer.visible = false;
         }
         else if(param1 == "PROGRESSTYPE_BAR")
         {
            this.SetProgressTimerType(PROGRESSTYPE_BAR);
         }
         else if(param1 == "PROGRESSTYPE_RADIAL")
         {
            this.SetProgressTimerType(PROGRESSTYPE_RADIAL);
         }
      }
      
      public function getId() : String
      {
         if(this._boost == null)
         {
            return "";
         }
         return this._boost.getId();
      }
      
      private function ShowCrossCollectorFrameFeedback(param1:Boolean, param2:String) : void
      {
         var show:Boolean = param1;
         var frameName:String = param2;
         if(show)
         {
            if(this.mCrossCollectorFeedback != null)
            {
               if(frameName == "activated" && this.mCrossCollectorCollectLastFrame != -1)
               {
                  this.mCrossCollectorFeedback.gotoAndPlay(frameName);
               }
               return;
            }
            BoostAssetLoaderInterface.getMovieClip(this._boost.getId(),"CrossCollectorBlinking",function(param1:MovieClip):*
            {
               mCrossCollectorFeedback = param1;
               mCrossCollectorCollectLastFrame = Utils.GetAnimationLastFrame(mCrossCollectorFeedback,"collect");
               mCrossCollectorActivatedLastFrame = Utils.GetAnimationLastFrame(mCrossCollectorFeedback,"activated");
               mCrossCollectorFeedback.addEventListener(Event.ENTER_FRAME,CrossCollectorFrameFeedbackEachFrame);
               crosscollectorplaceholder.addChild(mCrossCollectorFeedback);
               mCrossCollectorFeedback.gotoAndPlay(frameName);
            });
         }
         else
         {
            this.DestroyAndResetCrossCollectorFrameFeedbackValues();
         }
      }
      
      private function CrossCollectorFrameFeedbackEachFrame(param1:Event) : void
      {
         if(this.mCrossCollectorFeedback == null)
         {
            return;
         }
         if(this.mCrossCollectorFeedback.currentFrame == this.mCrossCollectorActivatedLastFrame)
         {
            this.mCrossCollectorFeedback.gotoAndPlay("activated");
         }
         else if(this.mCrossCollectorFeedback.currentFrame == this.mCrossCollectorCollectLastFrame)
         {
            this.DestroyAndResetCrossCollectorFrameFeedbackValues();
         }
      }
      
      private function DestroyAndResetCrossCollectorFrameFeedbackValues() : void
      {
         if(this.mCrossCollectorFeedback == null || this.mCrossCollectorFeedback.visible == false)
         {
            return;
         }
         this.mCrossCollectorFeedback.removeEventListener(Event.ENTER_FRAME,this.CrossCollectorFrameFeedbackEachFrame);
         crosscollectorplaceholder.removeChild(this.mCrossCollectorFeedback);
         this.mCrossCollectorFeedback = null;
         this.mCrossCollectorCollectLastFrame = -1;
         this.mCrossCollectorActivatedLastFrame = -1;
      }
   }
}
