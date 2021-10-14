package §_-u§
{
   import §_-66§.§_-8n§;
   import §_-66§.§_-VY§;
   import com.popcap.flash.framework.resources.images.§_-e§;
   import com.popcap.flash.games.blitz3.ui.widgets.boosts.§_-CW§;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix;
   
   public class §_-kW§ extends Sprite
   {
      
      public static const §_-ov§:int = 50;
      
      public static const §_-Ss§:Number = 1 / 40;
       
      
      private var §_-0Q§:Class;
      
      private var §_-WY§:Bitmap;
      
      private var §_-aS§:Bitmap;
      
      public var playButton:§_-VY§;
      
      private var §_-XH§:Number = 1;
      
      private var §_-l1§:Class;
      
      private var §_-ds§:Class;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-he§:§_-CW§;
      
      private var §_-cS§:Number = 0;
      
      public var fadeTimer:int = 0;
      
      private var §_-CU§:Class;
      
      private var §_-k5§:§_-8n§;
      
      private var mApp:Blitz3Game;
      
      private var §_-QN§:Bitmap;
      
      public function §_-kW§(param1:Blitz3Game)
      {
         this.§_-ds§ = §_-i9§;
         this.§_-0Q§ = §_-Ey§;
         this.§_-l1§ = §_-UT§;
         this.§_-CU§ = §_-7O§;
         super();
         this.mApp = param1;
         this.playButton = new §_-VY§(param1);
         if(this.mApp.§_-nJ§)
         {
            this.§_-cS§ = §_-Ss§;
            this.§_-XH§ = 0;
            this.§_-bw§(0);
         }
      }
      
      public function get boostView() : §_-8n§
      {
         var _loc1_:Matrix = null;
         if(this.§_-k5§ == null)
         {
            this.§_-k5§ = new §_-8n§(this.mApp);
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 121;
            _loc1_.ty = 296;
            this.§_-k5§.transform.matrix = _loc1_;
         }
         return this.§_-k5§;
      }
      
      public function Update() : void
      {
         this.playButton.Update();
         this.§_-he§.Update();
         this.mApp.§_-Ba§.networkWait.Update();
         if(!this.mApp.§_-nJ§)
         {
            this.§_-fB§.alpha = 1 - this.§_-he§.alpha;
            if(this.§_-XH§ < 1 && this.§_-cS§ != 0)
            {
               this.§_-bw§(this.§_-XH§ + this.§_-cS§);
               if(this.§_-XH§ >= 1)
               {
                  this.§_-cS§ = 0;
                  if(ExternalInterface.available)
                  {
                     ExternalInterface.call("UIDisplayed");
                  }
               }
            }
         }
      }
      
      public function Init() : void
      {
         this.§_-he§ = this.mApp.§_-Ba§.boosts;
         addChild(this.background);
         addChild(this.§_-V§);
         addChild(this.§_-fB§);
         addChild(this.playButton);
         addChild(this.boostView);
         addChild(this.§_-he§);
         this.playButton.Init();
         this.boostView.Init();
         this.boostView.button.addEventListener(MouseEvent.CLICK,this.§_-DW§);
         this.playButton.x = this.background.width / 2;
         this.playButton.y = this.background.height / 2 + 15;
         this.§_-Vj§ = true;
      }
      
      private function §_-3m§() : void
      {
         if(this.§_-he§.visible)
         {
            this.HideBoostBar();
         }
         else
         {
            this.ShowBoostBar();
         }
      }
      
      public function get §_-V§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-QN§ == null)
         {
            this.§_-QN§ = new this.§_-0Q§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 0;
            _loc1_.ty = 349;
            this.§_-QN§.transform.matrix = _loc1_;
         }
         return this.§_-QN§;
      }
      
      private function §_-DW§(param1:MouseEvent) : void
      {
         if(this.mApp.network.GetAreBoostsLocked())
         {
            return;
         }
         this.§_-3m§();
      }
      
      private function §_-bw§(param1:Number) : void
      {
         this.§_-XH§ = param1;
         this.playButton.alpha = param1;
         this.§_-V§.alpha = param1;
         this.§_-fB§.alpha = param1;
         this.boostView.alpha = param1;
         if(param1 < 1)
         {
            mouseChildren = false;
            mouseEnabled = false;
            return;
         }
         mouseChildren = true;
         mouseEnabled = true;
      }
      
      public function Draw() : void
      {
      }
      
      public function ShowBoostBar() : void
      {
         this.§_-he§.§_-NY§(§_-ov§);
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BOOST_BAR_APPEAR);
      }
      
      public function get background() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-aS§ == null)
         {
            this.§_-aS§ = new this.§_-ds§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 0;
            _loc1_.ty = 0;
            this.§_-aS§.transform.matrix = _loc1_;
         }
         return this.§_-aS§;
      }
      
      public function Reset() : void
      {
         this.playButton.Reset();
         var _loc1_:§_-CW§ = this.mApp.§_-Ba§.boosts;
         addChild(_loc1_);
         _loc1_.x = 255;
         _loc1_.y = 64;
         this.fadeTimer = 0;
         this.§_-he§.Reset();
         this.§_-fB§.alpha = 1 - this.§_-he§.alpha;
      }
      
      public function HideBoostBar() : void
      {
         this.§_-he§.§_-SA§(§_-ov§);
         this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_BOOST_BAR_DISAPPEAR);
      }
      
      public function get §_-fB§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-WY§ == null)
         {
            this.§_-WY§ = new Bitmap(§_-e§.§_-ow§((new this.§_-l1§() as Bitmap).bitmapData,null));
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = 32.5;
            _loc1_.ty = 15;
            this.§_-WY§.transform.matrix = _loc1_;
         }
         return this.§_-WY§;
      }
   }
}
