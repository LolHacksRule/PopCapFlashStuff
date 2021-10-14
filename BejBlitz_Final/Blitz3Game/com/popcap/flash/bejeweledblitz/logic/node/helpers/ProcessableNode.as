package com.popcap.flash.bejeweledblitz.logic.node.helpers
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   
   public class ProcessableNode
   {
      
      public static const NODETYPE_NONE:String = "none";
      
      public static const NODETYPE_PARAMATER:String = "parameter";
      
      public static const NODETYPE_ACTION:String = "action";
       
      
      public var nodeName:String;
      
      public var mId:String;
      
      public var mRNGType:int;
      
      public function ProcessableNode()
      {
         super();
         this.mRNGType = BlitzRNGManager.RNG_BLITZ_SECONDARY;
      }
      
      public function Init(param1:String) : void
      {
         this.nodeName = param1;
      }
      
      public function GetType() : String
      {
         return NODETYPE_NONE;
      }
      
      public function GetName() : String
      {
         return this.nodeName;
      }
      
      public function SetName(param1:String) : void
      {
         this.nodeName = param1;
      }
      
      public function DoActionOrGetValue() : ParameterNode
      {
         if(this as ActionNode != null)
         {
            return (this as ActionNode).DoAction();
         }
         if(this as ParameterHolderNode)
         {
            return (this as ParameterHolderNode).GetValue();
         }
         return null;
      }
      
      public function DoCleanUp() : void
      {
      }
      
      public function SetValue(param1:Vector.<ProcessableNode>) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.SetAValue(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function SetAValue(param1:ProcessableNode) : void
      {
      }
      
      public function SetId(param1:String) : void
      {
         this.mId = param1;
      }
      
      public function Reset() : void
      {
      }
      
      public function SetRNGType(param1:int) : void
      {
         this.mRNGType = param1;
      }
   }
}
