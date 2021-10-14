package §_-u§
{
   import com.popcap.flash.games.blitz3.ui.widgets.game.stats.§_-jH§;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class §_-CS§ extends Sprite
   {
       
      
      protected var §_-mY§:§_-jH§;
      
      protected var §_-Lp§:Blitz3Game;
      
      protected var §_-Ti§:Shape;
      
      protected var §_-eB§:Shape;
      
      protected var §_-3c§:TextField;
      
      public function §_-CS§(param1:Blitz3Game)
      {
         super();
         this.§_-Lp§ = param1;
         this.§_-eB§ = new Shape();
         this.§_-eB§.graphics.beginFill(16777215,0);
         this.§_-eB§.graphics.drawRect(0,0,Blitz3Game.§_-h8§,Blitz3Game.§_-GN§);
         this.§_-eB§.graphics.endFill();
         addChild(this.§_-eB§);
         var _loc2_:Sprite = new Sprite();
         this.§_-Ti§ = new Shape();
         this.§_-Ti§.graphics.beginFill(0,0.5);
         this.§_-Ti§.graphics.drawRoundRect(-5,-5,381.2,105,20);
         this.§_-Ti§.graphics.endFill();
         _loc2_.addChild(this.§_-Ti§);
         this.§_-mY§ = new §_-jH§(40,7.5);
         _loc2_.addChild(this.§_-mY§);
         this.§_-3c§ = new TextField();
         this.§_-3c§.defaultTextFormat = new TextFormat(Blitz3Fonts.§_-Un§,18,16777215);
         this.§_-3c§.embedFonts = true;
         this.§_-3c§.autoSize = TextFieldAutoSize.LEFT;
         this.§_-3c§.selectable = false;
         this.§_-3c§.filters = [new GlowFilter(0,1,2,2,4,1,false,false)];
         this.§_-3c§.text = this.§_-Lp§.§_-JC§.GetLocString("UI_NETWORK_WAIT");
         this.§_-3c§.x = this.§_-mY§.x + this.§_-mY§.width + 25;
         this.§_-3c§.y = 0.5 * this.§_-mY§.height - 0.5 * this.§_-3c§.height;
         _loc2_.addChild(this.§_-3c§);
         addChild(_loc2_);
         _loc2_.x = Blitz3Game.§_-h8§ / 2 - _loc2_.width / 2;
         _loc2_.y = Blitz3Game.§_-GN§ / 2 - _loc2_.height / 2;
      }
      
      public function Init() : void
      {
         this.§_-mY§.Init();
         this.Reset();
      }
      
      public function §_-Zd§() : void
      {
         this.§_-Ti§.visible = true;
         this.§_-mY§.visible = true;
         this.§_-3c§.visible = true;
      }
      
      public function Reset() : void
      {
         this.§_-Zd§();
         this.§_-mY§.Reset();
         visible = false;
      }
      
      public function Update() : void
      {
         this.§_-mY§.Update();
      }
      
      public function §_-YG§() : void
      {
         this.§_-Ti§.visible = false;
         this.§_-mY§.visible = false;
         this.§_-3c§.visible = false;
      }
   }
}
