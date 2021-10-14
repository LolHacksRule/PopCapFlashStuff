package com.popcap.flash.bejeweledblitz.game.tournament.controllers
{
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentConfigData;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.TournamentDataManager;
   import com.popcap.flash.bejeweledblitz.game.tournament.data.UserTournamentProgress;
   import com.popcap.flash.bejeweledblitz.game.tournament.runtimeEntity.*;
   
   public class TournamentRuntimeEntityManager
   {
       
      
      private var _allTournaments:Vector.<TournamentRuntimeEntity>;
      
      private var _app:Blitz3Game;
      
      public function TournamentRuntimeEntityManager(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         this._allTournaments = new Vector.<TournamentRuntimeEntity>();
      }
      
      public function reset() : void
      {
         var _loc1_:int = this._allTournaments.length - 1;
         while(_loc1_ > 0)
         {
            delete this._allTournaments[_loc1_];
            _loc1_--;
         }
         this._allTournaments.splice(0,this._allTournaments.length);
      }
      
      public function init(param1:TournamentDataManager) : void
      {
         this._app.sessionData.tournamentController.UserProgressManager.setOnComplete(this.onUserProgressUpdated);
         var _loc2_:int = 0;
         while(_loc2_ < param1.AllData.length)
         {
            this.createTournament(param1.getTournamentInfoByIndex(_loc2_));
            _loc2_++;
         }
      }
      
      public function createTournament(param1:TournamentConfigData) : TournamentRuntimeEntity
      {
         var _loc2_:TournamentRuntimeEntity = this.getTournamentById(param1.Id);
         if(_loc2_ == null)
         {
            _loc2_ = new TournamentRuntimeEntity(this._app);
         }
         _loc2_.Data = param1;
         this._allTournaments.push(_loc2_);
         return _loc2_;
      }
      
      public function getTournamentById(param1:String) : TournamentRuntimeEntity
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._allTournaments.length)
         {
            if(this._allTournaments[_loc2_].Id == param1)
            {
               return this._allTournaments[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getTournamentByIndex(param1:int) : TournamentRuntimeEntity
      {
         if(param1 < this._allTournaments.length)
         {
            return this._allTournaments[param1];
         }
         return null;
      }
      
      public function update(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._allTournaments.length)
         {
            this._allTournaments[_loc2_].update(param1);
            _loc2_++;
         }
      }
      
      public function getAllEntities() : Vector.<TournamentRuntimeEntity>
      {
         return this._allTournaments;
      }
      
      public function onUserProgressUpdated(param1:Boolean) : void
      {
         var _loc2_:UserTournamentProgressManager = null;
         var _loc3_:int = 0;
         var _loc4_:UserTournamentProgress = null;
         if(param1)
         {
            _loc2_ = this._app.sessionData.tournamentController.UserProgressManager;
            _loc3_ = 0;
            while(_loc3_ < this._allTournaments.length)
            {
               if((_loc4_ = _loc2_.getUserProgress(this._allTournaments[_loc3_].Id)) != null)
               {
                  this._allTournaments[_loc3_].onUserFetchCompleted(_loc4_);
               }
               _loc3_++;
            }
         }
      }
   }
}
