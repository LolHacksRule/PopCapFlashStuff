package com.popcap.flash.bejeweledblitz.endgamepopups
{
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.endgamepopups.view.BlitzKingPopUp;
   import com.popcap.flash.bejeweledblitz.endgamepopups.view.GenericPopUp;
   import com.popcap.flash.bejeweledblitz.endgamepopups.view.LevelUpPopUp;
   import com.popcap.flash.bejeweledblitz.endgamepopups.view.RareGemPopUp;
   import com.popcap.flash.bejeweledblitz.endgamepopups.view.StarMedalPopUp;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   
   public class JSPopUpController
   {
       
      
      private var _app:Blitz3App;
      
      private var _currentPopUp:GenericPopUp;
      
      private const SHOW_BLITZ_KING:String = "showBlitzKing";
      
      private const SHOW_STAR_MEDAL:String = "showStarMedal";
      
      private const SHOW_RARE_GEM:String = "showRareGemShare";
      
      private const SHOW_RANK_UP:String = "showLevelUp";
      
      public function JSPopUpController(param1:Blitz3App)
      {
         super();
         this._app = param1;
         ServerIO.registerCallback(this.SHOW_BLITZ_KING,this.showBlitzKing);
         ServerIO.registerCallback(this.SHOW_STAR_MEDAL,this.showStarMedal);
         ServerIO.registerCallback(this.SHOW_RARE_GEM,this.showRareGem);
         ServerIO.registerCallback(this.SHOW_RANK_UP,this.showRankUp);
      }
      
      private function showBlitzKing(param1:Object) : void
      {
         this.showDialog(this.SHOW_BLITZ_KING,param1.data);
      }
      
      private function showStarMedal(param1:Object) : void
      {
         this.showDialog(this.SHOW_STAR_MEDAL,param1.data);
      }
      
      private function showRareGem(param1:Object) : void
      {
         this.showDialog(this.SHOW_RARE_GEM,param1.data);
      }
      
      private function showRankUp(param1:Object) : void
      {
         this.showDialog(this.SHOW_RANK_UP,param1.data);
      }
      
      private function showDialog(param1:String, param2:Object) : void
      {
         if(this._currentPopUp)
         {
            return;
         }
         var _loc3_:MainWidgetGame = this._app.ui as MainWidgetGame;
         if(param1 == this.SHOW_BLITZ_KING)
         {
            this._currentPopUp = new BlitzKingPopUp(this._app,"blitzKingClosed",this.responseCallback,param2);
         }
         else if(param1 == this.SHOW_STAR_MEDAL)
         {
            this._currentPopUp = new StarMedalPopUp(this._app,"starMedalClosed",this.responseCallback,param2);
         }
         else if(param1 == this.SHOW_RARE_GEM)
         {
            this._currentPopUp = new RareGemPopUp(this._app,"rareGemShareClosed",this.responseCallback,param2);
         }
         else if(param1 == this.SHOW_RANK_UP)
         {
            this._currentPopUp = new LevelUpPopUp(this._app,"levelUpClosed",this.responseCallback,param2);
         }
         _loc3_.MessageMode(true,this._currentPopUp);
      }
      
      private function responseCallback(param1:Object) : void
      {
         var _loc2_:String = this._currentPopUp.JSCallbackName;
         var _loc3_:MainWidgetGame = this._app.ui as MainWidgetGame;
         _loc3_.MessageMode(false,this._currentPopUp);
         this._currentPopUp.destroy();
         this._currentPopUp = null;
         ServerIO.sendToServer(_loc2_,param1);
      }
   }
}
