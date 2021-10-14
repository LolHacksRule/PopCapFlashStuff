package com.popcap.flash.framework.utils
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   
   public class Base64
   {
      
      public static const CODE_TO_BYTE:Array = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","+","/","="];
      
      public static const BYTE_TO_CODE:Dictionary = new Dictionary();
      
      protected static var m_ReadBuff:Array = [];
      
      protected static var m_WriteBuff:Array = [];
      
      {
         BYTE_TO_CODE["A"] = 0;
         BYTE_TO_CODE["B"] = 1;
         BYTE_TO_CODE["C"] = 2;
         BYTE_TO_CODE["D"] = 3;
         BYTE_TO_CODE["E"] = 4;
         BYTE_TO_CODE["F"] = 5;
         BYTE_TO_CODE["G"] = 6;
         BYTE_TO_CODE["H"] = 7;
         BYTE_TO_CODE["I"] = 8;
         BYTE_TO_CODE["J"] = 9;
         BYTE_TO_CODE["K"] = 10;
         BYTE_TO_CODE["L"] = 11;
         BYTE_TO_CODE["M"] = 12;
         BYTE_TO_CODE["N"] = 13;
         BYTE_TO_CODE["O"] = 14;
         BYTE_TO_CODE["P"] = 15;
         BYTE_TO_CODE["Q"] = 16;
         BYTE_TO_CODE["R"] = 17;
         BYTE_TO_CODE["S"] = 18;
         BYTE_TO_CODE["T"] = 19;
         BYTE_TO_CODE["U"] = 20;
         BYTE_TO_CODE["V"] = 21;
         BYTE_TO_CODE["W"] = 22;
         BYTE_TO_CODE["X"] = 23;
         BYTE_TO_CODE["Y"] = 24;
         BYTE_TO_CODE["Z"] = 25;
         BYTE_TO_CODE["a"] = 26;
         BYTE_TO_CODE["b"] = 27;
         BYTE_TO_CODE["c"] = 28;
         BYTE_TO_CODE["d"] = 29;
         BYTE_TO_CODE["e"] = 30;
         BYTE_TO_CODE["f"] = 31;
         BYTE_TO_CODE["g"] = 32;
         BYTE_TO_CODE["h"] = 33;
         BYTE_TO_CODE["i"] = 34;
         BYTE_TO_CODE["j"] = 35;
         BYTE_TO_CODE["k"] = 36;
         BYTE_TO_CODE["l"] = 37;
         BYTE_TO_CODE["m"] = 38;
         BYTE_TO_CODE["n"] = 39;
         BYTE_TO_CODE["o"] = 40;
         BYTE_TO_CODE["p"] = 41;
         BYTE_TO_CODE["q"] = 42;
         BYTE_TO_CODE["r"] = 43;
         BYTE_TO_CODE["s"] = 44;
         BYTE_TO_CODE["t"] = 45;
         BYTE_TO_CODE["u"] = 46;
         BYTE_TO_CODE["v"] = 47;
         BYTE_TO_CODE["w"] = 48;
         BYTE_TO_CODE["x"] = 49;
         BYTE_TO_CODE["y"] = 50;
         BYTE_TO_CODE["z"] = 51;
         BYTE_TO_CODE["0"] = 52;
         BYTE_TO_CODE["1"] = 53;
         BYTE_TO_CODE["2"] = 54;
         BYTE_TO_CODE["3"] = 55;
         BYTE_TO_CODE["4"] = 56;
         BYTE_TO_CODE["5"] = 57;
         BYTE_TO_CODE["6"] = 58;
         BYTE_TO_CODE["7"] = 59;
         BYTE_TO_CODE["8"] = 60;
         BYTE_TO_CODE["9"] = 61;
         BYTE_TO_CODE["+"] = 62;
         BYTE_TO_CODE["/"] = 63;
         BYTE_TO_CODE["="] = 64;
      }
      
      public function Base64()
      {
         super();
      }
      
      public static function Encode(input:ByteArray) : ByteArray
      {
         var i:int = 0;
         input.position = 0;
         var result:ByteArray = new ByteArray();
         result.endian = Endian.LITTLE_ENDIAN;
         while(input.bytesAvailable > 0)
         {
            m_ReadBuff.length = 0;
            i = 0;
            while(i < 3 && input.bytesAvailable > 0)
            {
               m_ReadBuff[i] = input.readUnsignedByte();
               i++;
            }
            m_WriteBuff.length = 0;
            m_WriteBuff[0] = (m_ReadBuff[0] & 252) >> 2;
            m_WriteBuff[1] = (m_ReadBuff[0] & 3) << 4 | m_ReadBuff[1] >> 4;
            m_WriteBuff[2] = (m_ReadBuff[1] & 15) << 2 | m_ReadBuff[2] >> 6;
            m_WriteBuff[3] = m_ReadBuff[2] & 63;
            for(i = m_ReadBuff.length; i < 3; i++)
            {
               m_WriteBuff[i + 1] = 64;
            }
            for(i = 0; i < m_WriteBuff.length; i++)
            {
               result.writeUTFBytes(CODE_TO_BYTE[m_WriteBuff[i]]);
            }
         }
         input.position = 0;
         result.position = 0;
         return result;
      }
      
      public static function Decode(input:ByteArray) : ByteArray
      {
         var j:int = 0;
         input.position = 0;
         var result:ByteArray = new ByteArray();
         result.endian = Endian.LITTLE_ENDIAN;
         var numBytes:int = input.length;
         for(var i:int = 0; i < numBytes; i += 4)
         {
            m_ReadBuff.length = 0;
            for(j = 0; j < 4; j++)
            {
               m_ReadBuff[j] = BYTE_TO_CODE[String.fromCharCode(input.readUnsignedByte())];
            }
            m_WriteBuff.length = 0;
            m_WriteBuff[0] = (m_ReadBuff[0] << 2) + ((m_ReadBuff[1] & 48) >> 4);
            m_WriteBuff[1] = ((m_ReadBuff[1] & 15) << 4) + ((m_ReadBuff[2] & 60) >> 2);
            m_WriteBuff[2] = ((m_ReadBuff[2] & 3) << 6) + m_ReadBuff[3];
            for(j = 0; j < m_WriteBuff.length; j++)
            {
               if(m_ReadBuff[j + 1] == 64)
               {
                  break;
               }
               result.writeByte(m_WriteBuff[j]);
            }
         }
         input.position = 0;
         result.position = 0;
         return result;
      }
      
      public static function DecodeString(input:String) : ByteArray
      {
         var tmp:ByteArray = new ByteArray();
         tmp.endian = Endian.LITTLE_ENDIAN;
         var numChars:int = input.length;
         var finalString:String = "";
         for(var i:int = 0; i < numChars; i++)
         {
            if(input.charAt(i) == " ")
            {
               finalString += "+";
            }
            else
            {
               finalString += input.charAt(i);
            }
         }
         tmp.writeUTFBytes(finalString);
         return Decode(tmp);
      }
   }
}
