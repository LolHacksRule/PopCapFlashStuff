package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.Utils;
   
   public class BoostUIParameterInfo
   {
       
      
      private var mName:String = "";
      
      private var mDisplayName:String = "";
      
      private var mUnit:String = "";
      
      private var mDefaultValue:Number = 0;
      
      private var mDivisionFactor:Number = 1;
      
      public function BoostUIParameterInfo(param1:Array)
      {
         var paramsArray:Array = param1;
         super();
         try
         {
            this.Parse(paramsArray);
         }
         catch(e:Error)
         {
            throw new Error("Boost UI param parsing failed : trace " + e.getStackTrace());
         }
      }
      
      private function Parse(param1:Array) : void
      {
         var _loc5_:* = null;
         var _loc6_:Object = null;
         var _loc7_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_)
            {
               break;
            }
            for(_loc5_ in param1[_loc4_])
            {
               if((_loc6_ = param1[_loc4_][_loc5_]).primary && _loc6_.primary.Boolean)
               {
                  if(_loc7_ = Utils.getBoolFromObjectKey(_loc6_.primary.Boolean,"value",false))
                  {
                     this.mName = _loc6_.name;
                     this.mDisplayName = Utils.getStringFromObjectKey(_loc6_.displayName.String,"value","CHANCE");
                     this.mUnit = Utils.getStringFromObjectKey(_loc6_.unit.String,"value","%");
                     if(this.mUnit == "Secs" || this.mUnit == "s" || this.mUnit == "secs" || this.mUnit == "sec" || this.mUnit == "Sec")
                     {
                        this.mDivisionFactor = 100;
                        this.mUnit = "s";
                     }
                     this.mDefaultValue = Utils.getNumberFromObjectKey(_loc6_,"value",0);
                     _loc2_ = true;
                     break;
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public function getParamKey() : String
      {
         return this.mName;
      }
      
      public function getParamDisplayName() : String
      {
         return this.mDisplayName;
      }
      
      public function getDefaultValue() : Number
      {
         return this.mDefaultValue;
      }
      
      public function getDivisionFactor() : Number
      {
         return this.mDivisionFactor;
      }
      
      public function getParamUnit() : String
      {
         return this.mUnit;
      }
   }
}
