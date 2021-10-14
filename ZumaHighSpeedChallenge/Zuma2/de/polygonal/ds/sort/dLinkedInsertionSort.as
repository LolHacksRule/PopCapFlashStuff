package de.polygonal.ds.sort
{
   import de.polygonal.ds.DListNode;
   
   public function dLinkedInsertionSort(param1:DListNode, param2:Boolean = false) : DListNode
   {
      var _loc4_:DListNode = null;
      var _loc5_:DListNode = null;
      var _loc6_:DListNode = null;
      var _loc7_:DListNode = null;
      var _loc8_:* = undefined;
      if(!param1)
      {
         return null;
      }
      var _loc3_:DListNode = param1;
      if(param2)
      {
         _loc5_ = _loc3_.next;
         while(_loc5_)
         {
            _loc6_ = _loc5_.next;
            if((_loc4_ = _loc5_.prev).data < _loc5_.data)
            {
               _loc7_ = _loc4_;
               while(_loc7_.prev)
               {
                  if(_loc7_.prev.data >= _loc5_.data)
                  {
                     break;
                  }
                  _loc7_ = _loc7_.prev;
               }
               if(_loc6_)
               {
                  _loc4_.next = _loc6_;
                  _loc6_.prev = _loc4_;
               }
               else
               {
                  _loc4_.next = null;
               }
               if(_loc7_ == _loc3_)
               {
                  _loc5_.prev = null;
                  _loc5_.next = _loc7_;
                  _loc7_.prev = _loc5_;
                  _loc3_ = _loc5_;
               }
               else
               {
                  _loc5_.prev = _loc7_.prev;
                  _loc7_.prev.next = _loc5_;
                  _loc5_.next = _loc7_;
                  _loc7_.prev = _loc5_;
               }
            }
            _loc5_ = _loc6_;
         }
         return _loc3_;
      }
      _loc5_ = _loc3_.next;
      while(_loc5_)
      {
         _loc6_ = _loc5_.next;
         if((_loc4_ = _loc5_.prev).data > _loc5_.data)
         {
            _loc7_ = _loc4_;
            while(_loc7_.prev)
            {
               if(_loc7_.prev.data <= _loc5_.data)
               {
                  break;
               }
               _loc7_ = _loc7_.prev;
            }
            if(_loc6_)
            {
               _loc4_.next = _loc6_;
               _loc6_.prev = _loc4_;
            }
            else
            {
               _loc4_.next = null;
            }
            if(_loc7_ == _loc3_)
            {
               _loc5_.prev = null;
               _loc5_.next = _loc7_;
               _loc7_.prev = _loc5_;
               _loc3_ = _loc5_;
            }
            else
            {
               _loc5_.prev = _loc7_.prev;
               _loc7_.prev.next = _loc5_;
               _loc5_.next = _loc7_;
               _loc7_.prev = _loc5_;
            }
         }
         _loc5_ = _loc6_;
      }
      return _loc3_;
   }
}
