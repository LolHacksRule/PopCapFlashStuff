package §_-bW§
{
   import §_-P2§.§_-4X§;
   import §_-P2§.§_-CD§;
   import §_-P2§.§_-Ms§;
   import §_-P2§.§_-kf§;
   import §_-P2§.§_-mj§;
   import §_-P2§.§_-oE§;
   import §_-P2§.§_-p6§;
   import com.popcap.flash.games.bej3.Gem;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class §_-kY§ extends Sprite
   {
      
      public static const §_-DE§:int = 40;
       
      
      private var §_-5y§:Gem = null;
      
      private var mApp:Blitz3Game;
      
      private var §_-Vj§:Boolean = false;
      
      private var §_-pW§:Boolean = false;
      
      private var §_-Gy§:Point;
      
      public var compliments:§_-4X§;
      
      private var §_-LF§:Boolean = false;
      
      public var clock:§_-CD§;
      
      private var §_-b-§:int = 0;
      
      private var §_-Ky§:int = 0;
      
      private var §_-Ea§:Boolean = false;
      
      public var broadcast:§_-oE§;
      
      public var gemLayer:§_-kf§;
      
      private var §_-cX§:Boolean = false;
      
      public var checkerboard:§_-Ms§;
      
      public var blipLayer:§_-p6§;
      
      public var frame:§_-mj§;
      
      private var §_-pN§:Point;
      
      private var §_-A0§:Point;
      
      public function §_-kY§(param1:Blitz3Game)
      {
         this.§_-Gy§ = new Point();
         this.§_-A0§ = new Point();
         this.§_-pN§ = new Point();
         super();
         this.mApp = param1;
         this.mApp.§_-kP§("InfoCheat",this.InfoCheat);
         this.mApp.§_-kP§("RedGemCheat",this.RedGemCheat);
         this.mApp.§_-kP§("OrangeGemCheat",this.OrangeGemCheat);
         this.mApp.§_-kP§("YellowGemCheat",this.YellowGemCheat);
         this.mApp.§_-kP§("GreenGemCheat",this.GreenGemCheat);
         this.mApp.§_-kP§("BlueGemCheat",this.BlueGemCheat);
         this.mApp.§_-kP§("PurpleGemCheat",this.PurpleGemCheat);
         this.mApp.§_-kP§("WhiteGemCheat",this.WhiteGemCheat);
         this.mApp.§_-kP§("FlameGemCheat",this.FlameGemCheat);
         this.mApp.§_-kP§("StarGemCheat",this.StarGemCheat);
         this.mApp.§_-kP§("RainbowGemCheat",this.RainbowGemCheat);
         this.mApp.§_-kP§("MultiplierGemCheat",this.MultiplierGemCheat);
         this.mApp.§_-kP§("NormalGemCheat",this.NormalGemCheat);
         this.mApp.§_-kP§("RemoveGemCheat",this.RemoveGemCheat);
         this.mApp.§_-kP§("ShatterGemCheat",this.ShatterGemCheat);
         this.mApp.§_-kP§("BlazingSpeedCheat",this.BlazingSpeedCheat);
         this.mApp.§_-kP§("SpawnCoinTokenCheat",this.SpawnCoinTokenCheat);
         mouseChildren = false;
         this.checkerboard = new §_-Ms§(param1);
         this.frame = new §_-mj§(param1);
         this.gemLayer = new §_-kf§(param1);
         this.blipLayer = new §_-p6§(param1);
         this.clock = new §_-CD§(param1);
         this.compliments = new §_-4X§(param1);
         this.broadcast = new §_-oE§(param1);
         addEventListener(MouseEvent.MOUSE_DOWN,this.§_-Lv§);
         addEventListener(MouseEvent.MOUSE_UP,this.§_-ES§);
         addEventListener(MouseEvent.MOUSE_MOVE,this.§_-Oz§);
         addEventListener(MouseEvent.MOUSE_OUT,this.§_-Ut§);
      }
      
      private function SpawnCoinTokenCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.coinTokenLogic.SpawnCoinOnGem(_loc2_);
      }
      
      private function RemoveGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueRemoveGem(_loc2_);
      }
      
      private function §_-A8§(param1:Gem) : void
      {
         if(this.mApp.logic.GetTimeRemaining() == 0)
         {
            return;
         }
         if(this.§_-5y§ != null && param1 == this.§_-5y§)
         {
            this.§_-pW§ = true;
            return;
         }
         if(this.§_-5y§ != null && param1 != null && this.§_-5y§ != param1)
         {
            if(this.mApp.logic.QueueSwap(this.§_-5y§,param1.§_-dg§,param1.§_-pX§))
            {
               this.§_-5y§.§_-An§ = false;
               this.§_-5y§ = null;
               return;
            }
         }
         if(this.§_-5y§ != null)
         {
            this.§_-5y§.§_-An§ = false;
         }
         if(this.§_-5y§ == null && param1 != null)
         {
            if(param1.type == Gem.§_-72§)
            {
               this.mApp.logic.QueueDetonate(param1);
               return;
            }
            if(param1.type == Gem.§_-nT§)
            {
               this.mApp.logic.QueueScramble(param1);
               return;
            }
         }
         this.§_-5y§ = param1;
         if(this.§_-5y§ != null)
         {
            this.§_-5y§.§_-An§ = true;
            this.mApp.§_-Qi§.playSound(Blitz3Sounds.SOUND_SELECT);
         }
      }
      
      private function BlazingSpeedCheat(param1:Array = null) : void
      {
         this.mApp.logic.blazingSpeedBonus.StartBonus();
      }
      
      private function InfoCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         trace(_loc2_.§_-Fm§());
      }
      
      private function §_-ce§() : void
      {
         if(this.§_-5y§ == null || this.§_-cX§)
         {
            this.§_-Ky§ = 0;
            this.§_-b-§ = 0;
            return;
         }
         var _loc1_:int = this.§_-5y§.§_-dg§ + this.§_-b-§;
         var _loc2_:int = this.§_-5y§.§_-pX§ + this.§_-Ky§;
         if(this.mApp.logic.QueueSwap(this.§_-5y§,_loc1_,_loc2_))
         {
            this.§_-5y§.§_-An§ = false;
            this.§_-5y§ = null;
            this.§_-Ky§ = 0;
            this.§_-b-§ = 0;
            this.§_-Ea§ = false;
         }
      }
      
      public function §_-Oz§(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.§_-Gy§.x = _loc2_;
         this.§_-Gy§.y = _loc3_;
         this.gemLayer.§_-k3§.x = int(_loc2_ / §_-DE§);
         this.gemLayer.§_-k3§.y = int(_loc3_ / §_-DE§);
         if(!this.§_-Ea§)
         {
            return;
         }
         var _loc4_:Number = _loc2_ - this.§_-A0§.x;
         var _loc5_:Number = _loc3_ - this.§_-A0§.y;
         _loc4_ /= §_-DE§;
         _loc5_ /= §_-DE§;
         this.§_-Ky§ = 0;
         this.§_-b-§ = 0;
         if(_loc5_ > 0.33)
         {
            this.§_-b-§ = 1;
            this.§_-ce§();
         }
         else if(_loc5_ < -0.33)
         {
            this.§_-b-§ = -1;
            this.§_-ce§();
         }
         else if(_loc4_ > 0.33)
         {
            this.§_-Ky§ = 1;
            this.§_-ce§();
         }
         else if(_loc4_ < -0.33)
         {
            this.§_-Ky§ = -1;
            this.§_-ce§();
         }
      }
      
      public function Reset() : void
      {
         this.checkerboard.Reset();
         this.frame.Reset();
         this.gemLayer.Reset();
         this.blipLayer.Reset();
         this.clock.Reset();
         this.compliments.Reset();
         this.broadcast.Reset();
         if(this.§_-5y§ != null)
         {
            this.§_-5y§.§_-An§ = false;
            this.§_-5y§ = null;
         }
         this.§_-Ky§ = 0;
         this.§_-b-§ = 0;
         this.§_-pW§ = false;
         this.§_-cX§ = false;
      }
      
      public function Init() : void
      {
         addChild(this.checkerboard);
         addChild(this.frame);
         addChild(this.gemLayer);
         addChild(this.blipLayer);
         addChild(this.clock);
         addChild(this.compliments);
         addChild(this.broadcast);
         this.checkerboard.Init();
         this.frame.Init();
         this.gemLayer.Init();
         this.blipLayer.Init();
         this.clock.Init();
         this.compliments.Init();
         this.broadcast.Init();
         this.compliments.x = 160;
         this.compliments.y = 160;
         this.broadcast.x = 160;
         this.broadcast.y = 160;
         this.§_-Vj§ = true;
      }
      
      private function §_-LA§() : void
      {
         if(this.§_-pW§ == true)
         {
            if(this.§_-5y§ != null)
            {
               this.§_-5y§.§_-An§ = false;
            }
            this.§_-5y§ = null;
         }
         this.§_-Ky§ = 0;
         this.§_-b-§ = 0;
         this.§_-pW§ = false;
      }
      
      private function ShatterGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueDestroyGem(_loc2_);
      }
      
      public function §_-ES§(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.§_-Gy§.x = _loc2_;
         this.§_-Gy§.y = _loc3_;
         this.§_-LA§();
         this.§_-Ea§ = false;
         this.§_-cX§ = false;
      }
      
      private function OrangeGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-md§);
      }
      
      private function §_-0z§(param1:int) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemColor(_loc2_,param1);
      }
      
      private function MultiplierGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.multiLogic.SpawnGem(_loc2_);
      }
      
      private function §_-fZ§() : Gem
      {
         var _loc1_:int = int(this.§_-Gy§.y / §_-DE§);
         var _loc2_:int = int(this.§_-Gy§.x / §_-DE§);
         return this.mApp.logic.grid.getGem(_loc1_,_loc2_);
      }
      
      private function GreenGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-Zz§);
      }
      
      private function PurpleGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-70§);
      }
      
      private function RedGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-Y7§);
      }
      
      private function StarGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(_loc2_,Gem.§_-N3§);
      }
      
      public function §_-Ut§(param1:MouseEvent) : void
      {
         this.§_-LF§ = param1.buttonDown;
         if(this.§_-LF§)
         {
            this.§_-cX§ = true;
         }
      }
      
      private function RainbowGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(_loc2_,Gem.§_-l0§);
      }
      
      private function BlueGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§ use§);
      }
      
      public function Draw() : void
      {
      }
      
      public function Update() : void
      {
         if(this.§_-5y§ == null)
         {
            return;
         }
         if(this.mApp.logic.GetTimeRemaining() == 0)
         {
            this.§_-5y§.§_-An§ = false;
            this.§_-5y§ = null;
            return;
         }
         if(this.§_-Ky§ == 0 && this.§_-b-§ == 0)
         {
            return;
         }
         this.§_-ce§();
      }
      
      private function NormalGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.type = Gem.§_-Jz§;
      }
      
      private function FlameGemCheat(param1:Array = null) : void
      {
         var _loc2_:Gem = this.§_-fZ§();
         if(_loc2_ == null)
         {
            return;
         }
         this.mApp.logic.QueueChangeGemType(_loc2_,Gem.§_-Q3§);
      }
      
      private function YellowGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-AH§);
      }
      
      private function WhiteGemCheat(param1:Array = null) : void
      {
         this.§_-0z§(Gem.§_-8M§);
      }
      
      public function §_-Lv§(param1:MouseEvent) : void
      {
         var _loc2_:Number = param1.localX;
         var _loc3_:Number = param1.localY;
         this.§_-Gy§.x = _loc2_;
         this.§_-Gy§.y = _loc3_;
         this.§_-Ea§ = true;
         this.§_-cX§ = false;
         this.§_-A0§.x = _loc2_;
         this.§_-A0§.y = _loc3_;
         var _loc4_:int = int(this.§_-A0§.y / §_-DE§);
         var _loc5_:int = int(this.§_-A0§.x / §_-DE§);
         var _loc6_:Gem;
         if((_loc6_ = this.mApp.logic.grid.getGem(_loc4_,_loc5_)) == null)
         {
            this.§_-Ea§ = false;
            return;
         }
         this.§_-pN§.y = _loc6_.§_-dg§;
         this.§_-pN§.x = _loc6_.§_-pX§;
         this.§_-A8§(_loc6_);
      }
   }
}
