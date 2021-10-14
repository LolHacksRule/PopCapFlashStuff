package com.popcap.flash.games.blitz3.ui.widgets.boosts
{
   import §_-4M§.§_-Ze§;
   import §_-AV§.*;
   import com.popcap.flash.games.bej3.blitz.IBlitz3NetworkHandler;
   import com.popcap.flash.games.bej3.blitz.§_-Bw§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import com.popcap.flash.games.blitz3.ui.sprites.§_-25§;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Matrix;
   import flash.net.*;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.*;
   
   public class §_-CW§ extends MovieClip implements IBlitz3NetworkHandler
   {
      
      private static const §_-Ss§:Number = 0.04;
      
      private static const §_-Ej§:Number = 500;
      
      public static const §_-d-§:int = 3;
      
      public static const §_-OD§:int = 5;
      
      private static const §_-BV§:Number = 3600;
      
      private static const §_-P6§:Number = 100;
      
      private static const §_-Tx§:Number = 0.0034;
      
      private static const §_-8Q§:Number = 900;
      
      private static const §_-8u§:Number = 1.8;
      
      private static const §_-N9§:Number = 0.1;
       
      
      private var §_-Jc§:Boolean = false;
      
      private var §_-JA§:Dictionary;
      
      private var §_-8g§:TextField;
      
      private var §_-9q§:Class;
      
      private var §_-pZ§:Class;
      
      private var §_-mX§:Boolean = false;
      
      private var §_-ZC§:Class;
      
      private var §_-ds§:Class;
      
      private var §_-M4§:Boolean = false;
      
      private var §_-j0§:Bitmap;
      
      private var §_-ma§:Dictionary;
      
      private var §_-Lp§:Blitz3Game;
      
      private var §_-G4§:Dictionary;
      
      public var §_-MI§:§_-Zg§;
      
      private var §_-dk§:int = 0;
      
      private var §_-h3§:int = -1;
      
      private var §_-3W§:int = 0;
      
      private var §_-ew§:int = -1;
      
      private var §_-NO§:§_-25§;
      
      private var §_-L9§:Boolean = false;
      
      private var §_-Uf§:Number = 0;
      
      private var §_-Sz§:Array;
      
      private var §_-aS§:Bitmap;
      
      private var §_-eK§:Timer;
      
      private var §_-hT§:Vector.<BoostButton>;
      
      private var §_-jz§:String;
      
      private var §_-NF§:§_-7C§;
      
      private var §_-2q§:Number = 0;
      
      private var §_-HM§:Class;
      
      private var §_-3N§:Bitmap;
      
      private var §_-fn§:int;
      
      public function §_-CW§(param1:Blitz3Game)
      {
         this.§_-ds§ = §_-Sj§;
         this.§_-9q§ = §_-7m§;
         this.§_-ZC§ = §_-jR§;
         this.§_-HM§ = §_-m0§;
         this.§_-pZ§ = §_-2l§;
         super();
         this.§_-Lp§ = param1;
         cacheAsBitmap = true;
         this.§_-MI§ = new §_-Zg§();
         this.§_-MI§.mouseEnabled = false;
         this.§_-MI§.mouseChildren = false;
         this.§_-hT§ = new Vector.<BoostButton>();
         this.§_-JA§ = new Dictionary();
         this.§_-JA§["5Sec"] = new §_-Ya§("5Sec",0,3,this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIME_TITLE"),this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_TIME_DESCRIPTION"));
         this.§_-JA§["FreeMult"] = new §_-Ya§("FreeMult",0,3,this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_MULTIPLIER_TITLE"),this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_MULTIPLIER_DESCRIPTION"));
         this.§_-JA§["Mystery"] = new §_-Ya§("Mystery",0,3,this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_GEM_TITLE"),this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_GEM_DESCRIPTION"));
         this.§_-JA§["Detonate"] = new §_-Ya§("Detonate",0,3,this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_DETONATOR_TITLE"),this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_DETONATOR_DESCRIPTION"));
         this.§_-JA§["Scramble"] = new §_-Ya§("Scramble",0,3,this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_SCRAMBLER_TITLE"),this.§_-Lp§.§_-JC§.GetLocString("BOOSTS_SCRAMBLER_DESCRIPTION"));
         this.§_-8g§ = new TextField();
         this.§_-8g§.selectable = false;
         this.§_-8g§.mouseEnabled = false;
         this.§_-8g§.embedFonts = true;
         this.§_-8g§.autoSize = TextFieldAutoSize.CENTER;
         this.§_-8g§.defaultTextFormat = new TextFormat(Blitz3Fonts.§_-Un§,42,15522304);
         this.§_-8g§.defaultTextFormat.align = TextFormatAlign.CENTER;
         this.§_-NO§ = new §_-25§(param1);
         this.§_-NO§.§_-5H§.addChild(new this.§_-pZ§());
         this.§_-NO§.§_-G0§.addChild(new this.§_-HM§());
         this.§_-NO§.addEventListener(MouseEvent.CLICK,this.§_-E3§);
      }
      
      public function §_-Zq§(param1:String) : void
      {
         this.§_-Lp§.network.BuyBoost(param1);
      }
      
      private function §_-4K§(param1:Array) : void
      {
         var _loc2_:BoostButton = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:BoostButton = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         for each(_loc2_ in this.§_-hT§)
         {
            removeChild(_loc2_);
         }
         this.§_-hT§.length = 0;
         _loc3_ = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = -150;
            _loc7_ = 75;
            _loc8_ = 2;
            _loc5_.x = _loc6_ + _loc7_ * _loc4_;
            _loc5_.y = _loc8_;
            addChild(_loc5_);
            this.§_-hT§[_loc4_] = _loc5_;
            _loc4_++;
         }
      }
      
      private function §_-6c§(param1:int) : String
      {
         return "button" + (param1 + 1) + "Text";
      }
      
      public function §_-SA§(param1:int = -1) : void
      {
         if(param1 == -1)
         {
            this.§_-Uf§ = -§_-Ss§;
         }
         else
         {
            this.§_-Uf§ = -alpha / param1;
         }
      }
      
      public function §_-Kw§(param1:int) : void
      {
         this.§_-fn§ = param1;
         this.§_-Z5§();
      }
      
      private function §_-8z§() : void
      {
         var _loc1_:BoostButton = null;
         var _loc2_:Boolean = true;
         for each(_loc1_ in this.§_-hT§)
         {
            if(_loc1_)
            {
               _loc1_.alpha = 1;
               if(_loc1_.§_-0B§() > 0)
               {
                  _loc2_ = false;
               }
            }
         }
         if(_loc2_)
         {
            this.§_-8g§.scaleX = this.§_-8g§.scaleY = 1;
            this.§_-8g§.visible = true;
            this.§_-8g§.alpha = 1;
            this.§_-8g§.x = this.background.x + this.background.width * 0.5 - this.§_-8g§.width * 0.5;
            this.§_-8g§.y = this.background.y + this.background.height * 0.5 - this.§_-8g§.height * 0.5;
            setChildIndex(this.§_-8g§,numChildren - 1);
            for each(_loc1_ in this.§_-hT§)
            {
               if(_loc1_)
               {
                  _loc1_.alpha = §_-N9§;
               }
            }
         }
      }
      
      public function §_-ey§(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         var _loc3_:Event = null;
         var _loc4_:int = 0;
         this.§_-ma§ = new Dictionary();
         this.§_-3W§ = 0;
         for(_loc2_ in param1)
         {
            _loc4_ = param1[_loc2_];
            this.§_-ma§[_loc2_] = _loc4_;
            if(_loc4_ > 0 && !this.§_-Lp§.logic.boostLogic.IsRareGem(_loc2_))
            {
               ++this.§_-3W§;
            }
         }
         this.§_-Z5§();
         _loc3_ = new §_-nZ§(this.§_-ma§);
         dispatchEvent(_loc3_);
      }
      
      public function §_-M-§(param1:Boolean) : void
      {
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
            _loc1_.tx = -215.499;
            _loc1_.ty = -42.499;
            this.§_-aS§.transform.matrix = _loc1_;
         }
         return this.§_-aS§;
      }
      
      private function §_-oN§() : void
      {
         var _loc3_:String = null;
         var _loc4_:§_-Ya§ = null;
         var _loc5_:BoostButton = null;
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < this.§_-Sz§.length)
         {
            _loc3_ = this.§_-Sz§[_loc2_];
            if((_loc4_ = this.§_-JA§[_loc3_]) != null)
            {
               _loc4_.cost = this.§_-G4§[_loc3_];
               if((_loc5_ = this.§_-nd§(_loc4_)) != null)
               {
                  _loc5_.index = _loc2_;
                  _loc1_.push(_loc5_);
               }
            }
            _loc2_++;
         }
         this.§_-4K§(_loc1_);
         this.§_-Z5§();
      }
      
      private function §_-E3§(param1:MouseEvent) : void
      {
         if(this.§_-Lp§.network.GetAreBoostsLocked())
         {
            return;
         }
         this.§_-Lp§.network.BackupBoosts();
         dispatchEvent(new Event(§_-0Z§.§_-4I§));
         this.§_-Lp§.network.OnAddCoinsClick();
      }
      
      public function Reset() : void
      {
         if(this.§_-U3§.visible)
         {
            y = 68;
         }
      }
      
      private function §_-Z5§() : void
      {
         var _loc1_:int = this.§_-5S§();
         this.§_-4H§.SetText(§_-Ze§.§_-2P§(_loc1_));
         this.§_-NO§.x = this.§_-4H§.x + 150 - 18;
         if(this.§_-U3§.visible)
         {
            this.§_-NO§.y = this.§_-4H§.y - 5;
         }
         var _loc2_:int = this.§_-hT§.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.§_-QL§(this.§_-hT§[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      public function get §_-U3§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-3N§ == null)
         {
            this.§_-3N§ = new this.§_-ZC§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -125;
            _loc1_.ty = -68;
            this.§_-3N§.transform.matrix = _loc1_;
         }
         return this.§_-3N§;
      }
      
      public function Init() : void
      {
         addChild(this.background);
         addChild(this.§_-TA§);
         addChild(this.§_-U3§);
         addChild(this.§_-4H§);
         addChild(this.§_-NO§);
         addChild(this.§_-8g§);
         this.§_-U3§.visible = this.§_-Lp§.network.IsCommerceEnabled();
         this.§_-NO§.visible = this.§_-U3§.visible;
         this.§_-TA§.visible = !this.§_-U3§.visible;
         if(this.§_-U3§.visible)
         {
            this.§_-4H§.x = -130;
            this.§_-4H§.y += 1;
         }
         this.§_-ew§ = -1;
         this.§_-Uf§ = 0;
         visible = false;
         alpha = 0;
         this.§_-fn§ = 0;
         this.§_-8g§.text = this.§_-Lp§.§_-JC§.GetLocString("BOOST_BAR_NONE_ACTIVE");
         this.§_-8g§.visible = false;
         var _loc1_:§_-Bw§ = this.§_-Lp§.network;
         _loc1_.AddHandler(this);
         _loc1_.§_-Wf§();
      }
      
      public function §use§(param1:Dictionary) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         this.§_-G4§ = new Dictionary();
         this.§_-Sz§ = new Array();
         for(_loc2_ in param1)
         {
            _loc3_ = this.§_-Lp§.logic.boostLogic.GetBoostOrderingIDFromStringID(_loc2_);
            this.§_-Sz§[_loc3_] = _loc2_;
            this.§_-G4§[_loc2_] = param1[_loc2_];
         }
         this.§_-oN§();
         this.§_-Z5§();
      }
      
      public function OnShowBar() : void
      {
         var _loc2_:BoostButton = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         this.§_-mX§ = false;
         this.§_-Jc§ = true;
         this.§_-8g§.visible = false;
         if(this.§_-Lp§.network.isOffline)
         {
            for each(_loc3_ in this.§_-Sz§)
            {
               _loc4_ = this.§_-G4§[_loc3_];
               if(this.§_-fn§ >= _loc4_)
               {
                  this.§_-mX§ = true;
                  this.§_-Jc§ = false;
                  break;
               }
            }
         }
         else
         {
            this.§_-mX§ = true;
            this.§_-Jc§ = false;
         }
         var _loc1_:Boolean = false;
         for each(_loc2_ in this.§_-hT§)
         {
            _loc2_.alpha = 1;
            if(_loc2_.§_-0B§() > 0)
            {
               this.§_-M4§ = true;
            }
            if(_loc2_.§_-l4§().cost <= this.§_-fn§)
            {
               _loc1_ = true;
            }
         }
         if(this.§_-Jc§)
         {
            this.§_-NO§.§_-gs§(§_-OD§ * 2 * BoostButton.§_-PM§,§_-25§.§_-ht§);
         }
         if(!this.§_-M4§)
         {
            this.§_-L9§ = true;
            this.§_-8z§();
         }
         this.§_-2q§ = §_-Ej§;
      }
      
      private function §_-nd§(param1:§_-Ya§) : BoostButton
      {
         var _loc2_:BoostButton = null;
         switch(param1.name)
         {
            case "Scramble":
               _loc2_ = new §_-AA§(this.§_-Lp§);
               break;
            case "Detonate":
               _loc2_ = new §_-7V§(this.§_-Lp§);
               break;
            case "FreeMult":
               _loc2_ = new § try§(this.§_-Lp§);
               break;
            case "Mystery":
               _loc2_ = new §_-SL§(this.§_-Lp§);
               break;
            case "5Sec":
               _loc2_ = new §_-AK§(this.§_-Lp§);
               break;
            default:
               return null;
         }
         _loc2_.§_-cR§ = this;
         _loc2_.§_-De§(param1);
         return _loc2_;
      }
      
      public function §_-NY§(param1:int = -1) : void
      {
         var _loc2_:BoostButton = null;
         visible = true;
         if(param1 == -1)
         {
            this.§_-Uf§ = §_-Ss§;
         }
         else
         {
            this.§_-Uf§ = (1 - alpha) / param1;
         }
         for each(_loc2_ in this.§_-hT§)
         {
            _loc2_.alpha = 1;
         }
         this.§_-8g§.visible = false;
         this.§_-L9§ = false;
         this.§_-8z§();
         if(this.§_-Uf§ == 0)
         {
            this.OnShowBar();
         }
      }
      
      public function Update() : void
      {
         var _loc1_:BoostButton = null;
         if(this.§_-hT§[0].alpha < 1)
         {
            if(this.§_-L9§)
            {
               this.§_-8g§.alpha -= §_-Tx§;
               this.§_-8g§.scaleX -= §_-Tx§;
               this.§_-8g§.scaleY -= §_-Tx§;
               this.§_-8g§.x = this.background.x + this.background.width * 0.5 - this.§_-8g§.width * 0.5;
               this.§_-8g§.y = this.background.y + this.background.height * 0.5 - this.§_-8g§.height * 0.5;
               if(this.§_-8g§.alpha <= 0)
               {
                  this.§_-8g§.alpha = 0;
                  for each(_loc1_ in this.§_-hT§)
                  {
                     if(_loc1_)
                     {
                        _loc1_.alpha = 1;
                     }
                  }
                  this.§_-L9§ = false;
                  if(this.§_-mX§ && !this.§_-M4§)
                  {
                     this.§_-ew§ = 0;
                     this.§_-hT§[this.§_-ew§].StartBulge();
                  }
               }
            }
            for each(_loc1_ in this.§_-hT§)
            {
               if(_loc1_)
               {
                  _loc1_.alpha = Math.max(1 - this.§_-8g§.alpha,§_-N9§);
               }
            }
         }
         if(this.§_-Uf§ != 0)
         {
            alpha += this.§_-Uf§;
            if(alpha >= 1)
            {
               this.§_-Uf§ = 0;
               this.OnShowBar();
            }
            else
            {
               if(alpha > 0)
               {
                  return;
               }
               this.§_-Uf§ = 0;
               for each(_loc1_ in this.§_-hT§)
               {
                  _loc1_.§_-XY§();
               }
               visible = false;
            }
         }
         if(this.§_-mX§ && this.§_-M4§)
         {
            this.§_-M4§ = false;
            for each(_loc1_ in this.§_-hT§)
            {
               if(_loc1_.§_-0B§() > 0)
               {
                  this.§_-M4§ = true;
                  break;
               }
            }
            if(!this.§_-M4§)
            {
               this.§_-ew§ = 0;
               this.§_-hT§[this.§_-ew§].StartBulge();
            }
         }
         if(this.§_-mX§ && !this.§_-M4§)
         {
            if(this.§_-ew§ >= 0)
            {
               _loc1_ = this.§_-hT§[this.§_-ew§];
               if(_loc1_ && !_loc1_.§_-EA§())
               {
                  ++this.§_-ew§;
                  if(this.§_-ew§ >= §_-OD§)
                  {
                     this.§_-ew§ = -1;
                     this.§_-2q§ = §_-Ej§;
                  }
                  else
                  {
                     _loc1_ = this.§_-hT§[this.§_-ew§];
                     _loc1_.StartBulge();
                  }
               }
            }
            else if(visible)
            {
               this.§_-M4§ = false;
               for each(_loc1_ in this.§_-hT§)
               {
                  if(_loc1_.§_-0B§() > 0)
                  {
                     this.§_-M4§ = true;
                     break;
                  }
               }
               --this.§_-2q§;
               if(this.§_-2q§ <= 0)
               {
                  this.§_-ew§ = 0;
                  _loc1_ = this.§_-hT§[this.§_-ew§];
                  _loc1_.StartBulge();
               }
            }
         }
         if(this.§_-Jc§ && visible && !this.§_-NO§.§_-dN§())
         {
            --this.§_-2q§;
            if(this.§_-2q§ <= 0)
            {
               this.§_-NO§.§_-gs§(§_-OD§ * 2 * BoostButton.§_-PM§,§_-25§.§_-ht§);
               this.§_-2q§ = §_-Ej§;
            }
         }
         for each(_loc1_ in this.§_-hT§)
         {
            _loc1_.Update();
         }
      }
      
      public function §_-jD§() : Boolean
      {
         return this.§_-3W§ >= §_-d-§;
      }
      
      public function §_-2i§() : void
      {
      }
      
      public function §_-5S§() : int
      {
         return this.§_-fn§;
      }
      
      public function §_-fX§() : void
      {
      }
      
      public function SellBoost(param1:String) : void
      {
         this.§_-Lp§.network.SellBoost(param1);
      }
      
      public function get §_-TA§() : Bitmap
      {
         var _loc1_:Matrix = null;
         if(this.§_-j0§ == null)
         {
            this.§_-j0§ = new this.§_-9q§();
            _loc1_ = new Matrix();
            _loc1_.a = 1;
            _loc1_.b = 0;
            _loc1_.c = 0;
            _loc1_.d = 1;
            _loc1_.tx = -73.999;
            _loc1_.ty = -65.499;
            this.§_-j0§.transform.matrix = _loc1_;
         }
         return this.§_-j0§;
      }
      
      public function §_-Ae§(param1:int) : void
      {
         this.§_-h3§ = param1;
         this.§_-Z5§();
      }
      
      public function get §_-4H§() : §_-7C§
      {
         if(this.§_-NF§ == null)
         {
            this.§_-NF§ = new §_-7C§();
            this.§_-NF§.§_-NW§(150,27.05);
            this.§_-NF§.x = -75;
            this.§_-NF§.y = -56;
         }
         return this.§_-NF§;
      }
      
      private function §_-QL§(param1:BoostButton, param2:int) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.§_-ma§ == null)
         {
            param1.§_-nz§(0);
            return;
         }
         var _loc3_:int = 0;
         var _loc4_:String = this.§_-Sz§[param2];
         if(this.§_-ma§.hasOwnProperty(_loc4_) == true)
         {
            _loc3_ = this.§_-ma§[_loc4_];
         }
         param1.§_-nz§(_loc3_);
      }
   }
}
