package §_-bW§
{
   import §_-FX§.§_-7U§;
   import §_-FX§.§_-HU§;
   import §_-FX§.§_-Lj§;
   import §_-FX§.§_-Od§;
   import §_-FX§.§_-RG§;
   import §_-FX§.§_-gP§;
   import §_-FX§.§_-jG§;
   import §_-FX§.§with§;
   import flash.display.Sprite;
   
   public class §_-JE§ extends Sprite
   {
       
      
      public var buttons:§_-7U§;
      
      public var starMedal:§_-HU§;
      
      private var §_-Vj§:Boolean = false;
      
      public var speed:§_-jG§;
      
      public var coinBank:§_-RG§;
      
      public var highScore:§_-Od§;
      
      public var score:§with§;
      
      public var rareGem:§_-Lj§;
      
      public var boostIcons:§_-gP§;
      
      private var mApp:Blitz3Game;
      
      public function §_-JE§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.speed = new §_-jG§(param1);
         this.score = new §with§(param1);
         this.boostIcons = new §_-gP§(param1);
         this.starMedal = new §_-HU§(param1);
         this.highScore = new §_-Od§(param1);
         this.buttons = new §_-7U§(param1);
         this.coinBank = new §_-RG§(param1);
         this.rareGem = new §_-Lj§(param1);
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         this.speed.Reset();
         this.score.Reset();
         this.boostIcons.Reset();
         this.starMedal.Reset();
         this.highScore.Reset();
         this.coinBank.Reset();
         this.buttons.Reset();
         this.rareGem.Reset();
      }
      
      public function Update() : void
      {
      }
      
      public function Init() : void
      {
         addChild(this.speed);
         addChild(this.score);
         addChild(this.boostIcons);
         addChild(this.rareGem);
         addChild(this.starMedal);
         addChild(this.highScore);
         addChild(this.coinBank);
         addChild(this.buttons);
         this.speed.Init();
         this.score.Init();
         this.boostIcons.Init();
         this.starMedal.Init();
         this.highScore.Init();
         this.coinBank.Init();
         this.buttons.Init();
         this.rareGem.Init();
         this.speed.x = 80;
         this.speed.y = 25;
         this.score.x = 20;
         this.score.y = 46;
         this.boostIcons.x = 80;
         this.boostIcons.y = 130;
         this.starMedal.x = 28;
         this.starMedal.y = 102;
         this.starMedal.visible = this.mApp.network.isOffline;
         this.rareGem.x = 65;
         this.rareGem.y = 143;
         this.highScore.x = 80;
         this.highScore.y = 244;
         this.coinBank.x = 80;
         this.coinBank.y = 240;
         this.buttons.x = 38;
         this.buttons.y = 268;
         this.§_-Vj§ = true;
      }
   }
}
