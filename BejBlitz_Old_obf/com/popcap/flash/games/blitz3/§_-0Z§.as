package com.popcap.flash.games.blitz3
{
   import §_-Nz§.§_-o4§;
   import com.popcap.flash.framework.§_-oL§;
   import com.popcap.flash.framework.resources.images.§_-ex§;
   import com.popcap.flash.framework.resources.localization.§_-lD§;
   import com.popcap.flash.framework.resources.localization.§true §;
   import com.popcap.flash.framework.resources.sounds.§_-Ol§;
   import com.popcap.flash.framework.resources.sounds.§_-V6§;
   import com.popcap.flash.games.bej3.blitz.BlitzLogic;
   import com.popcap.flash.games.bej3.blitz.§_-Bw§;
   
   public class §_-0Z§ extends §_-oL§
   {
      
      public static const §_-GN§:int = 384;
      
      public static const §_-p-§:String = "1.3.6.2765" + "-L" + BlitzLogic.§_-Rl§;
      
      public static const §_-h8§:int = 510;
      
      public static const §_-or§:int = 1;
      
      public static const §_-p5§:int = 2;
      
      public static const §_-4I§:String = "Blitz3:AddCoins";
       
      
      public var network:§_-Bw§;
      
      public var §_-cA§:Boolean = false;
      
      public var §_-JC§:§true §;
      
      public var §_-3A§:int = 0;
      
      public var §_-CG§:Boolean = false;
      
      public var §_-FC§:§_-lK§;
      
      public var §_-QZ§:§_-ex§;
      
      public var §_-SQ§:§_-o4§;
      
      public var §_-o3§:§_-KL§;
      
      public var §_-Qi§:§_-V6§;
      
      public var §_-fV§:int = 0;
      
      public var logic:BlitzLogic;
      
      public var §_-FL§:§_-79§;
      
      public var §_-nJ§:Boolean = false;
      
      public var static:Boolean = false;
      
      public function §_-0Z§()
      {
         super();
      }
      
      override public function Stop() : void
      {
         super.Stop();
         this.§_-Qi§.removeEventListener(§_-Ol§.§finally§,this.§_-Wo§);
         this.§_-Qi§.removeEventListener(§_-Ol§.§_-Xo§,this.§_-Wo§);
      }
      
      public function §_-eo§() : void
      {
         this.§_-nJ§ = false;
      }
      
      protected function §_-Wo§(param1:§_-Ol§) : void
      {
         if(this.§_-FL§)
         {
            this.§_-FL§.SetFlag(§_-79§.§_-5E§,this.§_-Qi§.isMuted());
         }
      }
      
      public function Init() : void
      {
         var _loc3_:Object = null;
         §_-UL§("Bejeweled Blitz v" + §_-p-§);
         this.§_-Qi§.addEventListener(§_-Ol§.§finally§,this.§_-Wo§);
         this.§_-Qi§.addEventListener(§_-Ol§.§_-Xo§,this.§_-Wo§);
         var _loc1_:String = "";
         var _loc2_:Boolean = false;
         if(stage.loaderInfo.parameters)
         {
            _loc3_ = stage.loaderInfo.parameters;
            if("hasDailySpin" in _loc3_ && _loc3_.hasDailySpin == "1")
            {
               this.§_-nJ§ = true;
            }
            if("fb_user" in _loc3_)
            {
               _loc1_ = _loc3_.fb_user;
            }
            if("locale" in _loc3_)
            {
               this.§_-JC§.§_-Y2§(_loc3_.locale);
            }
            else
            {
               this.§_-JC§.§_-Y2§(§_-lD§.ENGLISH);
            }
            if("openCart" in _loc3_ && _loc3_.openCart == "1")
            {
               this.§_-CG§ = true;
            }
         }
         this.static = this.§_-FC§.IsEnabled(§_-lK§.§_-Mw§);
         _loc2_ = this.§_-FC§.IsEnabled(§_-lK§.§_-oD§);
         this.§_-FL§ = new §_-79§(_loc1_);
         this.logic = new BlitzLogic(this);
         this.§_-o3§ = new §_-KL§(this,_loc2_);
         this.logic.Init();
         this.§_-o3§.Init();
      }
   }
}
