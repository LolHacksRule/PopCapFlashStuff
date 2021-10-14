package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   
   public class CTRMode extends IVMode implements IMode
   {
       
      
      public function CTRMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super(param1,param2);
      }
      
      public function toString() : String
      {
         return key.toString() + "-ctr";
      }
      
      private function core(param1:ByteArray, param2:ByteArray) : void
      {
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = new ByteArray();
         _loc4_ = new ByteArray();
         _loc3_.writeBytes(param2);
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_.position = 0;
            _loc4_.writeBytes(_loc3_);
            key.encrypt(_loc4_);
            _loc6_ = 0;
            while(_loc6_ < blockSize)
            {
               param1[_loc5_ + _loc6_] ^= _loc4_[_loc6_];
               _loc6_++;
            }
            _loc6_ = blockSize - 1;
            while(_loc6_ >= 0)
            {
               ++_loc3_[_loc6_];
               if(_loc3_[_loc6_] != 0)
               {
                  break;
               }
               _loc6_--;
            }
            _loc5_ += blockSize;
         }
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = getIV4d();
         core(param1,_loc2_);
         padding.unpad(param1);
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:ByteArray = null;
         padding.pad(param1);
         _loc2_ = getIV4e();
         core(param1,_loc2_);
      }
   }
}
