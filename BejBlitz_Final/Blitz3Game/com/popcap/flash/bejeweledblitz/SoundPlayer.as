package com.popcap.flash.bejeweledblitz
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardStats;
   import flash.media.Sound;
   import flash.media.SoundMixer;
   
   public class SoundPlayer
   {
      
      private static var _soundHash:Object;
      
      private static var _currentLoadingIndex:int = -1;
      
      private static var _loadingArray:Vector.<String>;
      
      private static var _loadedArray:Vector.<String>;
       
      
      public function SoundPlayer()
      {
         super();
      }
      
      public static function stopSound(param1:String) : void
      {
         var _loc2_:SoundObject = null;
         init();
         if(_soundHash[param1] != null)
         {
            _loc2_ = _soundHash[param1];
            if(_loc2_.isLoaded())
            {
               _loc2_.stopSound();
            }
         }
      }
      
      public static function stopAllSounds() : void
      {
         SoundMixer.stopAll();
      }
      
      public static function fadeOutSound(param1:String, param2:Number) : void
      {
         var _loc3_:SoundObject = null;
         if(_soundHash[param1] != null)
         {
            _loc3_ = _soundHash[param1];
            _loc3_.fadeOutSound(param2);
         }
      }
      
      public static function isPlaying(param1:String) : Boolean
      {
         var _loc2_:SoundObject = null;
         if(_soundHash[param1] != null)
         {
            _loc2_ = _soundHash[param1];
            return _loc2_.isPlaying();
         }
         return false;
      }
      
      public static function playSound(param1:String, param2:Boolean = true, param3:Number = 1) : Boolean
      {
         var _loc4_:SoundObject = null;
         init();
         if(_soundHash[param1] != null)
         {
            if((_loc4_ = _soundHash[param1]).isLoaded())
            {
               _loc4_.playSound(param2,param3);
               return true;
            }
         }
         else if(addSound(param1,AssetLoader.getNewSoundFromAssetID(param1)))
         {
            return playSound(param1);
         }
         return false;
      }
      
      public static function loadSound(param1:String) : String
      {
         var _loc3_:SoundObject = null;
         init();
         var _loc2_:String = Utils.getAlphaNumeric(param1);
         if(!isQueued(_loc2_))
         {
            _loc3_ = new SoundObject(_loc2_,param1);
            _soundHash[_loc2_] = _loc3_;
            _loadingArray.push(_loc2_);
            loadNext();
         }
         return _loc2_;
      }
      
      public static function addSound(param1:String, param2:Sound) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:SoundObject = null;
         if(param2 == null)
         {
            return false;
         }
         for each(_loc3_ in _loadingArray)
         {
            if(_loc3_ == param1)
            {
               return false;
            }
         }
         (_loc4_ = new SoundObject(param1)).addSound(param2);
         if(_soundHash != null)
         {
            _soundHash[param1] = _loc4_;
            return true;
         }
         return false;
      }
      
      public static function playRandomSound() : void
      {
         var _loc1_:SoundObject = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         init();
         if(_loadedArray.length == 0)
         {
            return;
         }
         if(_loadedArray.length >= LeaderboardStats.NUM_CAT_MEOWS + 1 && Math.random() * 200 <= 1)
         {
            _loc2_ = _loadedArray[LeaderboardStats.NUM_CAT_MEOWS];
            _loc1_ = _soundHash[_loc2_];
            _loc1_.playSound();
         }
         else
         {
            _loc3_ = Math.floor(Math.random() * (_loadedArray.length - 1));
            _loc4_ = _loadedArray[_loc3_];
            _loc1_ = _soundHash[_loc4_];
            _loc1_.playSound();
         }
      }
      
      private static function init() : void
      {
         if(_soundHash == null)
         {
            _soundHash = new Object();
         }
         if(_loadingArray == null)
         {
            _loadingArray = new Vector.<String>();
         }
         if(_loadedArray == null)
         {
            _loadedArray = new Vector.<String>();
         }
      }
      
      private static function areAllLoading() : Boolean
      {
         init();
         return _currentLoadingIndex >= _loadingArray.length - 1;
      }
      
      private static function isQueued(param1:String) : Boolean
      {
         init();
         var _loc2_:SoundObject = _soundHash[param1] as SoundObject;
         return _loc2_ != null;
      }
      
      private static function isLoading(param1:String) : Boolean
      {
         init();
         var _loc2_:SoundObject = _soundHash[param1] as SoundObject;
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.isLoaded == false;
      }
      
      public static function isLoaded(param1:String) : Boolean
      {
         init();
         var _loc2_:SoundObject = _soundHash[param1] as SoundObject;
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.isLoaded();
      }
      
      private static function loadNext() : void
      {
         var _loc2_:String = null;
         var _loc3_:SoundObject = null;
         init();
         var _loc1_:Boolean = true;
         if(_currentLoadingIndex >= 0 && _loadingArray.length >= 1)
         {
            _loc2_ = _loadingArray[_currentLoadingIndex];
            _loc3_ = _soundHash[_loc2_];
            if(!_loc3_.isLoaded())
            {
               _loc1_ = false;
            }
         }
         if(_loc1_ && _currentLoadingIndex < _loadingArray.length - 1)
         {
            ++_currentLoadingIndex;
            _loc2_ = _loadingArray[_currentLoadingIndex];
            _loc3_ = _soundHash[_loc2_];
            _loc3_.loadSound(onLoaded);
         }
      }
      
      private static function onLoaded(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(param1)
         {
            _loc2_ = _loadingArray[_currentLoadingIndex];
            _loadedArray.push(_loc2_);
         }
         loadNext();
      }
   }
}
