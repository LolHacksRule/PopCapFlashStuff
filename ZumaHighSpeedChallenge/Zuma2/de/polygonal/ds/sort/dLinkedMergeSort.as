package de.polygonal.ds.sort
{
   import de.polygonal.ds.DListNode;
   
   public function dLinkedMergeSort(param1:DListNode, param2:Boolean = false) : DListNode
   {
      var _loc4_:DListNode = null;
      var _loc5_:DListNode = null;
      var _loc6_:DListNode = null;
      var _loc7_:DListNode = null;
      var _loc9_:int = 0;
      var _loc10_:int = 0;
      var _loc11_:int = 0;
      var _loc12_:int = 0;
      if(!param1)
      {
         return null;
      }
      var _loc3_:DListNode = param1;
      var _loc8_:* = 1;
      if(param2)
      {
         while(true)
         {
            _loc4_ = _loc3_;
            _loc3_ = _loc7_ = null;
            _loc9_ = 0;
            while(_loc4_)
            {
               _loc9_++;
               _loc12_ = 0;
               _loc10_ = 0;
               _loc5_ = _loc4_;
               while(_loc12_ < _loc8_)
               {
                  _loc10_++;
                  if(!(_loc5_ = _loc5_.next))
                  {
                     break;
                  }
                  _loc12_++;
               }
               _loc11_ = _loc8_;
               while(_loc10_ > 0 || _loc11_ > 0 && _loc5_)
               {
                  if(_loc10_ == 0)
                  {
                     _loc6_ = _loc5_;
                     _loc5_ = _loc5_.next;
                     _loc11_--;
                  }
                  else if(_loc11_ == 0 || !_loc5_)
                  {
                     _loc6_ = _loc4_;
                     _loc4_ = _loc4_.next;
                     _loc10_--;
                  }
                  else if(_loc4_.data - _loc5_.data >= 0)
                  {
                     _loc6_ = _loc4_;
                     _loc4_ = _loc4_.next;
                     _loc10_--;
                  }
                  else
                  {
                     _loc6_ = _loc5_;
                     _loc5_ = _loc5_.next;
                     _loc11_--;
                  }
                  if(_loc7_)
                  {
                     _loc7_.next = _loc6_;
                  }
                  else
                  {
                     _loc3_ = _loc6_;
                  }
                  _loc6_.prev = _loc7_;
                  _loc7_ = _loc6_;
               }
               _loc4_ = _loc5_;
            }
            _loc7_.next = null;
            if(_loc9_ <= 1)
            {
               break;
            }
            _loc8_ <<= 1;
         }
         return _loc3_;
      }
      while(true)
      {
         _loc4_ = _loc3_;
         _loc3_ = _loc7_ = null;
         _loc9_ = 0;
         while(_loc4_)
         {
            _loc9_++;
            _loc12_ = 0;
            _loc10_ = 0;
            _loc5_ = _loc4_;
            while(_loc12_ < _loc8_)
            {
               _loc10_++;
               if(!(_loc5_ = _loc5_.next))
               {
                  break;
               }
               _loc12_++;
            }
            _loc11_ = _loc8_;
            while(_loc10_ > 0 || _loc11_ > 0 && _loc5_)
            {
               if(_loc10_ == 0)
               {
                  _loc6_ = _loc5_;
                  _loc5_ = _loc5_.next;
                  _loc11_--;
               }
               else if(_loc11_ == 0 || !_loc5_)
               {
                  _loc6_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  _loc10_--;
               }
               else if(_loc4_.data - _loc5_.data <= 0)
               {
                  _loc6_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  _loc10_--;
               }
               else
               {
                  _loc6_ = _loc5_;
                  _loc5_ = _loc5_.next;
                  _loc11_--;
               }
               if(_loc7_)
               {
                  _loc7_.next = _loc6_;
               }
               else
               {
                  _loc3_ = _loc6_;
               }
               _loc6_.prev = _loc7_;
               _loc7_ = _loc6_;
            }
            _loc4_ = _loc5_;
         }
         _loc7_.next = null;
         if(_loc9_ <= 1)
         {
            break;
         }
         _loc8_ <<= 1;
      }
      return _loc3_;
   }
}
