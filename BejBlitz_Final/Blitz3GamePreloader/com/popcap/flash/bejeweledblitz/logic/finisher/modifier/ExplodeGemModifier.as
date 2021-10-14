package com.popcap.flash.bejeweledblitz.logic.finisher.modifier
{
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.finisher.GemData;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   
   public class ExplodeGemModifier implements IGemModifier
   {
       
      
      private var _logic:BlitzLogic = null;
      
      public function ExplodeGemModifier(param1:BlitzLogic)
      {
         super();
         this._logic = param1;
      }
      
      public function AddGemData(param1:GemData) : void
      {
      }
      
      public function ConvertGem(param1:Gem) : void
      {
         param1.upgrade(param1.type,true);
         var _loc2_:MoveData = this._logic.movePool.GetMove();
         _loc2_.sourceGem = param1;
         _loc2_.sourcePos.x = param1.col;
         _loc2_.sourcePos.y = param1.row;
         this._logic.AddMove(_loc2_);
         param1.SetFuseTime(50);
         param1.SetFuseWhenNotFalling();
         param1.moveID = _loc2_.id;
         param1.shatterColor = param1.color;
         param1.shatterType = param1.type;
         if(param1.type == Gem.TYPE_DETONATE || param1.type == Gem.TYPE_SCRAMBLE)
         {
            param1.baseValue = 1500;
         }
      }
      
      public function GetName() : String
      {
         return "ExplodeGemModifier";
      }
      
      public function Release() : void
      {
      }
   }
}
