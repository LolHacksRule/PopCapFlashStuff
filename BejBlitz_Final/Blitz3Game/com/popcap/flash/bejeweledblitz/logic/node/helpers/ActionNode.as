package com.popcap.flash.bejeweledblitz.logic.node.helpers
{
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import flash.utils.Dictionary;
   
   public class ActionNode extends ProcessableNode
   {
       
      
      public var mParams:Dictionary;
      
      public var mBlitzLogic:BlitzLogic = null;
      
      public function ActionNode()
      {
         super();
         this.mParams = new Dictionary();
      }
      
      public function InitAction(param1:String, param2:BlitzLogic) : void
      {
         super.Init(param1);
         this.mBlitzLogic = param2;
      }
      
      override public function SetAValue(param1:ProcessableNode) : void
      {
         this.mParams[param1.GetName()] = param1;
      }
      
      public function DoAction() : ParameterNode
      {
         return null;
      }
      
      public function CleanAction() : void
      {
      }
      
      override public function GetType() : String
      {
         return NODETYPE_ACTION;
      }
      
      public function GetParamByName(param1:String) : ProcessableNode
      {
         if(this.mParams[param1])
         {
            this.mParams[param1].SetId(this.mId);
            return this.mParams[param1];
         }
         return null;
      }
   }
}
