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
      
      public static const TYPE_RAREGEM:int = 8;
      
      public static const TYPE_TOKENGEM:int = 9;
      
      public static const NUM_TYPES:int = 10;
      
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
      
      public var moveID:int;
      
      public var matchID:int;
      
      public var shatterGemID:int;
      
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
      
      public var rgTokens:Dictionary;
      
      public var uses:int;
      
      public var shatterColor:int = 0;
      
      public var shatterType:int = 0;
      
      public var isFalling:Boolean = false;
      
      public var isSwapping:Boolean = false;
      
      public var isUnswapping:Boolean = false;
      
      public var autoHint:Boolean = false;
      
      public var isHinted:Boolean = false;
      
      public var hasMove:Boolean = false;
      
      public var hasMatch:Boolean = false;
      
      public var isMatchee:Boolean = false;
      
      public var isBenignDestroy:Boolean = false;
      
      private var _isElectric:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      private var _isDead:Boolean = false;
      
      private var _isMatching:Boolean = false;
      
      private var _isMatched:Boolean = false;
      
      private var _isShattering:Boolean = false;
      
      private var _isShattered:Boolean = false;
      
      private var _isDetonating:Boolean = false;
      
      private var _isDetonated:Boolean = false;
      
      private var _fuseTime:Number = 0;
      
      private var _isFuseLit:Boolean = false;
      
      private var _trackForceShatter:Boolean = false;
      
      private var _isPunched:Boolean = false;
      
      private var _rotateGem:Boolean = false;
      
      private var _fuseWhenNotFalling:Boolean = false;
      
      public function Gem()
      {
         super();
         this.isMatchee = false;
         this.movePolicy = new MovePolicy();
         this.isMatchable = true;
         this.uses = 0;
         this.lifetime = 0;
         this.type = TYPE_STANDARD;
         this.id = -1;
         this.moveID = -1;
         this.matchID = -1;
         this.shatterGemID = -1;
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
         this.rgTokens = new Dictionary();
      }
      
      public function Reset() : void
      {
         this.tokens = new Dictionary();
         this.rgTokens = new Dictionary();
         this.isMatchable = true;
         this.movePolicy.Reset();
         this.lifetime = 0;
         this.type = TYPE_STANDARD;
         this._isDead = false;
         this._isElectric = false;
         this._isMatching = false;
         this._isShattering = false;
         this._isDetonating = false;
         this._isMatched = false;
         this._isShattered = false;
         this._isDetonated = false;
         this.isFalling = false;
         this.isSwapping = false;
         this.isUnswapping = false;
         this._isSelected = false;
         this._rotateGem = false;
         this.hasMove = false;
         this.hasMatch = false;
         this.isImmune = false;
         this.immuneTime = 0;
         this._fuseTime = 0;
         this._isFuseLit = false;
         this._fuseWhenNotFalling = false;
         this.autoHint = false;
         this.isHinted = false;
         this.matchID = -1;
         this.moveID = -1;
         this.shatterGemID = -1;
         this.activeCount = 0;
         this.scale = 1;
         this.color = COLOR_NONE;
         this.shatterColor = COLOR_NONE;
         this.row = -1;
         this.col = -1;
         this.x = -1;
         this.y = -1;
         this.bonusValue = 0;
         this.baseValue = 0;
         this.fallVelocity = 0;
         this._trackForceShatter = false;
         this._isPunched = false;
         this.isBenignDestroy = false;
      }
      
      public function Match(param1:int) : void
      {
         this.matchID = param1;
         this.SetMatching(true);
      }
      
      public function Shatter(param1:Gem) : void
      {
         if(this.isImmune || this.immuneTime > 0)
         {
            return;
         }
         this.moveID = param1.moveID;
         this.shatterGemID = param1.id;
         this.shatterColor = param1.color;
         this.shatterType = param1.type;
         this.SetShattering(true);
      }
      
      public function ForceShatter(param1:Boolean) : void
      {
         if(this.isImmune)
         {
            return;
         }
         if(param1 && this._trackForceShatter)
         {
            return;
         }
         this._trackForceShatter = param1;
         this.SetShattering(true);
         this._isShattering = true;
      }
      
      public function IsDead() : Boolean
      {
         return this._isDead;
      }
      
      public function IsElectric() : Boolean
      {
         return this._isElectric;
      }
      
      public function IsMatching() : Boolean
      {
         return this._isMatching;
      }
      
      public function IsShattering() : Boolean
      {
         return this._isShattering;
      }
      
      public function IsDetonating() : Boolean
      {
         return this._isDetonating;
      }
      
      public function IsFuseLit() : Boolean
      {
         return this._isFuseLit;
      }
      
      public function GetFuseTime() : Number
      {
         return this._fuseTime;
      }
      
      public function IsMatched() : Boolean
      {
         return this._isMatched;
      }
      
      public function IsShattered() : Boolean
      {
         return this._isShattered;
      }
      
      public function IsDetonated() : Boolean
      {
         return this._isDetonated;
      }
      
      public function IsPunched() : Boolean
      {
         return this._isPunched;
      }
      
      public function SetDead(param1:Boolean) : void
      {
         this._isDead = param1;
      }
      
      public function BenignDestroy() : void
      {
         this._isDetonated = true;
         this._isFuseLit = true;
      }
      
      public function makeElectric() : void
      {
         if(this.immuneTime > 0)
         {
            return;
         }
         this._isMatching = false;
         this._isMatched = true;
         this._isElectric = true;
      }
      
      public function SetPunched(param1:Boolean) : void
      {
         this._isPunched = param1;
      }
      
      public function SetDelayedShatter(param1:int) : void
      {
         this.SetFuseTime(param1);
         this._isMatched = false;
         this._isMatching = false;
      }
      
      public function SetMatching(param1:Boolean) : void
      {
         this._isMatching = this._isMatching || param1 && !this._isMatched && !this._isDead;
         this._isMatched = this._isMatched || param1;
      }
      
      public function SetShattering(param1:Boolean) : void
      {
         if(this.isImmune || this.immuneTime > 0)
         {
            return;
         }
         this._isShattering = this._isShattering || param1 && !this._isShattered && !this._isDead;
         this._isShattered = this._isShattered || param1;
         this._isMatched = true;
         this._isMatching = false;
      }
      
      public function SetDetonating(param1:Boolean) : void
      {
         if(this.isImmune || this.immuneTime > 0 && !this._isMatching)
         {
            return;
         }
         this._isDetonating = this._isDetonating || param1 && !this._isDetonated && !this._isDead;
         this._isDetonated = this._isDetonated || param1;
         this._isMatched = true;
         this._isMatching = false;
         this._isShattered = true;
         this._isShattering = false;
      }
      
      public function SetFuseTime(param1:Number) : void
      {
         if(this._isFuseLit || param1 <= 0)
         {
            return;
         }
         this._isShattered = true;
         this._isShattering = false;
         this._fuseTime = param1;
         this._isFuseLit = true;
      }
      
      public function CanSelect() : Boolean
      {
         return !this._isDead && !this._isMatched && !this._isShattered && !this._isDetonated && !this._fuseWhenNotFalling && !this._isFuseLit;
      }
      
      public function canMatch() : Boolean
      {
         return this.isMatchable && !(this._isDead || this.isSwapping && !this.isUnswapping || this._isMatched || this._isShattered || this._isDetonated || this.type == TYPE_HYPERCUBE);
      }
      
      public function isStill() : Boolean
      {
         return !(this._isDead || this.isSwapping || this.isFalling || this._isMatching || this._isShattering || this._isDetonating || this._isMatched || this._isShattered || this._isDetonated || this._fuseTime > 0 || this.hasMatch);
      }
      
      public function isIdle() : Boolean
      {
         return !(this._isDead || this.isFalling || this._isMatching || this._isShattering || this._isDetonating || this._isMatched || this._isShattered || this._isDetonated || this._fuseTime > 0);
      }
      
      public function Flush() : void
      {
         this._isMatching = false;
         this._isShattering = false;
         this._isDetonating = false;
      }
      
      public function SetSelected(param1:Boolean) : void
      {
         this._isSelected = param1;
      }
      
      public function IsSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function SetRotateGem(param1:Boolean) : void
      {
         this._rotateGem = param1;
      }
      
      public function IsGemRotating() : Boolean
      {
         return this._rotateGem;
      }
      
      public function IsBottomCornerGem() : Boolean
      {
         return this.row == Board.BOTTOM && this.col == Board.LEFT || this.row == Board.BOTTOM && this.col == Board.RIGHT;
      }
      
      public function HasToken() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = this.tokens;
         for(_loc1_ in _loc3_)
         {
            return true;
         }
         _loc2_ = 0;
         _loc3_ = this.rgTokens;
         for(_loc1_ in _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function CanUpgrade(param1:int) : Boolean
      {
         return this.type < param1;
      }
      
      public function upgrade(param1:int, param2:Boolean) : void
      {
         if(param2 || this.CanUpgrade(param1))
         {
            this.lifetime = 0;
            this._isDead = false;
            this._isMatching = false;
            this._isShattering = false;
            this._isDetonating = false;
            this._isMatched = false;
            this._isShattered = false;
            this._isDetonated = false;
            this._isElectric = false;
            this._fuseTime = 0;
            this._isFuseLit = false;
            this.type = param1;
            this.isImmune = false;
            this.immuneTime = 25;
            this._trackForceShatter = false;
            this._fuseWhenNotFalling = false;
         }
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
            this.immuneTime = this.immuneTime - 1;
         }
         if(this._fuseTime > 0)
         {
            this._fuseTime = this._fuseTime - 1;
         }
         if(this._isFuseLit && this._fuseTime == 0 && !this.IsDetonated())
         {
            if(this._fuseWhenNotFalling && this.isFalling)
            {
               return;
            }
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
      
      public function SetFuseWhenNotFalling() : void
      {
         this._isFuseLit = true;
         this._fuseWhenNotFalling = true;
      }
      
      public function getCellKey() : String
      {
         return this.col.toString() + "x" + this.row.toString();
      }
   }
}
