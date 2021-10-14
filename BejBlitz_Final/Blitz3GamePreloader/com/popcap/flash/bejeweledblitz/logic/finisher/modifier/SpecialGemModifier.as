package com.popcap.flash.bejeweledblitz.logic.finisher.modifier
{
   import com.popcap.flash.bejeweledblitz.logic.BlitzRandom;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.finisher.GemData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.DynamicRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.MoonstoneRGLogic;
   import com.popcap.flash.bejeweledblitz.logic.raregems.PhoenixPrismRGLogic;
   import com.popcap.flash.framework.math.MersenneTwister;
   
   public class SpecialGemModifier implements IGemModifier
   {
       
      
      private var modifierMap:Vector.<GemData>;
      
      private var maxWeight:int;
      
      private var _logic:BlitzLogic = null;
      
      private var _initialized:Boolean = false;
      
      private var _random:BlitzRandom;
      
      public function SpecialGemModifier(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
         this.modifierMap = new Vector.<GemData>();
         this.maxWeight = 0;
         this._random = new BlitzRandom(new MersenneTwister());
         this._random.SetSeed(this._logic.GetCurrentSeed());
         this._initialized = true;
      }
      
      public function AddGemData(param1:GemData) : void
      {
         this.modifierMap.push(param1);
         this.AddModifier(param1.gem_weight);
      }
      
      public function ConvertGem(param1:Gem) : void
      {
         var _loc5_:GemData = null;
         var _loc6_:Number = NaN;
         if(!this._initialized)
         {
            return;
         }
         var _loc2_:Number = this._random.Float(0,1) * this.maxWeight;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this.modifierMap.length)
         {
            _loc6_ = (_loc5_ = this.modifierMap[_loc4_]).gem_weight + _loc3_;
            if(_loc2_ < _loc6_)
            {
               this.ExplodeGem(param1,_loc5_.gem_type);
               return;
            }
            _loc3_ = _loc6_;
            _loc4_++;
         }
      }
      
      private function ExplodeGem(param1:Gem, param2:int) : void
      {
         var _loc4_:DynamicRGLogic = null;
         if(param2 == Gem.TYPE_RAREGEM)
         {
            if(this._logic.rareGemsLogic.hasCurrentRareGem())
            {
               if(_loc4_ = this._logic.rareGemsLogic.currentRareGem as DynamicRGLogic)
               {
                  if(this._logic.rareGemsLogic.currentRareGem.isTokenRareGem())
                  {
                     param2 = Gem.TYPE_TOKENGEM;
                  }
                  else
                  {
                     if(param1)
                     {
                        param1.color = _loc4_.getFlameColor();
                     }
                     param2 = Gem.TYPE_FLAME;
                  }
               }
               else if(this._logic.rareGemsLogic.currentRareGem.getStringID() == PhoenixPrismRGLogic.ID)
               {
                  param2 = Gem.TYPE_PHOENIXPRISM;
               }
               else if(this._logic.rareGemsLogic.currentRareGem.getStringID() == MoonstoneRGLogic.ID)
               {
                  param2 = Gem.TYPE_STAR;
               }
               else
               {
                  param2 = Gem.TYPE_HYPERCUBE;
               }
            }
            else
            {
               param2 = Gem.TYPE_HYPERCUBE;
            }
         }
         if(param2 == Gem.TYPE_TOKENGEM)
         {
            this._logic.rareGemTokenLogic.SpawnRareGemTokenOnGem(param1);
         }
         else if(param2 == Gem.TYPE_PHOENIXPRISM)
         {
            this._logic.phoenixPrismLogic.UpgradeGem(param1,null,true);
         }
         else
         {
            param1.upgrade(param2,true);
         }
         var _loc3_:MoveData = this._logic.movePool.GetMove();
         _loc3_.sourceGem = param1;
         _loc3_.sourcePos.x = param1.col;
         _loc3_.sourcePos.y = param1.row;
         this._logic.AddMove(_loc3_);
         param1.SetFuseTime(50);
         param1.SetFuseWhenNotFalling();
         param1.moveID = _loc3_.id;
         param1.shatterColor = param1.color;
         param1.shatterType = param1.type;
         if(param1.type == Gem.TYPE_DETONATE || param1.type == Gem.TYPE_SCRAMBLE)
         {
            param1.baseValue = 1500;
         }
      }
      
      private function AddModifier(param1:Number) : void
      {
         this.maxWeight += param1;
      }
      
      public function GetName() : String
      {
         return "SpecialGemModifier";
      }
      
      public function Release() : void
      {
      }
   }
}
