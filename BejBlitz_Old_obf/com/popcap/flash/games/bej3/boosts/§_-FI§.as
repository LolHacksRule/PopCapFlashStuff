package com.popcap.flash.games.bej3.boosts
{
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.IBlitzLogicHandler;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.utils.Dictionary;
   
   public class §_-FI§ implements IBlitzLogicHandler
   {
       
      
      public var §_-SM§:Vector.<IBoost>;
      
      private var §_-IK§:Dictionary;
      
      private var §_-Yq§:Array;
      
      private var §_-Lp§:§_-0Z§ = null;
      
      private var §_-NI§:Vector.<String>;
      
      public function §_-FI§(param1:§_-0Z§)
      {
         this.§_-Yq§ = [];
         this.§_-IK§ = new Dictionary();
         this.§_-NI§ = new Vector.<String>();
         this.§_-SM§ = new Vector.<IBoost>();
         super();
         this.§_-Lp§ = param1;
         this.§_-i2§(new §_-ia§(this.§_-Lp§));
         this.§_-i2§(new §_-of§(this.§_-Lp§));
         this.§_-i2§(new §_-kT§(this.§_-Lp§));
         this.§_-i2§(new §_-b4§(this.§_-Lp§));
         this.§_-i2§(new §_-8r§(this.§_-Lp§));
         this.§_-i2§(new §_-FA§(this.§_-Lp§));
      }
      
      public function GetBoostOrderingIDFromStringID(param1:String) : int
      {
         return IBoost(this.§_-Yq§[this.§_-IK§[param1]]).§_-Iu§();
      }
      
      public function §_-i2§(param1:IBoost) : void
      {
         this.§_-Yq§[param1.§_-dW§()] = param1;
         this.§_-IK§[param1.§_-eA§()] = param1.§_-dW§();
      }
      
      public function §_-2a§(param1:int) : void
      {
         this.§_-SM§.push(this.§_-Yq§[param1]);
      }
      
      public function §_-ZA§(param1:String) : int
      {
         return this.§_-IK§[param1];
      }
      
      public function §_-hF§() : String
      {
         var _loc1_:IBoost = null;
         for each(_loc1_ in this.§_-SM§)
         {
            if(_loc1_.IsRareGem())
            {
               return _loc1_.§_-eA§();
            }
         }
         return "NONE";
      }
      
      public function §_-Rj§(param1:String) : IBoost
      {
         var _loc2_:int = this.§_-IK§[param1];
         return this.§_-Yq§[_loc2_];
      }
      
      public function §_-Um§() : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:IBoost = null;
         this.§_-SM§.length = 0;
         if(this.§_-Lp§.logic.§_-aZ§)
         {
            return;
         }
         var _loc1_:int = this.§_-NI§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-NI§[_loc2_];
            _loc4_ = this.§_-IK§[_loc3_];
            _loc5_ = this.§_-Yq§[_loc4_];
            this.§_-SM§.push(_loc5_);
            _loc2_++;
         }
      }
      
      public function §_-fD§() : void
      {
         this.§_-SM§.length = 0;
      }
      
      public function IsRareGem(param1:String) : Boolean
      {
         return IBoost(this.§_-Yq§[this.§_-IK§[param1]]).IsRareGem();
      }
      
      public function ClearQueue() : void
      {
         this.§_-NI§.length = 0;
      }
      
      public function §_-St§(param1:int) : IBoost
      {
         return this.§_-Yq§[param1];
      }
      
      public function Init() : void
      {
         this.§_-Lp§.logic.AddBlitzLogicHandler(this);
      }
      
      public function QueueBoost(param1:String) : void
      {
         this.§_-NI§.push(param1);
      }
      
      public function §_-BR§() : void
      {
         var _loc3_:IBoost = null;
         var _loc4_:String = null;
         var _loc1_:int = this.§_-SM§.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.§_-SM§[_loc2_];
            _loc4_ = _loc3_.§_-eA§();
            _loc3_.§_-TR§();
            this.§_-Lp§.logic.§_-IN§(BlitzLogic.§_-bs§,this.§_-IK§[_loc4_]);
            _loc2_++;
         }
      }
   }
}
