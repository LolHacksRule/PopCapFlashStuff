package com.popcap.flash.bejeweledblitz.game
{
   import com.popcap.flash.bejeweledblitz.game.session.IBoostManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.raregem.IRareGemManagerHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.IAutoHintLogicHandler;
   import com.popcap.flash.bejeweledblitz.logic.raregems.IRareGemLogicHandler;
   import flash.utils.Dictionary;
   
   public class BlitzLogicAdapter implements IAutoHintLogicHandler, IBoostManagerHandler, IRareGemLogicHandler, IRareGemManagerHandler
   {
       
      
      private var _app:Blitz3App;
      
      private var _nextBoosts:Vector.<String>;
      
      private var _nextRareGem:String;
      
      public function BlitzLogicAdapter(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._nextBoosts = new Vector.<String>();
         this._nextRareGem = "";
      }
      
      public function Init() : void
      {
         this._app.logic.autoHintLogic.AddHandler(this);
         this._app.logic.rareGemsLogic.SetHandler(this);
         this._app.sessionData.rareGemManager.AddHandler(this);
      }
      
      public function AllowAutoHint() : Boolean
      {
         return this._app.sessionData.configManager.GetFlag(ConfigManager.FLAG_AUTO_HINT);
      }
      
      public function GetActiveBoostList(param1:Vector.<String>) : void
      {
         param1.length = 0;
         var _loc2_:Blitz3Game = this._app as Blitz3Game;
         if(_loc2_ != null && _loc2_.tutorial.IsActive())
         {
            return;
         }
         var _loc3_:int = this._nextBoosts.length;
         param1.length = _loc3_;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param1[_loc4_] = this._nextBoosts[_loc4_];
            _loc4_++;
         }
      }
      
      public function HandleBoostCatalogChanged(param1:Dictionary) : void
      {
      }
      
      public function HandleActiveBoostsChanged(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         this._nextBoosts.length = 0;
         for(_loc2_ in param1)
         {
            this._nextBoosts.push(_loc2_);
         }
      }
      
      public function HandleBoostAutorenew(param1:Vector.<String>) : void
      {
      }
      
      public function HandleBoostAutonewFailedPricesChanged() : void
      {
      }
      
      public function GetActiveRareGem() : String
      {
         var _loc1_:Blitz3Game = this._app as Blitz3Game;
         if(_loc1_ != null && _loc1_.tutorial.IsActive())
         {
            return "";
         }
         return this._nextRareGem;
      }
      
      public function HandleRareGemCatalogChanged() : void
      {
      }
      
      public function HandleActiveRareGemChanged(param1:String) : void
      {
         this._nextRareGem = param1;
      }
      
      private function RegisterCheats() : void
      {
         this._app.RegisterCommand("ForceCompleteGame",this.EndGame);
         this._app.RegisterCommand("IncreaseGameSpeed",this.IncreaseGameSpeed);
         this._app.RegisterCommand("DecreaseGameSpeed",this.DecreaseGameSpeed);
      }
      
      private function IncreaseGameSpeed() : void
      {
         this._app.logic.addSpeedBoost(0.1);
      }
      
      private function DecreaseGameSpeed() : void
      {
         this._app.logic.addSpeedBoost(-0.1);
      }
      
      private function EndGame() : void
      {
         this._app.logic.timerLogic.SetGameTime(100);
      }
   }
}
