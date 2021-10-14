package de.polygonal.ds.sort
{
   import de.polygonal.ds.DListNode;
   
   public function dLinkedInsertionSortCmp(param1:DListNode, param2:Function, param3:Boolean = false) : DListNode
   {
      var _loc5_:DListNode = null;
      var _loc6_:DListNode = null;
      var _loc7_:DListNode = null;
      var _loc8_:DListNode = null;
      var _loc9_:* = undefined;
      if(!param1 || param2 == null)
      {
         return null;
      }
      var _loc4_:DListNode = param1;
      if(param3)
      {
         _loc6_ = _loc4_.next;
         while(_loc6_)
         {
            _loc7_ = _loc6_.next;
            _loc5_ = _loc6_.prev;
            if(param2(_loc5_.data,_loc6_.data) < 0)
            {
               _loc8_ = _loc5_;
               while(_loc8_.prev)
               {
                  if(param2(_loc8_.prev.data,_loc6_.data) >= 0)
                  {
                     break;
                  }
                  _loc8_ = _loc8_.prev;
               }
               if(_loc7_)
               {
                  _loc5_.next = _loc7_;
                  _loc7_.prev = _loc5_;
               }
               else
               {
                  _loc5_.next = null;
               }
               if(_loc8_ == _loc4_)
               {
                  _loc6_.prev = null;
                  _loc6_.next = _loc8_;
                  _loc8_.prev = _loc6_;
                  _loc4_ = _loc6_;
               }
               else
               {
                  _loc6_.prev = _loc8_.prev;
                  _loc8_.prev.next = _loc6_;
                  _loc6_.next = _loc8_;
                  _loc8_.prev = _loc6_;
               }
            }
            _loc6_ = _loc7_;
         }
      }
      else
      {
         _loc6_ = _loc4_.next;
         while(_loc6_)
         {
            _loc7_ = _loc6_.next;
            _loc5_ = _loc6_.prev;
            if(param2(_loc5_.data,_loc6_.data) > 0)
            {
               _loc8_ = _loc5_;
               while(_loc8_.prev)
               {
                  if(param2(_loc8_.prev.data,_loc6_.data) <= 0)
                  {
                     break;
                  }
                  _loc8_ = _loc8_.prev;
               }
               if(_loc7_)
               {
                  _loc5_.next = _loc7_;
                  _loc7_.prev = _loc5_;
               }
               else
               {
                  _loc5_.next = null;
               }
               if(_loc8_ == _loc4_)
               {
                  _loc6_.prev = null;
                  _loc6_.next = _loc8_;
                  _loc8_.prev = _loc6_;
                  _loc4_ = _loc6_;
               }
               else
               {
                  _loc6_.prev = _loc8_.prev;
                  _loc8_.prev.next = _loc6_;
                  _loc6_.next = _loc8_;
                  _loc8_.prev = _loc6_;
               }
            }
            _loc6_ = _loc7_;
         }
      }
      return _loc4_;
   }
}
