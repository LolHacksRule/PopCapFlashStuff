package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class PartyListBoxCurrentToPlay extends PartyListBox
   {
       
      
      public function PartyListBoxCurrentToPlay(param1:Blitz3Game, param2:PartyListContainer, param3:PartyData)
      {
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         super(param1,param2,param3);
         if(partyData.isPartyTypeTeam())
         {
            _loc4_ = PartyServerIO.getStakePercent(partyData.stakesNum);
            _loc5_ = Math.min(4,Math.max(1,Math.ceil(4 * _loc4_)));
            this.mcIcons.gotoAndStop("toPlayPartner" + _loc5_);
         }
         else
         {
            this.mcIcons.gotoAndStop("toPlayDuel");
         }
         this.mcIcons.txtType.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_TYPE_PLAY);
         this.typeStakesClip.txtTime.htmlText = partyData.getExpireString();
         _btnCover.setPress(onPlayPress);
      }
   }
}
