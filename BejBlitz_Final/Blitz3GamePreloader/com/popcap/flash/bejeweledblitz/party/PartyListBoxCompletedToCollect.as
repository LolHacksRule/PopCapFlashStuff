package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class PartyListBoxCompletedToCollect extends PartyListBox
   {
       
      
      public function PartyListBoxCompletedToCollect(param1:Blitz3Game, param2:PartyListContainer, param3:PartyData)
      {
         super(param1,param2,param3);
         _btnCover.setPress(onCollectPress);
         this.mcIcons.gotoAndStop("toCollect");
         this.mcIcons.txtType.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_TYPE_COLLECT);
         this.typeStakesClip.txtTime.htmlText = partyData.getExpireString();
      }
   }
}
