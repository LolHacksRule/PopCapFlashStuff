package com.popcap.flash.bejeweledblitz.game.ui.gameover.levels
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.Bitmap;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class LevelCrestCache
   {
      
      protected static const MIN_TO_LOAD:int = 3;
      
      protected static const MAX_IMAGE_LEVEL:int = 100;
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Loaders:Dictionary;
      
      public function LevelCrestCache(param1:Blitz3App)
      {
         super();
         this.m_App = param1;
         this.m_Loaders = new Dictionary();
      }
      
      public function SetNextLevel(param1:Number) : void
      {
         this.LoadLevels(param1,MIN_TO_LOAD);
      }
      
      public function LoadLevels(param1:Number, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2)
         {
            this.LoadCrest(param1 + _loc3_);
            _loc3_++;
         }
      }
      
      public function GetCrest(param1:Number) : LevelCrestLoader
      {
         var _loc2_:Number = Math.min(param1,MAX_IMAGE_LEVEL);
         var _loc3_:LevelCrestLoader = this.m_Loaders[_loc2_];
         if(!_loc3_)
         {
            this.LoadCrest(_loc2_);
            _loc3_ = this.m_Loaders[_loc2_];
         }
         return _loc3_;
      }
      
      protected function LoadCrest(param1:Number) : void
      {
         var _loc2_:Number = Math.min(param1,MAX_IMAGE_LEVEL);
         var _loc3_:LevelCrestLoader = this.m_Loaders[_loc2_];
         if(_loc3_)
         {
            if(_loc3_.loadState != LevelCrestLoader.STATE_LOAD_ERROR)
            {
               return;
            }
         }
         _loc3_ = new LevelCrestLoader(_loc2_);
         _loc3_.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleLoadError);
         _loc3_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleLoadError);
         var _loc4_:String = "" + _loc2_;
         if(_loc2_ < 100)
         {
            _loc4_ = "0" + _loc4_;
         }
         if(_loc2_ < 10)
         {
            _loc4_ = "0" + _loc4_;
         }
         var _loc5_:* = this.m_App.network.GetFlashPath() + "level_crests/" + _loc4_ + ".png";
         Utils.log(this,"LoadCrest loading crest image: " + _loc5_);
         _loc3_.load(new URLRequest(_loc5_),new LoaderContext(true));
         _loc3_.loadState = LevelCrestLoader.STATE_LOAD_BEGUN;
         this.m_Loaders[_loc2_] = _loc3_;
      }
      
      protected function HandleLoadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Bitmap = _loc2_.content as Bitmap;
         if(_loc3_ != null)
         {
            _loc3_.smoothing = true;
         }
         var _loc4_:LevelCrestLoader;
         if((_loc4_ = _loc2_.loader as LevelCrestLoader) == null)
         {
            _loc4_.loadState = LevelCrestLoader.STATE_LOAD_COMPLETE;
         }
      }
      
      protected function HandleLoadError(param1:IOErrorEvent) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"LevelCrestCache load error: " + param1.toString());
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:LevelCrestLoader = _loc2_.loader as LevelCrestLoader;
         if(_loc3_ != null)
         {
            _loc3_.loadState = LevelCrestLoader.STATE_LOAD_ERROR;
         }
      }
   }
}
