package §_-PB§
{
   import flash.utils.Dictionary;
   
   public class §_-X4§ implements §_-58§
   {
       
      
      private var §_-TJ§:int;
      
      private var §_-1O§:int;
      
      private var _pair:PairNode;
      
      private var §_-ED§:Dictionary;
      
      private var §_-Zw§:int;
      
      private var §_-T-§:PairNode;
      
      private var §_-1V§:Dictionary;
      
      private var §_-Yy§:PairNode;
      
      public function §_-X4§(param1:int = 500)
      {
         super();
         this.§_-1O§ = this.§_-TJ§ = Math.max(10,param1);
         this.§_-ED§ = new Dictionary(true);
         this.§_-1V§ = new Dictionary(true);
         this.§_-Zw§ = 0;
         var _loc2_:PairNode = new PairNode();
         this.§_-Yy§ = this.§_-T-§ = _loc2_;
         var _loc3_:int = this.§_-1O§ + 1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.next = new PairNode();
            _loc2_ = _loc2_.next;
            _loc4_++;
         }
         this.§_-T-§ = _loc2_;
      }
      
      public function §_-Iv§(param1:*) : Boolean
      {
         return this.§_-ED§[param1] != undefined;
      }
      
      public function get size() : int
      {
         return this.§_-Zw§;
      }
      
      public function §_-2-§() : Boolean
      {
         return this.§_-Zw§ == 0;
      }
      
      public function remove(param1:*) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:PairNode = this.§_-ED§[param1];
         if(_loc2_)
         {
            _loc3_ = _loc2_.obj;
            delete this.§_-ED§[param1];
            if(_loc2_.prev)
            {
               _loc2_.prev.next = _loc2_.next;
            }
            if(_loc2_.next)
            {
               _loc2_.next.prev = _loc2_.prev;
            }
            if(_loc2_ == this._pair)
            {
               this._pair = _loc2_.next;
            }
            _loc2_.prev = null;
            _loc2_.next = null;
            this.§_-T-§.next = _loc2_;
            this.§_-T-§ = _loc2_;
            if(--this.§_-1V§[_loc3_] <= 0)
            {
               delete this.§_-1V§[_loc3_];
            }
            if(--this.§_-Zw§ <= this.§_-TJ§ - this.§_-1O§)
            {
               _loc4_ = (this.§_-TJ§ = this.§_-TJ§ - this.§_-1O§) + 1;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  this.§_-Yy§ = this.§_-Yy§.next;
                  _loc5_++;
               }
            }
            return _loc3_;
         }
         return null;
      }
      
      public function §_-pR§(param1:*) : *
      {
         var _loc2_:PairNode = this.§_-ED§[param1];
         if(_loc2_)
         {
            return _loc2_.obj;
         }
         return null;
      }
      
      public function clear() : void
      {
         var _loc1_:PairNode = null;
         this.§_-ED§ = new Dictionary(true);
         this.§_-1V§ = new Dictionary(true);
         var _loc2_:PairNode = this._pair;
         while(_loc2_)
         {
            _loc1_ = _loc2_.next;
            _loc2_.prev = null;
            _loc2_.next = null;
            _loc2_.key = null;
            _loc2_.obj = null;
            this.§_-T-§.next = _loc2_;
            this.§_-T-§ = this.§_-T-§.next;
            _loc2_ = _loc1_;
         }
         this._pair = null;
         this.§_-Zw§ = 0;
      }
      
      public function §_-Ac§() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:PairNode = null;
         var _loc1_:Array = new Array(this.§_-Zw§);
         for each(_loc3_ in this.§_-ED§)
         {
            var _loc6_:*;
            _loc1_[_loc6_ = _loc2_++] = _loc3_.key;
         }
         return _loc1_;
      }
      
      public function §switch§() : §_-9Z§
      {
         return new HashMapIterator(this._pair);
      }
      
      public function §_-Ru§() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:PairNode = null;
         var _loc1_:Array = new Array(this.§_-Zw§);
         for each(_loc3_ in this.§_-ED§)
         {
            var _loc6_:*;
            _loc1_[_loc6_ = _loc2_++] = _loc3_.obj;
         }
         return _loc1_;
      }
      
      public function contains(param1:*) : Boolean
      {
         return this.§_-1V§[param1] > 0;
      }
      
      public function toString() : String
      {
         return "[HashMap, size=" + this.size + "]";
      }
      
      public function §_-lp§() : String
      {
         var _loc2_:PairNode = null;
         var _loc1_:String = "HashMap:\n";
         for each(_loc2_ in this.§_-ED§)
         {
            _loc1_ += "[key: " + _loc2_.key + ", val:" + _loc2_.obj + "]\n";
         }
         return _loc1_;
      }
      
      public function §_-Km§(param1:*, param2:*) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         if(param2 == null)
         {
            return false;
         }
         if(this.§_-ED§[param1])
         {
            return false;
         }
         if(this.§_-Zw§++ == this.§_-TJ§)
         {
            _loc4_ = (this.§_-TJ§ = this.§_-TJ§ + this.§_-1O§) + 1;
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               this.§_-T-§.next = new PairNode();
               this.§_-T-§ = this.§_-T-§.next;
               _loc5_++;
            }
         }
         var _loc3_:PairNode = this.§_-Yy§;
         this.§_-Yy§ = this.§_-Yy§.next;
         _loc3_.key = param1;
         _loc3_.obj = param2;
         _loc3_.next = this._pair;
         if(this._pair)
         {
            this._pair.prev = _loc3_;
         }
         this._pair = _loc3_;
         this.§_-ED§[param1] = _loc3_;
         if(this.§_-1V§[param2])
         {
            ++this.§_-1V§[param2];
         }
         else
         {
            this.§_-1V§[param2] = 1;
         }
         return true;
      }
   }
}

class PairNode
{
    
   
   public var prev:PairNode;
   
   public var obj;
   
   public var next:PairNode;
   
   public var key;
   
   function PairNode()
   {
      super();
   }
}

import §_-PB§.§_-9Z§;

class HashMapIterator implements §_-9Z§
{
    
   
   private var _walker:PairNode;
   
   private var _pair:PairNode;
   
   function HashMapIterator(param1:PairNode)
   {
      super();
      this._pair = this._walker = param1;
   }
   
   public function start() : void
   {
      this._walker = this._pair;
   }
   
   public function get data() : *
   {
      return this._walker.obj;
   }
   
   public function hasNext() : Boolean
   {
      return this._walker != null;
   }
   
   public function set data(param1:*) : void
   {
      this._walker.obj = param1;
   }
   
   public function next() : *
   {
      var _loc1_:* = this._walker.obj;
      this._walker = this._walker.next;
      return _loc1_;
   }
}
