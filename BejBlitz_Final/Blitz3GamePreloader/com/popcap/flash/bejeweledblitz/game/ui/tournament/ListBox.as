package com.popcap.flash.bejeweledblitz.game.ui.tournament
{
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.TournamentRuntimeEntity;
   import flash.display.MovieClip;
   
   public class ListBox extends MovieClip
   {
       
      
      protected var _app:Blitz3Game;
      
      protected var _tournament:TournamentRuntimeEntity;
      
      public function ListBox(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._tournament = null;
      }
      
      public function setData(param1:TournamentRuntimeEntity) : void
      {
         this._tournament = param1;
      }
      
      public function getData() : TournamentRuntimeEntity
      {
         return this._tournament;
      }
      
      public function get Tournament() : TournamentRuntimeEntity
      {
         return this._tournament;
      }
   }
}
