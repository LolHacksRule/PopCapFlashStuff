package com.popcap.flash.bejeweledblitz.logic
{
   import com.popcap.flash.framework.pool.IPoolObject;
   
   public class Match implements IPoolObject
   {
       
      
      public var matchId:int;
      
      public var cascadeId:int;
      
      public var matchGems:Vector.<Gem>;
      
      public var overlaps:Vector.<Match>;
      
      public var matchColor:int;
      
      public var left:int;
      
      public var right:int;
      
      public var top:int;
      
      public var bottom:int;
      
      public var matchSet:MatchSet;
      
      private var m_X:Number;
      
      private var m_Y:Number;
      
      public function Match()
      {
         super();
         this.overlaps = new Vector.<Match>();
         this.matchGems = new Vector.<Gem>();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.matchId = 0;
         this.cascadeId = 0;
         this.matchGems.length = 0;
         this.overlaps.length = 0;
         this.matchColor = Gem.COLOR_NONE;
         this.left = -1;
         this.right = -1;
         this.top = -1;
         this.bottom = -1;
         this.matchSet = null;
         this.m_X = 0;
         this.m_Y = 0;
      }
      
      public function Init(param1:Vector.<Gem>, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:Gem = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.matchGems.length = 0;
         var _loc4_:int = param1.length;
         this.matchGems.length = _loc4_;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            this.matchGems[_loc3_] = param1[_loc3_];
            _loc3_++;
         }
         this.matchColor = param2;
         this.left = Board.WIDTH;
         this.right = -1;
         this.top = Board.HEIGHT;
         this.bottom = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc6_ = (_loc5_ = this.matchGems[_loc3_]).row;
            _loc7_ = _loc5_.col;
            this.left = _loc7_ < this.left ? int(_loc7_) : int(this.left);
            this.right = _loc7_ > this.right ? int(_loc7_) : int(this.right);
            this.top = _loc6_ < this.top ? int(_loc6_) : int(this.top);
            this.bottom = _loc6_ > this.bottom ? int(_loc6_) : int(this.bottom);
            _loc5_.hasMatch = true;
            this.cascadeId = _loc5_.moveID > this.cascadeId ? int(_loc5_.moveID) : int(this.cascadeId);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            (_loc5_ = this.matchGems[_loc3_]).moveID = this.cascadeId;
            _loc3_++;
         }
         this.overlaps.length = 0;
         this.m_X = this.left + (this.right - this.left) * 0.5;
         this.m_Y = this.top + (this.bottom - this.top) * 0.5;
      }
      
      public function IsOverlapping(param1:Match) : Boolean
      {
         if(this.left > param1.right)
         {
            return false;
         }
         if(this.right < param1.left)
         {
            return false;
         }
         if(this.top > param1.bottom)
         {
            return false;
         }
         if(this.bottom < param1.top)
         {
            return false;
         }
         return true;
      }
   }
}
