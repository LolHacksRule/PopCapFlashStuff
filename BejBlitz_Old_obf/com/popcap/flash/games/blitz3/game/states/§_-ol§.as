package com.popcap.flash.games.blitz3.game.states
{
   import §_-bW§.§_-JE§;
   import com.popcap.flash.framework.IAppState;
   import com.popcap.flash.framework.§_-27§;
   import com.popcap.flash.framework.§_-Tn§;
   import com.popcap.flash.framework.input.keyboard.§_-6b§;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class §_-ol§ extends Sprite implements IAppState
   {
      
      public static const §_-86§:String = "Signal:GamePlayPause";
      
      public static const §_-6G§:String = "Signal:GamePlayEnd";
      
      public static const §_-fa§:String = "State:Game:Play:Paused";
      
      public static const §_-H5§:String = "Signal:GamePlayStart";
      
      public static const §_-Dv§:String = "State:Game:Play:Stop";
      
      public static const §_-B5§:String = "Signal:GamePlayResume";
      
      public static const §_-Lf§:String = "State:Game:Play:Active";
      
      public static const §_-0J§:String = "State:Game:Play:Start";
      
      public static const §_-ha§:String = "Signal:GamePlayStop";
      
      public static const §_-3t§:String = "Signal:GamePlayQuit";
       
      
      public var stop:§_-0o§;
      
      private var §_-YP§:§_-Tn§;
      
      public var §_-Tm§:§_-9k§;
      
      private var §_-b8§:String;
      
      public var start:§_-d9§;
      
      private var §_-fp§:Boolean = false;
      
      public var §_-Jd§:§_-9U§;
      
      private var mApp:Blitz3Game;
      
      public function §_-ol§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.§_-b8§ = §_-Lf§;
         this.§_-YP§ = new §_-27§();
         this.start = new §_-d9§(param1);
         this.§_-Tm§ = new §_-9k§(param1);
         this.§_-Jd§ = new §_-9U§(param1);
         this.stop = new §_-0o§(param1);
         this.mApp.§_-Ba§.game.sidebar.buttons.menuButton.addEventListener(MouseEvent.CLICK,this.§_-DL§);
         this.start.addEventListener(§_-H5§,this.§_-gQ§);
         this.§_-Tm§.addEventListener(§_-ha§,this.§_-n8§);
         this.§_-Jd§.addEventListener(§_-B5§,this.§_-cy§);
         this.§_-Jd§.addEventListener(§_-3t§,this.§_-FS§);
         this.stop.addEventListener(§_-6G§,this.§_-L8§);
         this.§_-YP§.§_-Fl§(§_-0J§,this.start);
         this.§_-YP§.§_-Fl§(§_-Lf§,this.§_-Tm§);
         this.§_-YP§.§_-Fl§(§_-fa§,this.§_-Jd§);
         this.§_-YP§.§_-Fl§(§_-Dv§,this.stop);
      }
      
      public function §_-3Z§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-3Z§(param1,param2);
      }
      
      public function update() : void
      {
         this.mApp.§_-Ba§.game.board.Update();
         this.§_-YP§.§_-Sp§().update();
         this.mApp.§_-Ba§.game.board.gemLayer.Update();
         var _loc1_:§_-JE§ = this.mApp.§_-Ba§.game.sidebar;
         _loc1_.speed.Update();
         _loc1_.score.Update();
         _loc1_.starMedal.Update();
         _loc1_.highScore.Update();
         _loc1_.coinBank.Update();
      }
      
      private function §_-DL§(param1:Event) : void
      {
         this.Pause();
      }
      
      public function §_-W-§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-W-§(param1,param2);
      }
      
      public function draw(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().draw(param1);
         this.mApp.§_-Ba§.game.board.gemLayer.Draw();
         this.mApp.§_-Ba§.game.sidebar.speed.Draw();
         this.mApp.§_-Ba§.game.sidebar.score.Draw();
         this.mApp.§_-Ba§.game.sidebar.starMedal.Draw();
         this.mApp.§_-Ba§.game.sidebar.highScore.Draw();
      }
      
      public function Pause() : void
      {
         this.§_-YP§.§_-Jp§(§_-fa§);
      }
      
      private function §_-cy§(param1:Event) : void
      {
         this.§_-73§();
      }
      
      public function §_-Fn§() : void
      {
      }
      
      public function §_-5Q§(param1:int) : void
      {
         this.§_-YP§.§_-Sp§().§_-5Q§(param1);
      }
      
      public function §_-73§() : void
      {
         this.§_-YP§.§_-Jp§(this.§_-b8§);
      }
      
      private function §_-n8§(param1:Event) : void
      {
         this.§_-b8§ = §_-Dv§;
         this.§_-YP§.§_-Jp§(§_-Dv§);
      }
      
      private function §_-FS§(param1:Event) : void
      {
         this.§_-YP§.§_-Jp§(§_-Lf§);
         dispatchEvent(new Event(§_-31§.§_-M8§));
      }
      
      public function §_-5a§() : void
      {
         if(!this.§_-fp§)
         {
            return;
         }
         var _loc1_:IAppState = this.§_-YP§.§_-Sp§();
         if(_loc1_ != this.§_-Jd§)
         {
            this.Pause();
         }
         else if(_loc1_ == this.§_-Jd§)
         {
            this.§_-73§();
         }
      }
      
      private function §_-L8§(param1:Event) : void
      {
         dispatchEvent(new Event(§_-31§.§_-K8§));
      }
      
      public function §_-Bz§() : void
      {
         this.§_-YP§.§_-Sp§().§_-Bz§();
         this.§_-fp§ = false;
      }
      
      public function §_-Af§() : void
      {
      }
      
      public function §_-Yz§(param1:Number, param2:Number) : void
      {
         this.§_-YP§.§_-Sp§().§_-Yz§(param1,param2);
      }
      
      public function §_-7H§() : void
      {
         this.start.Reset();
         this.§_-Tm§.Reset();
         this.stop.Reset();
         this.§_-b8§ = §_-0J§;
         this.§_-fp§ = true;
         this.§_-YP§.§_-Jp§(§_-0J§);
      }
      
      public function §_-2R§(param1:int) : void
      {
         if(param1 == §_-6b§.SPACE)
         {
            this.§_-5a§();
            return;
         }
         this.§_-YP§.§_-Sp§().§_-2R§(param1);
      }
      
      private function §_-gQ§(param1:Event) : void
      {
         this.§_-b8§ = §_-Lf§;
         this.§_-YP§.§_-Jp§(§_-Lf§);
      }
   }
}
