package de.polygonal.ds.sort.compare
{
   public function compareStringCaseSensitive(param1:String, param2:String) : int
   {
      var _loc3_:int = 0;
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      if(param1.length + param2.length > 2)
      {
         _loc3_ = 0;
         _loc4_ = param1.length > param2.length ? int(param1.length) : int(param2.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1.charCodeAt(_loc5_) - param2.charCodeAt(_loc5_);
            if(_loc3_ != 0)
            {
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      return param1.charCodeAt(0) - param2.charCodeAt(0);
   }
}
