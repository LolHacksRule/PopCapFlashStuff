package com.adobe.serialization.json
{
   public class §_-Le§
   {
       
      
      private var §_-i§:int;
      
      private var §_-3z§:String;
      
      private var obj:Object;
      
      private var §_-9a§:String;
      
      public function §_-Le§(param1:String)
      {
         super();
         §_-9a§ = param1;
         §_-i§ = 0;
         §each §();
      }
      
      private function §_-3P§() : void
      {
         if(§_-3z§ == "/")
         {
            §each §();
            switch(§_-3z§)
            {
               case "/":
                  do
                  {
                     §each §();
                  }
                  while(§_-3z§ != "\n" && §_-3z§ != "");
                  
                  §each §();
                  break;
               case "*":
                  §each §();
                  while(true)
                  {
                     if(§_-3z§ == "*")
                     {
                        §each §();
                        if(§_-3z§ == "/")
                        {
                           break;
                        }
                     }
                     else
                     {
                        §each §();
                     }
                     if(§_-3z§ == "")
                     {
                        §_-0-§("Multi-line comment not closed");
                     }
                  }
                  §each §();
                  break;
               default:
                  §_-0-§("Unexpected " + §_-3z§ + " encountered (expecting \'/\' or \'*\' )");
            }
         }
      }
      
      private function §_-iM§(param1:String) : Boolean
      {
         return param1 >= "0" && param1 <= "9";
      }
      
      private function §_-XW§() : §_-5s§
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc1_:§_-5s§ = new §_-5s§();
         _loc1_.type = §_-K0§.§_-BP§;
         var _loc2_:* = "";
         §each §();
         while(§_-3z§ != "\"" && §_-3z§ != "")
         {
            if(§_-3z§ == "\\")
            {
               §each §();
               switch(§_-3z§)
               {
                  case "\"":
                     _loc2_ += "\"";
                     break;
                  case "/":
                     _loc2_ += "/";
                     break;
                  case "\\":
                     _loc2_ += "\\";
                     break;
                  case "b":
                     _loc2_ += "\b";
                     break;
                  case "f":
                     _loc2_ += "\f";
                     break;
                  case "n":
                     _loc2_ += "\n";
                     break;
                  case "r":
                     _loc2_ += "\r";
                     break;
                  case "t":
                     _loc2_ += "\t";
                     break;
                  case "u":
                     _loc3_ = "";
                     _loc4_ = 0;
                     while(_loc4_ < 4)
                     {
                        if(!§_-UX§(§each §()))
                        {
                           §_-0-§(" Excepted a hex digit, but found: " + §_-3z§);
                        }
                        _loc3_ += §_-3z§;
                        _loc4_++;
                     }
                     _loc2_ += String.fromCharCode(parseInt(_loc3_,16));
                     break;
                  default:
                     _loc2_ += "\\" + §_-3z§;
               }
            }
            else
            {
               _loc2_ += §_-3z§;
            }
            §each §();
         }
         if(§_-3z§ == "")
         {
            §_-0-§("Unterminated string literal");
         }
         §each §();
         _loc1_.value = _loc2_;
         return _loc1_;
      }
      
      private function §each §() : String
      {
         return §_-3z§ = §_-9a§.charAt(§_-i§++);
      }
      
      public function §_-Bv§() : §_-5s§
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc1_:§_-5s§ = new §_-5s§();
         §_-Mf§();
         switch(§_-3z§)
         {
            case "{":
               _loc1_.type = §_-K0§.LEFT_BRACE;
               _loc1_.value = "{";
               §each §();
               break;
            case "}":
               _loc1_.type = §_-K0§.RIGHT_BRACE;
               _loc1_.value = "}";
               §each §();
               break;
            case "[":
               _loc1_.type = §_-K0§.LEFT_BRACKET;
               _loc1_.value = "[";
               §each §();
               break;
            case "]":
               _loc1_.type = §_-K0§.RIGHT_BRACKET;
               _loc1_.value = "]";
               §each §();
               break;
            case ",":
               _loc1_.type = §_-K0§.COMMA;
               _loc1_.value = ",";
               §each §();
               break;
            case ":":
               _loc1_.type = §_-K0§.COLON;
               _loc1_.value = ":";
               §each §();
               break;
            case "t":
               _loc2_ = "t" + §each §() + §each §() + §each §();
               if(_loc2_ == "true")
               {
                  _loc1_.type = §_-K0§.§_-nI§;
                  _loc1_.value = true;
                  §each §();
               }
               else
               {
                  §_-0-§("Expecting \'true\' but found " + _loc2_);
               }
               break;
            case "f":
               _loc3_ = "f" + §each §() + §each §() + §each §() + §each §();
               if(_loc3_ == "false")
               {
                  _loc1_.type = §_-K0§.§_-ly§;
                  _loc1_.value = false;
                  §each §();
               }
               else
               {
                  §_-0-§("Expecting \'false\' but found " + _loc3_);
               }
               break;
            case "n":
               if((_loc4_ = "n" + §each §() + §each §() + §each §()) == "null")
               {
                  _loc1_.type = §_-K0§.§_-Ua§;
                  _loc1_.value = null;
                  §each §();
               }
               else
               {
                  §_-0-§("Expecting \'null\' but found " + _loc4_);
               }
               break;
            case "\"":
               _loc1_ = §_-XW§();
               break;
            default:
               if(§_-iM§(§_-3z§) || §_-3z§ == "-")
               {
                  _loc1_ = §_-nR§();
               }
               else
               {
                  if(§_-3z§ == "")
                  {
                     return null;
                  }
                  §_-0-§("Unexpected " + §_-3z§ + " encountered");
               }
         }
         return _loc1_;
      }
      
      private function §_-8e§() : void
      {
         while(§_-1J§(§_-3z§))
         {
            §each §();
         }
      }
      
      public function §_-0-§(param1:String) : void
      {
         throw new §_-YN§(param1,§_-i§,§_-9a§);
      }
      
      private function §_-1J§(param1:String) : Boolean
      {
         return param1 == " " || param1 == "\t" || param1 == "\n";
      }
      
      private function §_-Mf§() : void
      {
         §_-8e§();
         §_-3P§();
         §_-8e§();
      }
      
      private function §_-UX§(param1:String) : Boolean
      {
         var _loc2_:String = param1.toUpperCase();
         return §_-iM§(param1) || _loc2_ >= "A" && _loc2_ <= "F";
      }
      
      private function §_-nR§() : §_-5s§
      {
         var _loc1_:§_-5s§ = new §_-5s§();
         _loc1_.type = §_-K0§.§_-bT§;
         var _loc2_:* = "";
         if(§_-3z§ == "-")
         {
            _loc2_ += "-";
            §each §();
         }
         if(!§_-iM§(§_-3z§))
         {
            §_-0-§("Expecting a digit");
         }
         if(§_-3z§ == "0")
         {
            _loc2_ += §_-3z§;
            §each §();
            if(§_-iM§(§_-3z§))
            {
               §_-0-§("A digit cannot immediately follow 0");
            }
         }
         else
         {
            while(§_-iM§(§_-3z§))
            {
               _loc2_ += §_-3z§;
               §each §();
            }
         }
         if(§_-3z§ == ".")
         {
            _loc2_ += ".";
            §each §();
            if(!§_-iM§(§_-3z§))
            {
               §_-0-§("Expecting a digit");
            }
            while(§_-iM§(§_-3z§))
            {
               _loc2_ += §_-3z§;
               §each §();
            }
         }
         if(§_-3z§ == "e" || §_-3z§ == "E")
         {
            _loc2_ += "e";
            §each §();
            if(§_-3z§ == "+" || §_-3z§ == "-")
            {
               _loc2_ += §_-3z§;
               §each §();
            }
            if(!§_-iM§(§_-3z§))
            {
               §_-0-§("Scientific notation number needs exponent value");
            }
            while(§_-iM§(§_-3z§))
            {
               _loc2_ += §_-3z§;
               §each §();
            }
         }
         var _loc3_:Number = Number(_loc2_);
         if(isFinite(_loc3_) && !isNaN(_loc3_))
         {
            _loc1_.value = _loc3_;
            return _loc1_;
         }
         §_-0-§("Number " + _loc3_ + " is not valid!");
         return null;
      }
   }
}
