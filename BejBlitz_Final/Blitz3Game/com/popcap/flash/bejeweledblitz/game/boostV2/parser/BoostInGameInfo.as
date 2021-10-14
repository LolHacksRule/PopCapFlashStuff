package com.popcap.flash.bejeweledblitz.game.boostV2.parser
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.NodeManager;
   import com.popcap.flash.bejeweledblitz.logic.BlitzRNGManager;
   import com.popcap.flash.bejeweledblitz.logic.boostV2.BoostV2;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ActionNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterHolderNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ParameterNode;
   import com.popcap.flash.bejeweledblitz.logic.node.helpers.ProcessableNode;
   
   public class BoostInGameInfo extends BoostV2
   {
       
      
      var mParticleFeedback:BoostParticleInfo = null;
      
      public function BoostInGameInfo(param1:Object)
      {
         var config:Object = param1;
         super(Blitz3App.app.logic);
         try
         {
            this.Parse(config);
         }
         catch(e:Error)
         {
            throw new Error("Boost parsing failed : " + mId + " trace " + e.getStackTrace());
         }
      }
      
      public function GetParams() : Vector.<ParameterHolderNode>
      {
         return mParameters;
      }
      
      private function Parse(param1:Object) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:Object = null;
         var _loc7_:ParameterHolderNode = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:Vector.<ActionNode> = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:Vector.<ProcessableNode> = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:Array = null;
         var _loc19_:int = 0;
         var _loc20_:String = null;
         var _loc21_:Array = null;
         var _loc22_:int = 0;
         var _loc23_:Array = null;
         var _loc24_:int = 0;
         var _loc25_:Array = null;
         var _loc26_:int = 0;
         var _loc27_:Array = null;
         var _loc28_:int = 0;
         mId = Utils.getStringFromObjectKey(param1.Root.Id.String,"value","id");
         var _loc2_:int = 0;
         if(param1.Root.Parameters.Array)
         {
            _loc3_ = Utils.getArrayFromObjectKey(param1.Root.Parameters.Array,"value");
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.length;
               _loc2_ = 0;
               while(_loc2_ < _loc4_)
               {
                  for(_loc5_ in _loc3_[_loc2_])
                  {
                     _loc6_ = _loc3_[_loc2_][_loc5_];
                     _loc7_ = Utils.createParameterHolderNode(_loc6_,BlitzRNGManager.RNG_BLITZ_SECONDARY);
                     mParameters.push(_loc7_);
                  }
                  _loc2_++;
               }
            }
         }
         if(param1.Root.Upgrade && param1.Root.Upgrade.Array)
         {
            _loc9_ = (_loc8_ = Utils.getArrayFromObjectKey(param1.Root.Upgrade.Array,"value")).length;
            _loc2_ = 0;
            while(_loc2_ < _loc9_)
            {
               _loc10_ = _loc8_[_loc2_].UpgradeLevel;
               _loc11_ = new Vector.<ActionNode>();
               if(_loc10_.value.Array)
               {
                  if((_loc12_ = Utils.getArrayFromObjectKey(_loc10_.value.Array,"value")) != null && _loc12_.length > 0)
                  {
                     _loc13_ = _loc12_.length;
                     _loc14_ = 0;
                     while(_loc14_ < _loc13_)
                     {
                        _loc16_ = (_loc15_ = this.CreateProcessableNodes(_loc12_[_loc14_],BlitzRNGManager.RNG_BLITZ_SECONDARY)).length;
                        _loc17_ = 0;
                        while(_loc17_ < _loc16_)
                        {
                           if(_loc15_[_loc17_] as ActionNode != null)
                           {
                              _loc11_.push(_loc15_[_loc17_] as ActionNode);
                           }
                           _loc17_++;
                        }
                        _loc14_++;
                     }
                  }
               }
               mUpgrades.push(_loc11_);
               _loc2_++;
            }
         }
         if(param1.Root.Compute && param1.Root.Compute.Array)
         {
            _loc19_ = (_loc18_ = Utils.getArrayFromObjectKey(param1.Root.Compute.Array,"value")).length;
            _loc2_ = 0;
            while(_loc2_ < _loc19_)
            {
               _loc10_ = _loc18_[_loc2_].ComputeLevel;
               if((_loc20_ = Utils.getStringFromObjectKey(_loc10_.event.GlobalEvents,"value","")).length > 0)
               {
                  _loc11_ = new Vector.<ActionNode>();
                  if(_loc10_.value.Array)
                  {
                     if((_loc21_ = Utils.getArrayFromObjectKey(_loc10_.value.Array,"value")) != null && _loc21_.length > 0)
                     {
                        _loc22_ = _loc21_.length;
                        _loc14_ = 0;
                        while(_loc14_ < _loc22_)
                        {
                           _loc16_ = (_loc15_ = this.CreateProcessableNodes(_loc21_[_loc14_],BlitzRNGManager.RNG_BLITZ_BOOSTS)).length;
                           _loc17_ = 0;
                           while(_loc17_ < _loc16_)
                           {
                              if(_loc15_[_loc17_] as ActionNode != null)
                              {
                                 _loc11_.push(_loc15_[_loc17_] as ActionNode);
                              }
                              _loc17_++;
                           }
                           _loc14_++;
                        }
                     }
                  }
                  else
                  {
                     _loc11_ = new Vector.<ActionNode>();
                     _loc16_ = (_loc15_ = this.CreateProcessableNodes(_loc10_.value,BlitzRNGManager.RNG_BLITZ_BOOSTS)).length;
                     _loc17_ = 0;
                     while(_loc17_ < _loc15_.length)
                     {
                        if(_loc15_[_loc17_] as ActionNode != null)
                        {
                           _loc11_.push(_loc15_[_loc17_] as ActionNode);
                        }
                        _loc17_++;
                     }
                  }
                  mComputes[_loc20_] = _loc11_;
               }
               _loc2_++;
            }
         }
         if(param1.Root.Activation && param1.Root.Activation.Array)
         {
            _loc24_ = (_loc23_ = Utils.getArrayFromObjectKey(param1.Root.Activation.Array,"value")).length;
            _loc2_ = 0;
            while(_loc2_ < _loc24_)
            {
               _loc10_ = _loc23_[_loc2_].ActivationLevel;
               _loc20_ = Utils.getStringFromObjectKey(_loc10_.event.GlobalEvents,"value","");
               _loc11_ = new Vector.<ActionNode>();
               if(_loc20_.length > 0)
               {
                  if(_loc10_.value.Array)
                  {
                     if((_loc25_ = Utils.getArrayFromObjectKey(_loc10_.value.Array,"value")) != null && _loc25_.length > 0)
                     {
                        _loc26_ = _loc25_.length;
                        _loc14_ = 0;
                        while(_loc14_ < _loc26_)
                        {
                           _loc15_ = this.CreateProcessableNodes(_loc25_[_loc14_],BlitzRNGManager.RNG_BLITZ_SECONDARY);
                           _loc17_ = 0;
                           while(_loc17_ < _loc15_.length)
                           {
                              if(_loc15_[_loc17_] as ActionNode != null)
                              {
                                 _loc11_.push(_loc15_[_loc17_] as ActionNode);
                              }
                              _loc17_++;
                           }
                           _loc14_++;
                        }
                     }
                  }
                  mActivations[_loc20_] = _loc11_;
               }
               _loc2_++;
            }
         }
         if(param1.Root.Actions.Array)
         {
            if((_loc27_ = Utils.getArrayFromObjectKey(param1.Root.Actions.Array,"value")) != null)
            {
               _loc28_ = _loc27_.length;
               _loc2_ = 0;
               while(_loc2_ < _loc28_)
               {
                  _loc16_ = (_loc15_ = this.CreateProcessableNodes(_loc27_[_loc2_],BlitzRNGManager.RNG_BLITZ_BOOSTS)).length;
                  _loc17_ = 0;
                  while(_loc17_ < _loc16_)
                  {
                     if(_loc15_[_loc17_] as ActionNode != null)
                     {
                        mActions.push(_loc15_[_loc17_] as ActionNode);
                     }
                     _loc17_++;
                  }
                  _loc2_++;
               }
            }
         }
         if(param1.Root.Classic)
         {
            mIsClassic = true;
         }
         if(param1.Root.ParticleFeedback)
         {
            this.mParticleFeedback = new BoostParticleInfo(param1.Root.ParticleFeedback);
         }
      }
      
      public function GetParticleFeedback() : BoostParticleInfo
      {
         return this.mParticleFeedback;
      }
      
      private function CreateProcessableNodes(param1:Object, param2:int, param3:String = null) : Vector.<ProcessableNode>
      {
         var _loc5_:* = null;
         var _loc6_:ProcessableNode = null;
         var _loc7_:* = null;
         var _loc8_:Vector.<ProcessableNode> = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:ParameterHolderNode = null;
         var _loc12_:Object = null;
         var _loc13_:ParameterNode = null;
         var _loc4_:Vector.<ProcessableNode> = new Vector.<ProcessableNode>();
         for(_loc5_ in param1)
         {
            if(_loc5_ != "pos")
            {
               _loc6_ = null;
               if(_loc5_.indexOf("Action") >= 0)
               {
                  _loc6_ = NodeManager.GetRegisteredActionByName(_loc5_,mBlitzLogic);
                  if(param3 != null)
                  {
                     _loc6_.SetName(param3);
                  }
                  for(_loc7_ in param1[_loc5_])
                  {
                     if(_loc7_ != "pos")
                     {
                        _loc8_ = this.CreateProcessableNodes(param1[_loc5_][_loc7_],param2,_loc7_);
                        (_loc6_ as ActionNode).SetValue(_loc8_);
                     }
                  }
                  _loc6_.SetRNGType(param2);
                  _loc4_.push(_loc6_);
               }
               else if(_loc5_ == "LocalProperties")
               {
                  _loc9_ = mParameters.length;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     if(mParameters[_loc10_].GetName() == Utils.getStringFromObjectKey(param1[_loc5_],"value",""))
                     {
                        (_loc11_ = new ParameterHolderNode(param3,mParameters[_loc10_])).SetRNGType(param2);
                        _loc4_.push(_loc11_);
                     }
                     _loc10_++;
                  }
               }
               else
               {
                  _loc12_ = param1[_loc5_];
                  if(param3 == null)
                  {
                     _loc13_ = Utils.getDecisionV2DataType(_loc12_,BlitzRNGManager.RNG_BLITZ_SECONDARY);
                     _loc4_.push(_loc13_);
                  }
                  else
                  {
                     _loc12_.name = param3;
                     _loc4_.push(Utils.createParameterHolderNode(_loc12_,BlitzRNGManager.RNG_BLITZ_SECONDARY));
                  }
               }
            }
         }
         return _loc4_;
      }
   }
}
