package com.popcap.flash.bejeweledblitz.party
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   
   public class PartyListBoxCompletedCollected extends PartyListBox
   {
       
      
      public function PartyListBoxCompletedCollected(param1:Blitz3Game, param2:PartyListContainer, param3:PartyData)
      {
         super(param1,param2,param3);
         this.mcIcons.txtType.htmlText = _app.TextManager.GetLocString(Blitz3GameLoc.LOC_CHALLENGE_LIST_TYPE_GAMEOVER);
         this.typeStakesClip.txtTime.htmlText = "";
      }
   }
}
