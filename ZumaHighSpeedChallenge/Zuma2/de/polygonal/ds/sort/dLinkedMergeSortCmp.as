package de.polygonal.ds.sort
{
   import de.polygonal.ds.DListNode;
   
   public function dLinkedMergeSortCmp(param1:DListNode, param2:Function, param3:Boolean = false) : DListNode
   {
      var _loc5_:DListNode = null;
      var _loc6_:DListNode = null;
      var _loc7_:DListNode = null;
      var _loc8_:DListNode = null;
      var _loc10_:int = 0;
      var _loc11_:int = 0;
      var _loc12_:int = 0;
      var _loc13_:int = 0;
      if(!param1 || param2 == null)
      {
         return null;
      }
      var _loc4_:DListNode = param1;
      var _loc9_:* = 1;
      if(param3)
      {
         while(true)
         {
            _loc5_ = _loc4_;
            _loc4_ = _loc8_ = null;
            _loc10_ = 0;
            while(_loc5_)
            {
               _loc10_++;
               _loc13_ = 0;
               _loc11_ = 0;
               _loc6_ = _loc5_;
               while(_loc13_ < _loc9_)
               {
                  _loc11_++;
                  if(!(_loc6_ = _loc6_.next))
                  {
                     break;
                  }
                  _loc13_++;
               }
               _loc12_ = _loc9_;
               while(_loc11_ > 0 || _loc12_ > 0 && _loc6_)
               {
                  if(_loc11_ == 0)
                  {
                     _loc7_ = _loc6_;
                     _loc6_ = _loc6_.next;
                     _loc12_--;
                  }
                  else if(_loc12_ == 0 || !_loc6_)
                  {
                     _loc7_ = _loc5_;
                     _loc5_ = _loc5_.next;
                     _loc11_--;
                  }
                  else if(param2(_loc5_.data,_loc6_.data) >= 0)
                  {
                     _loc7_ = _loc5_;
                     _loc5_ = _loc5_.next;
                     _loc11_--;
                  }
                  else
                  {
                     _loc7_ = _loc6_;
                     _loc6_ = _loc6_.next;
                     _loc12_--;
                  }
                  if(_loc8_)
                  {
                     _loc8_.next = _loc7_;
                  }
                  else
                  {
                     _loc4_ = _loc7_;
                  }
                  _loc7_.prev = _loc8_;
                  _loc8_ = _loc7_;
               }
               _loc5_ = _loc6_;
            }
            param1.prev = _loc8_;
            _loc8_.next = null;
            if(_loc10_ <= 1)
            {
               break;
            }
            _loc9_ <<= 1;
         }
         return _loc4_;
      }
      while(true)
      {
         _loc5_ = _loc4_;
         _loc4_ = _loc8_ = null;
         _loc10_ = 0;
         while(_loc5_)
         {
            _loc10_++;
            _loc13_ = 0;
            _loc11_ = 0;
            _loc6_ = _loc5_;
            while(_loc13_ < _loc9_)
            {
               _loc11_++;
               if(!(_loc6_ = _loc6_.next))
               {
                  break;
               }
               _loc13_++;
            }
            _loc12_ = _loc9_;
            while(_loc11_ > 0 || _loc12_ > 0 && _loc6_)
            {
               if(_loc11_ == 0)
               {
                  _loc7_ = _loc6_;
                  _loc6_ = _loc6_.next;
                  _loc12_--;
               }
               else if(_loc12_ == 0 || !_loc6_)
               {
                  _loc7_ = _loc5_;
                  _loc5_ = _loc5_.next;
                  _loc11_--;
               }
               else if(param2(_loc5_.data,_loc6_.data) <= 0)
               {
                  _loc7_ = _loc5_;
                  _loc5_ = _loc5_.next;
                  _loc11_--;
               }
               else
               {
                  _loc7_ = _loc6_;
                  _loc6_ = _loc6_.next;
                  _loc12_--;
               }
               if(_loc8_)
               {
                  _loc8_.next = _loc7_;
               }
               else
               {
                  _loc4_ = _loc7_;
               }
               _loc7_.prev = _loc8_;
               _loc8_ = _loc7_;
            }
            _loc5_ = _loc6_;
         }
         param1.prev = _loc8_;
         _loc8_.next = null;
         if(_loc10_ <= 1)
         {
            break;
         }
         _loc9_ <<= 1;
      }
      return _loc4_;
   }
}
