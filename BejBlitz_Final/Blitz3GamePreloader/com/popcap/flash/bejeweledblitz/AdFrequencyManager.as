package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   
   public class AdFrequencyManager
   {
       
      
      public var m_adFreqInfo:Vector.<AdFrequencyInfo>;
      
      public var mSpinBoardIdConsideredForAd:String;
      
      public function AdFrequencyManager()
      {
         super();
      }
      
      public function Init() : void
      {
         this.m_adFreqInfo = new Vector.<AdFrequencyInfo>();
      }
      
      public function parseAdFrequencyData(param1:String, param2:String) : void
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Object = new Object();
         if(param1 != "[]")
         {
            _loc4_ = JSON.parse(param1);
            _loc3_["placement"] = Blitz3Network.DS_PLACEMENT;
            _loc3_["adCap"] = _loc4_["dailySpin"]["adCap"];
            _loc3_["rewardCap"] = _loc4_["dailySpin"]["rewardCap"];
            this.m_adFreqInfo.push(new AdFrequencyInfo(_loc3_));
            _loc3_["placement"] = Blitz3Network.DC_PLACEMENT;
            _loc3_["adCap"] = _loc4_["dailyChallenge"]["adCap"];
            _loc3_["rewardCap"] = _loc4_["dailyChallenge"]["rewardCap"];
            this.m_adFreqInfo.push(new AdFrequencyInfo(_loc3_));
            _loc3_["placement"] = Blitz3Network.FREECHEST_PLACEMENT;
            _loc3_["adCap"] = _loc4_["giftBox"]["adCap"];
            _loc3_["rewardCap"] = _loc4_["giftBox"]["rewardCap"];
            this.m_adFreqInfo.push(new AdFrequencyInfo(_loc3_));
            _loc3_["placement"] = Blitz3Network.POSTGAME_PLACEMENT;
            _loc3_["adCap"] = _loc4_["2xCoins"]["adCap"];
            _loc3_["rewardCap"] = _loc4_["2xCoins"]["rewardCap"];
            this.m_adFreqInfo.push(new AdFrequencyInfo(_loc3_));
            _loc3_["placement"] = Blitz3Network.MAINMENU_PLACEMENT;
            _loc3_["adCap"] = _loc4_["freeCoins"]["adCap"];
            _loc3_["rewardCap"] = _loc4_["freeCoins"]["rewardCap"];
            this.m_adFreqInfo.push(new AdFrequencyInfo(_loc3_));
         }
         if(param2 != "[]")
         {
            _loc5_ = JSON.parse(param2);
            _loc6_ = this.m_adFreqInfo.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(this.m_adFreqInfo[_loc7_].placement == Blitz3Network.DS_PLACEMENT)
               {
                  this.m_adFreqInfo[_loc7_].adsRemaining = this.m_adFreqInfo[_loc7_].adCap - _loc5_["dailySpinV2"]["count"];
                  this.mSpinBoardIdConsideredForAd = _loc5_["dailySpinV2"]["boardId"];
               }
               else if(this.m_adFreqInfo[_loc7_].placement == Blitz3Network.DC_PLACEMENT)
               {
                  this.m_adFreqInfo[_loc7_].adsRemaining = this.m_adFreqInfo[_loc7_].adCap - _loc5_["dailyChallenge"];
               }
               else if(this.m_adFreqInfo[_loc7_].placement == Blitz3Network.FREECHEST_PLACEMENT)
               {
                  this.m_adFreqInfo[_loc7_].adsRemaining = this.m_adFreqInfo[_loc7_].adCap - _loc5_["giftBox"];
               }
               else if(this.m_adFreqInfo[_loc7_].placement == Blitz3Network.POSTGAME_PLACEMENT)
               {
                  this.m_adFreqInfo[_loc7_].adsRemaining = this.m_adFreqInfo[_loc7_].adCap - _loc5_["2xCoins"];
               }
               else if(this.m_adFreqInfo[_loc7_].placement == Blitz3Network.MAINMENU_PLACEMENT)
               {
                  this.m_adFreqInfo[_loc7_].adsRemaining = this.m_adFreqInfo[_loc7_].adCap - _loc5_["freeCoins"];
               }
               _loc7_++;
            }
         }
      }
      
      public function canShowRetry(param1:String, param2:uint = 0, param3:String = "") : Boolean
      {
         var _loc4_:* = false;
         var _loc5_:int = this.m_adFreqInfo.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            if(this.m_adFreqInfo[_loc6_].placement == param1)
            {
               if(param1 == Blitz3Network.DS_PLACEMENT)
               {
                  if(param3 != this.mSpinBoardIdConsideredForAd)
                  {
                     this.mSpinBoardIdConsideredForAd = param3;
                     this.m_adFreqInfo[_loc6_].adsRemaining = this.m_adFreqInfo[_loc6_].adCap;
                  }
               }
               _loc4_ = this.m_adFreqInfo[_loc6_].adsRemaining > 0;
               if(param1 == Blitz3Network.POSTGAME_PLACEMENT)
               {
                  _loc4_ = Boolean(_loc4_ && param2 <= this.m_adFreqInfo[_loc6_].rewardCap);
               }
               break;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function decrementRemainingUsesByPlacement(param1:String) : void
      {
         var _loc2_:int = this.m_adFreqInfo.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.m_adFreqInfo[_loc3_].placement == param1)
            {
               --this.m_adFreqInfo[_loc3_].adsRemaining;
               if(this.m_adFreqInfo[_loc3_].adsRemaining <= 0)
               {
                  Blitz3App.app.network.dispatchAdCapExhausted(param1);
               }
               break;
            }
            _loc3_++;
         }
      }
      
      public function getAdFreqCap(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.m_adFreqInfo.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.m_adFreqInfo[_loc4_].placement == param1)
            {
               _loc2_ = this.m_adFreqInfo[_loc4_].adCap;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getAdsWatched(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.m_adFreqInfo.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.m_adFreqInfo[_loc4_].placement == param1)
            {
               _loc2_ = this.m_adFreqInfo[_loc4_].adCap - this.m_adFreqInfo[_loc4_].adsRemaining;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
   }
}
