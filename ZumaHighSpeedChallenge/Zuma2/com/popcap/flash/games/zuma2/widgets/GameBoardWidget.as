package com.popcap.flash.games.zuma2.widgets
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.resources.images.ImageInst;
   import com.popcap.flash.framework.widgets.Widget;
   import com.popcap.flash.framework.widgets.WidgetContainer;
   import com.popcap.flash.games.zuma2.logic.Ball;
   import com.popcap.flash.games.zuma2.logic.Bouncy;
   import com.popcap.flash.games.zuma2.logic.Bullet;
   import com.popcap.flash.games.zuma2.logic.GameStats;
   import com.popcap.flash.games.zuma2.logic.Gun;
   import com.popcap.flash.games.zuma2.logic.Level;
   import com.popcap.flash.games.zuma2.logic.OptionsMenu;
   import com.popcap.flash.games.zuma2.logic.PowerEffect;
   import com.popcap.flash.games.zuma2.logic.PowerType;
   import com.popcap.flash.games.zuma2.logic.QRand;
   import com.popcap.flash.games.zuma2.logic.RollerScore;
   import com.popcap.flash.games.zuma2.logic.ScoreBlip;
   import com.popcap.flash.games.zuma2.logic.SexyVector3;
   import com.popcap.flash.games.zuma2.logic.StatsScreen;
   import com.popcap.flash.games.zuma2.logic.TimerBar;
   import com.popcap.flash.games.zuma2.logic.TreasurePoint;
   import com.popcap.flash.games.zuma2.logic.Zuma2Images;
   import com.popcap.flash.games.zuma2.logic.Zuma2Sounds;
   import de.polygonal.ds.DLinkedList;
   import de.polygonal.ds.DListIterator;
   import flash.display.Bitmap;
   import flash.display.BlendMode;
   import flash.display.PixelSnapping;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GameBoardWidget extends WidgetContainer implements Widget
   {
      
      public static const GameState_BeatLevelBonus:int = 6;
      
      public static const GameState_LevelBegin:int = 5;
      
      public static const GameState_Stats:int = 8;
      
      public static const GameState_TimeUp:int = 7;
      
      public static const TREASURE_LIFE:int = 1000;
      
      public static const GameState_Playing:int = 1;
      
      public static const PROXIMITY_BOMB_RADIUS:int = 56;
      
      public static const GameState_BossDead:int = 4;
      
      public static const GameState_Losing:int = 2;
      
      public static const GameState_None:int = 0;
      
      public static const GameState_LevelUp:int = 3;
       
      
      public var mDoGuide:Boolean;
      
      public var mAccuracyBackupCount:int;
      
      public var mShowGuide:Boolean;
      
      public var mTreasureAccel:Number = 0;
      
      public var aCenter:SexyVector3;
      
      public var mRollerScore:RollerScore;
      
      public var mTimerBar:TimerBar;
      
      public var mLastBallClickTick:int;
      
      public var mScore:int;
      
      public var mRecalcGuide:Boolean;
      
      public var mAccuracyCount:int = 0;
      
      public var mFruitGlowBitmap:Bitmap;
      
      public var mStatScreen:StatsScreen;
      
      public var mGuideSprite:Sprite;
      
      public var mTimeUpTextField:TextField;
      
      public var mNumClearsInARow:int;
      
      public var mCurTreasure:TreasurePoint;
      
      public var mMinTreasureY:Number = 0;
      
      public var mTreasureCel:int;
      
      public var mLastExplosionTick:int;
      
      public var mDisplayingStats:Boolean;
      
      private var mApp:Zuma2App;
      
      public var mLevelStarting:Boolean;
      
      public var mTimeUpTextFormat:TextFormat;
      
      public var v1:SexyVector3;
      
      public var gDrawGuideFrame:int = -1;
      
      public var mScoreBlips:Vector.<ScoreBlip>;
      
      public var mOptionsMenu:OptionsMenu;
      
      public var mSpaceBarDown:Boolean = false;
      
      public var mPauseOverlay:Sprite;
      
      public var mBackgroundBitmap:Bitmap;
      
      public var mGuide:Vector.<Number>;
      
      public var mClickToContinueTextField:TextField;
      
      public var mLazerGuideCenter:SexyVector3;
      
      public var mCurComboScore:int;
      
      private var mBulletListIterator:DListIterator;
      
      public var g1:SexyVector3;
      
      public var g2:SexyVector3;
      
      public var mRollingInDangerZone:Boolean;
      
      public var mRecalcLazerGuide:Boolean;
      
      public var mTreasureStarAngle:Number = 0;
      
      public var gPt1:Point;
      
      public var gPt2:Point;
      
      public var mLastMouseX:Number;
      
      public var mLastMouseY:Number;
      
      public var mTreasureYBob:Number = 0;
      
      public var mLevelNum:int;
      
      public var mTreasureGlowAlpha:int;
      
      public var guide_center:SexyVector3;
      
      public var mChuteBitmap:Bitmap;
      
      private var mIsInited:Boolean = false;
      
      private var mBulletList:DLinkedList;
      
      public var mWidget:GameWidget;
      
      public var mMenuBarBitmap:Bitmap;
      
      public var mLevel:Level;
      
      public var mCurComboCount:int;
      
      public var aGuide:SexyVector3;
      
      public var mNeedComboCount:DLinkedList;
      
      public var mBallColorMap:Array;
      
      public var mGuideBall:Ball;
      
      public var mOverMenuButton:Boolean;
      
      public var mPreventBallAdvancement:Boolean;
      
      public var mHasDoneIntroSounds:Boolean;
      
      public var l1:SexyVector3;
      
      public var mTreasureWasHit:Boolean;
      
      public var mStateCount:int;
      
      public var mFruitSprite:Sprite;
      
      public var l2:SexyVector3;
      
      public var mTreasureStarAlpha:int;
      
      public var mPowerEffects:Vector.<PowerEffect>;
      
      public var mLazerGuide:Array;
      
      public var mAdventureMode:Boolean;
      
      public var mTreasureGlowAlphaRate:int;
      
      public var mLazerHitTreasure:Boolean;
      
      public var mFruitBounceEffect:Bouncy;
      
      public var mLevelBeginning:Boolean;
      
      public var mBombExplosionSprite:Sprite;
      
      public var mNumCleared:int = 0;
      
      public var mMaxTreasureY:Number = 0;
      
      public var gCenter:Point;
      
      public var mGuideT:Number;
      
      public var gNewStyleBallChooser:Boolean = true;
      
      public var mGuideLines:Vector.<int>;
      
      private var mFrog:Gun;
      
      public var mTreasureEndFrame:int;
      
      public var mFruitBitmap:Bitmap;
      
      public var mFruitGlowSprite:Sprite;
      
      public var mCurInARowBonus:int;
      
      public var mMenuButton:SimpleButton;
      
      public var p3:SexyVector3;
      
      public var mGuideCenter:SexyVector3;
      
      public var mLevelStats:GameStats;
      
      public var mQRand:QRand;
      
      public var mCurTreasureNum:int;
      
      public var mGameState:int;
      
      public var mFruitGlow:Bitmap;
      
      public var mBombExplosionImage:ImageInst;
      
      public var mTunnels:Array;
      
      public var mGameStats:GameStats;
      
      public var mFruitGlowImage:ImageInst;
      
      public var mTreasureDefaultVY:Number = 0;
      
      public var mUpdateCnt:int;
      
      public var mFruitImage:ImageInst;
      
      public var mBombExplosionBitmap:Bitmap;
      
      public var mPaused:Boolean;
      
      public var mTreasureVY:Number = 0;
      
      public function GameBoardWidget(param1:Zuma2App)
      {
         this.mBallColorMap = new Array();
         this.mTunnels = new Array();
         this.mPowerEffects = new Vector.<PowerEffect>();
         this.mScoreBlips = new Vector.<ScoreBlip>();
         this.mGuide = new Vector.<Number>();
         this.mLazerGuide = new Array();
         this.mGuideLines = new Vector.<int>();
         this.mNeedComboCount = new DLinkedList();
         this.aCenter = new SexyVector3(0,0,0);
         this.g1 = new SexyVector3(0,0,0);
         this.g2 = new SexyVector3(0,0,0);
         this.v1 = new SexyVector3(0,0,0);
         this.l1 = new SexyVector3(0,0,0);
         this.l2 = new SexyVector3(0,0,0);
         this.p3 = new SexyVector3(0,0,0);
         this.aGuide = new SexyVector3(0,0,0);
         this.guide_center = new SexyVector3(0,0,0);
         super();
         this.mApp = param1;
         this.mApp.RegisterCommand("RedBall",this.RedBall);
         this.mApp.RegisterCommand("YellowBall",this.YellowBall);
         this.mApp.RegisterCommand("GreenBall",this.GreenBall);
         this.mApp.RegisterCommand("BlueBall",this.BlueBall);
         this.mApp.RegisterCommand("PurpleBall",this.PurpleBall);
         this.mApp.RegisterCommand("WhiteBall",this.WhiteBall);
         this.mApp.RegisterCommand("Bomb",this.Bomb);
         this.mApp.RegisterCommand("Stop",this.Stop);
         this.mApp.RegisterCommand("Reverse",this.Reverse);
         this.mApp.RegisterCommand("PauseBalls",this.PauseBalls);
         this.mApp.RegisterCommand("ForceFruit",this.ForceFruit);
         this.mApp.RegisterCommand("DeleteBall",this.DeleteBall);
         this.mApp.RegisterCommand("ForceTimeUp",this.ForceTimeUp);
         this.mApp.stage.addEventListener(FocusEvent.FOCUS_OUT,this.handleLostFocus);
         this.mApp.stage.addEventListener(FocusEvent.FOCUS_IN,this.handleGotFocus);
         this.mApp.stage.focus = this.mApp.stage;
      }
      
      public function PurpleBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.Purple_Ball);
      }
      
      public function handleGotFocus(param1:FocusEvent) : void
      {
         trace("Stage has gotten focus");
      }
      
      public function ForceFruit(param1:Array = null) : void
      {
         this.mApp.gForceFruit = !this.mApp.gForceFruit;
      }
      
      public function RedBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.Red_Ball);
      }
      
      public function HideBalls(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mCurveMgr[_loc2_].HideBalls(param1);
            _loc2_++;
         }
      }
      
      public function PauseBalls(param1:Array = null) : void
      {
         this.mApp.gUpdateBalls = !this.mApp.gUpdateBalls;
      }
      
      override public function contains(param1:Number, param2:Number) : Boolean
      {
         if(param1 > 0 && param1 < 540 && param2 > 0 && param2 < 405)
         {
            return true;
         }
         return false;
      }
      
      public function UpdateBombExplosion() : void
      {
         if(this.mUpdateCnt % 3 == 0)
         {
            ++this.mBombExplosionImage.mFrame;
            if(this.mBombExplosionImage.mFrame > 29)
            {
               if(this.mBombExplosionSprite.parent != null)
               {
                  this.mBombExplosionSprite.parent.removeChild(this.mBombExplosionSprite);
                  return;
               }
            }
            this.mBombExplosionBitmap.bitmapData = this.mBombExplosionImage.pixels;
         }
      }
      
      public function handleMenuButtonOver(param1:MouseEvent) : void
      {
         this.mOverMenuButton = true;
      }
      
      public function DrawTreasure() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:ColorTransform = null;
         if(this.IsPaused())
         {
            return;
         }
         if(this.mCurTreasure != null)
         {
            this.mFruitGlow.visible = true;
            this.mFruitSprite.visible = true;
            this.mFruitGlowSprite.visible = true;
            _loc1_ = this.mCurTreasure.x * Zuma2App.SHRINK_PERCENT;
            _loc2_ = this.mCurTreasure.y * Zuma2App.SHRINK_PERCENT;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc5_ = this.mFruitBounceEffect.GetPct();
            if(this.mFruitBounceEffect.GetCount() > 0)
            {
               (_loc6_ = !!this.mTreasureWasHit ? new ColorTransform(1,1,1,1,255,0,0) : new ColorTransform(1,1,1,1,255,255,255)).alphaOffset = this.mTreasureStarAlpha;
               if(_loc6_.alphaOffset != 255)
               {
                  this.mFruitGlow.transform.colorTransform = _loc6_;
               }
               this.mFruitGlowSprite.x = _loc1_ + _loc3_;
               this.mFruitGlowSprite.y = _loc2_ + _loc4_ + this.mTreasureYBob;
               this.mFruitGlowSprite.rotation = this.mTreasureStarAngle * Zuma2App.RAD_TO_DEG;
            }
            this.mFruitImage.mFrame = this.mTreasureCel;
            this.mFruitBitmap.bitmapData = this.mFruitImage.pixels;
            this.mFruitGlowBitmap.bitmapData = this.mFruitImage.pixels;
            this.mFruitSprite.x = _loc1_ + _loc3_;
            this.mFruitSprite.y = _loc2_ + this.mTreasureYBob + _loc4_;
            if(!this.mTreasureWasHit)
            {
               if(this.mTreasureGlowAlpha != 0 && this.mFruitGlow != null)
               {
                  this.mFruitGlowBitmap.alpha = this.mTreasureGlowAlpha / 255;
               }
            }
         }
      }
      
      public function Stop(param1:Array = null) : void
      {
         var _loc2_:Ball = this.mLevel.GetBallAtXY(this.mLastMouseX / Zuma2App.SHRINK_PERCENT,this.mLastMouseY / Zuma2App.SHRINK_PERCENT);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.SetPowerType(PowerType.PowerType_SlowDown,true);
      }
      
      public function GetGun() : Gun
      {
         return this.mFrog;
      }
      
      public function AddFiredBullet(param1:Bullet) : void
      {
         this.mBulletList.append(param1);
      }
      
      public function AddProxBombExplosion(param1:Number, param2:Number) : void
      {
         this.mBombExplosionImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_EXPLOSION_BOMB);
         this.mBombExplosionImage.mFrame = 0;
         this.mBombExplosionBitmap = new Bitmap(this.mBombExplosionImage.pixels,PixelSnapping.NEVER,true);
         this.mBombExplosionBitmap.x = -this.mBombExplosionBitmap.width / 2;
         this.mBombExplosionBitmap.y = -this.mBombExplosionBitmap.height / 2;
         this.mBombExplosionSprite.x = param1 * Zuma2App.SHRINK_PERCENT;
         this.mBombExplosionSprite.y = param2 * Zuma2App.SHRINK_PERCENT;
         this.mBombExplosionSprite.addChild(this.mBombExplosionBitmap);
         this.mApp.mLayers[2].mForeground.addChild(this.mBombExplosionSprite);
      }
      
      public function StartLevel(param1:int) : void
      {
         var _loc2_:int = 0;
         this.mDisplayingStats = false;
         if(this.mLevel != null)
         {
            this.mLevel.ReInit();
         }
         this.mQRand.Clear();
         if(this.mPowerEffects.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.mPowerEffects.length)
            {
               this.mPowerEffects[_loc2_] = null;
               _loc2_++;
            }
         }
         this.mLazerHitTreasure = false;
         this.mBackgroundBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_LEVELBACKGROUND_VOLCANO1));
         this.mApp.mLayers[0].mBackground.addChild(this.mBackgroundBitmap);
         this.mMenuBarBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_UI_BAR));
         this.mApp.mLayers[0].mForeground.addChild(this.mMenuBarBitmap);
         var _loc3_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_INGAME_MENUBUTTON_UP));
         var _loc4_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_INGAME_MENUBUTTON_DOWN));
         var _loc5_:Bitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_INGAME_MENUBUTTON_OVER));
         this.mMenuButton = new SimpleButton(_loc3_,_loc5_,_loc4_,_loc4_);
         this.mMenuButton.x = 450;
         this.mMenuButton.y = 0;
         this.mMenuButton.addEventListener(MouseEvent.CLICK,this.handleMenuButtonClick);
         this.mMenuButton.addEventListener(MouseEvent.ROLL_OVER,this.handleMenuButtonOver);
         this.mMenuButton.addEventListener(MouseEvent.ROLL_OUT,this.handleMenuButtonOut);
         this.mApp.mLayers[2].mBalls.addChild(this.mMenuButton);
         this.mLevelNum = param1;
         this.mLevel = this.mApp.mLevelMgr.GetLevelByIndex(param1);
         this.mLevel.mBoard = this;
         this.mLevel.mApp = this.mApp;
         this.mFrog.mX = this.mLevel.mFrogX[0];
         this.mFrog.mY = this.mLevel.mFrogY[0];
         this.SetupTunnels(this.mLevel);
         this.mLevel.StartLevel();
         this.mLevelBeginning = true;
         this.mChuteBitmap = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_LEVELBACKGROUND_VOLCANO1_CHUTE1));
         this.mChuteBitmap.x = this.mTunnels[0].mX;
         this.mChuteBitmap.y = this.mTunnels[0].mY;
         this.mApp.mLayers[0].mForeground.addChild(this.mChuteBitmap);
         this.UpdateGunPos(true);
         this.DoAccuracy(true);
      }
      
      public function DeleteBall(param1:Array = null) : void
      {
         var _loc2_:Ball = this.mLevel.GetBallAtXY(this.mLastMouseX / Zuma2App.SHRINK_PERCENT,this.mLastMouseY / Zuma2App.SHRINK_PERCENT);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.Explode(false,false);
      }
      
      public function GetCurComboScore() : int
      {
         return this.mCurComboScore;
      }
      
      public function HasFiredBullets() : Boolean
      {
         return this.mBulletList.size > 0;
      }
      
      public function UpdateBullets() : void
      {
         var _loc1_:DListIterator = this.mBulletList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            this.AdvanceFreeBullet(_loc1_);
         }
      }
      
      public function HasAchievedZuma() : Boolean
      {
         return false;
      }
      
      public function UpdateTrackBPM(param1:int, param2:int) : void
      {
      }
      
      public function AdvanceFreeBullet(param1:DListIterator) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:Ball = null;
         var _loc2_:Bullet = param1.data;
         var _loc3_:int = 0;
         for(; _loc3_ < 2; _loc3_++)
         {
            if(_loc2_.GetJustFired())
            {
               _loc2_.SetJustFired(false);
            }
            else
            {
               if(_loc3_ == 0)
               {
                  continue;
               }
               _loc2_.Update(1);
            }
            if(this.mCurTreasure != null && !this.mTreasureWasHit)
            {
               _loc5_ = _loc2_.GetX() - this.mCurTreasure.x;
               _loc6_ = _loc2_.GetY() - this.mCurTreasure.y;
               _loc7_ = _loc2_.GetRadius() + (this.mFruitImage.height / 2 - 0) / Zuma2App.SHRINK_PERCENT;
               if(_loc5_ * _loc5_ + _loc6_ * _loc6_ < _loc7_ * _loc7_)
               {
                  this.DoHitTreasure();
                  this.mLevel.BulletHit(_loc2_);
                  if(!_loc2_.GetIsCannon())
                  {
                     _loc2_.Delete();
                     this.mBulletList.remove(param1);
                     return;
                  }
               }
            }
            _loc4_ = 0;
            while(_loc4_ < this.mLevel.mNumCurves)
            {
               if(this.mLevel.mCurveMgr[_loc4_].CheckCollision(_loc2_))
               {
                  this.mLevel.BulletHit(_loc2_);
                  if(!_loc2_.GetIsCannon())
                  {
                     this.mBulletList.remove(param1);
                     return;
                  }
                  break;
               }
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < this.mLevel.mNumCurves)
            {
               this.mLevel.mCurveMgr[_loc4_].CheckGapShot(_loc2_);
               _loc4_++;
            }
            if(_loc2_.GetX() < -80 || _loc2_.GetX() > 880 || _loc2_.GetY() < -80 || _loc2_.GetY() > 680)
            {
               if(!_loc2_.GetIsCannon())
               {
                  this.ResetInARowBonus();
               }
               if(this.mApp.gSuckMode && !_loc2_.GetIsCannon())
               {
                  if(this.mLevel.mHaveReachedTarget && this.mLevel.mNumCurves > 0)
                  {
                     _loc8_ = int(Math.random() * this.mLevel.mNumCurves);
                     (_loc9_ = new Ball(this.mApp)).SetColorType(_loc2_.GetColorType());
                     _loc9_.SetPowerType(_loc2_.GetPowerType());
                     _loc9_.SetSpeedy(true);
                     this.mLevel.mCurveMgr[_loc8_].AddPendingBall(_loc9_);
                  }
               }
               ++this.mLevelStats.mNumMisses;
               _loc2_.Delete();
               this.mBulletList.remove(param1);
               return;
            }
            ++this.mBallColorMap[_loc2_.GetColorType()];
         }
         param1.forth();
      }
      
      public function GetNumClearsInARow() : int
      {
         return this.mNumClearsInARow;
      }
      
      public function CheckReload() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Bullet = null;
         var _loc4_:int = 0;
         if(this.mApp.gSuckMode)
         {
            _loc3_ = this.mFrog.GetBullet();
            if(_loc3_ != null)
            {
               ++this.mBallColorMap[_loc3_.GetColorType()];
            }
            _loc3_ = this.mFrog.GetNextBullet();
            if(_loc3_ != null)
            {
               ++this.mBallColorMap[_loc3_.GetColorType()];
            }
            return;
         }
         if(this.mFrog.GetBullet() != null && this.mBallColorMap[this.mFrog.GetBullet().GetColorType()] <= 0 && this.mLevel.mNumCurves > 0)
         {
            _loc1_ = this.GetGoodBallColor();
            if(_loc1_ == -1)
            {
               return;
            }
            this.mFrog.SetBulletType(_loc1_);
         }
         if(this.mFrog.GetNextBullet() != null && this.mBallColorMap[this.mFrog.GetNextBullet().GetColorType()] <= 0 && this.mLevel.mNumCurves > 0)
         {
            _loc1_ = this.GetGoodBallColor();
            if(_loc1_ == -1)
            {
               return;
            }
            this.mFrog.SetNextBulletType(_loc1_);
         }
         var _loc2_:Boolean = true;
         while(this.mFrog.NeedsReload())
         {
            _loc1_ = this.GetGoodBallColor();
            if(_loc1_ == -1)
            {
               return;
            }
            _loc4_ = PowerType.PowerType_None;
            this.mFrog.Reload(_loc1_,_loc2_,_loc4_);
         }
      }
      
      public function UpdateTimeUp() : void
      {
         this.UpdateText();
         this.mTimeUpTextField.x += 10;
         this.mRollerScore.Update();
         if(this.mTimeUpTextField.x >= 190)
         {
            this.mTimeUpTextField.x = 190;
         }
         if(this.mStateCount == 250)
         {
            this.DisplayStats();
         }
         this.UpdateGunPos();
         this.mFrog.update();
      }
      
      public function DrawText() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mScoreBlips.length)
         {
            this.mScoreBlips[_loc1_].Draw();
            _loc1_++;
         }
      }
      
      public function YellowBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.Yellow_Ball);
      }
      
      public function ChangeBallColor(param1:int) : void
      {
         var _loc2_:Ball = this.mLevel.GetBallAtXY(this.mLastMouseX / Zuma2App.SHRINK_PERCENT,this.mLastMouseY / Zuma2App.SHRINK_PERCENT);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.SetColorType(param1);
      }
      
      public function SetRollingInDangerZone() : void
      {
         this.mRollingInDangerZone = true;
      }
      
      public function UpdateTreasure() : void
      {
         if(this.mCurTreasure != null)
         {
            if(this.mStateCount >= this.mTreasureEndFrame)
            {
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_FRUIT_DISAPPEARS);
               this.mCurTreasure = null;
               this.mCurTreasureNum = 0;
               this.mFruitGlowSprite.visible = false;
               this.mFruitSprite.visible = false;
               return;
            }
         }
         var _loc1_:int = this.mLevel.mTreasureFreq;
         if(this.mApp.gForceFruit || this.mCurTreasure == null && this.mStateCount - this.mTreasureEndFrame > _loc1_)
         {
            if(this.mLevel.CheckFruitActivation(-1))
            {
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_FRUIT_APPEARS);
               this.mTreasureEndFrame = this.mStateCount + TREASURE_LIFE;
               this.mTreasureStarAlpha = 255;
               this.mTreasureGlowAlpha = 0;
               this.mTreasureGlowAlphaRate = 12;
               this.mTreasureWasHit = false;
               this.mTreasureVY = this.mTreasureDefaultVY = 0.25;
               this.mMinTreasureY = this.mMaxTreasureY = Number.MAX_VALUE;
               this.mTreasureYBob = 0;
               this.mTreasureAccel = -0.01;
               this.mFruitBounceEffect.Reset();
            }
            this.mApp.gForceFruit = false;
         }
      }
      
      override public function onKeyUp(param1:int) : void
      {
         if(param1 == 32 && this.mFrog != null)
         {
            this.mSpaceBarDown = false;
         }
      }
      
      public function Bomb(param1:Array = null) : void
      {
         var _loc2_:Ball = this.mLevel.GetBallAtXY(this.mLastMouseX / Zuma2App.SHRINK_PERCENT,this.mLastMouseY / Zuma2App.SHRINK_PERCENT);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.SetPowerType(PowerType.PowerType_ProximityBomb,true);
      }
      
      public function Reverse(param1:Array = null) : void
      {
         var _loc2_:Ball = this.mLevel.GetBallAtXY(this.mLastMouseX / Zuma2App.SHRINK_PERCENT,this.mLastMouseY / Zuma2App.SHRINK_PERCENT);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.SetPowerType(PowerType.PowerType_MoveBackwards,true);
      }
      
      public function DoAccuracy(param1:Boolean) : void
      {
         this.mDoGuide = this.mShowGuide = this.mRecalcLazerGuide = this.mRecalcGuide = param1;
         if(param1)
         {
            if(this.mAccuracyBackupCount > 0)
            {
               this.mAccuracyBackupCount = this.mAccuracyCount;
            }
            this.mGuideSprite.visible = true;
            this.mAccuracyCount = 2000;
            this.mFrog.SetFireSpeed(19);
         }
         else
         {
            if(this.mGuideBall != null)
            {
               this.mGuideBall.mHilightPulse = false;
            }
            this.mGuideBall = null;
            this.mAccuracyCount = 0;
            if(this.mLevel != null)
            {
               this.mFrog.SetFireSpeed(this.mLevel.mFireSpeed);
            }
         }
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         if(!this.mIsInited)
         {
            this.init();
         }
         if(this.mPaused)
         {
            return;
         }
         ++this.mUpdateCnt;
         ++this.mStateCount;
         switch(this.mGameState)
         {
            case GameState_Playing:
               this.UpdatePlaying();
               break;
            case GameState_Losing:
               this.UpdateLosing();
               break;
            case GameState_TimeUp:
               this.UpdateTimeUp();
         }
         _loc1_ = 0;
         while(_loc1_ < this.mPowerEffects.length)
         {
            this.mPowerEffects[_loc1_].Update();
            if(this.mPowerEffects[_loc1_].IsDone())
            {
               this.mPowerEffects[_loc1_].Delete();
               this.mPowerEffects.splice(_loc1_,1);
               _loc1_--;
            }
            _loc1_++;
         }
         if(this.mDoGuide || this.mAccuracyCount > 0 || this.mApp.gSuckMode)
         {
            if(this.mDoGuide || this.mApp.gSuckMode || this.mAccuracyCount > 0)
            {
               this.UpdateGuide(false);
            }
         }
         else
         {
            this.mGuideBall = null;
         }
      }
      
      override public function onKeyDown(param1:int) : void
      {
         if(param1 == 32 && this.mFrog != null && !this.mSpaceBarDown)
         {
            this.mSpaceBarDown = true;
            this.mFrog.SwapBullets();
         }
      }
      
      public function handleLostFocus(param1:FocusEvent) : void
      {
         trace("Stage has gotten focus");
         this.mApp.stage.focus = this.mApp.stage;
      }
      
      public function GetStateCount() : int
      {
         return this.mStateCount;
      }
      
      public function handleMenuButtonOut(param1:MouseEvent) : void
      {
         this.mOverMenuButton = false;
      }
      
      public function SetPause(param1:Boolean) : void
      {
         this.mPaused = param1;
         if(this.mPaused)
         {
            this.mApp.soundManager.pauseAll();
            this.mPauseOverlay = new Sprite();
            this.mPauseOverlay.graphics.clear();
            this.mPauseOverlay.graphics.beginFill(0,0.5);
            this.mPauseOverlay.graphics.drawRect(0,0,540,405);
            this.mPauseOverlay.graphics.endFill();
            this.mApp.mLayers[4].mBackground.addChild(this.mPauseOverlay);
            this.HideBalls(true);
         }
         else
         {
            this.mApp.soundManager.resumeAll();
            if(this.mPauseOverlay.parent != null)
            {
               this.mPauseOverlay.parent.removeChild(this.mPauseOverlay);
               this.mPauseOverlay.graphics.clear();
               this.mPauseOverlay = null;
            }
            this.HideBalls(false);
         }
      }
      
      public function UpdateLosing() : void
      {
         this.mLevel.mHoleMgr.Update();
         this.UpdateText();
         this.mRollerScore.Update();
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mCurveMgr[_loc2_].UpdateLosing();
            if(!this.mLevel.mCurveMgr[_loc2_].CanRestart())
            {
               _loc1_ = false;
            }
            _loc2_++;
         }
         this.mFrog.mAngle += 0.2;
         this.UpdateGunPos();
         if(_loc1_ && !this.mDisplayingStats)
         {
            this.DisplayStats();
         }
      }
      
      public function GetTickCount() : int
      {
         return this.GetStateCount() * 10;
      }
      
      public function IncCurComboScore(param1:int) : void
      {
         this.mCurComboScore += param1;
      }
      
      public function UpdateTreasureAnim() : void
      {
         if(this.mStateCount == this.mTreasureEndFrame - 200)
         {
            this.mTreasureGlowAlphaRate *= 4;
         }
         this.mTreasureStarAngle += 0.01;
         if(this.mUpdateCnt % 3 == 0)
         {
            this.mTreasureCel = (this.mTreasureCel + 1) % (6 * 10);
         }
         if(this.mTreasureWasHit)
         {
            if(this.mTreasureStarAlpha > 0)
            {
               this.mTreasureStarAlpha -= 8;
               if(this.mTreasureStarAlpha < 0)
               {
                  this.mTreasureStarAlpha = 0;
               }
            }
            this.mTreasureGlowAlpha += this.mTreasureGlowAlphaRate;
            if(this.mTreasureGlowAlphaRate > 0 && this.mTreasureGlowAlpha >= 255)
            {
               this.mTreasureGlowAlpha = 255;
               this.mTreasureGlowAlphaRate *= -1;
            }
            else if(this.mTreasureGlowAlphaRate < 0 && this.mTreasureGlowAlpha <= 0)
            {
               this.mTreasureGlowAlphaRate = this.mTreasureGlowAlpha = 0;
            }
            this.mCurTreasure = null;
            this.mCurTreasureNum = 0;
            this.mFruitGlowSprite.visible = false;
            this.mFruitSprite.visible = false;
         }
         else
         {
            this.mTreasureVY += this.mTreasureAccel;
            if(this.mTreasureAccel < 0 && this.mTreasureVY <= -this.mTreasureDefaultVY)
            {
               this.mTreasureAccel *= -1;
               if(Math.abs(this.mMinTreasureY - Number.MAX_VALUE) <= 1)
               {
                  this.mMinTreasureY = this.mTreasureYBob;
               }
               else
               {
                  this.mTreasureYBob = this.mMinTreasureY;
               }
            }
            else if(this.mTreasureAccel > 0 && this.mTreasureVY > this.mTreasureDefaultVY)
            {
               this.mTreasureAccel *= -1;
               if(Math.abs(this.mMaxTreasureY - Number.MAX_VALUE) <= 1)
               {
                  this.mMaxTreasureY = this.mTreasureYBob;
               }
               else
               {
                  this.mTreasureYBob = this.mMaxTreasureY;
               }
            }
            this.mTreasureYBob += this.mTreasureVY;
            this.mTreasureGlowAlpha += this.mTreasureGlowAlphaRate;
            if(this.mTreasureGlowAlphaRate > 0 && this.mTreasureGlowAlpha >= 255)
            {
               this.mTreasureGlowAlpha = 255;
               this.mTreasureGlowAlphaRate *= -1;
            }
            else if(this.mTreasureGlowAlphaRate < 0 && this.mTreasureGlowAlpha <= 0)
            {
               this.mTreasureGlowAlphaRate *= -1;
               this.mTreasureGlowAlpha = 0;
            }
         }
      }
      
      public function GetCurComboCount() : int
      {
         return this.mCurComboCount;
      }
      
      public function IncNumClearsInARow(param1:int) : void
      {
         this.mNumClearsInARow += param1;
         if(this.mNumClearsInARow > 1)
         {
         }
      }
      
      public function RestartLevel() : void
      {
         this.mApp.soundManager.stopAll();
         this.Reset();
         this.mFrog.LevelReset();
         this.StartLevel(0);
      }
      
      public function OpenMenu() : void
      {
         this.SetPause(true);
         this.mOptionsMenu = new OptionsMenu(this.mApp,this);
      }
      
      public function SetCurComboScore(param1:int) : void
      {
         this.mCurComboScore = param1;
      }
      
      public function ForceTimeUp(param1:Array = null) : void
      {
         this.SetTimeUp();
      }
      
      public function CirclesIntersect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0) : Boolean
      {
         var _loc7_:Number = param1 - param3;
         var _loc8_:Number = param2 - param4;
         var _loc9_:Number = _loc7_ * _loc7_ + _loc8_ * _loc8_;
         if(param6 != 0)
         {
            param6 = _loc9_;
         }
         return _loc9_ < param5 * param5;
      }
      
      override public function onMouseMove(param1:Number, param2:Number) : void
      {
         this.mLastMouseX = param1;
         this.mLastMouseY = param2;
         if(this.mPaused)
         {
            return;
         }
         if(this.mFrog == null)
         {
            return;
         }
         var _loc3_:Number = this.mFrog.GetDestAngle();
         var _loc4_:Number = this.mFrog.GetAngle();
         this.UpdateGunPos();
         if(_loc3_ >= Zuma2App.MY_PI)
         {
            _loc3_ -= Zuma2App.MY_PI * 2;
         }
         if(this.mFrog.mDestAngle >= Zuma2App.MY_PI)
         {
            this.mFrog.mDestAngle -= Zuma2App.MY_PI * 2;
         }
         if(_loc3_ < -Zuma2App.MY_PI && this.mFrog.GetDestAngle() > Zuma2App.MY_PI)
         {
            this.mFrog.mDestAngle -= 3.14159 * 2;
         }
         else if(_loc3_ > Zuma2App.MY_PI && this.mFrog.GetDestAngle() < -Zuma2App.MY_PI)
         {
            this.mFrog.mDestAngle += 3.14159 * 2;
         }
         this.mFrog.mAngle = _loc4_;
      }
      
      public function UpdatePlaying() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc1_:Bullet = null;
         while((_loc1_ = this.mFrog.GetFiredBullet()) != null)
         {
            this.AddFiredBullet(_loc1_);
         }
         this.mFrog.update();
         this.UpdateBullets();
         if(this.mLevelBeginning)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < this.mLevel.mNumCurves)
            {
               if(!this.mLevel.mCurveMgr[_loc3_].HasReachedCruisingSpeed())
               {
                  _loc2_ = true;
               }
               _loc3_++;
            }
            if(!_loc2_ || this.mStateCount > 500)
            {
               this.mLevelBeginning = false;
            }
         }
         if(this.mApp.gUpdateBalls)
         {
            this.mLevel.UpdatePlaying();
         }
         this.mLevel.Update(1);
         this.CheckEndConditions();
         this.CheckReload();
         if(this.mBombExplosionSprite.parent != null)
         {
            this.UpdateBombExplosion();
         }
         this.UpdateText();
         if(!this.mLevel.DoingInitialPathHilite() && this.mGameState == GameState_Playing)
         {
            this.mTimerBar.Update();
            if(this.mTimerBar.mTimerNumber == 0 && this.mLevel.CurvesAtRest())
            {
               this.SetTimeUp();
            }
         }
         this.mRollerScore.Update();
         if(!this.mHasDoneIntroSounds)
         {
            if(!this.mLevel.DoingInitialPathHilite() && this.mGameState != GameState_Losing)
            {
               this.mHasDoneIntroSounds = true;
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BALLS_ROLLING);
            }
         }
         this.UpdateTreasureAnim();
         this.UpdateTreasure();
         this.mFruitBounceEffect.Update();
      }
      
      public function GetGoodBallColor() : int
      {
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Vector.<Number> = null;
         var _loc8_:Bullet = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            if(this.mBallColorMap[_loc5_] > 0)
            {
               var _loc9_:*;
               _loc1_[_loc9_ = _loc2_++] = _loc5_;
               if(_loc4_ && this.mBallColorMap[_loc5_] >= 1)
               {
                  _loc3_ = false;
               }
               if(this.mBallColorMap[_loc5_] >= 1)
               {
                  _loc4_ = true;
               }
            }
            _loc5_++;
         }
         if(_loc2_ > 0)
         {
            _loc6_ = false;
            _loc7_ = new Vector.<Number>();
            _loc5_ = 0;
            while(_loc5_ < 6)
            {
               if(this.mBallColorMap[_loc5_] > 0)
               {
                  _loc7_.push(this.mLevel.GetRandomFrogBulletColor(_loc2_,_loc5_));
               }
               else
               {
                  _loc7_.push(0);
               }
               if(this.mBallColorMap[_loc5_] > 0 && !this.mQRand.HasWeight(_loc5_) || this.mBallColorMap[_loc5_] == 0 && this.mQRand.HasWeight(_loc5_))
               {
                  _loc6_ = true;
               }
               _loc5_++;
            }
            if(_loc6_)
            {
               this.mQRand.Clear();
               this.mQRand.SetWeights(_loc7_);
            }
         }
         if(this.mLevel.mNumCurves == 0 || _loc3_ && !this.mLevel.DoingInitialPathHilite())
         {
            if((_loc8_ = this.mFrog.GetBullet()) == null)
            {
               _loc8_ = this.mFrog.GetNextBullet();
            }
            if(_loc8_ != null)
            {
               return _loc8_.GetColorType();
            }
            return Math.random() * 4;
         }
         if(_loc2_ <= 0)
         {
            return -1;
         }
         if(this.gNewStyleBallChooser)
         {
            return this.mQRand.Next();
         }
         return _loc1_[Math.random() * _loc2_];
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         this.mScore = 0;
         this.mGameStats = new GameStats();
         this.mLevelStats = new GameStats();
         this.mLevelStats.Reset();
         this.mPaused = false;
         this.mTimerBar = new TimerBar(this.mApp);
         this.mTimerBar.Init();
         this.mRollerScore = new RollerScore(this.mApp,false);
         this.mQRand = new QRand();
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.mBallColorMap[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc1_++;
         }
         this.mHasDoneIntroSounds = false;
         this.mLastBallClickTick = 0;
         this.mLastExplosionTick = 0;
         this.mTreasureStarAngle = 0;
         this.mFruitBounceEffect = new Bouncy();
         this.mFruitBounceEffect.SetTargetPercents(0.5,1.2,1);
         this.mFruitBounceEffect.SetRate(0.15);
         this.mFruitBounceEffect.SetNumBounces(6);
         this.mFruitBounceEffect.SetPct(0,true);
         this.mFruitBounceEffect.SetRateDivFactor(1.25);
         this.mFruitGlowSprite = new Sprite();
         this.mFruitGlow = new Bitmap(this.mApp.imageManager.getBitmapData(Zuma2Images.IMAGE_FRUIT_GLOW),PixelSnapping.NEVER,true);
         this.mFruitGlow.blendMode = BlendMode.ADD;
         this.mFruitGlow.x = -this.mFruitGlow.width / 2;
         this.mFruitGlow.y = -this.mFruitGlow.height / 2;
         this.mFruitGlow.visible = false;
         this.mFruitGlowSprite.addChild(this.mFruitGlow);
         this.mFruitGlowImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_FRUIT_ACORN_GLOW);
         this.mFruitGlowImage.mFrame = 0;
         this.mFruitGlowBitmap = new Bitmap(this.mFruitGlowImage.pixels,PixelSnapping.NEVER,true);
         this.mFruitGlowBitmap.x = -this.mFruitGlowBitmap.width / 2;
         this.mFruitGlowBitmap.y = -this.mFruitGlowBitmap.height / 2;
         this.mFruitImage = this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_FRUIT_ACORN);
         this.mFruitImage.mFrame = 0;
         this.mFruitBitmap = new Bitmap(this.mFruitImage.pixels,PixelSnapping.NEVER,true);
         this.mFruitBitmap.x = -this.mFruitBitmap.width / 2;
         this.mFruitBitmap.y = -this.mFruitBitmap.height / 2;
         this.mFruitSprite = new Sprite();
         this.mFruitSprite.addChild(this.mFruitBitmap);
         this.mFruitSprite.addChild(this.mFruitGlowBitmap);
         this.mFruitSprite.visible = false;
         this.mApp.mLayers[1].mForeground.addChild(this.mFruitGlowSprite);
         this.mApp.mLayers[1].mForeground.addChild(this.mFruitSprite);
         this.mGuideSprite = new Sprite();
         this.mGuideLines.push(2,2,2,2);
         this.mApp.mLayers[1].mBackground.addChild(this.mGuideSprite);
         this.mBombExplosionSprite = new Sprite();
         this.mIsInited = true;
         this.mAccuracyCount = 0;
         this.mFrog = new Gun(this.mApp,this);
         addChild(this.mFrog);
         this.mBulletList = new DLinkedList();
         this.mGameState = GameState_Playing;
         this.mApp.gUpdateBalls = true;
         this.StartLevel(0);
      }
      
      public function GetNumCleared() : int
      {
         return this.mNumCleared;
      }
      
      public function IsPaused() : Boolean
      {
         return false;
      }
      
      public function SetNumCleared(param1:int) : void
      {
         this.mNumCleared = param1;
      }
      
      public function GetGameState() : int
      {
         return this.mGameState;
      }
      
      public function SetTimeUp() : void
      {
         this.ResetInARowBonus();
         if(this.mScore > this.mApp.mHighScore)
         {
            this.mApp.mHighScore = this.mScore;
            this.mApp.mSharedObject.data.highscore = this.mScore;
            this.mApp.mSharedObject.flush();
         }
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_CHALLENGE_TIME_UP);
         this.mGameState = GameState_TimeUp;
         this.mStateCount = 0;
         this.mTimeUpTextField = new TextField();
         this.mTimeUpTextFormat = new TextFormat();
         this.mTimeUpTextFormat.font = "TimeUpText";
         this.mTimeUpTextFormat.align = TextFormatAlign.CENTER;
         this.mTimeUpTextFormat.color = 16777215;
         this.mTimeUpTextFormat.size = 55;
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.strength = 50;
         this.mTimeUpTextField = new TextField();
         this.mTimeUpTextField.embedFonts = true;
         this.mTimeUpTextField.defaultTextFormat = this.mTimeUpTextFormat;
         this.mTimeUpTextField.filters = [_loc1_];
         this.mTimeUpTextField.textColor = 16777215;
         this.mTimeUpTextField.width = 200;
         this.mTimeUpTextField.height = 100;
         this.mTimeUpTextField.x = -50;
         this.mTimeUpTextField.y = 100;
         this.mTimeUpTextField.alpha = 1;
         this.mTimeUpTextField.selectable = false;
         this.mTimeUpTextField.multiline = true;
         this.mTimeUpTextField.wordWrap = true;
         this.mTimeUpTextField.text = "TIME!";
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = "TimeUpText";
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.color = 16777215;
         _loc2_.size = 24;
         this.mApp.mLayers[3].mForeground.addChild(this.mTimeUpTextField);
      }
      
      public function DisplayStats() : void
      {
         this.mDisplayingStats = true;
         this.mStatScreen = new StatsScreen(this.mApp,this,this.mLevelStats.mMaxCombo + 1,this.mLevelStats.mMaxInARow,this.mLevelStats.mNumGaps,this.mLevelStats.mNumGemsCleared,this.mApp.mHighScore,this.mScore);
      }
      
      public function Reset() : void
      {
         var _loc1_:int = 0;
         this.mTimerBar = new TimerBar(this.mApp);
         this.mTimerBar.Init();
         this.mScore = 0;
         this.mLevelStats.Reset();
         if(this.mTimeUpTextField != null)
         {
            if(this.mTimeUpTextField.parent != null)
            {
               this.mTimeUpTextField.parent.removeChild(this.mTimeUpTextField);
            }
         }
         this.mHasDoneIntroSounds = false;
         this.mTreasureCel = 0;
         this.mNumClearsInARow = this.mCurInARowBonus = this.mCurComboScore = this.mNumCleared = this.mCurComboCount = 0;
         this.mStateCount = 0;
         this.mLastBallClickTick = 0;
         this.mAccuracyCount = 0;
         this.mAccuracyBackupCount = 0;
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.mBallColorMap[_loc1_] = 0;
            _loc1_++;
         }
         this.DeleteBullets();
         this.DoAccuracy(false);
         this.mFrog.EmptyBullets();
         this.mRollerScore.Reset(false);
         this.mGameState = GameState_Playing;
         this.mStateCount = 0;
         this.mQRand = new QRand();
         this.mApp.gDieAtEnd = true;
         this.mApp.gSuckMode = false;
         this.mApp.gAddBalls = true;
         this.UpdateGunPos(true);
         this.mFruitGlow.visible = false;
         this.mFruitSprite.visible = false;
         this.mCurTreasure = null;
         this.mTreasureEndFrame = 0;
         this.mLastExplosionTick = 0;
      }
      
      public function ActivatePowerBall(param1:Ball) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.GetPowerOrDestType();
         this.ActivatePower(_loc2_,param1.GetColorType(),param1.GetX(),param1.GetY());
         _loc3_ = 0;
         while(_loc3_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mCurveMgr[_loc3_].ActivatePower(param1);
            _loc3_++;
         }
      }
      
      public function IncCurInARowBonus(param1:int) : void
      {
         this.mCurInARowBonus += param1;
      }
      
      override public function draw(param1:Canvas) : void
      {
         var _loc2_:int = 0;
         if(!this.mIsInited)
         {
            return;
         }
         if(this.mPaused)
         {
            return;
         }
         if(this.mFrog != null)
         {
            this.mFrog.draw(param1);
         }
         _loc2_ = 0;
         while(_loc2_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mHoleMgr.Draw(param1);
            this.mLevel.mCurveMgr[_loc2_].DrawSkullPath();
            this.mLevel.mCurveMgr[_loc2_].DrawMisc();
            _loc2_++;
         }
         this.mBulletListIterator = this.mBulletList.getListIterator();
         this.mBulletListIterator.start();
         var _loc3_:Bullet = this.mBulletListIterator.data;
         while(_loc3_ != null)
         {
            _loc3_.Draw(param1);
            _loc3_ = this.mBulletListIterator.next();
         }
         _loc2_ = 0;
         while(_loc2_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mCurveMgr[_loc2_].DrawBalls(param1);
            _loc2_++;
         }
         this.DrawTreasure();
         _loc2_ = 0;
         while(_loc2_ < this.mPowerEffects.length)
         {
            this.mPowerEffects[_loc2_].Draw();
            _loc2_++;
         }
         this.DrawText();
         if(!this.mLevel.DoingInitialPathHilite() && this.mGameState == GameState_Playing)
         {
            this.mTimerBar.Draw();
         }
         this.mRollerScore.Draw();
         this.DrawGuide();
      }
      
      public function AddText(param1:String, param2:Number, param3:Number, param4:uint, param5:Number = 1.0) : void
      {
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc6_:uint = this.mApp.gBallColors[param4];
         var _loc7_:ScoreBlip = new ScoreBlip(this.mApp,param1,param2,param3,_loc6_);
         if(param5 >= 1)
         {
            _loc8_ = 2;
            if(param5 > 1.51)
            {
               _loc8_++;
            }
            _loc10_ = (_loc9_ = 1) / _loc8_;
            _loc11_ = (6 * _loc9_ - _loc10_ * 6) / 0.1;
            _loc10_ = (_loc9_ = param5 - 1) / _loc8_;
            _loc12_ = (6 * _loc9_ - _loc10_ * 6) / _loc11_;
         }
         _loc7_.Bulge(param5,_loc12_,_loc8_);
         this.mScoreBlips.push(_loc7_);
      }
      
      public function handleMenuButtonClick(param1:MouseEvent) : void
      {
         this.OpenMenu();
      }
      
      public function UpdateGunPos(param1:Boolean = false, param2:int = -1, param3:int = -1) : void
      {
         var _loc11_:int = 0;
         if(param1)
         {
            _loc11_ = this.mLevel.mCurFrogPoint;
            this.mFrog.SetPos(this.mLevel.mFrogX[_loc11_],this.mLevel.mFrogY[_loc11_]);
         }
         var _loc4_:int = param2 == -1 ? int(this.mLastMouseX / Zuma2App.SHRINK_PERCENT) : int(param2);
         var _loc5_:int = param3 == -1 ? int(this.mLastMouseY / Zuma2App.SHRINK_PERCENT) : int(param3);
         var _loc6_:int = this.mFrog.GetCenterX();
         var _loc7_:int = this.mFrog.GetCenterY();
         var _loc8_:int = _loc4_ - _loc6_;
         var _loc9_:int = _loc7_ - _loc5_;
         var _loc10_:Number = -Math.atan2(_loc9_,_loc8_);
         this.mFrog.SetDestAngle(_loc10_);
      }
      
      public function PowerupToStr(param1:int, param2:Boolean = true) : String
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case PowerType.PowerType_ProximityBomb:
               _loc3_ = !!param2 ? "PROXIMITY BOMB" : "Bomb";
               break;
            case PowerType.PowerType_SlowDown:
               _loc3_ = !!param2 ? "SLOW" : "Slow";
               break;
            case PowerType.PowerType_Accuracy:
               _loc3_ = !!param2 ? "ACCURACY" : "Accuracy";
               break;
            case PowerType.PowerType_MoveBackwards:
               _loc3_ = !!param2 ? "REVERSE" : "Reverse";
               break;
            case PowerType.PowerType_Cannon:
               _loc3_ = !!param2 ? "TRI-SHOT" : "Tri-Shot";
               break;
            case PowerType.PowerType_ColorNuke:
               _loc3_ = !!param2 ? "LIGHTNING" : "Lightning";
               break;
            case PowerType.PowerType_Laser:
               _loc3_ = !!param2 ? "LASER" : "Laser";
               break;
            case PowerType.PowerType_GauntletMultBall:
               _loc3_ = !!param2 ? "BONUS BALL" : "Bonus Ball";
         }
         return _loc3_;
      }
      
      public function CloseMenu() : void
      {
         this.SetPause(false);
      }
      
      public function SetCurComboCount(param1:int) : void
      {
         this.mCurComboCount = param1;
      }
      
      public function DeleteBullets() : void
      {
         var _loc1_:DListIterator = this.mBulletList.getListIterator();
         _loc1_.start();
         while(_loc1_.valid())
         {
            _loc1_.data.Delete();
            _loc1_.forth();
         }
         this.mBulletList.clear();
      }
      
      public function PlayExplosionSound() : void
      {
         var _loc1_:int = this.GetTickCount();
         if(_loc1_ - this.mLastExplosionTick > 250)
         {
            this.mLastExplosionTick = _loc1_;
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BOMB_EXPLOSION);
         }
      }
      
      public function SetLosing(param1:int = -1) : void
      {
         if(this.mScore > this.mApp.mHighScore)
         {
            this.mApp.mHighScore = this.mScore;
            this.mApp.mSharedObject.data.highscore = this.mScore;
            this.mApp.mSharedObject.flush();
         }
         var _loc2_:int = 0;
         this.mPreventBallAdvancement = false;
         this.DoAccuracy(false);
         this.mFrog.PlayerDied();
         this.mCurTreasure = null;
         this.mFruitGlowSprite.visible = false;
         this.mFruitSprite.visible = false;
         this.mCurTreasureNum = 0;
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_GAMEOVER1);
         this.ResetInARowBonus();
         this.mAccuracyBackupCount = 0;
         if(this.mAccuracyCount > 300)
         {
            this.mAccuracyCount = 300;
         }
         _loc2_ = 0;
         while(_loc2_ < this.mLevel.mNumCurves)
         {
            this.mLevel.mCurveMgr[_loc2_].SetLosing();
            _loc2_++;
         }
         this.mGameState = GameState_Losing;
         this.mStateCount = 0;
      }
      
      public function IncScore(param1:int, param2:Boolean, param3:Boolean = true) : void
      {
         if(param1 <= 0 || param2 && !this.mLevel.AllowPointsFromBalls())
         {
            return;
         }
         var _loc4_:int = this.mScore;
         var _loc5_:int = this.mScore;
         this.mScore += param1;
         this.mRollerScore.SetTargetScore(this.mRollerScore.GetTargetScore() + param1);
      }
      
      public function GreenBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.Green_Ball);
      }
      
      public function GauntletMode() : Boolean
      {
         return false;
      }
      
      public function BlueBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.Blue_Ball);
      }
      
      public function ResetInARowBonus() : void
      {
         if(this.mNumClearsInARow > this.mLevelStats.mMaxInARow)
         {
            this.mLevelStats.mMaxInARow = this.mNumClearsInARow;
            this.mLevelStats.mMaxInARowScore = this.mCurInARowBonus;
         }
         this.mNumClearsInARow = 0;
         this.mCurInARowBonus = 0;
      }
      
      public function UpdateGuide(param1:Boolean = false) : void
      {
         var _loc11_:SexyVector3 = null;
         var _loc12_:SexyVector3 = null;
         var _loc13_:int = 0;
         var _loc17_:Ball = null;
         this.mGuideT = -1;
         var _loc2_:Number = -this.mFrog.GetAngle();
         -Zuma2App.MY_PI / 2;
         var _loc3_:Number = Math.sin(_loc2_);
         var _loc4_:Number = Math.cos(_loc2_);
         var _loc5_:Number = _loc3_;
         var _loc6_:Number = _loc4_;
         var _loc7_:Number = _loc3_ * 28;
         var _loc8_:Number = _loc4_ * 28;
         var _loc9_:int = 33;
         this.aCenter.x = this.mFrog.GetCenterX() - -1 * _loc3_ + _loc9_ * _loc4_;
         this.aCenter.y = this.mFrog.GetCenterY() - -1 * _loc4_ - _loc9_ * _loc3_;
         this.aCenter.z = 0;
         this.g1.x = this.aCenter.x - _loc7_;
         this.g1.y = this.aCenter.y - _loc8_;
         this.g1.z = 0;
         this.g2.x = this.aCenter.x + _loc7_;
         this.g2.y = this.aCenter.y + _loc8_;
         this.g2.z = 0;
         this.v1.x = Math.cos(_loc2_);
         this.v1.y = -Math.sin(_loc2_);
         this.v1.z = 0;
         var _loc10_:int = 5;
         this.l1.x = this.aCenter.x + _loc10_ * _loc3_;
         this.l1.y = this.aCenter.y;
         this.l1.z = 0;
         this.l2.x = this.aCenter.x - _loc10_ * _loc3_;
         this.l2.y = this.aCenter.y;
         this.l2.z = 0;
         this.p3.x = this.aCenter.x;
         this.p3.y = this.aCenter.y;
         this.p3.z = 0;
         if(param1)
         {
            _loc11_ = this.l1;
            _loc12_ = this.l2;
         }
         else
         {
            _loc11_ = this.g1;
            _loc12_ = this.g2;
         }
         this.gPt1 = new Point(_loc11_.x,_loc11_.y);
         this.gPt2 = new Point(_loc12_.x,_loc12_.y);
         this.gCenter = new Point(this.p3.x,this.p3.y);
         this.mLazerHitTreasure = false;
         var _loc14_:Number = 10000000;
         var _loc15_:Ball = null;
         var _loc16_:Point;
         (_loc16_ = new Point()).x = 10000000;
         if(this.mApp.gSuckMode && this.mFrog.GetBullet() == null)
         {
            _loc13_ = 0;
            while(_loc13_ < this.mLevel.mNumCurves)
            {
               _loc17_ = this.mLevel.mCurveMgr[_loc13_].CheckBallIntersection(this.p3,this.v1,_loc16_,false);
               _loc14_ = _loc16_.x;
               if(_loc17_ != null && !_loc17_.GetIsExploding())
               {
                  _loc15_ = _loc17_;
               }
               _loc13_++;
            }
         }
         else
         {
            _loc13_ = 0;
            while(_loc13_ < this.mLevel.mNumCurves)
            {
               _loc17_ = this.mLevel.mCurveMgr[_loc13_].CheckBallIntersection(this.p3,this.v1,_loc16_,true);
               _loc14_ = _loc16_.x;
               if(_loc17_ != null && !_loc17_.GetIsExploding())
               {
                  _loc15_ = _loc17_;
               }
               _loc13_++;
            }
         }
         if(!this.mLazerHitTreasure)
         {
            if(_loc15_ == null)
            {
               _loc14_ = 1000 / this.v1.Magnitude();
            }
            if(this.mGuideBall != null)
            {
               this.mGuideBall.mHilightPulse = false;
            }
            this.mGuideBall = _loc15_;
            if(this.mGuideBall != null)
            {
               this.mGuideBall.mHilightPulse = true;
            }
         }
         else if(this.mGuideBall != null)
         {
            this.mGuideBall.mHilightPulse = false;
            this.mGuideBall = null;
         }
         this.aGuide = this.aCenter.Add(this.v1.Mult(_loc14_ + 20));
         this.guide_center = !!param1 ? this.mLazerGuideCenter : this.mGuideCenter;
         var _loc18_:Boolean;
         if(!(_loc18_ = !!param1 ? Boolean(this.mRecalcLazerGuide) : Boolean(this.mRecalcGuide)) && this.mShowGuide && this.guide_center.Sub(this.aGuide).Magnitude() < 20)
         {
            return;
         }
         this.guide_center = this.aGuide;
         this.mShowGuide = true;
         _loc18_ = false;
         this.mGuide[0] = (_loc11_.x + _loc7_ / 2) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[1] = (_loc11_.y + _loc8_ / 2) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[2] = (_loc12_.x - _loc7_ / 2) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[3] = (_loc12_.y - _loc8_ / 2) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[4] = (this.aGuide.x + _loc5_) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[5] = (this.aGuide.y + _loc6_) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[6] = (this.aGuide.x - _loc5_) * Zuma2App.SHRINK_PERCENT;
         this.mGuide[7] = (this.aGuide.y - _loc6_) * Zuma2App.SHRINK_PERCENT;
      }
      
      public function WhiteBall(param1:Array = null) : void
      {
         this.ChangeBallColor(Zuma2App.White_Ball);
      }
      
      public function ActivatePower(param1:int, param2:int = -1, param3:int = -1, param4:int = -1) : void
      {
         if(param3 == -1)
         {
            param3 = Zuma2App.SCREEN_WIDTH / 2;
         }
         if(param4 == -1)
         {
            param4 = Zuma2App.SCREEN_WIDTH / 2;
         }
         var _loc5_:String = this.PowerupToStr(param1);
         if(param1 == PowerType.PowerType_ProximityBomb)
         {
            this.PlayExplosionSound();
            if(this.mCurTreasure != null)
            {
               if(this.CirclesIntersect(this.mCurTreasure.x,this.mCurTreasure.y,param3,param4,PROXIMITY_BOMB_RADIUS + 52))
               {
                  this.DoHitTreasure();
               }
            }
         }
         else if(param1 == PowerType.PowerType_MoveBackwards)
         {
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_POWERUP_REVERSE1);
            this.AddText(_loc5_,param3 - 20,param4 - 40,param2);
         }
         else if(param1 == PowerType.PowerType_SlowDown)
         {
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_POWERUP_SLOWDOWN);
            this.AddText(_loc5_,param3 - 20,param4 - 40,param2);
         }
         else if(param1 == PowerType.PowerType_Accuracy)
         {
            this.AddText(_loc5_,param3 - 20,param4 - 40,param2);
            this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_POWERUP_ACCURACY);
            this.mAccuracyCount = 2000;
            this.DoAccuracy(true);
         }
         else if(param1 != PowerType.PowerType_Cannon)
         {
            if(param1 != PowerType.PowerType_Laser)
            {
               if(param1 != PowerType.PowerType_ColorNuke)
               {
                  if(param1 == PowerType.PowerType_GauntletMultBall)
                  {
                  }
               }
            }
         }
      }
      
      public function IncNumCleared(param1:int) : void
      {
         this.mNumCleared += param1;
      }
      
      public function UpdateText() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mScoreBlips.length)
         {
            this.mScoreBlips[_loc1_].Update();
            if(this.mScoreBlips[_loc1_].mDone)
            {
               this.mScoreBlips[_loc1_].Delete();
               this.mScoreBlips.splice(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function DoHitTreasure() : void
      {
         this.mTreasureWasHit = true;
         this.mTreasureGlowAlphaRate = 12;
         ++this.mLevelStats.mNumGemsCleared;
         var _loc1_:int = 500;
         this.AddText("BONUS! \r+" + _loc1_,this.mCurTreasure.x,this.mCurTreasure.y,0,1.5);
         this.IncScore(_loc1_,false);
         this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_FRUIT_HIT);
      }
      
      public function AddPowerEffect(param1:PowerEffect) : void
      {
         this.mPowerEffects.push(param1);
      }
      
      override public function onMouseDown(param1:Number, param2:Number) : void
      {
         if(!this.mPaused && this.mGameState == GameState_Playing && !this.mOverMenuButton)
         {
            if(this.mFrog.StartFire())
            {
               this.mApp.soundManager.playSound(Zuma2Sounds.SOUND_BALL_FIRE);
            }
         }
      }
      
      public function PlayBallClick(param1:String) : void
      {
         var _loc2_:int = this.GetTickCount();
         if(_loc2_ - this.mLastBallClickTick < 250)
         {
            return;
         }
         this.mApp.soundManager.playSound(param1);
         this.mLastBallClickTick = _loc2_;
      }
      
      public function CheckEndConditions() : void
      {
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         if(this.mFrog.IsFiring() || !this.mBulletList.isEmpty())
         {
            return;
         }
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.mLevel.mNumCurves)
         {
            if(!this.mLevel.mCurveMgr[_loc1_].IsWinning())
            {
               break;
            }
            _loc1_++;
            _loc2_++;
         }
         if(_loc2_ == this.mLevel.mNumCurves)
         {
            if(this.mLevel.mNumCurves > 0 || this.mLevel.mHaveReachedTarget)
            {
               this.mFrog.EmptyBullets();
               this.mGameState = GameState_BeatLevelBonus;
               return;
            }
         }
         _loc2_ = 0;
         var _loc3_:int = -1;
         _loc1_ = 0;
         while(_loc1_ < this.mLevel.mNumCurves)
         {
            if(this.mLevel.mCurveMgr[_loc1_].IsLosing())
            {
               _loc3_ = _loc1_;
               break;
            }
            _loc1_++;
            _loc2_++;
         }
         if(_loc2_ != this.mLevel.mNumCurves)
         {
            this.SetLosing(_loc3_);
            return;
         }
         if(this.mLevel.mTimer == 0)
         {
            this.SetTimeUp();
            return;
         }
         var _loc4_:int = -1;
         var _loc5_:int = -1;
         _loc1_ = 0;
         while(_loc1_ < this.mLevel.mNumCurves)
         {
            if(this.mLevel.mCurveMgr[_loc1_].IsInDanger())
            {
               _loc6_ = this.mLevel.mCurveMgr[_loc1_].GetDistanceToDeath();
               if(_loc4_ == -1 || _loc6_ < _loc4_)
               {
                  _loc5_ = this.mLevel.mCurveMgr[_loc1_].GetDangerDistance();
                  _loc4_ = _loc6_;
               }
            }
            _loc1_++;
         }
         this.UpdateTrackBPM(_loc4_,_loc5_);
      }
      
      public function SetupTunnels(param1:Level) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.mTunnelData.length)
         {
            this.mTunnels[_loc2_] = param1.mTunnelData[_loc2_];
            _loc2_++;
         }
      }
      
      public function SetNumClearsInARow(param1:int) : void
      {
         this.mNumClearsInARow = param1;
         if(this.mNumClearsInARow > 1)
         {
         }
      }
      
      public function DrawGuide() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         if(this.mFrog.GetBullet() == null || this.mAccuracyCount <= 0 || this.IsPaused())
         {
            this.mGuideSprite.visible = false;
            return;
         }
         this.mGuideSprite.visible = true;
         this.gDrawGuideFrame = this.mUpdateCnt;
         if(this.mShowGuide || this.mApp.gSuckMode || this.mAccuracyCount > 0)
         {
            _loc1_ = 128;
            if(this.mAccuracyCount >= 0 && this.mAccuracyCount <= 300)
            {
               _loc1_ = 120 * this.mAccuracyCount / 300 + 8;
            }
            if(this.mApp.gSuckMode)
            {
               _loc1_ = 128;
            }
            _loc2_ = 65535;
            _loc3_ = 16777215;
            if(this.mFrog.GetBullet() != null)
            {
               _loc4_ = this.mFrog.GetBullet().GetColorType();
               _loc2_ = this.mApp.gBrightBallColors[_loc4_];
               _loc3_ = this.mApp.gDarkBallColors[_loc4_];
            }
            this.mGuideSprite.graphics.clear();
            this.mGuideSprite.alpha = _loc1_ / 255;
            this.mGuideSprite.graphics.lineStyle(5,_loc3_,1);
            this.mGuideSprite.graphics.beginFill(_loc2_,1);
            this.mGuideSprite.graphics.moveTo(this.mGuide[6],this.mGuide[7]);
            this.mGuideSprite.graphics.drawPath(this.mGuideLines,this.mGuide,"nonZero");
            this.mGuideSprite.graphics.endFill();
         }
      }
   }
}
