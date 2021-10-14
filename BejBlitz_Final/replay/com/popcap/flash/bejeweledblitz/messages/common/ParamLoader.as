package com.popcap.flash.bejeweledblitz.messages.common
{
   public class ParamLoader
   {
       
      
      private var m_Params:Object;
      
      public function ParamLoader(params:Object)
      {
         super();
         this.m_Params = params;
      }
      
      public function getParamStr(param:String) : String
      {
         return String(this.validateParam(param));
      }
      
      public function getParamInt(param:String) : int
      {
         return int(this.validateParam(param));
      }
      
      public function getParamBool(param:String) : Boolean
      {
         return this.validateParam(param) == "true" ? Boolean(true) : Boolean(false);
      }
      
      public function hasParam(param:String) : Boolean
      {
         return this.m_Params[param] == null ? Boolean(false) : Boolean(true);
      }
      
      public function toString() : Object
      {
         var param:* = null;
         var output:String = "Params:";
         for(param in this.m_Params)
         {
            output += "\n\t" + param + "=" + this.m_Params[param];
         }
         return output;
      }
      
      private function validateParam(param:String) : String
      {
         var p:String = this.m_Params[param];
         if(p == null)
         {
            throw new Error("failed to find parameter: " + param);
         }
         return p;
      }
   }
}
