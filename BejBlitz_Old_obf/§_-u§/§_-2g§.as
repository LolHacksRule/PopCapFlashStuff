package §_-u§
{
   import §_-bW§.§_-JE§;
   import §_-bW§.§_-YV§;
   import §_-bW§.§_-kY§;
   import flash.display.Sprite;
   
   public class §_-2g§ extends Sprite
   {
       
      
      public var board:§_-kY§;
      
      private var §_-Vj§:Boolean = false;
      
      public var background:§_-YV§;
      
      private var mApp:Blitz3Game;
      
      public var sidebar:§_-JE§;
      
      public function §_-2g§(param1:Blitz3Game)
      {
         super();
         this.mApp = param1;
         this.background = new §_-YV§(param1);
         this.sidebar = new §_-JE§(param1);
         this.board = new §_-kY§(param1);
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
      }
      
      public function Reset() : void
      {
         this.background.Reset();
         this.sidebar.Reset();
         this.board.Reset();
      }
      
      public function Init() : void
      {
         this.board.x = 510 - 32 - 8 * 40 + 10;
         this.board.y = 32;
         addChild(this.background);
         addChild(this.sidebar);
         addChild(this.board);
         this.background.Init();
         this.sidebar.Init();
         this.board.Init();
         this.§_-Vj§ = true;
      }
   }
}
