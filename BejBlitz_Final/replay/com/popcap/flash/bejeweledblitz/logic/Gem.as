package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   import flash.utils.Dictionary;
   
   public class Gem implements IPoolObject
   {
      
      public static const TYPE_STANDARD:int = 0;
      
      public static const TYPE_MULTI:int = 1;
      
      public static const TYPE_FLAME:int = 2;
      
      public static const TYPE_HYPERCUBE:int = 3;
      
      public static const TYPE_STAR:int = 4;
      
      public static const TYPE_PHOENIXPRISM:int = 5;
      
      public static const TYPE_DETONATE:int = 6;
      
      public static const TYPE_SCRAMBLE:int = 7;
      
      public static const NUM_TYPES:int = 8;
      
      public static const COLOR_NONE:int = 0;
      
      public static const COLOR_RED:int = 1;
      
      public static const COLOR_ORANGE:int = 2;
      
      public static const COLOR_YELLOW:int = 3;
      
      public static const COLOR_GREEN:int = 4;
      
      public static const COLOR_BLUE:int = 5;
      
      public static const COLOR_PURPLE:int = 6;
      
      public static const COLOR_WHITE:int = 7;
      
      public static const COLOR_ANY:int = 8;
      
      public static const NUM_COLORS:int = 9;
      
      public static const GEM_COLORS:Vector.<int> = new Vector.<int>(7);
      
      {
         GEM_COLORS[0] = COLOR_RED;
         GEM_COLORS[1] = COLOR_ORANGE;
         GEM_COLORS[2] = COLOR_YELLOW;
         GEM_COLORS[3] = COLOR_GREEN;
         GEM_COLORS[4] = COLOR_BLUE;
         GEM_COLORS[5] = COLOR_PURPLE;
         GEM_COLORS[6] = COLOR_WHITE;
      }
      
      public var isMatchable:Boolean;
      
      public var movePolicy:MovePolicy;
      
      public var lifetime:int;
      
      public var type:int;
      
      public var id:int;
      
      public var mMoveId:int;
      
      public var mMatchId:int;
      
      public var mShatterGemId:int;
      
      public var isImmune:Boolean;
      
      public var immuneTime:int;
      
      public var activeCount:int;
      
      public var color:int;
      
      public var row:int;
      
      public var col:int;
      
      public var scale:Number;
      
      public var x:Number;
      
      public var y:Number;
      
      public var fallVelocity:Number;
      
      public var multiValue:int;
      
      public var baseValue:int;
      
      public var bonusValue:int;
      
      public var tokens:Dictionary;
      
      public var uses:int;
      
      private var mIsElectric:Boolean;
      
      public var mShatterColor:int;
      
      public var mShatterType:int;
      
      public var mIsFalling:Boolean;
      
      public var mIsSwapping:Boolean;
      
      public var isUnswapping:Boolean;
      
      public var autoHint:Boolean;
      
      public var isHinted:Boolean;
      
      private var mIsSelected:Boolean;
      
      public var mHasMove:Boolean;
      
      public var mHasMatch:Boolean;
      
      public var mIsMatchee:Boolean;
      
      private var mIsDead:Boolean;
      
      private var mIsMatching:Boolean;
      
      private var mIsMatched:Boolean;
      
      private var mIsShattering:Boolean;
      
      private var mIsShattered:Boolean;
      
      private var mIsDetonating:Boolean;
      
      private var mIsDetonated:Boolean;
      
      private var mFuseTime:Number;
      
      private var mIsFuseLit:Boolean;
      
      private var mTrackForceShatter:Boolean;
      
      public function Gem()
      {
         super();
         this.movePolicy = new MovePolicy();
         this.isMatchable = true;
         this.uses = 0;
         this.lifetime = 0;
         this.type = TYPE_STANDARD;
         this.id = -1;
         this.mMoveId = -1;
         this.mMatchId = -1;
         this.mShatterGemId = -1;
         this.isImmune = false;
         this.immuneTime = 0;
         this.activeCount = 0;
         this.color = COLOR_NONE;
         this.row = -1;
         this.col = -1;
         this.scale = 1;
         this.x = 0;
         this.y = 0;
         this.fallVelocity = 0;
         this.multiValue = 0;
         this.baseValue = 0;
         this.bonusValue = 0;
         this.tokens = new Dictionary();
         this.mIsElectric = false;
         this.mShatterColor = 0;
         this.mShatterType = TYPE_STANDARD;
         this.mIsFalling = false;
         this.mIsSwapping = false;
         this.isUnswapping = false;
         this.autoHint = false;
         this.isHinted = false;
         this.mIsSelected = false;
         this.mHasMove = false;
         this.mHasMatch = false;
         this.mIsMatchee = false;
         this.mIsDead = false;
         this.mIsMatching = false;
         this.mIsMatched = false;
         this.mIsShattering = false;
         this.mIsShattered = false;
         this.mIsDetonating = false;
         this.mIsDetonated = false;
         this.mFuseTime = 0;
         this.mIsFuseLit = false;
         this.mTrackForceShatter = false;
      }
      
      public function Reset() : void
      {
         this.tokens = new Dictionary();
         this.isMatchable = true;
         this.movePolicy.Reset();
         this.lifetime = 0;
         this.type = TYPE_STANDARD;
         this.mIsDead = false;
         this.mIsElectric = false;
         this.mIsMatching = false;
         this.mIsShattering = false;
         this.mIsDetonating = false;
         this.mIsMatched = false;
         this.mIsShattered = false;
         this.mIsDetonated = false;
         this.mIsFalling = false;
         this.mIsSwapping = false;
         this.isUnswapping = false;
         this.mIsSelected = false;
         this.mHasMove = false;
         this.mHasMatch = false;
         this.isImmune = false;
         this.immuneTime = 0;
         this.mFuseTime = 0;
         this.mIsFuseLit = false;
         this.autoHint = false;
         this.isHinted = false;
         this.mMatchId = -1;
         this.mMoveId = -1;
         this.mShatterGemId = -1;
         this.activeCount = 0;
         this.scale = 1;
         this.color = COLOR_NONE;
         this.mShatterColor = COLOR_NONE;
         this.row = -1;
         this.col = -1;
         this.x = -1;
         this.y = -1;
         this.bonusValue = 0;
         this.baseValue = 0;
         this.fallVelocity = 0;
         this.mTrackForceShatter = false;
      }
      
      public function Match(matchId:int) : void
      {
         this.mMatchId = matchId;
         this.SetMatching(true);
      }
      
      public function Shatter(shatterGem:Gem) : void
      {
         if(this.isImmune || this.immuneTime > 0)
         {
            return;
         }
         this.mMoveId = shatterGem.mMoveId;
         this.mShatterGemId = shatterGem.id;
         this.mShatterColor = shatterGem.color;
         this.mShatterType = shatterGem.type;
         this.SetShattering(true);
      }
      
      public function ForceShatter(track:Boolean) : void
      {
         if(this.isImmune)
         {
            return;
         }
         if(track && this.mTrackForceShatter)
         {
            return;
         }
         this.mTrackForceShatter = track;
         this.SetShattering(true);
         this.mIsShattering = true;
      }
      
      public function IsDead() : Boolean
      {
         return this.mIsDead;
      }
      
      public function IsElectric() : Boolean
      {
         return this.mIsElectric;
      }
      
      public function IsMatching() : Boolean
      {
         return this.mIsMatching;
      }
      
      public function IsShattering() : Boolean
      {
         return this.mIsShattering;
      }
      
      public function IsDetonating() : Boolean
      {
         return this.mIsDetonating;
      }
      
      public function IsFuseLit() : Boolean
      {
         return this.mIsFuseLit;
      }
      
      public function GetFuseTime() : Number
      {
         return this.mFuseTime;
      }
      
      public function IsMatched() : Boolean
      {
         return this.mIsMatched;
      }
      
      public function IsShattered() : Boolean
      {
         return this.mIsShattered;
      }
      
      public function IsDetonated() : Boolean
      {
         return this.mIsDetonated;
      }
      
      public function SetDead(value:Boolean) : void
      {
         this.mIsDead = value;
      }
      
      public function BenignDestroy() : void
      {
         this.mIsDetonated = true;
         this.mIsFuseLit = true;
      }
      
      public function makeElectric() : void
      {
         if(this.immuneTime > 0)
         {
            return;
         }
         this.mIsMatching = false;
         this.mIsMatched = true;
         this.mIsElectric = true;
      }
      
      public function SetMatching(value:Boolean) : void
      {
         this.mIsMatching = this.mIsMatching || value && !this.mIsMatched && !this.mIsDead;
         this.mIsMatched = this.mIsMatched || value;
      }
      
      public function SetShattering(value:Boolean) : void
      {
         if(this.isImmune || this.immuneTime > 0)
         {
            return;
         }
         this.mIsShattering = this.mIsShattering || value && !this.mIsShattered && !this.mIsDead;
         this.mIsShattered = this.mIsShattered || value;
         this.mIsMatched = true;
         this.mIsMatching = false;
      }
      
      public function SetDetonating(value:Boolean) : void
      {
         if(this.isImmune || this.immuneTime > 0 && !this.mIsMatching)
         {
            return;
         }
         this.mIsDetonating = this.mIsDetonating || value && !this.mIsDetonated && !this.mIsDead;
         this.mIsDetonated = this.mIsDetonated || value;
         this.mIsMatched = true;
         this.mIsMatching = false;
         this.mIsShattered = true;
         this.mIsShattering = false;
      }
      
      public function SetFuseTime(value:Number) : void
      {
         if(this.mIsFuseLit || value <= 0)
         {
            return;
         }
         this.mIsShattered = true;
         this.mIsShattering = false;
         this.mFuseTime = value;
         this.mIsFuseLit = true;
      }
      
      public function CanSelect() : Boolean
      {
         return !this.mIsDead && !this.mIsMatched && !this.mIsShattered && !this.mIsDetonated;
      }
      
      public function canMatch() : Boolean
      {
         return this.isMatchable && !(this.mIsDead || this.mIsSwapping && !this.isUnswapping || this.mIsMatched || this.mIsShattered || this.mIsDetonated || this.type == TYPE_HYPERCUBE);
      }
      
      public function isStill() : Boolean
      {
         return !(this.mIsDead || this.mIsSwapping || this.mIsFalling || this.mIsMatching || this.mIsShattering || this.mIsDetonating || this.mIsMatched || this.mIsShattered || this.mIsDetonated || this.mFuseTime > 0);
      }
      
      public function isIdle() : Boolean
      {
         return !(this.mIsDead || this.mIsFalling || this.mIsMatching || this.mIsShattering || this.mIsDetonating || this.mIsMatched || this.mIsShattered || this.mIsDetonated || this.mFuseTime > 0);
      }
      
      public function Flush() : void
      {
         this.mIsMatching = false;
         this.mIsShattering = false;
         this.mIsDetonating = false;
      }
      
      public function SetSelected(value:Boolean) : void
      {
         this.mIsSelected = value;
      }
      
      public function IsSelected() : Boolean
      {
         return this.mIsSelected;
      }
      
      public function HasToken() : Boolean
      {
         var key:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = this.tokens;
         for(key in _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function CanUpgrade(newType:int) : Boolean
      {
         return this.type < newType;
      }
      
      public function upgrade(newType:int, forced:Boolean) : void
      {
         if(!forced && !this.CanUpgrade(newType))
         {
            return;
         }
         this.lifetime = 0;
         this.mIsDead = false;
         this.mIsMatching = false;
         this.mIsShattering = false;
         this.mIsDetonating = false;
         this.mIsMatched = false;
         this.mIsShattered = false;
         this.mIsDetonated = false;
         this.mIsElectric = false;
         this.mFuseTime = 0;
         this.type = newType;
         this.isImmune = false;
         this.immuneTime = 25;
         this.mTrackForceShatter = false;
      }
      
      public function update() : void
      {
         this.Flush();
         if(this.IsDead())
         {
            return;
         }
         ++this.lifetime;
         if(this.autoHint && this.isStill() && this.row == this.y)
         {
            this.autoHint = false;
            this.isHinted = true;
         }
         if(this.immuneTime > 0)
         {
            this.immuneTime -= 1;
         }
         if(this.mFuseTime > 0)
         {
            this.mFuseTime -= 1;
            if(this.mFuseTime == 0)
            {
               if(this.type == TYPE_DETONATE || this.type == TYPE_SCRAMBLE)
               {
                  this.isImmune = false;
                  this.ForceShatter(false);
               }
               else
               {
                  this.SetDetonating(true);
               }
            }
         }
      }
   }
}
