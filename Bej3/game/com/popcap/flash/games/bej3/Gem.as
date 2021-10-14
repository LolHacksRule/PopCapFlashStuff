package com.popcap.flash.games.bej3
{
   import de.polygonal.ds.HashMap;
   
   public class Gem
   {
      
      public static const TYPE_STANDARD:int = 0;
      
      public static const TYPE_MULTI:int = 1;
      
      public static const TYPE_FLAME:int = 2;
      
      public static const TYPE_RAINBOW:int = 3;
      
      public static const TYPE_STAR:int = 4;
      
      public static const TYPE_DETONATE:int = 5;
      
      public static const TYPE_SCRAMBLE:int = 6;
      
      public static const NUM_TYPES:int = 7;
      
      public static const COLOR_NONE:int = 0;
      
      public static const COLOR_RED:int = 1;
      
      public static const COLOR_ORANGE:int = 2;
      
      public static const COLOR_YELLOW:int = 3;
      
      public static const COLOR_GREEN:int = 4;
      
      public static const COLOR_BLUE:int = 5;
      
      public static const COLOR_PURPLE:int = 6;
      
      public static const COLOR_WHITE:int = 7;
      
      public static const NUM_COLORS:int = 8;
      
      public static const GEM_COLORS:Array = new Array(COLOR_RED,COLOR_ORANGE,COLOR_YELLOW,COLOR_GREEN,COLOR_BLUE,COLOR_PURPLE,COLOR_WHITE);
       
      
      public var isMatchable:Boolean = true;
      
      public var uses:int = 0;
      
      public var movePolicy:MovePolicy;
      
      public var lifetime:int = 0;
      
      public var type:int = 0;
      
      public var id:int = -1;
      
      public var mMoveId:int = -1;
      
      public var mMatchId:int = -1;
      
      public var mShatterGemId:int = -1;
      
      public var isImmune:Boolean = false;
      
      public var immuneTime:int = 0;
      
      public var activeCount:int = 0;
      
      public var color:int = 0;
      
      public var row:int = -1;
      
      public var col:int = -1;
      
      public var scale:Number = 1.0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var fallVelocity:Number = 0;
      
      public var multiValue:int = 0;
      
      public var baseValue:int = 0;
      
      public var bonusValue:int = 0;
      
      public var tokens:HashMap;
      
      public var mIsElectric:Boolean = false;
      
      public var mShatterColor:int = 0;
      
      public var mShatterType:int = 0;
      
      public var mIsFalling:Boolean = false;
      
      public var mIsSwapping:Boolean = false;
      
      public var isUnswapping:Boolean = false;
      
      public var autoHint:Boolean = false;
      
      public var mIsHinted:Boolean = false;
      
      private var mIsSelected:Boolean = false;
      
      public var mHasMove:Boolean = false;
      
      public var mHasMatch:Boolean = false;
      
      public var mIsMatchee:Boolean = false;
      
      private var mIsDead:Boolean = false;
      
      private var mIsMatching:Boolean = false;
      
      private var mIsMatched:Boolean = false;
      
      private var mIsShattering:Boolean = false;
      
      private var mIsShattered:Boolean = false;
      
      private var mIsDetonating:Boolean = false;
      
      private var mIsDetonated:Boolean = false;
      
      private var mFuseTime:Number = 0;
      
      private var mIsFuseLit:Boolean = false;
      
      private var mTrackForceShatter:Boolean = false;
      
      public function Gem()
      {
         this.tokens = new HashMap(10);
         super();
      }
      
      public function Reset() : void
      {
         this.tokens.clear();
         this.isMatchable = true;
         this.movePolicy = new MovePolicy();
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
         this.isMatching = true;
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
         this.isShattering = true;
      }
      
      public function ForceShatter(track:Boolean = false) : void
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
         this.isShattering = true;
         this.mIsShattering = true;
      }
      
      public function get isDead() : Boolean
      {
         return this.mIsDead;
      }
      
      public function get isElectric() : Boolean
      {
         return this.mIsElectric;
      }
      
      public function get isMatching() : Boolean
      {
         return this.mIsMatching;
      }
      
      public function get isShattering() : Boolean
      {
         return this.mIsShattering;
      }
      
      public function get isDetonating() : Boolean
      {
         return this.mIsDetonating;
      }
      
      public function get isFuseLit() : Boolean
      {
         return this.mIsFuseLit;
      }
      
      public function get fuseTime() : Number
      {
         return this.mFuseTime;
      }
      
      public function get isMatched() : Boolean
      {
         return this.mIsMatched;
      }
      
      public function get isShattered() : Boolean
      {
         return this.mIsShattered;
      }
      
      public function get isDetonated() : Boolean
      {
         return this.mIsDetonated;
      }
      
      public function set isDead(value:Boolean) : void
      {
         this.mIsDead = value;
      }
      
      public function BenignDestroy() : void
      {
         this.mIsDetonated = true;
         this.mIsFuseLit = true;
      }
      
      public function set isElectric(value:Boolean) : void
      {
         if(this.immuneTime > 0)
         {
            return;
         }
         this.mIsMatching = false;
         this.mIsMatched = true;
         this.mIsElectric = true;
      }
      
      public function set isMatching(value:Boolean) : void
      {
         this.mIsMatching = this.mIsMatching || value && !this.mIsMatched && !this.mIsDead;
         this.mIsMatched = this.mIsMatched || value;
      }
      
      public function set isShattering(value:Boolean) : void
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
      
      public function set isDetonating(value:Boolean) : void
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
      
      public function set fuseTime(value:Number) : void
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
         return this.isMatchable && !(this.mIsDead || this.mIsSwapping && !this.isUnswapping || this.mIsMatched || this.mIsShattered || this.mIsDetonated || this.type == TYPE_RAINBOW);
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
      
      public function set isSelected(value:Boolean) : void
      {
         this.mIsSelected = value;
      }
      
      public function get isSelected() : Boolean
      {
         return this.mIsSelected;
      }
      
      public function upgrade(newType:int, forced:Boolean = false) : void
      {
         if(!forced && this.type >= newType)
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
         if(this.isDead)
         {
            return;
         }
         ++this.lifetime;
         if(this.autoHint && this.isStill() && this.row == this.y)
         {
            this.autoHint = false;
            this.mIsHinted = true;
         }
         if(this.mFuseTime > 0 && this.immuneTime > 0)
         {
            throw new Error("Fuse time somehow got set on an immune gem...");
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
                  this.ForceShatter();
               }
               else
               {
                  this.isDetonating = true;
               }
            }
         }
      }
      
      public function toString() : String
      {
         return this.toIdString() + "" + this.toColorString();
      }
      
      public function toColorString() : String
      {
         switch(this.color)
         {
            case Gem.COLOR_RED:
               return "r";
            case Gem.COLOR_ORANGE:
               return "o";
            case Gem.COLOR_YELLOW:
               return "y";
            case Gem.COLOR_GREEN:
               return "g";
            case Gem.COLOR_BLUE:
               return "b";
            case Gem.COLOR_PURPLE:
               return "p";
            case Gem.COLOR_WHITE:
               return "w";
            default:
               return "-";
         }
      }
      
      public function toIdString() : String
      {
         return this.row + "" + this.col;
      }
      
      public function toDetailString() : String
      {
         var str:String = "Gem details:\n";
         str += "  Color: " + this.toColorString() + "\n";
         str += "  Type: " + this.type + "\n";
         str += "  Can Match? " + this.canMatch() + "\n";
         str += "  Dead? " + this.mIsDead + "\n";
         str += "  Swapping? " + this.mIsSwapping + "\n";
         str += "  Falling? " + this.mIsFalling + "\n";
         str += "  Matching? " + this.mIsMatching + "\n";
         str += "  Shattering? " + this.mIsShattering + "\n";
         str += "  Detonating? " + this.mIsDetonating + "\n";
         str += "  Matched? " + this.mIsMatched + "\n";
         str += "  Shattered? " + this.mIsShattered + "\n";
         str += "  Detonated? " + this.mIsDetonated + "\n";
         str += "  Fuse Time: " + this.mFuseTime + "\n";
         return str + ("  Immune Time: " + this.immuneTime + "\n");
      }
   }
}
