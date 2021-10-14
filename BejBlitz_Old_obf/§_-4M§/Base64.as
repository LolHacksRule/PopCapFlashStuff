package §_-4M§
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   public class Base64
   {
      
      protected static var §_-D0§:Array = [];
      
      public static const §_-93§:Dictionary = new Dictionary();
      
      protected static var §_-Y1§:Array = [];
      
      public static const §_-2U§:Array = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/","="];
      
      {
         §_-93§["A"] = 0;
         §_-93§["B"] = 1;
         §_-93§["C"] = 2;
         §_-93§["D"] = 3;
         §_-93§["E"] = 4;
         §_-93§["F"] = 5;
         §_-93§["G"] = 6;
         §_-93§["H"] = 7;
         §_-93§["I"] = 8;
         §_-93§["J"] = 9;
         §_-93§["K"] = 10;
         §_-93§["L"] = 11;
         §_-93§["M"] = 12;
         §_-93§["N"] = 13;
         §_-93§["O"] = 14;
         §_-93§["P"] = 15;
         §_-93§["Q"] = 16;
         §_-93§["R"] = 17;
         §_-93§["S"] = 18;
         §_-93§["T"] = 19;
         §_-93§["U"] = 20;
         §_-93§["V"] = 21;
         §_-93§["W"] = 22;
         §_-93§["X"] = 23;
         §_-93§["Y"] = 24;
         §_-93§["Z"] = 25;
         §_-93§["a"] = 26;
         §_-93§["b"] = 27;
         §_-93§["c"] = 28;
         §_-93§["d"] = 29;
         §_-93§["e"] = 30;
         §_-93§["f"] = 31;
         §_-93§["g"] = 32;
         §_-93§["h"] = 33;
         §_-93§["i"] = 34;
         §_-93§["j"] = 35;
         §_-93§["k"] = 36;
         §_-93§["l"] = 37;
         §_-93§["m"] = 38;
         §_-93§["n"] = 39;
         §_-93§["o"] = 40;
         §_-93§["p"] = 41;
         §_-93§["q"] = 42;
         §_-93§["r"] = 43;
         §_-93§["s"] = 44;
         §_-93§["t"] = 45;
         §_-93§["u"] = 46;
         §_-93§["v"] = 47;
         §_-93§["w"] = 48;
         §_-93§["x"] = 49;
         §_-93§["y"] = 50;
         §_-93§["z"] = 51;
         §_-93§["0"] = 52;
         §_-93§["1"] = 53;
         §_-93§["2"] = 54;
         §_-93§["3"] = 55;
         §_-93§["4"] = 56;
         §_-93§["5"] = 57;
         §_-93§["6"] = 58;
         §_-93§["7"] = 59;
         §_-93§["8"] = 60;
         §_-93§["9"] = 61;
         §_-93§["+"] = 62;
         §_-93§["/"] = 63;
         §_-93§["="] = 64;
      }
      
      public function Base64()
      {
         super();
      }
      
      public static function §_-oz§(param1:ByteArray) : ByteArray
      {
         var _loc3_:int = 0;
         param1.position = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         while(param1.bytesAvailable > 0)
         {
            §_-Y1§.length = 0;
            _loc3_ = 0;
            while(_loc3_ < 3 && param1.bytesAvailable > 0)
            {
               §_-Y1§[_loc3_] = param1.readUnsignedByte();
               _loc3_++;
            }
            §_-D0§.length = 0;
            §_-D0§[0] = (§_-Y1§[0] & 252) >> 2;
            §_-D0§[1] = (§_-Y1§[0] & 3) << 4 | §_-Y1§[1] >> 4;
            §_-D0§[2] = (§_-Y1§[1] & 15) << 2 | §_-Y1§[2] >> 6;
            §_-D0§[3] = §_-Y1§[2] & 63;
            _loc3_ = §_-Y1§.length;
            while(_loc3_ < 3)
            {
               §_-D0§[_loc3_ + 1] = 64;
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < §_-D0§.length)
            {
               _loc2_.writeUTFBytes(§_-2U§[§_-D0§[_loc3_]]);
               _loc3_++;
            }
         }
         param1.position = 0;
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function §_-5G§(param1:ByteArray) : ByteArray
      {
         var _loc5_:int = 0;
         param1.position = 0;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            §_-Y1§.length = 0;
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               §_-Y1§[_loc5_] = §_-93§[String.fromCharCode(param1.readUnsignedByte())];
               _loc5_++;
            }
            §_-D0§.length = 0;
            §_-D0§[0] = (§_-Y1§[0] << 2) + ((§_-Y1§[1] & 48) >> 4);
            §_-D0§[1] = ((§_-Y1§[1] & 15) << 4) + ((§_-Y1§[2] & 60) >> 2);
            §_-D0§[2] = ((§_-Y1§[2] & 3) << 6) + §_-Y1§[3];
            _loc5_ = 0;
            while(_loc5_ < §_-D0§.length)
            {
               if(§_-Y1§[_loc5_ + 1] == 64)
               {
                  break;
               }
               _loc2_.writeByte(§_-D0§[_loc5_]);
               _loc5_++;
            }
            _loc4_ += 4;
         }
         param1.position = 0;
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function §_-dw§(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.endian = Endian.LITTLE_ENDIAN;
         var _loc3_:int = param1.length;
         var _loc4_:* = "";
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            if(param1.charAt(_loc5_) == " ")
            {
               _loc4_ += "+";
            }
            else
            {
               _loc4_ += param1.charAt(_loc5_);
            }
            _loc5_++;
         }
         _loc2_.writeUTFBytes(_loc4_);
         return §_-5G§(_loc2_);
      }
   }
}
