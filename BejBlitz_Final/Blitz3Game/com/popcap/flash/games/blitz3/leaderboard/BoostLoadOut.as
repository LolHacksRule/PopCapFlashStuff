package com.popcap.flash.games.blitz3.leaderboard
{
   import com.popcap.flash.games.blitz3.boostLoadout.Boost1;
   import com.popcap.flash.games.blitz3.boostLoadout.Booster2;
   import com.popcap.flash.games.blitz3.boostLoadout.Booster3;
   import com.popcap.flash.games.blitz3.boostLoadout.EquipAndPlay;
   import com.popcap.flash.games.blitz3.boostLoadout.SelectedBoost;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class BoostLoadOut extends MovieClip
   {
       
      
      public var leaderboardButton:MovieClip;
      
      public var SelectedBoosterPlaceholder:SelectedBoost;
      
      public var BoostInnerContainer:MovieClip;
      
      public var Sidebar:EquipAndPlay;
      
      public var txtEquip:TextField;
      
      public var RaregemPlaceholder:RGIconPlaceholder;
      
      public var boostinfoplaceholder:MovieClip;
      
      public var btnUp:MovieClip;
      
      public var btnDown:MovieClip;
      
      public var txtaddRG:TextField;
      
      public var infoButton:MovieClip;
      
      public var ButtonPlayNow:Playnow;
      
      public var Indicator:MovieClip;
      
      public var BCTimerText:MovieClip;
      
      public var Booster3Placeholder:Booster3;
      
      public var Booster2Placeholder:Booster2;
      
      public var Txequipboost:MovieClip;
      
      public var Booster1Placeholder:Boost1;
      
      public function BoostLoadOut()
      {
         super();
      }
   }
}
