package de.polygonal.ds
{
   import de.polygonal.ds.sort.compare.compareStringCaseInSensitive;
   import de.polygonal.ds.sort.compare.compareStringCaseInSensitiveDesc;
   import de.polygonal.ds.sort.compare.compareStringCaseSensitive;
   import de.polygonal.ds.sort.compare.compareStringCaseSensitiveDesc;
   import de.polygonal.ds.sort.dLinkedInsertionSort;
   import de.polygonal.ds.sort.dLinkedInsertionSortCmp;
   import de.polygonal.ds.sort.dLinkedMergeSort;
   import de.polygonal.ds.sort.dLinkedMergeSortCmp;
   
   public class DLinkedList implements Collection
   {
       
      
      private var _count:int;
      
      public var tail:DListNode;
      
      public var head:DListNode;
      
      public function DLinkedList(... rest)
      {
         super();
         this.head = this.tail = null;
         this._count = 0;
         if(rest.length > 0)
         {
            this.append.apply(this,rest);
         }
      }
      
      public function get size() : int
      {
         return this._count;
      }
      
      public function isEmpty() : Boolean
      {
         return this._count == 0;
      }
      
      public function remove(param1:DListIterator) : Boolean
      {
         if(param1.list != this || !param1.node)
         {
            return false;
         }
         var _loc2_:DListNode = param1.node;
         if(_loc2_ == this.head)
         {
            this.head = this.head.next;
         }
         else if(_loc2_ == this.tail)
         {
            this.tail = this.tail.prev;
         }
         if(param1.node)
         {
            param1.node = param1.node.next;
         }
         if(_loc2_.prev)
         {
            _loc2_.prev.next = _loc2_.next;
         }
         if(_loc2_.next)
         {
            _loc2_.next.prev = _loc2_.prev;
         }
         _loc2_.next = _loc2_.prev = null;
         if(this.head == null)
         {
            this.tail = null;
         }
         --this._count;
         return true;
      }
      
      public function removeHead() : *
      {
         var _loc1_:* = undefined;
         if(this.head)
         {
            _loc1_ = this.head.data;
            this.head = this.head.next;
            if(this.head)
            {
               this.head.prev = null;
            }
            else
            {
               this.tail = null;
            }
            --this._count;
            return _loc1_;
         }
         return null;
      }
      
      public function clear() : void
      {
         var _loc2_:DListNode = null;
         var _loc1_:DListNode = this.head;
         this.head = null;
         while(_loc1_)
         {
            _loc2_ = _loc1_.next;
            _loc1_.next = _loc1_.prev = null;
            _loc1_ = _loc2_;
         }
         this._count = 0;
      }
      
      public function prepend(... rest) : DListNode
      {
         var _loc4_:DListNode = null;
         var _loc5_:int = 0;
         var _loc2_:int = rest.length;
         var _loc3_:DListNode = new DListNode(rest[int(_loc2_ - 1)]);
         if(this.head)
         {
            this.head.insertBefore(_loc3_);
            this.head = this.head.prev;
         }
         else
         {
            this.head = this.tail = _loc3_;
         }
         if(_loc2_ > 1)
         {
            _loc4_ = _loc3_;
            _loc5_ = _loc2_ - 2;
            while(_loc5_ >= 0)
            {
               _loc3_ = new DListNode(rest[_loc5_]);
               this.head.insertBefore(_loc3_);
               this.head = this.head.prev;
               _loc5_--;
            }
            this._count += _loc2_;
            return _loc4_;
         }
         ++this._count;
         return _loc3_;
      }
      
      public function popDown() : void
      {
         var _loc1_:DListNode = this.tail;
         if(this.tail.prev == this.head)
         {
            this.tail = this.head;
            this.tail.next = null;
            this.head = _loc1_;
            this.head.prev = null;
            this.head.next = this.tail;
            this.tail.prev = this.head;
         }
         else
         {
            this.tail = this.tail.prev;
            this.tail.next = null;
            this.head.prev = _loc1_;
            _loc1_.prev = null;
            _loc1_.next = this.head;
            this.head = _loc1_;
         }
      }
      
      public function concat(... rest) : DLinkedList
      {
         var _loc3_:DLinkedList = null;
         var _loc4_:DListNode = null;
         var _loc2_:DLinkedList = new DLinkedList();
         _loc4_ = this.head;
         while(_loc4_)
         {
            _loc2_.append(_loc4_.data);
            _loc4_ = _loc4_.next;
         }
         var _loc5_:int = rest.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = rest[_loc6_];
            _loc4_ = _loc3_.head;
            while(_loc4_)
            {
               _loc2_.append(_loc4_.data);
               _loc4_ = _loc4_.next;
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public function insertBefore(param1:DListIterator, param2:*) : DListNode
      {
         var _loc3_:DListNode = null;
         if(param1.list != this)
         {
            return null;
         }
         if(param1.node)
         {
            _loc3_ = new DListNode(param2);
            param1.node.insertBefore(_loc3_);
            if(param1.node == this.head)
            {
               this.head = this.head.prev;
            }
            ++this._count;
            return _loc3_;
         }
         return this.prepend(param2);
      }
      
      public function append(... rest) : DListNode
      {
         var _loc4_:DListNode = null;
         var _loc5_:int = 0;
         var _loc2_:int = rest.length;
         var _loc3_:DListNode = new DListNode(rest[0]);
         if(this.head)
         {
            this.tail.insertAfter(_loc3_);
            this.tail = this.tail.next;
         }
         else
         {
            this.head = this.tail = _loc3_;
         }
         if(_loc2_ > 1)
         {
            _loc4_ = _loc3_;
            _loc5_ = 1;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = new DListNode(rest[_loc5_]);
               this.tail.insertAfter(_loc3_);
               this.tail = this.tail.next;
               _loc5_++;
            }
            this._count += _loc2_;
            return _loc4_;
         }
         ++this._count;
         return _loc3_;
      }
      
      public function sort(... rest) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Function = null;
         var _loc4_:* = undefined;
         if(this._count <= 1)
         {
            return;
         }
         if(rest.length > 0)
         {
            _loc2_ = 0;
            _loc3_ = null;
            if((_loc4_ = rest[0]) is Function)
            {
               _loc3_ = _loc4_;
               if(rest.length > 1)
               {
                  if((_loc4_ = rest[1]) is int)
                  {
                     _loc2_ = _loc4_;
                  }
               }
            }
            else if(_loc4_ is int)
            {
               _loc2_ = _loc4_;
            }
            if(Boolean(_loc3_))
            {
               if(_loc2_ & 2)
               {
                  this.head = dLinkedInsertionSortCmp(this.head,_loc3_,_loc2_ == 18);
               }
               else
               {
                  this.head = dLinkedMergeSortCmp(this.head,_loc3_,_loc2_ == 16);
               }
            }
            else if(_loc2_ & 2)
            {
               if(_loc2_ & 4)
               {
                  if(_loc2_ == 22)
                  {
                     this.head = dLinkedInsertionSortCmp(this.head,compareStringCaseSensitiveDesc);
                  }
                  else if(_loc2_ == 14)
                  {
                     this.head = dLinkedInsertionSortCmp(this.head,compareStringCaseInSensitive);
                  }
                  else if(_loc2_ == 30)
                  {
                     this.head = dLinkedInsertionSortCmp(this.head,compareStringCaseInSensitiveDesc);
                  }
                  else
                  {
                     this.head = dLinkedInsertionSortCmp(this.head,compareStringCaseSensitive);
                  }
               }
               else
               {
                  this.head = dLinkedInsertionSort(this.head,_loc2_ == 18);
               }
            }
            else if(_loc2_ & 4)
            {
               if(_loc2_ == 20)
               {
                  this.head = dLinkedMergeSortCmp(this.head,compareStringCaseSensitiveDesc);
               }
               else if(_loc2_ == 12)
               {
                  this.head = dLinkedMergeSortCmp(this.head,compareStringCaseInSensitive);
               }
               else if(_loc2_ == 28)
               {
                  this.head = dLinkedMergeSortCmp(this.head,compareStringCaseInSensitiveDesc);
               }
               else
               {
                  this.head = dLinkedMergeSortCmp(this.head,compareStringCaseSensitive);
               }
            }
            else if(_loc2_ & 16)
            {
               this.head = dLinkedMergeSort(this.head,true);
            }
         }
         else
         {
            this.head = dLinkedMergeSort(this.head);
         }
      }
      
      public function contains(param1:*) : Boolean
      {
         var _loc2_:DListNode = this.head;
         while(_loc2_)
         {
            if(_loc2_.data == param1)
            {
               return true;
            }
            _loc2_ = _loc2_.next;
         }
         return false;
      }
      
      public function reverse() : void
      {
         var _loc1_:DListNode = null;
         var _loc3_:DListNode = null;
         if(this._count == 0)
         {
            return;
         }
         var _loc2_:DListNode = this.tail;
         while(_loc2_)
         {
            _loc1_ = _loc2_.prev;
            if(!_loc2_.next)
            {
               _loc2_.next = _loc2_.prev;
               _loc2_.prev = null;
               this.head = _loc2_;
            }
            else if(!_loc2_.prev)
            {
               _loc2_.prev = _loc2_.next;
               _loc2_.next = null;
               this.tail = _loc2_;
            }
            else
            {
               _loc3_ = _loc2_.next;
               _loc2_.next = _loc2_.prev;
               _loc2_.prev = _loc3_;
            }
            _loc2_ = _loc1_;
         }
      }
      
      public function insertAfter(param1:DListIterator, param2:*) : DListNode
      {
         var _loc3_:DListNode = null;
         if(param1.list != this)
         {
            return null;
         }
         if(param1.node)
         {
            _loc3_ = new DListNode(param2);
            param1.node.insertAfter(_loc3_);
            if(param1.node == this.tail)
            {
               this.tail = param1.node.next;
            }
            ++this._count;
            return _loc3_;
         }
         return this.append(param2);
      }
      
      public function getIterator() : Iterator
      {
         return new DListIterator(this,this.head);
      }
      
      public function toArray() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:DListNode = this.head;
         while(_loc2_)
         {
            _loc1_.push(_loc2_.data);
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function getListIterator() : DListIterator
      {
         return new DListIterator(this,this.head);
      }
      
      public function join(param1:*) : String
      {
         if(this._count == 0)
         {
            return "";
         }
         var _loc2_:String = "";
         var _loc3_:DListNode = this.head;
         while(_loc3_.next)
         {
            _loc2_ += _loc3_.data + param1;
            _loc3_ = _loc3_.next;
         }
         return _loc2_ + _loc3_.data;
      }
      
      public function toString() : String
      {
         return "[DLinkedList > has " + this.size + " nodes]";
      }
      
      public function removeTail() : *
      {
         var _loc1_:* = undefined;
         if(this.tail)
         {
            _loc1_ = this.tail.data;
            this.tail = this.tail.prev;
            if(this.tail)
            {
               this.tail.next = null;
            }
            else
            {
               this.head = null;
            }
            --this._count;
            return _loc1_;
         }
         return null;
      }
      
      public function lastNodeOf(param1:*, param2:DListIterator = null) : DListIterator
      {
         if(param2 != null)
         {
            if(param2.list != this)
            {
               return null;
            }
         }
         var _loc3_:DListNode = param2 == null ? this.tail : param2.node;
         while(_loc3_)
         {
            if(_loc3_.data === param1)
            {
               return new DListIterator(this,_loc3_);
            }
            _loc3_ = _loc3_.prev;
         }
         return null;
      }
      
      public function merge(... rest) : void
      {
         var _loc2_:DLinkedList = null;
         _loc2_ = rest[0];
         if(_loc2_.head)
         {
            if(this.head)
            {
               this.tail.next = _loc2_.head;
               _loc2_.head.prev = this.tail;
               this.tail = _loc2_.tail;
            }
            else
            {
               this.head = _loc2_.head;
               this.tail = _loc2_.tail;
            }
            this._count += _loc2_.size;
         }
         var _loc3_:int = rest.length;
         var _loc4_:int = 1;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = rest[_loc4_];
            if(_loc2_.head)
            {
               this.tail.next = _loc2_.head;
               _loc2_.head.prev = this.tail;
               this.tail = _loc2_.tail;
               this._count += _loc2_.size;
            }
            _loc4_++;
         }
      }
      
      public function nodeOf(param1:*, param2:DListIterator = null) : DListIterator
      {
         if(param2 != null)
         {
            if(param2.list != this)
            {
               return null;
            }
         }
         var _loc3_:DListNode = param2 == null ? this.head : param2.node;
         while(_loc3_)
         {
            if(_loc3_.data === param1)
            {
               return new DListIterator(this,_loc3_);
            }
            _loc3_ = _loc3_.next;
         }
         return null;
      }
      
      public function dump() : String
      {
         if(this.head == null)
         {
            return "DLinkedList, empty";
         }
         var _loc1_:* = "DLinkedList, has " + this._count + " node" + (this._count == 1 ? "" : "s") + "\n|< Head\n";
         var _loc2_:DListIterator = this.getListIterator();
         while(_loc2_.valid())
         {
            _loc1_ += "\t" + _loc2_.data + "\n";
            _loc2_.forth();
         }
         return _loc1_ + "Tail >|";
      }
      
      public function splice(param1:DListIterator, param2:uint = 4.294967295E9, ... rest) : DLinkedList
      {
         var _loc4_:DListNode = null;
         var _loc5_:DListNode = null;
         var _loc6_:DLinkedList = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:DListNode = null;
         if(param1)
         {
            if(param1.list != this)
            {
               return null;
            }
         }
         if(param1.node)
         {
            _loc4_ = param1.node;
            _loc5_ = param1.node.prev;
            _loc6_ = new DLinkedList();
            if(param2 == 4294967295)
            {
               if(param1.node == this.tail)
               {
                  return _loc6_;
               }
               while(param1.node)
               {
                  _loc6_.append(param1.node.data);
                  param1.remove();
               }
               param1.list = _loc6_;
               param1.node = _loc4_;
               return _loc6_;
            }
            _loc7_ = 0;
            while(_loc7_ < param2)
            {
               if(!param1.node)
               {
                  break;
               }
               _loc6_.append(param1.node.data);
               param1.remove();
               _loc7_++;
            }
            if((_loc8_ = rest.length) > 0)
            {
               if(this._count == 0)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc8_)
                  {
                     this.append(rest[_loc7_]);
                     _loc7_++;
                  }
               }
               else if(_loc5_ == null)
               {
                  _loc9_ = this.prepend(rest[0]);
                  _loc7_ = 1;
                  while(_loc7_ < _loc8_)
                  {
                     _loc9_.insertAfter(new DListNode(rest[_loc7_]));
                     if(_loc9_ == this.tail)
                     {
                        this.tail = _loc9_.next;
                     }
                     _loc9_ = _loc9_.next;
                     ++this._count;
                     _loc7_++;
                  }
               }
               else
               {
                  _loc9_ = _loc5_;
                  _loc7_ = 0;
                  while(_loc7_ < _loc8_)
                  {
                     _loc9_.insertAfter(new DListNode(rest[_loc7_]));
                     if(_loc9_ == this.tail)
                     {
                        this.tail = _loc9_.next;
                     }
                     _loc9_ = _loc9_.next;
                     ++this._count;
                     _loc7_++;
                  }
               }
               param1.node = _loc9_;
            }
            else
            {
               param1.node = _loc4_;
            }
            param1.list = _loc6_;
            return _loc6_;
         }
         return null;
      }
      
      public function shiftUp() : void
      {
         var _loc1_:DListNode = this.head;
         if(this.head.next == this.tail)
         {
            this.head = this.tail;
            this.head.prev = null;
            this.tail = _loc1_;
            this.tail.next = null;
            this.head.next = this.tail;
            this.tail.prev = this.head;
         }
         else
         {
            this.head = this.head.next;
            this.head.prev = null;
            this.tail.next = _loc1_;
            _loc1_.next = null;
            _loc1_.prev = this.tail;
            this.tail = _loc1_;
         }
      }
   }
}
