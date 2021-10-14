package de.polygonal.ds
{
   public class DListNode implements LinkedListNode
   {
       
      
      public var prev:DListNode;
      
      public var next:DListNode;
      
      public var data;
      
      public function DListNode(param1:*)
      {
         super();
         this.next = this.prev = null;
         this.data = param1;
      }
      
      public function unlink() : void
      {
         if(this.prev)
         {
            this.prev.next = this.next;
         }
         if(this.next)
         {
            this.next.prev = this.prev;
         }
         this.next = this.prev = null;
      }
      
      public function insertAfter(param1:DListNode) : void
      {
         param1.next = this.next;
         param1.prev = this;
         if(this.next)
         {
            this.next.prev = param1;
         }
         this.next = param1;
      }
      
      public function insertBefore(param1:DListNode) : void
      {
         param1.next = this;
         param1.prev = this.prev;
         if(this.prev)
         {
            this.prev.next = param1;
         }
         this.prev = param1;
      }
      
      public function toString() : String
      {
         return "[DListNode, data=" + this.data + "]";
      }
   }
}
