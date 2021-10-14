package com.popcap.flash.bejeweledblitz.logic.game
{
   public interface IBlitzReplayHandler
   {
       
      
      function SetEncoreForReplay(param1:String, param2:Boolean) : void;
      
      function ShowCharacterForReplay() : void;
      
      function ReplayHasErrors() : void;
   }
}
