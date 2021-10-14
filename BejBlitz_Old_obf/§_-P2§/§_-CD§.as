package §_-P2§
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-CD§ extends Sprite
   {
       
      
      private var §_-bO§:int = 0;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-Xf§:TextField;
      
      private var mApp:§_-0Z§;
      
      private var §_-Gn§:Sprite;
      
      public function §_-CD§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
         alpha = 0;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         if(this.mApp.logic.§_-Kb§)
         {
            ++this.§_-bO§;
         }
         if(this.mApp.logic.§_-Kb§)
         {
            this.§_-Xf§.text = this.mApp.§_-JC§.GetLocString("UI_GAMEBOARD_LAST_HURRAH");
            _loc1_ = this.§_-bO§ * 0.04;
            _loc2_ = Math.sin(_loc1_ * Math.PI / 2);
            _loc3_ = 1 + _loc2_ * 0.2;
            if(this.§_-Gn§.scaleX != _loc3_)
            {
               this.§_-Gn§.scaleX = _loc3_;
               this.§_-Gn§.scaleY = _loc3_;
            }
         }
         else
         {
            this.§_-bO§ = 0;
            _loc4_ = this.mApp.logic.GetTimeRemaining();
            _loc5_ = Math.ceil(_loc4_ * 0.01);
            _loc6_ = 0;
            while(_loc5_ >= 60)
            {
               _loc5_ -= 60;
               _loc6_++;
            }
            _loc7_ = _loc6_.toString();
            _loc8_ = _loc5_.toString();
            if(_loc5_ < 10)
            {
               _loc8_ = "0" + _loc5_.toString();
            }
            _loc9_ = _loc7_ + ":" + _loc8_;
            this.§_-Xf§.text = _loc9_;
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         alpha = 0;
         x = 160;
         y = 160;
         scaleX = 4;
         scaleY = 4;
         this.§_-Gn§.scaleX = 1;
         this.§_-Gn§.scaleY = 1;
      }
      
      public function Init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 16;
         _loc1_.align = TextFormatAlign.CENTER;
         this.§_-Xf§ = new TextField();
         this.§_-Xf§.embedFonts = true;
         this.§_-Xf§.textColor = 16777215;
         this.§_-Xf§.defaultTextFormat = _loc1_;
         this.§_-Xf§.filters = [new GlowFilter(0,1,2,2)];
         this.§_-Xf§.width = 160;
         this.§_-Xf§.height = 22;
         this.§_-Xf§.x = -this.§_-Xf§.width / 2;
         this.§_-Xf§.y = -this.§_-Xf§.height / 2;
         this.§_-Xf§.cacheAsBitmap = true;
         this.§_-Gn§ = new Sprite();
         this.§_-Gn§.addChild(this.§_-Xf§);
         this.§_-Gn§.cacheAsBitmap = true;
         addChild(this.§_-Gn§);
         this.§_-Vj§ = true;
      }
   }
}
