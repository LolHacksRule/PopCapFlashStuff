package §_-P2§
{
   import §_-Xk§.§_-Hd§;
   import §_-Xk§.§_-LE§;
   import com.popcap.flash.games.bej3.blitz.IBlazingSpeedLogicHandler;
   import com.popcap.flash.games.bej3.blitz.§_-Rh§;
   import com.popcap.flash.games.blitz3.§_-0Z§;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class §_-4X§ extends Sprite implements IBlazingSpeedLogicHandler
   {
      
      public static const §_-Uq§:int = 150;
      
      public static const §_-U8§:int = 150;
      
      public static const §_-4Q§:int = 6;
      
      public static const §_-CZ§:int = 7;
       
      
      private var §_-dX§:int = 0;
      
      private var §_-c6§:§_-Hd§;
      
      private var §_-Y-§:Array;
      
      private var §_-Hl§:§_-Hd§;
      
      private var §_-Gn§:int = 0;
      
      private var §_-ng§:Bitmap;
      
      private var mApp:§_-0Z§;
      
      private var §_-ez§:Vector.<BitmapData>;
      
      private var §_-1h§:Object;
      
      private var §_-3i§:Sprite;
      
      public function §_-4X§(param1:§_-0Z§)
      {
         super();
         this.mApp = param1;
      }
      
      public function §_-f2§() : void
      {
      }
      
      public function §_-P4§() : void
      {
         var _loc1_:String = Blitz3Sounds.§_-Ff§;
         this.§_-dX§ = 0;
         this.§_-1h§ = {
            "timer":§_-U8§,
            "level":§_-4Q§,
            "sound":_loc1_
         };
      }
      
      private function §_-lM§(param1:§_-Rh§) : void
      {
         if(this.mApp.logic.§_-Kb§ == true)
         {
            return;
         }
         var _loc2_:String = "SOUND_VOICE_COMPLIMENT_" + param1.level;
         this.§_-1h§ = {
            "timer":§_-U8§,
            "level":param1.level,
            "sound":_loc2_
         };
      }
      
      public function Update() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(this.mApp.logic.isPaused)
         {
            return;
         }
         for each(_loc1_ in this.§_-Y-§)
         {
            if(_loc1_ != null)
            {
               if(_loc1_.timer > 0)
               {
                  --_loc1_.timer;
                  _loc2_ = _loc1_.timer;
                  _loc3_ = 1 - _loc2_ / §_-U8§;
                  _loc4_ = this.§_-c6§.getOutValue(1 - _loc3_);
                  _loc5_ = this.§_-Hl§.getOutValue(_loc3_);
                  this.§_-ng§.bitmapData = this.§_-ez§[_loc1_.level];
                  this.§_-ng§.x = -(this.§_-ng§.width / 2);
                  this.§_-ng§.y = -(this.§_-ng§.height / 2);
                  this.§_-3i§.scaleX = _loc5_;
                  this.§_-3i§.scaleY = _loc5_;
                  this.§_-3i§.alpha = _loc4_;
               }
            }
         }
         --this.§_-dX§;
         if(this.§_-dX§ <= 0 && this.§_-1h§ != null)
         {
            this.§_-dX§ = §_-Uq§;
            this.§_-Y-§.push(this.§_-1h§);
            this.mApp.§_-Qi§.playSound(this.§_-1h§.sound);
            this.§_-1h§ = null;
         }
      }
      
      public function Draw() : void
      {
      }
      
      public function Reset() : void
      {
         this.§_-1h§ = null;
         this.§_-Y-§.length = 0;
         this.§_-dX§ = §_-Uq§;
         this.§_-3i§.alpha = 0;
      }
      
      public function Init() : void
      {
         this.§_-c6§ = new §_-Hd§();
         this.§_-c6§.§_-9O§(0,1);
         this.§_-c6§.§_-0g§(0,1);
         this.§_-c6§.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(0.5,1,0),new §_-LE§(1,0,0));
         this.§_-Hl§ = new §_-Hd§();
         this.§_-Hl§.§_-9O§(0,1);
         this.§_-Hl§.§_-0g§(0,1);
         this.§_-Hl§.§_-c3§(true,new §_-LE§(0,0,0),new §_-LE§(1,1,0));
         this.§_-Gn§ = 0;
         this.§_-ng§ = new Bitmap();
         this.§_-3i§ = new Sprite();
         this.§_-3i§.addChild(this.§_-ng§);
         this.mApp.logic.compliments.addEventListener(§_-Rh§.§_-fU§,this.§_-lM§);
         this.mApp.logic.blazingSpeedBonus.AddHandler(this);
         this.§_-ez§ = new Vector.<BitmapData>(§_-CZ§,true);
         this.§_-ez§[0] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_GOOD);
         this.§_-ez§[1] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_EXCELLENT);
         this.§_-ez§[2] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_AWESOME);
         this.§_-ez§[3] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_SPECTACULAR);
         this.§_-ez§[4] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_EXTRAORDINARY);
         this.§_-ez§[5] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_UNBELIEVABLE);
         this.§_-ez§[6] = this.mApp.§_-QZ§.getBitmapData(Blitz3Images.IMAGE_TEXT_BLAZING_SPEED);
         this.§_-1h§ = null;
         this.§_-Y-§ = new Array();
         addChild(this.§_-3i§);
      }
   }
}
