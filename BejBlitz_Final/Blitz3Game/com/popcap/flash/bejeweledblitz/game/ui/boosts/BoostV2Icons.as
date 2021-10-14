package com.popcap.flash.bejeweledblitz.game.ui.boosts
{
   import com.popcap.flash.bejeweledblitz.BoostAssetLoaderInterface;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.boostV2.BoostV2EventDispatcher;
   import com.popcap.flash.games.blitz3.BoostDailogMC;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class BoostV2Icons
   {
       
      
      private var _app:Blitz3App;
      
      private var _boostAssetCounter:int = 0;
      
      public function BoostV2Icons(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._app.sessionData.boostV2Manager.boostEventDispatcher.addEventListener(BoostV2EventDispatcher.BOOST_CONFIG_FETCH_COMPLETE,this.loadAllBoosts);
      }
      
      private function loadAllBoosts(param1:Event) : void
      {
         var _loc2_:BoostAssetLoaderInterface = new BoostAssetLoaderInterface(this._app);
         var _loc3_:int = 0;
         while(_loc3_ < this._app.sessionData.boostV2Manager.boostV2Configs.length)
         {
            _loc2_.load(this._app.sessionData.boostV2Manager.boostV2Configs[_loc3_].getBoostUIConfig().getId(),this.OnLoadProgress,this.OnLoadComplete);
            _loc3_++;
         }
      }
      
      public function OnLoadProgress(param1:Number) : void
      {
      }
      
      public function OnLoadComplete() : void
      {
         ++this._boostAssetCounter;
         if(this._boostAssetCounter == this._app.sessionData.boostV2Manager.boostV2Configs.length)
         {
            trace("Boost loading complete");
            this._app.sessionData.boostV2Manager.boostEventDispatcher.sendEvent(BoostV2EventDispatcher.BOOST_ASSET_DOWNLOAD_COMPLETE);
         }
      }
      
      public function getBitmapDataOfInGameBoostState(param1:String, param2:String) : BitmapData
      {
         var _loc3_:Bitmap = BoostAssetLoaderInterface.getImage(param1,"Game_Boost_Image_" + param2,false);
         if(_loc3_ != null)
         {
            return _loc3_.bitmapData.clone();
         }
         return null;
      }
      
      public function getInGameBoostState(param1:String, param2:String, param3:MovieClip) : void
      {
         var boostID:String = param1;
         var state:String = param2;
         var holder:MovieClip = param3;
         try
         {
            BoostAssetLoaderInterface.attachBitmap(boostID,"Game_Boost_Image_" + state,holder,1,1,false);
         }
         catch(e:Error)
         {
            trace("getImage failed to load image: boost ID: " + boostID + " image ID : " + state);
         }
      }
      
      public function getUIBoostIconMC(param1:String) : MovieClip
      {
         var iconName:String = null;
         var boostID:String = param1;
         var boostDialogMC:BoostDailogMC = new BoostDailogMC();
         try
         {
            iconName = "Menu_Boost_Image_Normal";
            BoostAssetLoaderInterface.attachBitmap(boostID,iconName,boostDialogMC.Boostplaceholder,1,1,false);
         }
         catch(e:Error)
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"getImage failed to load image: boost ID: " + boostID + " image ID : Dialogicon");
            trace("getImage failed to load image: boost ID: " + boostID + " image ID : Dialogicon");
         }
         return boostDialogMC;
      }
      
      public function getLBBoostIconMC(param1:String, param2:MovieClip) : void
      {
         var iconName:String = null;
         var boostID:String = param1;
         var targetContainer:MovieClip = param2;
         try
         {
            iconName = "LB_Boost_Image_Normal";
            BoostAssetLoaderInterface.attachBitmap(boostID,iconName,targetContainer,1,1,false);
         }
         catch(e:Error)
         {
            trace("getImage failed to load image: boost ID: " + boostID + " image ID : Dialogicon");
         }
      }
      
      public function getBoostAnimIconByID(param1:String) : BitmapData
      {
         var iconBitmapdata:BitmapData = null;
         var boostID:String = param1;
         var imageBitmap:Bitmap = BoostAssetLoaderInterface.getImage(boostID,"Icon",false);
         try
         {
            iconBitmapdata = imageBitmap.bitmapData.clone();
            return iconBitmapdata;
         }
         catch(e:Error)
         {
            trace("getImage failed to load image: boost ID: " + boostID + " image ID : Icon");
            return null;
         }
      }
   }
}
