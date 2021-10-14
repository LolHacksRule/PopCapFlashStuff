package com.popcap.flash.games.blitz3.game.states
{
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.§_-27§;
   import com.popcap.flash.framework.§_-Tn§;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.tokens.§_-l8§;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class §_-31§ extends Sprite implements IAppState
   {
      
      public static const §_-Cb§:String = "State:Game:Help";
      
      public static const §_-K8§:String = "Signal:GameEnd";
      
      public static const §_-41§:String = "Signal:GameStart";
      
      public static const §_-By§:String = "State:Game:Reset";
      
      public static const §_-6R§:String = "State:Game:Play";
      
      public static const §_-M8§:String = "Signal:GameQuit";
      
      public static const §_-a6§:String = "Signal:GameReset";
      
      public static const §_-ji§:String = "State:Game:Over";
       
      
      public var help:§_-Wb§;
      
      private var §_-YP§:§_-Tn§;
      
      public var §_-P0§:§var§;
      
      public var §_-5H§:§_-dH§;
      
      private var mApp:Blitz3Game;
      
      public var play:§_-ol§;
      
      private var §_-Fb§:DisplayObject;
      
      public function §_-31§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.§_-YP§ = new §_-27§();
         this.help = new §_-Wb§(param1);
         this.§_-P0§ = new §var§(param1);
         this.play = new §_-ol§(param1);
         this.§_-5H§ = new §_-dH§(param1);
         this.help.addEventListener(§_-a6§,this.§_-Mg§);
         this.help.addEventListener(§_-41§,this.§_-gQ§);
         this.§_-P0§.addEventListener(§_-41§,this.§_-gQ§);
         this.play.addEventListener(§_-K8§,this.§_-L8§);
         this.play.addEventListener(§_-a6§,this.§_-Mg§);
         this.play.addEventListener(§_-M8§,this.§_-FS§);
         this.§_-5H§.addEventListener(§_-a6§,this.§_-Mg§);
         this.§_-YP§.§_-Fl§(§_-Cb§,this.help);
         this.§_-YP§.§_-Fl§(§_-By§,this.§_-P0§);
         this.§_-YP§.§_-Fl§(§_-6R§,this.play);
         this.§_-YP§.§_-Fl§(§_-ji§,this.§_-5H§);
      }
      
      public function §_-7H§() : void
      {
         this.help.§_-bL§(true);
         this.§_-aF§(§_-Cb§,this.help);
      }
      
      public function draw(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().draw(param1);
         this.mApp.§_-Ba§.game.sidebar.buttons.menuButton.Draw();
         this.mApp.§_-Ba§.game.sidebar.buttons.hintButton.Draw();
         this.mApp.§_-Ba§.game.background.Draw();
         this.mApp.§_-Ba§.game.board.checkerboard.Draw();
         this.mApp.§_-Ba§.game.board.blipLayer.Draw();
         this.mApp.§_-Ba§.game.board.clock.Draw();
         this.mApp.§_-Ba§.game.board.compliments.Draw();
         this.mApp.§_-Ba§.game.sidebar.speed.Draw();
      }
      
      private function SubmitStats() : void
      {
         var _loc4_:MoveData = null;
         var _loc5_:BlitzLogic = null;
         var _loc6_:Object = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<MoveData> = this.mApp.logic.moves;
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.§_-hK§)
            {
               _loc1_++;
               if(_loc4_.§_-bd§)
               {
                  _loc2_++;
               }
            }
         }
         _loc5_ = this.mApp.logic;
         (_loc6_ = new Object())["isGameOver"] = _loc5_.isGameOver;
         _loc6_["gameTimePlayed"] = _loc5_.GetTimeElapsed();
         _loc6_["score"] = _loc5_.GetScore();
         _loc6_["numGemsCleared"] = _loc5_.board.GetNumGemsCleared();
         _loc6_["flameGemsCreated"] = _loc5_.flameGemLogic.numCreated;
         _loc6_["starGemsCreated"] = _loc5_.starGemLogic.numCreated;
         _loc6_["hypercubesCreated"] = _loc5_.hypercubeLogic.numCreated;
         _loc6_["blazingExplosions"] = _loc5_.blazingSpeedBonus.GetNumExplosions();
         _loc6_["numMoves"] = _loc1_;
         _loc6_["numGoodMoves"] = _loc2_;
         _loc6_["numMatches"] = _loc5_.numMatches;
         _loc6_["timeUpMultiplier"] = _loc5_.multiLogic.multiplier;
         _loc6_["multiplier"] = _loc5_.multiLogic.numSpawned + 1;
         _loc6_["speedPoints"] = _loc5_.scoreKeeper.GetSpeedPoints();
         _loc6_["speedLevel"] = _loc5_.speedBonus.GetHighestLevel();
         _loc6_["lastHurrahPoints"] = _loc5_.scoreKeeper.GetLastHurrahPoints();
         _loc6_["coinsEarned"] = _loc5_.coinTokenLogic.collected.length;
         _loc6_["fpsAvg"] = this.mApp.fpsMonitor.GetAverageFPS();
         _loc6_["fpsLow"] = this.mApp.fpsMonitor.GetFPSLow();
         _loc6_["fpsHigh"] = this.mApp.fpsMonitor.GetFPSHigh();
         this.mApp.network.SubmitStats(_loc6_);
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-3Z§(param1,param2);
      }
      
      public function update() : void
      {
         this.§_-YP§.§_-Sp§().update();
         this.mApp.§_-Ba§.game.background.Update();
         this.mApp.§_-Ba§.game.board.checkerboard.Update();
         this.mApp.§_-Ba§.game.board.blipLayer.Update();
         this.mApp.§_-Ba§.game.board.clock.Update();
         this.mApp.§_-Ba§.game.board.compliments.Update();
         this.mApp.§_-Ba§.game.board.broadcast.Update();
         this.mApp.§_-Ba§.game.sidebar.speed.Update();
      }
      
      private function §_-Mg§(param1:Event) : void
      {
         this.§_-aF§(§_-By§,this.§_-P0§);
      }
      
      public function §_-5Q§(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().§_-5Q§(param1);
      }
      
      private function §_-aF§(param1:String, param2:DisplayObject) : void
      {
         if(this.§_-Fb§ != null)
         {
            removeChild(this.§_-Fb§);
         }
         this.§_-Fb§ = param2;
         addChild(param2);
         this.§_-YP§.§_-Jp§(param1);
      }
      
      public function §_-2R§(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().§_-2R§(param1);
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-W-§(param1,param2);
      }
      
      public function §_-Fn§() : void
      {
      }
      
      private function §_-gQ§(param1:Event) : void
      {
         this.mApp.fpsMonitor.§_-dK§();
         this.§_-aF§(§_-6R§,this.play);
      }
      
      private function §_-L8§(param1:Event) : void
      {
         this.SubmitStats();
         this.§_-aF§(§_-ji§,this.§_-5H§);
      }
      
      public function §_-Bz§() : void
      {
      }
      
      private function §_-FS§(param1:Event) : void
      {
         this.SubmitStats();
         this.mApp.network.AbortGame(this.mApp.logic.coinTokenLogic.collected.length * §_-l8§.§_-7K§);
         dispatchEvent(new Event(§_-pB§.§_-Z4§));
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-Yz§(param1,param2);
      }
      
      public function §_-Af§() : void
      {
      }
   }
}
