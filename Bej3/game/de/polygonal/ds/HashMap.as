package de.polygonal.ds
{
   import flash.utils.Dictionary;
   
   public class HashMap implements Collection
   {
       
      
      private var _keyMap:Dictionary;
      
      private var _dupMap:Dictionary;
      
      private var _initSize:int;
      
      private var _maxSize:int;
      
      private var _size:int;
      
      private var _pair:PairNode;
      
      private var _head:PairNode;
      
      private var _tail:PairNode;
      
      public function HashMap(size:int = 500)
      {
         super();
         this._initSize = this._maxSize = Math.max(10,size);
         this._keyMap = new Dictionary(true);
         this._dupMap = new Dictionary(true);
         this._size = 0;
         var node:PairNode = new PairNode();
         this._head = this._tail = node;
         var k:int = this._initSize + 1;
         for(var i:int = 0; i < k; i++)
         {
            node.next = new PairNode();
            node = node.next;
         }
         this._tail = node;
      }
      
      public function insert(key:*, obj:*) : Boolean
      {
         var k:int = 0;
         var i:int = 0;
         if(key == null)
         {
            return false;
         }
         if(obj == null)
         {
            return false;
         }
         if(this._keyMap[key])
         {
            return false;
         }
         if(this._size++ == this._maxSize)
         {
            k = (this._maxSize = this._maxSize + this._initSize) + 1;
            for(i = 0; i < k; i++)
            {
               this._tail.next = new PairNode();
               this._tail = this._tail.next;
            }
         }
         var pair:PairNode = this._head;
         this._head = this._head.next;
         pair.key = key;
         pair.obj = obj;
         pair.next = this._pair;
         if(this._pair)
         {
            this._pair.prev = pair;
         }
         this._pair = pair;
         this._keyMap[key] = pair;
         if(this._dupMap[obj])
         {
            ++this._dupMap[obj];
         }
         else
         {
            this._dupMap[obj] = 1;
         }
         return true;
      }
      
      public function find(key:*) : *
      {
         var pair:PairNode = this._keyMap[key];
         if(pair)
         {
            return pair.obj;
         }
         return null;
      }
      
      public function remove(key:*) : *
      {
         var obj:* = undefined;
         var k:int = 0;
         var i:int = 0;
         var pair:PairNode = this._keyMap[key];
         if(pair)
         {
            obj = pair.obj;
            delete this._keyMap[key];
            if(pair.prev)
            {
               pair.prev.next = pair.next;
            }
            if(pair.next)
            {
               pair.next.prev = pair.prev;
            }
            if(pair == this._pair)
            {
               this._pair = pair.next;
            }
            pair.prev = null;
            pair.next = null;
            this._tail.next = pair;
            this._tail = pair;
            if(--this._dupMap[obj] <= 0)
            {
               delete this._dupMap[obj];
            }
            if(--this._size <= this._maxSize - this._initSize)
            {
               k = (this._maxSize = this._maxSize - this._initSize) + 1;
               for(i = 0; i < k; i++)
               {
                  this._head = this._head.next;
               }
            }
            return obj;
         }
         return null;
      }
      
      public function containsKey(key:*) : Boolean
      {
         return this._keyMap[key] != undefined;
      }
      
      public function getKeySet() : Array
      {
         var i:int = 0;
         var p:PairNode = null;
         var a:Array = new Array(this._size);
         for each(p in this._keyMap)
         {
            var _loc6_:* = i++;
            a[_loc6_] = p.key;
         }
         return a;
      }
      
      public function contains(obj:*) : Boolean
      {
         return this._dupMap[obj] > 0;
      }
      
      public function clear() : void
      {
         var t:PairNode = null;
         this._keyMap = new Dictionary(true);
         this._dupMap = new Dictionary(true);
         var n:PairNode = this._pair;
         while(n)
         {
            t = n.next;
            n.next = n.prev = null;
            n.key = null;
            n.obj = null;
            this._tail.next = n;
            this._tail = this._tail.next;
            n = t;
         }
         this._pair = null;
         this._size = 0;
      }
      
      public function getIterator() : Iterator
      {
         return new HashMapIterator(this._pair);
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function isEmpty() : Boolean
      {
         return this._size == 0;
      }
      
      public function toArray() : Array
      {
         var i:int = 0;
         var p:PairNode = null;
         var a:Array = new Array(this._size);
         for each(p in this._keyMap)
         {
            var _loc6_:* = i++;
            a[_loc6_] = p.obj;
         }
         return a;
      }
      
      public function toString() : String
      {
         return "[HashMap, size=" + this.size + "]";
      }
      
      public function dump() : String
      {
         var p:PairNode = null;
         var s:String = "HashMap:\n";
         for each(p in this._keyMap)
         {
            s += "[key: " + p.key + ", val:" + p.obj + "]\n";
         }
         return s;
      }
   }
}

class PairNode
{
    
   
   public var key;
   
   public var obj;
   
   public var prev:PairNode;
   
   public var next:PairNode;
   
   function PairNode()
   {
      super();
   }
}

import de.polygonal.ds.Iterator;

class HashMapIterator implements Iterator
{
    
   
   private var _pair:PairNode;
   
   private var _walker:PairNode;
   
   function HashMapIterator(pairList:PairNode)
   {
      super();
      this._pair = this._walker = pairList;
   }
   
   public function get data() : *
   {
      return this._walker.obj;
   }
   
   public function set data(obj:*) : void
   {
      this._walker.obj = obj;
   }
   
   public function start() : void
   {
      this._walker = this._pair;
   }
   
   public function hasNext() : Boolean
   {
      return this._walker != null;
   }
   
   public function next() : *
   {
      var obj:* = this._walker.obj;
      this._walker = this._walker.next;
      return obj;
   }
}
