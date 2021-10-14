package com.popcap.flash.bejeweledblitz.game.session.feature
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class Feature
   {
       
      
      protected var _app:Blitz3App;
      
      private var _id:String;
      
      private var _dependenciesArray:Vector.<String>;
      
      private var _isEnabled:Boolean;
      
      public function Feature(param1:Blitz3App, param2:String, param3:Array)
      {
         var _loc4_:String = null;
         super();
         this._app = param1;
         this._id = param2;
         this._dependenciesArray = new Vector.<String>();
         for each(_loc4_ in param3)
         {
            if(!(_loc4_ == null || _loc4_.length == 0))
            {
               this._dependenciesArray.push(_loc4_);
            }
         }
         this._isEnabled = false;
      }
      
      public function getID() : String
      {
         return this._id;
      }
      
      public function getDependencies() : Vector.<String>
      {
         return this._dependenciesArray.slice();
      }
      
      public function isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function enable() : Boolean
      {
         if(this._isEnabled)
         {
            return true;
         }
         this._isEnabled = true;
         var _loc1_:Boolean = this.enableDependencies();
         this._isEnabled = _loc1_;
         return this._isEnabled;
      }
      
      public function updateIsEnabled() : void
      {
         if(!this._isEnabled && this.shouldEnable())
         {
            this.enable();
         }
      }
      
      protected function shouldEnable() : Boolean
      {
         return false;
      }
      
      private function enableDependencies() : Boolean
      {
         return this._app.sessionData.featureManager.enableFeatures(this._dependenciesArray);
      }
   }
}
