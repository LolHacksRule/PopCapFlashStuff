package §_-u§
{
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.§_-CW§;
   import com.popcap.flash.games.blitz3.ui.widgets.game.stats.§_-Sv§;
   import flash.display.Sprite;
   
   public class §_-Nj§ extends Sprite
   {
       
      
      public var help:§_-Sk§;
      
      public var networkWait:§_-CS§;
      
      private var §_-Vj§:Boolean = false;
      
      public var menu:§_-kW§;
      
      public var boosts:§_-CW§;
      
      public var game:§_-2g§;
      
      private var mApp:Blitz3Game;
      
      public var stats:§_-Sv§;
      
      public function §_-Nj§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.game = new §_-2g§(param1);
         this.menu = new §_-kW§(param1);
         this.help = new §_-Sk§();
         this.stats = new §_-Sv§(param1);
         this.boosts = new §_-CW§(param1);
         this.networkWait = new §_-CS§(param1);
      }
      
      public function Update() : void
      {
         this.networkWait.Update();
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         this.menu.Reset();
         this.game.Reset();
         this.stats.Reset();
         this.networkWait.Reset();
      }
      
      public function ShowNetworkWait() : void
      {
         addChild(this.networkWait);
         this.networkWait.visible = true;
      }
      
      public function Init() : void
      {
         addChild(this.game);
         addChild(this.menu);
         this.game.Init();
         this.menu.Init();
         this.stats.Init();
         this.boosts.Init();
         this.networkWait.Init();
         this.§_-Vj§ = true;
      }
      
      public function HideNetworkWait() : void
      {
         this.networkWait.visible = false;
         removeChild(this.networkWait);
      }
   }
}
