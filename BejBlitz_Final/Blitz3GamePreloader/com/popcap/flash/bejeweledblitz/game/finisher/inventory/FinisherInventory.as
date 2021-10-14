package com.popcap.flash.bejeweledblitz.game.finisher.inventory
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   
   public class FinisherInventory
   {
       
      
      private var offers:Vector.<FinisherItemOffer>;
      
      public function FinisherInventory(param1:Object)
      {
         super();
         this.offers = new Vector.<FinisherItemOffer>();
         this.Parse(param1);
      }
      
      public function GetAvailableFinisher() : String
      {
         if(!Blitz3App.app.sessionData.configManager.GetFlag(ConfigManager.FLAG_TUTORIAL_COMPLETE) || Blitz3App.app.isDailyChallengeGame() || Blitz3App.app.isMultiplayerGame())
         {
            return "";
         }
         var _loc1_:FinisherItemOffer = this.GetOffer();
         if(_loc1_ == null || !_loc1_.IsValid())
         {
            return "";
         }
         return _loc1_.GetInventoryItem().GetFinisherName();
      }
      
      public function Consume(param1:String) : void
      {
         var _loc2_:FinisherItemOffer = this.GetOffer();
         if(_loc2_ != null)
         {
            _loc2_.Consume(param1);
         }
      }
      
      private function GetOffer() : FinisherItemOffer
      {
         var _loc1_:int = this.offers.length;
         if(_loc1_ == 0)
         {
            return null;
         }
         return this.offers[_loc1_ - 1];
      }
      
      private function Parse(param1:Object) : void
      {
         var offer:Object = null;
         var data:Object = param1;
         var itemOffer:Array = Utils.getArrayFromObjectKey(data,"inventory");
         for each(offer in itemOffer)
         {
            this.offers.push(new FinisherItemOffer(offer));
         }
         this.offers.sort(function(param1:FinisherItemOffer, param2:FinisherItemOffer):int
         {
            if(param1.GetExpiryTime() < param2.GetExpiryTime())
            {
               return -1;
            }
            if(param1.GetExpiryTime() > param2.GetExpiryTime())
            {
               return 1;
            }
            return 0;
         });
      }
   }
}
