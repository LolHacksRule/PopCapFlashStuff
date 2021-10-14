package §_-4M§
{
   public class §_-Ze§
   {
       
      
      public function §_-Ze§()
      {
         super();
      }
      
      public static function §_-2P§(param1:int) : String
      {
         var _loc2_:String = "";
         var _loc3_:Boolean = false;
         if(param1 < 0)
         {
            _loc3_ = true;
         }
         var _loc4_:String = Math.abs(param1).toString();
         while(_loc4_.length > 3)
         {
            _loc2_ = "," + _loc4_.substr(_loc4_.length - 3,_loc4_.length) + _loc2_;
            _loc4_ = _loc4_.substr(0,_loc4_.length - 3);
         }
         _loc2_ = _loc4_ + _loc2_;
         if(_loc3_)
         {
            _loc2_ = "-" + _loc2_;
         }
         return _loc2_;
      }
   }
}
