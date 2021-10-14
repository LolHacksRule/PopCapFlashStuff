package com.hurlant.crypto.symmetric
{
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class ECBMode implements IMode, ICipher
   {
       
      
      private var key:ISymmetricKey;
      
      private var padding:IPad;
      
      public function ECBMode(param1:ISymmetricKey, param2:IPad = null)
      {
         super();
         this.key = param1;
         if(param2 == null)
         {
            param2 = new PKCS5(param1.getBlockSize());
         }
         else
         {
            param2.setBlockSize(param1.getBlockSize());
         }
         this.padding = param2;
      }
      
      public function encrypt(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         padding.pad(param1);
         param1.position = 0;
         _loc2_ = key.getBlockSize();
         _loc3_ = new ByteArray();
         _loc4_ = new ByteArray();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_.length = 0;
            param1.readBytes(_loc3_,0,_loc2_);
            key.encrypt(_loc3_);
            _loc4_.writeBytes(_loc3_);
            _loc5_ += _loc2_;
         }
         param1.length = 0;
         param1.writeBytes(_loc4_);
      }
      
      public function decrypt(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:ByteArray = null;
         var _loc5_:uint = 0;
         param1.position = 0;
         _loc2_ = key.getBlockSize();
         if(param1.length % _loc2_ != 0)
         {
            throw new Error("ECB mode cipher length must be a multiple of blocksize " + _loc2_);
         }
         _loc3_ = new ByteArray();
         _loc4_ = new ByteArray();
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_.length = 0;
            param1.readBytes(_loc3_,0,_loc2_);
            key.decrypt(_loc3_);
            _loc4_.writeBytes(_loc3_);
            _loc5_ += _loc2_;
         }
         padding.unpad(_loc4_);
         param1.length = 0;
         param1.writeBytes(_loc4_);
      }
      
      public function dispose() : void
      {
         key.dispose();
         key = null;
         padding = null;
         Memory.gc();
      }
      
      public function getBlockSize() : uint
      {
         return key.getBlockSize();
      }
      
      public function toString() : String
      {
         return key.toString() + "-ecb";
      }
   }
}
