package com.popcap.flash.games.zuma2.logic
{
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ScoreBlip
   {
       
      
      public var mBulgeDir:Number;
      
      public var mLife:int;
      
      public var mAlphaDecRate:Number;
      
      public var mX:Number;
      
      public var mY:Number;
      
      public var mSize:Number;
      
      public var mDone:Boolean;
      
      public var mTextFormat:TextFormat;
      
      public var mAlphaDelay:Number;
      
      public var mBulgePct:Number;
      
      public var mUpdateCount:int;
      
      public var mSpeed:Number;
      
      public var mTextSprite:Sprite;
      
      public var mTextField:TextField;
      
      public var mAlpha:Number;
      
      public var mColor:uint;
      
      public var mBulgeDec:Number;
      
      public var mText:String;
      
      public var mApp:Zuma2App;
      
      public var mAlphaFadeDelay:Number;
      
      public var mBulgeAmt:Number;
      
      public function ScoreBlip(param1:Zuma2App, param2:String, param3:Number, param4:Number, param5:uint)
      {
         super();
         this.mApp = param1;
         this.mText = param2;
         this.mColor = param5;
         this.mX = param3;
         this.mY = param4;
         if(this.mX < 150)
         {
            this.mX = 150;
         }
         if(this.mX > 600)
         {
            this.mX = 600;
         }
         if(this.mY < 0)
         {
            this.mY = 0;
         }
         if(this.mY > 600)
         {
            this.mY = 600;
         }
         this.mSize = 1;
         this.mLife = 25;
         this.mSpeed = 0.5;
         this.mAlphaFadeDelay = 50;
         this.mAlphaDecRate = 5;
         this.mAlpha = 255;
         this.mDone = false;
         this.mTextSprite = new Sprite();
         this.mTextFormat = new TextFormat();
         this.mTextFormat.font = "BonusText";
         this.mTextFormat.align = TextFormatAlign.CENTER;
         this.mTextFormat.color = param5;
         this.mTextFormat.size = 24;
         var _loc6_:GlowFilter = new GlowFilter(0,1,2,2,200);
         this.mTextField = new TextField();
         this.mTextField.embedFonts = true;
         this.mTextField.defaultTextFormat = this.mTextFormat;
         this.mTextField.filters = [_loc6_];
         this.mTextField.textColor = param5;
         this.mTextField.width = 200;
         this.mTextField.height = 100;
         this.mTextField.x = -this.mTextField.width / 2;
         this.mTextField.y = -this.mTextField.height / 2;
         this.mTextField.alpha = 1;
         this.mTextField.selectable = false;
         this.mTextField.multiline = true;
         this.mTextField.wordWrap = true;
         this.mTextField.text = param2;
         this.mTextSprite.alpha = 1;
         this.mTextSprite.addChild(this.mTextField);
         this.mTextSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
         this.mTextSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
         this.mApp.mLayers[3].mBackground.addChild(this.mTextSprite);
      }
      
      public function Update() : void
      {
         ++this.mUpdateCount;
         if(this.mDone)
         {
            return;
         }
         if(this.mBulgeDir != 0)
         {
            this.mSize += this.mBulgeDir * this.mBulgeAmt;
            if(this.mBulgeDir > 0 && this.mSize >= this.mBulgePct)
            {
               this.mSize = this.mBulgePct;
               this.mBulgeDir = -1;
               this.mBulgePct -= this.mBulgeDec;
            }
            else if(this.mBulgeDir < 0 && this.mSize <= 1)
            {
               this.mSize = 1;
               this.mBulgeDir = 1;
            }
            if(this.mSize <= 1 && this.mBulgePct <= 1)
            {
               this.mSize = 1;
               this.mBulgeDir = 0;
            }
         }
         this.mY -= this.mSpeed;
         if(this.mY < -this.mTextField.height)
         {
            this.mDone = true;
         }
         if(--this.mLife <= 0)
         {
            this.mLife = 0;
            if(this.mAlpha <= 0)
            {
               this.mDone = true;
            }
         }
         if(--this.mAlphaFadeDelay <= 0)
         {
            this.mAlpha -= this.mAlphaDecRate;
            if(this.mAlpha < 0)
            {
               this.mAlpha = 0;
               if(this.mLife <= 0)
               {
                  this.mDone = true;
               }
            }
         }
      }
      
      public function Delete() : void
      {
         if(this.mTextSprite != null)
         {
            if(this.mTextSprite.parent != null)
            {
               this.mTextSprite.parent.removeChild(this.mTextSprite);
            }
         }
      }
      
      public function Draw() : void
      {
         var _loc1_:Number = NaN;
         if(!this.mDone)
         {
            _loc1_ = this.mLife / 18;
            if(_loc1_ > 1)
            {
               _loc1_ = 1;
            }
            this.mTextSprite.scaleX = this.mSize;
            this.mTextSprite.scaleY = this.mSize;
            this.mTextSprite.x = this.mX * Zuma2App.SHRINK_PERCENT;
            this.mTextSprite.y = this.mY * Zuma2App.SHRINK_PERCENT;
            this.mTextSprite.alpha = this.mAlpha / 255;
         }
      }
      
      public function Bulge(param1:Number, param2:Number, param3:int) : void
      {
         this.mSize = 1;
         this.mBulgePct = param1;
         this.mBulgeAmt = param2;
         this.mBulgeDir = 1;
         this.mBulgeDec = (param1 - 1) / Number(param3);
      }
   }
}
