package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.AppUtils;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class LevelMgr
   {
       
      
      public var mLevelXML:String;
      
      public var mReady:Boolean;
      
      public var mPostZumaTime:int;
      
      public var mHasFailed:Boolean;
      
      public var mPowerDelay:int = 1500;
      
      public var mError:String;
      
      public var mUniquePowerupColor:Boolean = true;
      
      public var mPowerupSpawnDelay:int = 700;
      
      public var mPowerCooldown:int = 1000;
      
      public var mXMLParser:XML;
      
      public var mIsHardConfig:Boolean;
      
      public var mMinMultBallDistance:int = 3;
      
      public var mMapPoints:Vector.<Point>;
      
      public var mApp:Zuma2App;
      
      public var mCurDir:String;
      
      public var mLevels:Array;
      
      public var mClearCurveRolloutPct:Number;
      
      public function LevelMgr(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
      }
      
      public function SetupCurveInfoFromXML(param1:String, param2:Level, param3:int) : void
      {
         ++param2.mNumCurves;
         param2.mCurveMgr[param3 - 1] = new CurveMgr(this.mApp);
         param2.mCurveMgr[param3 - 1].mLevel = param2;
         param2.mCurveMgr[param3 - 1].mPath = param1;
      }
      
      public function DoParseTunnel(param1:XML, param2:Level) : void
      {
         var _loc3_:int = param1.Tunnel.length();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param2.mTunnelData[_loc4_] = new TunnelData();
            param2.mTunnelData[_loc4_].mPriority = param1.Tunnel[_loc4_].attribute("pri");
            param2.mTunnelData[_loc4_].mX = param1.Tunnel[_loc4_].attribute("x");
            param2.mTunnelData[_loc4_].mY = param1.Tunnel[_loc4_].attribute("y");
            _loc4_++;
         }
      }
      
      public function LoadLevels(param1:Event) : void
      {
         this.mLevels = new Array();
         this.mXMLParser = new XML(param1.target.data);
         this.DoParseLevels();
      }
      
      public function DoParseLevels() : void
      {
         var _loc3_:Level = null;
         var _loc4_:String = null;
         var _loc1_:int = this.mXMLParser.Level.length();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new Level(this.mApp);
            _loc3_.mId = this.mXMLParser.Level[_loc2_].attribute("id");
            _loc3_.mDisplayName = this.mXMLParser.Level[_loc2_].attribute("dispname");
            _loc3_.mDrawCurves = AppUtils.asBoolean(this.mXMLParser.Level[_loc2_].attribute("drawcurve"));
            _loc3_.mParTime = this.mXMLParser.Level[_loc2_].attribute("partime");
            _loc3_.mTreasureFreq = this.mXMLParser.Level[_loc2_].attribute("tfreq");
            this.SetupCurveInfoFromXML(this.mXMLParser.Level[_loc2_].attribute("curve1"),_loc3_,1);
            if(_loc4_ = this.mXMLParser.Level[_loc2_].attribute("curve2"))
            {
               this.SetupCurveInfoFromXML(_loc4_,_loc3_,2);
            }
            this.DoParseTreasure(this.mXMLParser.Level[_loc2_],_loc3_);
            this.DoParseTunnel(this.mXMLParser.Level[_loc2_],_loc3_);
            this.DoParseGun(this.mXMLParser.Level[_loc2_],_loc3_);
            this.mLevels[_loc2_] = _loc3_;
            _loc2_++;
         }
         this.mReady = true;
      }
      
      public function DoParseGun(param1:XML, param2:Level) : void
      {
         var _loc3_:int = param1.Gun.length();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param2.mMoveType = param1.Gun[_loc4_].attribute("type");
            param2.mFrogX[0] = param1.Gun[_loc4_].attribute("gx1");
            param2.mFrogY[0] = param1.Gun[_loc4_].attribute("gy1");
            if(param1.Gun.gx2)
            {
               param2.mFrogX[1] = param1.Gun.attribute("gx2");
               param2.mFrogY[1] = param1.Gun.attribute("gy2");
            }
            _loc4_++;
         }
      }
      
      public function DoParseTreasure(param1:XML, param2:Level) : void
      {
         var _loc3_:int = param1.TreasurePoint.length();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            param2.mTreasurePoints[_loc4_] = new TreasurePoint();
            param2.mTreasurePoints[_loc4_].x = param1.TreasurePoint[_loc4_].attribute("x");
            param2.mTreasurePoints[_loc4_].y = param1.TreasurePoint[_loc4_].attribute("y");
            param2.mTreasurePoints[_loc4_].mCurveDist[0] = param1.TreasurePoint[_loc4_].attribute("dist1");
            if(param1.TreasurePoint.dist2)
            {
               param2.mTreasurePoints[_loc4_].mCurveDist[1] = param1.TreasurePoint[_loc4_].attribute("dist2");
            }
            _loc4_++;
         }
      }
      
      public function GetLevelByIndex(param1:int) : Level
      {
         if(param1 < 0 || param1 > this.mLevels.length)
         {
            return null;
         }
         return this.mLevels[param1];
      }
      
      public function LoadXML(param1:String) : void
      {
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,this.LoadLevels);
         _loc2_.load(new URLRequest(param1));
      }
   }
}
