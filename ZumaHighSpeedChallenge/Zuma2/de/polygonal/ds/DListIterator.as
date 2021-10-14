package de.polygonal.ds
{
   public class DListIterator implements Iterator
   {
       
      
      public var node:DListNode;
      
      public var list:DLinkedList;
      
      public function DListIterator(param1:DLinkedList, param2:DListNode = null)
      {
         super();
         this.list = param1;
         this.node = param2;
      }
      
      public function remove() : Boolean
      {
         return this.list.remove(this);
      }
      
      public function back() : void
      {
         if(this.node)
         {
            this.node = this.node.prev;
         }
      }
      
      public function start() : void
      {
         this.node = this.list.head;
      }
      
      public function get data() : *
      {
         if(this.node)
         {
            return this.node.data;
         }
         return null;
      }
      
      public function forth() : void
      {
         if(this.node)
         {
            this.node = this.node.next;
         }
      }
      
      public function toString() : String
      {
         return "{DListIterator, data=" + (!!this.node ? this.node.data : "null") + "}";
      }
      
      public function hasNext() : Boolean
      {
         return Boolean(this.node);
      }
      
      public function valid() : Boolean
      {
         return Boolean(this.node);
      }
      
      public function next() : *
      {
         var _loc1_:* = undefined;
         if(this.hasNext())
         {
            _loc1_ = this.node.data;
            this.node = this.node.next;
            return _loc1_;
         }
         return null;
      }
      
      public function set data(param1:*) : void
      {
         this.node.data = param1;
      }
      
      public function end() : void
      {
         this.node = this.list.tail;
      }
   }
}
