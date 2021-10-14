package com.popcap.flash.bejeweledblitz.logic.node.actions
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.node.datatypes.StringDataTypeNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class ActionRandomizeBoardPatternPositionNode extends ActionNode
   {
       
      
      public function ActionRandomizeBoardPatternPositionNode(param1:BlitzLogic)
      {
         super();
         super.InitAction(GetActionType(),param1);
      }
      
      public static function GetActionType() : String
      {
         return "ActionRandomizeBoardPatternPosition";
      }
      
      override public function DoAction() : ParameterNode
      {
         var _loc17_:Boolean = false;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc1_:ProcessableNode = GetParamByName("pattern");
         if(_loc1_ == null)
         {
            return new StringDataTypeNode("");
         }
         var _loc2_:ParameterNode = _loc1_.DoActionOrGetValue();
         var _loc3_:String = (_loc2_ as StringDataTypeNode).dataValue;
         var _loc4_:ProcessableNode;
         var _loc5_:* = (_loc4_ = GetParamByName("skipmult")) == true;
         var _loc6_:int = 8;
         var _loc7_:int = -1;
         var _loc8_:int = 8;
         var _loc9_:int = -1;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < 8)
         {
            _loc11_ = 0;
            while(_loc11_ < 8)
            {
               if(_loc3_.charAt(_loc10_ + 8 * _loc11_) == "X")
               {
                  _loc6_ = _loc6_ < _loc10_ ? int(_loc6_) : int(_loc10_);
                  _loc7_ = _loc7_ > _loc10_ ? int(_loc7_) : int(_loc10_);
                  _loc8_ = _loc8_ < _loc11_ ? int(_loc8_) : int(_loc11_);
                  _loc9_ = _loc9_ > _loc11_ ? int(_loc9_) : int(_loc11_);
               }
               _loc11_++;
            }
            _loc10_++;
         }
         var _loc12_:int = _loc7_ - _loc6_ + 1;
         var _loc13_:int = _loc9_ - _loc8_ + 1;
         var _loc14_:int = _loc6_ - this.mBlitzLogic.GetPrimaryRNG().Int(0,8 - _loc12_);
         var _loc15_:int = _loc8_ - this.mBlitzLogic.GetPrimaryRNG().Int(0,8 - _loc13_);
         if(_loc5_)
         {
            _loc17_ = this.CanProcInRegion(_loc3_,_loc14_,_loc15_,true);
            _loc18_ = 1;
            while(!_loc17_)
            {
               _loc14_ = _loc6_ - mBlitzLogic.GetRNGOfType(mRNGType).Int(0,8 - _loc12_);
               _loc15_ = _loc8_ - mBlitzLogic.GetRNGOfType(mRNGType).Int(0,8 - _loc13_);
               _loc17_ = this.CanProcInRegion(_loc3_,_loc14_,_loc15_,true);
               _loc18_++;
               if(_loc18_ > 10)
               {
                  return null;
               }
            }
         }
         var _loc16_:String = "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO";
         _loc10_ = 0;
         while(_loc10_ < 8)
         {
            _loc11_ = 0;
            while(_loc11_ < 8)
            {
               if(_loc3_.charAt(_loc10_ + 8 * _loc11_) == "X")
               {
                  _loc19_ = _loc10_ - _loc14_ + 8 * (_loc11_ - _loc15_);
                  _loc16_ = Utils.setCharAt(_loc16_,_loc19_,"X");
               }
               _loc11_++;
            }
            _loc10_++;
         }
         return new StringDataTypeNode(_loc16_);
      }
      
      private function CanProcInRegion(param1:String, param2:int, param3:int, param4:Boolean) : Boolean
      {
         var _loc7_:int = 0;
         var _loc5_:Gem = null;
         var _loc6_:int = 0;
         while(_loc6_ < 8)
         {
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               if(param1.charAt(_loc6_ + 8 * _loc7_) == "X")
               {
                  if((_loc5_ = mBlitzLogic.board.GetGemAt(_loc7_ - param3,_loc6_ - param2)) == null || _loc5_.type == Gem.TYPE_MULTI || _loc5_.isStill() != param4)
                  {
                     return false;
                  }
               }
               _loc7_++;
            }
            _loc6_++;
         }
         return true;
      }
   }
}
