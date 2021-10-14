package §_-FX§
{
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class §_-jG§ extends Sprite
   {
      
      public static const §_-ov§:int = 100;
      
      public static const §_-PM§:int = 25;
       
      
      private var §_-HX§:TextField;
      
      private var §_-Fd§:Sprite;
      
      private var §_-YU§:GlowFilter;
      
      private var §_-Nh§:TextField;
      
      private var §_-oy§:TextField;
      
      private var §_-GJ§:Rectangle;
      
      private var §_-BJ§:int = 0;
      
      private var §_-ZH§:Sprite;
      
      private var §_-bq§:Sprite;
      
      private var §_-Qt§:GlowFilter;
      
      private var §_-kq§:Sprite;
      
      private var mApp:§_-0Z§;
      
      private var §_-KF§:int = 0;
      
      private var §_-Ci§:int = 0;
      
      private var §_-OC§:TextField;
      
      public function §_-jG§(param1:§_-0Z§)
      {
         this.§_-Qt§ = new GlowFilter(0,1,2,2);
         this.§_-YU§ = new GlowFilter(16777215,1,2,2);
         this.§_-GJ§ = new Rectangle(0,0,0,100);
         super();
         this.mApp = param1;
      }
      
      public function Init() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = Blitz3Fonts.§_-Un§;
         _loc1_.size = 14;
         _loc1_.align = TextFormatAlign.CENTER;
         this.§_-OC§ = new TextField();
         this.§_-OC§.embedFonts = true;
         this.§_-OC§.textColor = 16777215;
         this.§_-OC§.defaultTextFormat = _loc1_;
         this.§_-OC§.filters = [this.§_-Qt§];
         this.§_-OC§.width = 120;
         this.§_-OC§.height = 22;
         this.§_-OC§.x = 0;
         this.§_-OC§.y = 0;
         this.§_-HX§ = new TextField();
         this.§_-HX§.embedFonts = true;
         this.§_-HX§.textColor = 16777215;
         this.§_-HX§.defaultTextFormat = _loc1_;
         this.§_-HX§.filters = [this.§_-Qt§];
         this.§_-HX§.width = 120;
         this.§_-HX§.height = 22;
         this.§_-HX§.x = 0;
         this.§_-HX§.y = 0;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.font = Blitz3Fonts.§_-Un§;
         _loc2_.size = 14;
         _loc2_.align = TextFormatAlign.CENTER;
         this.§_-oy§ = new TextField();
         this.§_-oy§.embedFonts = true;
         this.§_-oy§.textColor = 16777215;
         this.§_-oy§.defaultTextFormat = _loc2_;
         this.§_-oy§.filters = [this.§_-Qt§];
         this.§_-oy§.width = 80;
         this.§_-oy§.height = 22;
         this.§_-oy§.x = 0;
         this.§_-oy§.y = 14;
         this.§_-Nh§ = new TextField();
         this.§_-Nh§.embedFonts = true;
         this.§_-Nh§.textColor = 16777215;
         this.§_-Nh§.defaultTextFormat = _loc2_;
         this.§_-Nh§.filters = [this.§_-Qt§];
         this.§_-Nh§.width = 80;
         this.§_-Nh§.height = 22;
         this.§_-Nh§.x = 0;
         this.§_-Nh§.y = 14;
         this.§_-ZH§ = new Sprite();
         this.§_-ZH§.addChild(this.§_-OC§);
         this.§_-ZH§.x = -this.§_-ZH§.width / 2;
         this.§_-ZH§.y = -this.§_-ZH§.height / 2;
         this.§_-Fd§ = new Sprite();
         this.§_-Fd§.addChild(this.§_-HX§);
         this.§_-Fd§.x = -this.§_-Fd§.width / 2;
         this.§_-Fd§.y = -this.§_-Fd§.height / 2;
         this.§_-GJ§.width = this.§_-Fd§.width;
         this.§_-GJ§.height = 44;
         this.§_-Fd§.scrollRect = this.§_-GJ§;
         this.§_-kq§ = new Sprite();
         this.§_-kq§.addChild(this.§_-ZH§);
         this.§_-kq§.x = 0;
         this.§_-kq§.y = 0;
         this.§_-bq§ = new Sprite();
         this.§_-bq§.addChild(this.§_-Fd§);
         this.§_-bq§.x = 0;
         this.§_-bq§.y = 0;
         addChild(this.§_-kq§);
         addChild(this.§_-bq§);
      }
      
      public function Draw() : void
      {
         var _loc1_:Number = 1 - this.§_-KF§ / §_-PM§;
         var _loc2_:Number = Math.sin(_loc1_ * Math.PI);
         var _loc3_:Number = _loc2_ * 0.2;
         this.§_-kq§.scaleX = 1 + _loc3_;
         this.§_-kq§.scaleY = 1 + _loc3_;
         this.§_-bq§.scaleX = 1 + _loc3_;
         this.§_-bq§.scaleY = 1 + _loc3_;
         this.§_-YU§.blurX = _loc2_ * 8;
         this.§_-YU§.blurY = _loc2_ * 8;
         if(this.§_-KF§ == 0)
         {
            this.§_-oy§.filters = [this.§_-Qt§];
            this.§_-Nh§.filters = [this.§_-Qt§];
         }
         else
         {
            this.§_-oy§.filters = [this.§_-Qt§,this.§_-YU§];
            this.§_-Nh§.filters = [this.§_-Qt§,this.§_-YU§];
         }
         var _loc4_:Number = this.§_-Ci§ / §_-ov§;
         this.§_-kq§.alpha = _loc4_;
         this.§_-bq§.alpha = _loc4_;
         this.§_-OC§.textColor = 16777215;
         this.§_-oy§.textColor = 16777215;
         var _loc5_:Number = this.mApp.logic.blazingSpeedBonus.§_-iZ§();
         var _loc6_:Number = Math.max(0,(_loc5_ - 0.5) / (1 - 0.5));
         this.§_-GJ§.width = 104 * _loc6_;
         this.§_-Fd§.scrollRect = this.§_-GJ§;
         this.§_-HX§.textColor = 16742144;
         this.§_-Nh§.textColor = 16742144;
      }
      
      public function Update() : void
      {
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         if(this.mApp.logic.speedBonus.§_-iU§() > this.§_-BJ§)
         {
            this.§_-BJ§ = this.mApp.logic.speedBonus.§_-iU§();
            this.§_-KF§ = §_-PM§;
         }
         if(this.mApp.logic.speedBonus.§_-iU§() < this.§_-BJ§ && this.§_-BJ§ > 0)
         {
            --this.§_-Ci§;
            if(this.§_-Ci§ == 0)
            {
               this.§_-BJ§ = 0;
            }
            this.§_-oy§.visible = false;
            this.§_-Nh§.visible = false;
         }
         else
         {
            this.§_-Ci§ = §_-ov§;
            this.§_-oy§.visible = true;
            this.§_-Nh§.visible = true;
         }
         if(this.§_-BJ§ == 0)
         {
            this.§_-kq§.visible = false;
            this.§_-bq§.visible = false;
         }
         else
         {
            this.§_-kq§.visible = true;
            this.§_-bq§.visible = true;
         }
         if(this.§_-KF§ > 0)
         {
            --this.§_-KF§;
         }
         this.§_-OC§.text = this.mApp.§_-JC§.GetLocString("GAMEPLAY_BONUS_SPEED") + this.mApp.logic.speedBonus.§_-lY§();
         this.§_-HX§.text = this.mApp.§_-JC§.GetLocString("GAMEPLAY_BONUS_SPEED") + this.mApp.logic.speedBonus.§_-lY§();
      }
      
      public function Reset() : void
      {
         this.§_-Ci§ = 0;
         this.§_-BJ§ = 0;
         this.§_-KF§ = 0;
         this.§_-kq§.visible = false;
         this.§_-bq§.visible = false;
      }
   }
}
