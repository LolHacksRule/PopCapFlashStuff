package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.resources.images.ImageInst;
   import flash.geom.ColorTransform;
   
   public class PowerEffect
   {
      
      public static const PowerEffect_Cannon:int = 4;
      
      public static const WHITE:ColorTransform = new ColorTransform(1,1,1,1,0,0,0);
      
      public static const PowerEffect_Stop:int = 3;
      
      public static const PowerEffect_Laser:int = 5;
      
      public static const PowerEffect_Accuracy:int = 1;
      
      public static const PowerEffect_Reverse:int = 2;
      
      public static const PowerEffect_Bomb:int = 0;
       
      
      public var mType:int;
      
      public var mY:Number;
      
      public var mDone:Boolean;
      
      public var mColorType:int;
      
      public var mDrawReverse:Boolean;
      
      public var mX:Number;
      
      public var mItems:Vector.<EffectItem>;
      
      public var mUpdateCount:int;
      
      public var mApp:Zuma2App;
      
      public function PowerEffect(param1:Zuma2App, param2:Number = 0, param3:Number = 0)
      {
         this.mItems = new Vector.<EffectItem>();
         super();
         this.mApp = param1;
         this.mX = param2;
         this.mY = param3;
         this.mType = -1;
         this.mColorType = -1;
         this.mDone = false;
         this.mDrawReverse = false;
         this.mUpdateCount = 0;
      }
      
      public function GetComponentValue(param1:Vector.<Component>, param2:Number, param3:int) : Number
      {
         var _loc5_:Component = null;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            if(param3 < _loc5_.mStartFrame)
            {
               return _loc5_.mValue;
            }
            if(_loc5_.Active(param3))
            {
               return _loc5_.mValue;
            }
            if(_loc4_ == param1.length - 1)
            {
               return _loc5_.mValue;
            }
            _loc4_++;
         }
         return param2;
      }
      
      public function Delete() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.mItems.length)
         {
            this.mItems[_loc1_].Delete();
            _loc1_++;
         }
      }
      
      public function AddDefaultEffectType(param1:int, param2:int, param3:Number = 0) : void
      {
         var _loc4_:ColorTransform = null;
         var _loc5_:ColorTransform = null;
         var _loc6_:EffectItem = null;
         var _loc7_:int = 0;
         var _loc8_:ImageInst = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         switch(param2)
         {
            case Zuma2App.Blue_Ball:
               _loc4_ = new ColorTransform(150 / 255,150 / 255,150 / 255);
               _loc5_ = new ColorTransform(75 / 255,75 / 255,255 / 255);
               break;
            case Zuma2App.Yellow_Ball:
               _loc4_ = new ColorTransform(255 / 255,255 / 255,150 / 255);
               _loc5_ = new ColorTransform(255 / 255,255 / 255,0 / 255);
               break;
            case Zuma2App.Red_Ball:
               _loc4_ = new ColorTransform(250 / 255,140 / 255,0 / 255);
               _loc5_ = new ColorTransform(250 / 255,50 / 255,1 / 255);
               break;
            case Zuma2App.Green_Ball:
               _loc4_ = new ColorTransform(200 / 255,200 / 255,0 / 255);
               _loc5_ = new ColorTransform(0 / 255,185 / 255,118 / 255);
               break;
            case Zuma2App.Purple_Ball:
               _loc4_ = new ColorTransform(255 / 255,100 / 255,255 / 255);
               _loc5_ = new ColorTransform(255 / 255,50 / 255,255 / 255);
            case Zuma2App.White_Ball:
               _loc4_ = new ColorTransform(255 / 255,255 / 255,255 / 255);
               _loc5_ = new ColorTransform(200 / 255,200 / 255,200 / 255);
         }
         this.mType = param1;
         this.mColorType = param2;
         if(param1 == PowerEffect_Bomb)
         {
            _loc7_ = 83;
            (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_POWERUP_POWERPULSES),_loc5_,3)).mScale.push(new Component(1,1.63,83 - _loc7_,115 - _loc7_));
            _loc6_.mOpacity.push(new Component(255,0,100 - _loc7_,130 - _loc7_));
            _loc8_ = this.mApp.imageManager.getImageInst("IMAGE_BLOOM_BLAST_" + this.GetColorName(param2));
            (_loc6_ = this.AddItem(_loc8_,WHITE)).mScale.push(new Component(0.2,1,83 - _loc7_,105 - _loc7_));
            _loc6_.mAngle.push(new Component(param3,param3 + Zuma2App.MY_PI,83 - _loc7_,105 - _loc7_));
            _loc6_.mOpacity.push(new Component(0,128,83 - _loc7_,105 - _loc7_));
            _loc6_.mOpacity.push(new Component(128,0,106 - _loc7_,120 - _loc7_));
            (_loc6_ = this.AddItem(_loc8_,WHITE)).mScale.push(new Component(0.2,1,83 - _loc7_,131 - _loc7_));
            _loc6_.mAngle.push(new Component(param3,param3 - Zuma2App.MY_PI,83 - _loc7_,105 - _loc7_));
            _loc6_.mOpacity.push(new Component(0,128,83 - _loc7_,105 - _loc7_));
            _loc6_.mOpacity.push(new Component(128,0,106 - _loc7_,145 - _loc7_));
         }
         else if(param1 != PowerEffect_Accuracy)
         {
            if(param1 == PowerEffect_Reverse)
            {
               _loc9_ = 8;
               _loc7_ = 70 / _loc9_;
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_BALL_GLOW),_loc4_)).mOpacity.push(new Component(128,255,70 / _loc9_ - _loc7_,210 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(255,0,211 / _loc9_ - _loc7_,310 / _loc9_ - _loc7_));
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_POWERUP_POWERPULSES),_loc5_,4)).mScale.push(new Component(1,2,109 / _loc9_ - _loc7_,385 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(0,0,70 / _loc9_ - _loc7_,108 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(255,255,109 / _loc9_ - _loc7_,360 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(255,0,361 / _loc9_ - _loc7_,485 / _loc9_ - _loc7_));
               _loc6_.mBitmap.rotation = -90;
               _loc8_ = this.mApp.imageManager.getImageInst("IMAGE_BLOOM_REVERSE_" + this.GetColorName(param2));
               (_loc6_ = this.AddItem(_loc8_,WHITE)).mOpacity.push(new Component(0,0,70 / _loc9_ - _loc7_,160 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(0,128,161 / _loc9_ - _loc7_,360 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(128,153,361 / _loc9_ - _loc7_,485 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(153,0,486 / _loc9_ - _loc7_,560 / _loc9_ - _loc7_));
               _loc6_.mScale.push(new Component(0.2,1,160 / _loc9_ - _loc7_,360 / _loc9_ - _loc7_));
               (_loc6_ = this.AddItem(_loc8_,WHITE)).mOpacity.push(new Component(0,0,70 / _loc9_ - _loc7_,335 / _loc9_ - _loc7_));
               _loc6_.mOpacity.push(new Component(0,255,336 / _loc9_ - _loc7_,585 / _loc9_ - _loc7_));
               _loc6_.mScale.push(new Component(0.2,1,335 / _loc9_ - _loc7_,535 / _loc9_ - _loc7_));
            }
            else if(param1 == PowerEffect_Stop)
            {
               if((_loc10_ = param3 - Zuma2App.MY_PI / 2) > Zuma2App.MY_PI)
               {
                  _loc11_ = Zuma2App.MY_PI * 2;
               }
               else
               {
                  _loc11_ = 0;
               }
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_POWERUP_POWERPULSES),WHITE,2)).mOpacity.push(new Component(255,255,0,15));
               _loc6_.mOpacity.push(new Component(255,0,16,21));
               _loc6_.mScale.push(new Component(1,1,0,9));
               _loc6_.mScale.push(new Component(1,2,10,21));
               _loc6_.mAngle.push(new Component(_loc10_,_loc11_,0,20));
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst("IMAGE_BLOOM_STOP_" + this.GetColorName(param2)),WHITE)).mOpacity.push(new Component(0,0,0,9));
               _loc6_.mOpacity.push(new Component(128,255,10,20));
               _loc6_.mOpacity.push(new Component(255,0,40,50));
               _loc6_.mScale.push(new Component(0.5,1.1,10,22));
               _loc6_.mScale.push(new Component(1.1,1,23,30));
               _loc6_.mScale.push(new Component(1,0.5,40,50));
               _loc6_.mYOffset.push(new Component(0,-10,10,20));
               _loc6_.mAngle.push(new Component(_loc10_,_loc11_,0,20));
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst("IMAGE_BLOOM_STOP_" + this.GetColorName(param2)),WHITE)).mOpacity.push(new Component(0,0,0,20));
               _loc6_.mOpacity.push(new Component(0,255,21,26));
               _loc6_.mOpacity.push(new Component(255,0,27,37));
               _loc6_.mScale.push(new Component(1,1.1,20,22));
               _loc6_.mScale.push(new Component(1.1,1,23,27));
               _loc6_.mYOffset.push(new Component(-10,-10,20,20));
               _loc6_.mAngle.push(new Component(_loc10_,_loc11_,0,20));
               (_loc6_ = this.AddItem(this.mApp.imageManager.getImageInst(Zuma2Images.IMAGE_STOP_OUTLINE),WHITE)).mOpacity.push(new Component(0,0,0,24));
               _loc6_.mOpacity.push(new Component(255,0,25,50));
               _loc6_.mScale.push(new Component(1,3,25,50));
               _loc6_.mAngle.push(new Component(_loc10_,_loc11_,0,20));
            }
            else if(param1 == PowerEffect_Laser)
            {
            }
         }
      }
      
      public function Draw() : void
      {
         var _loc4_:EffectItem = null;
         if(this.mDone)
         {
            return;
         }
         var _loc1_:int = !!this.mDrawReverse ? int(this.mItems.length - 1) : 0;
         var _loc2_:int = !!this.mDrawReverse ? 0 : int(this.mItems.length);
         var _loc3_:int = _loc1_;
         while(!!this.mDrawReverse ? _loc3_ >= _loc2_ : _loc3_ < _loc2_)
         {
            (_loc4_ = this.mItems[_loc3_]).mSprite.alpha = this.GetComponentValue(_loc4_.mOpacity,255,this.mUpdateCount) / 255;
            _loc4_.mSprite.rotation = this.GetComponentValue(_loc4_.mAngle,0,this.mUpdateCount) * Zuma2App.RAD_TO_DEG;
            _loc4_.mSprite.scaleX = this.GetComponentValue(_loc4_.mScale,1,this.mUpdateCount);
            _loc4_.mSprite.scaleY = this.GetComponentValue(_loc4_.mScale,1,this.mUpdateCount);
            _loc4_.mSprite.x = this.GetComponentValue(_loc4_.mXOffset,0,this.mUpdateCount) + this.mX * Zuma2App.SHRINK_PERCENT;
            _loc4_.mSprite.y = this.GetComponentValue(_loc4_.mYOffset,0,this.mUpdateCount) + this.mY * Zuma2App.SHRINK_PERCENT;
            _loc3_ += !!this.mDrawReverse ? -1 : 1;
         }
      }
      
      public function UpdateComponentVec(param1:Vector.<Component>, param2:int) : Boolean
      {
         var _loc5_:Component = null;
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < param1.length)
         {
            if((_loc5_ = param1[_loc4_]).Active(param2))
            {
               _loc5_.Update();
               return false;
            }
            if(param2 < _loc5_.mStartFrame)
            {
               _loc3_ = false;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function Update() : void
      {
         var _loc3_:EffectItem = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         if(this.mDone)
         {
            return;
         }
         ++this.mUpdateCount;
         var _loc1_:Boolean = true;
         var _loc2_:int = 0;
         while(_loc2_ < this.mItems.length)
         {
            _loc3_ = this.mItems[_loc2_];
            _loc4_ = this.UpdateComponentVec(_loc3_.mScale,this.mUpdateCount);
            _loc5_ = this.UpdateComponentVec(_loc3_.mAngle,this.mUpdateCount);
            _loc6_ = this.UpdateComponentVec(_loc3_.mOpacity,this.mUpdateCount);
            _loc7_ = this.UpdateComponentVec(_loc3_.mXOffset,this.mUpdateCount);
            _loc8_ = this.UpdateComponentVec(_loc3_.mYOffset,this.mUpdateCount);
            _loc1_ = _loc1_ && _loc4_ && _loc5_ && _loc6_ && _loc7_ && _loc8_;
            _loc2_++;
         }
         this.mDone = _loc1_;
      }
      
      public function IsDone() : Boolean
      {
         return this.mDone;
      }
      
      public function GetColorName(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case 0:
               _loc2_ = "BLUE";
               break;
            case 1:
               _loc2_ = "YELLOW";
               break;
            case 2:
               _loc2_ = "RED";
               break;
            case 3:
               _loc2_ = "GREEN";
               break;
            case 4:
               _loc2_ = "PURPLE";
               break;
            case 5:
               _loc2_ = "WHITE";
               break;
            default:
               _loc2_ = "BLUE";
         }
         return _loc2_;
      }
      
      public function AddItem(param1:ImageInst, param2:ColorTransform, param3:int = 0) : EffectItem
      {
         this.mItems.push(new EffectItem(this.mApp));
         var _loc4_:EffectItem;
         (_loc4_ = this.mItems[this.mItems.length - 1]).mImage = param1;
         _loc4_.mCel = param3;
         _loc4_.mColor = param2;
         _loc4_.Init(this.mX,this.mY);
         return _loc4_;
      }
   }
}
