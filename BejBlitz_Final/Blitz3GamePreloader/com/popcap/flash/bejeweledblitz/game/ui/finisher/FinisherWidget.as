package com.popcap.flash.bejeweledblitz.game.ui.finisher
{
   import com.popcap.flash.bejeweledblitz.SoundPlayer;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.finisher.config.IFinisherPopupConfig;
   import flash.display.MovieClip;
   import flash.media.Sound;
   import flash.system.ApplicationDomain;
   
   public class FinisherWidget
   {
       
      
      private var _base:MovieClip = null;
      
      private var _applicationDomain:ApplicationDomain = null;
      
      private var _app:Blitz3App;
      
      private var _finisherId:String;
      
      public function FinisherWidget(param1:Blitz3App, param2:String, param3:MovieClip)
      {
         super();
         this._app = param1;
         this._base = param3;
         this._applicationDomain = this._base.loaderInfo.applicationDomain;
         this._finisherId = param2;
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:MovieClip = this._base.getMovieClip("MovieClip" + param1);
         if(_loc2_ == null)
         {
            trace("getMovieClip cannot find " + param1 + " swf embedded");
         }
         return _loc2_;
      }
      
      public function getFinisherIntroWidget() : FinisherIntroWidget
      {
         var _loc1_:MovieClip = this.getMovieClip(FinisherFacade.INTRO_ANIM);
         if(_loc1_ != null)
         {
            return new FinisherIntroWidget(this._app,_loc1_,this);
         }
         return null;
      }
      
      public function getFinisherEntryIntroWidget() : FinisherEntryIntroWidget
      {
         var _loc1_:MovieClip = this.getMovieClip(FinisherFacade.FINISHER_SHOW);
         if(_loc1_ != null)
         {
            return new FinisherEntryIntroWidget(this._app,_loc1_);
         }
         return null;
      }
      
      public function getFinisherActorWidget() : FinisherActorWidget
      {
         var _loc1_:MovieClip = this.getMovieClip(FinisherFacade.FINISHER_ACTOR);
         if(_loc1_ != null)
         {
            return new FinisherActorWidget(this._app,_loc1_);
         }
         return null;
      }
      
      public function getFinisherPropWidget() : FinisherPropWidget
      {
         var _loc1_:MovieClip = this.getMovieClip(FinisherFacade.FINISHER_PROP);
         if(_loc1_ != null)
         {
            return new FinisherPropWidget(this._app,_loc1_);
         }
         return null;
      }
      
      public function getFinisherPopupWidget(param1:IFinisherPopupConfig) : FinisherPopupWidget
      {
         var _loc2_:MovieClip = this.getMovieClip(FinisherFacade.FINISHER_POPUP);
         if(_loc2_ != null)
         {
            return new FinisherPopupWidget(this._app,_loc2_,this,param1);
         }
         return null;
      }
      
      public function getFinisherIndicatorWidget() : MovieClip
      {
         return this.getMovieClip(FinisherFacade.FINISHER_FRAME_INDICATOR);
      }
      
      public function getFinisherBadgeWidget() : MovieClip
      {
         return this.getMovieClip(FinisherFacade.FINISHER_BADGE);
      }
      
      public function playSound(param1:String) : void
      {
         var _loc3_:Sound = null;
         var _loc2_:String = this._finisherId + param1;
         if(!SoundPlayer.isLoaded(_loc2_))
         {
            _loc3_ = this._base.getSound("Sound" + param1);
            SoundPlayer.addSound(_loc2_,_loc3_);
         }
         SoundPlayer.playSound(_loc2_);
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this._base.visible = param1;
      }
   }
}
