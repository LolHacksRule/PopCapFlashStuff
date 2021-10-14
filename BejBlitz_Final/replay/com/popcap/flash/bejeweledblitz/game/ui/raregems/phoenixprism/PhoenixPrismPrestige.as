package com.popcap.flash.bejeweledblitz.game.ui.raregems.phoenixprism
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.framework.anim.AnimatedSprite;
   import com.popcap.flash.framework.anim.AnimationEvent;
   import com.popcap.flash.framework.anim.KeyframeData;
   import com.popcap.flash.framework.utils.StringUtils;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.filters.BevelFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class PhoenixPrismPrestige extends Sprite
   {
      
      private static const STATE_INACTIVE:int = 0;
      
      private static const STATE_ACTIVE:int = 1;
      
      private static const STATE_PAUSED:int = 2;
      
      private static const BASE_BONUS_POINTS:int = 1500;
      
      private static const ANIM_NAME:String = "PRIMARY";
       
      
      private var m_State:int = 0;
      
      private var m_LastState:int = 0;
      
      private var m_Frame:int = 0;
      
      private var m_HitJackpot:Boolean = false;
      
      private var m_App:Blitz3App;
      
      private var m_Phoenix:Phoenix;
      
      private var m_CoinPrestige:CoinPrestige;
      
      private var m_Explosion:PhoenixPrismExplosion;
      
      private var m_BonusTextSprite:AnimatedSprite;
      
      private var m_BonusText:TextField;
      
      private var m_Feathers:Vector.<PhoenixFeather>;
      
      private var m_AwardFeather:PhoenixFeather;
      
      private var m_DarkLayer:Shape;
      
      public function PhoenixPrismPrestige(app:Blitz3App)
      {
         this.m_Feathers = new Vector.<PhoenixFeather>(0);
         super();
         this.m_App = app;
         this.m_DarkLayer = new Shape();
         this.m_Phoenix = new Phoenix(app);
         this.m_CoinPrestige = new CoinPrestige(this.m_App,this);
         this.m_Explosion = new PhoenixPrismExplosion(this.m_App,true);
         this.m_BonusTextSprite = new AnimatedSprite();
         this.m_BonusTextSprite.addEventListener(AnimationEvent.EVENT_ANIMATION_COMPLETE,this.HandleAnimComplete);
         this.m_BonusTextSprite.visible = false;
         var format:TextFormat = new TextFormat(Blitz3GameFonts.FONT_FLARE_GOTHIC,32);
         format.align = TextFormatAlign.CENTER;
         this.m_BonusText = new TextField();
         this.m_BonusText.embedFonts = true;
         this.m_BonusText.defaultTextFormat = format;
         this.m_BonusText.autoSize = TextFieldAutoSize.CENTER;
         this.m_BonusText.filters = [new GlowFilter(16777215,0.5,10,10),new BevelFilter(2),new DropShadowFilter(2)];
         this.m_BonusTextSprite.addChild(this.m_BonusText);
      }
      
      public function Init() : void
      {
         var feather:PhoenixFeather = null;
         addChild(this.m_DarkLayer);
         addChild(this.m_Explosion);
         addChild(this.m_Phoenix);
         addChild(this.m_BonusTextSprite);
         addChild(this.m_CoinPrestige);
         this.m_DarkLayer.graphics.beginFill(0,0.5);
         this.m_DarkLayer.graphics.drawRect(0,0,this.m_App.uiFactory.GetGameWidth(),this.m_App.uiFactory.GetGameHeight());
         this.m_DarkLayer.graphics.endFill();
         this.m_DarkLayer.x = -this.m_App.ui.game.board.x;
         this.m_DarkLayer.y = -this.m_App.ui.game.board.y - 20;
         this.m_DarkLayer.cacheAsBitmap = true;
         this.m_Phoenix.x = 160;
         this.m_Phoenix.y = 320;
         this.m_Phoenix.Init();
         this.m_CoinPrestige.x = -this.m_App.ui.game.board.x;
         this.m_CoinPrestige.y = -this.m_App.ui.game.board.y - 20;
         this.m_CoinPrestige.Init();
         for each(feather in this.m_Feathers)
         {
            feather.Init();
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         var feather:PhoenixFeather = null;
         visible = false;
         this.m_State = STATE_INACTIVE;
         this.m_BonusTextSprite.visible = false;
         this.m_Frame = 0;
         this.m_HitJackpot = false;
         this.m_Phoenix.Reset();
         this.m_CoinPrestige.Reset();
         for each(feather in this.m_Feathers)
         {
            feather.Reset(false);
         }
         this.m_AwardFeather = null;
      }
      
      public function Update() : void
      {
         if(this.m_State == STATE_INACTIVE || this.m_State == STATE_PAUSED)
         {
            return;
         }
         ++this.m_Frame;
         if(this.m_Frame == 1 || this.m_Frame == 200)
         {
            this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_RG_APPEAR_PHOENIXPRISM);
         }
         if(this.m_Frame < 200 || this.m_Frame > 200 && this.m_Frame < 300)
         {
            this.m_Explosion.UpdatePrestige();
         }
         else if(this.m_Frame == 200 || this.m_Frame == 300)
         {
            this.m_Explosion.Reset();
         }
         if(this.m_Frame < 1000)
         {
            this.m_Phoenix.Update();
            this.m_BonusTextSprite.Update();
         }
         if(!this.m_App.isReplayer)
         {
            if(this.m_Frame > 410 && this.m_Frame < 1300)
            {
               this.m_CoinPrestige.Update();
            }
            if(this.m_Frame > 350 && this.m_Frame < 1300)
            {
               this.UpdateFeathers();
            }
            if(this.m_Frame >= 1000 && this.m_HitJackpot)
            {
               this.m_CoinPrestige.ExplodeCoins();
            }
            if(this.m_Frame >= 1200 && this.m_HitJackpot)
            {
               this.m_CoinPrestige.OfferShare();
            }
            else if(this.m_Frame >= 1500)
            {
               this.Done();
            }
         }
         else if(this.m_Frame == 550)
         {
            this.Done();
         }
      }
      
      public function ShowBonusText(points:int, mult:int) : void
      {
         this.m_BonusTextSprite.visible = true;
         var content:String = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_PHOENIX_PRISM_BONUS);
         content = content.replace("%s",StringUtils.InsertNumberCommas(points));
         content = content.replace("%s",mult);
         content = content.replace(/<[bB][rR]>/,"\n");
         this.m_BonusText.htmlText = content;
         this.m_BonusText.x = this.m_BonusText.textWidth * -0.5;
         this.m_BonusText.y = this.m_BonusText.textHeight * -0.5;
         var rect:Rectangle = this.m_App.ui.game.sidebar.score.getRect(this);
         var phoenixHeight:Number = this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_PP_PRESTIGE_PHOENIX).height;
         this.m_BonusTextSprite.ClearAnims();
         var anim:Vector.<KeyframeData> = new Vector.<KeyframeData>();
         anim.push(new KeyframeData(0,this.m_Phoenix.x,this.m_Phoenix.y - phoenixHeight * 0.33,0,0));
         anim.push(new KeyframeData(50,this.m_Phoenix.x,this.m_Phoenix.y - phoenixHeight * 0.33,1,1));
         anim.push(new KeyframeData(150,this.m_Phoenix.x,this.m_Phoenix.y - phoenixHeight * 0.33,1,1));
         anim.push(new KeyframeData(400,rect.x + rect.width * 0.5,rect.y + rect.height * 0.25,0,0));
         this.m_BonusTextSprite.AddAnimation(ANIM_NAME,anim);
         this.m_BonusTextSprite.PlayAnimation(ANIM_NAME);
      }
      
      public function GetAwardFeather() : PhoenixFeather
      {
         var index:int = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_PHOENIX_PAYOUT_INDEX);
         if(index < 0 || index > this.m_Feathers.length - 1)
         {
            index = 0;
         }
         return this.m_Feathers[index];
      }
      
      public function Show() : void
      {
         visible = true;
         this.m_State = STATE_ACTIVE;
         this.PreenFeathers();
      }
      
      public function Done() : void
      {
         this.Reset();
         this.m_State = STATE_INACTIVE;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_State == STATE_INACTIVE;
      }
      
      public function GameEnd() : void
      {
         this.Done();
      }
      
      public function GameAbort() : void
      {
         this.Done();
      }
      
      public function Pause() : void
      {
         if(this.m_State == STATE_ACTIVE)
         {
            this.m_LastState = this.m_State;
            this.m_State = STATE_PAUSED;
            this.m_CoinPrestige.visible = false;
         }
      }
      
      public function Resume() : void
      {
         if(this.m_State == STATE_PAUSED)
         {
            this.m_State = this.m_LastState;
            this.m_CoinPrestige.visible = true;
         }
      }
      
      private function UpdateFeathers() : void
      {
         var feather:PhoenixFeather = null;
         var featherState:int = 0;
         for each(feather in this.m_Feathers)
         {
            feather.Update();
            featherState += feather.State;
         }
      }
      
      private function PreenFeathers() : void
      {
         var payouts:Array = null;
         var i:int = 0;
         var payout:int = 0;
         var feather:PhoenixFeather = null;
         var curFeather:PhoenixFeather = null;
         var index:int = 0;
         var isAwarded:Boolean = false;
         var point:Point = null;
         payouts = this.m_App.sessionData.configManager.GetArray(ConfigManager.ARRAY_PHOENIX_PAYOUTS);
         var numPayouts:int = payouts.length;
         var numFeathers:int = this.m_Feathers.length;
         if(numPayouts < numFeathers)
         {
            for(i = numPayouts; i < numFeathers; i++)
            {
               removeChild(this.m_Feathers[i]);
            }
            this.m_Feathers.length = payouts.length;
         }
         else if(numPayouts > numFeathers)
         {
            this.m_Feathers.length = payouts.length;
            for(i = numFeathers; i < numPayouts; i++)
            {
               feather = new PhoenixFeather(this.m_App,i);
               feather.Init();
               this.m_Feathers[i] = feather;
               addChildAt(feather,numChildren - 1);
            }
         }
         var maxValue:int = 0;
         for each(payout in payouts)
         {
            if(payout > maxValue)
            {
               maxValue = payout;
            }
         }
         for(i = 0; i < numPayouts; i++)
         {
            curFeather = this.m_Feathers[i];
            index = this.m_App.sessionData.configManager.GetInt(ConfigManager.INT_PHOENIX_PAYOUT_INDEX);
            if(index < 0 || index > this.m_Feathers.length - 1)
            {
               index = 0;
            }
            isAwarded = i == index;
            curFeather.visible = true;
            if(payouts[i] <= 0)
            {
               curFeather.visible = false;
            }
            curFeather.Reset(isAwarded);
            curFeather.SetValue(payouts[i]);
            if(payouts[i] == maxValue)
            {
               curFeather.SetJackpot(true);
               if(isAwarded)
               {
                  this.m_HitJackpot = true;
               }
            }
            if(curFeather.parent != this)
            {
               addChildAt(curFeather,numChildren - 1);
            }
            if(isAwarded)
            {
               point = new Point(curFeather.x,curFeather.y);
               point = this.m_CoinPrestige.globalToLocal(localToGlobal(point));
               curFeather.x = point.x;
               curFeather.y = point.y;
               this.m_CoinPrestige.addChild(curFeather);
               this.m_AwardFeather = curFeather;
            }
         }
      }
      
      public function get AwardFeather() : PhoenixFeather
      {
         return this.m_AwardFeather;
      }
      
      private function HandleAnimComplete(event:AnimationEvent) : void
      {
         if(event.animationName == ANIM_NAME)
         {
            this.m_BonusTextSprite.visible = false;
         }
      }
   }
}
