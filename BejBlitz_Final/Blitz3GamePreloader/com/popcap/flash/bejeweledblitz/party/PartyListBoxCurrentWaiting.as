package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class PartyListBoxCurrentWaiting extends PartyListBox
   {
       
      
      public function PartyListBoxCurrentWaiting(param1:Blitz3Game, param2:PartyListContainer, param3:PartyData)
      {
         super(param1,param2,param3);
         _btnCover.setPress(onStatusPress);
         this.mcIcons.gotoAndStop("waiting");
         this.mcIcons.txtType.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_TYPE_SENT);
         this.typeStakesClip.txtTime.htmlText = partyData.getExpireString();
      }
   }
}
