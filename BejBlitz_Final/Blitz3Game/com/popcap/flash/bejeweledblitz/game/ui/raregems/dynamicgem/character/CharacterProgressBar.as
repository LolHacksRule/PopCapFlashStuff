package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.character
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherFacade;
   import com.popcap.flash.bejeweledblitz.game.ui.finisher.FinisherItemLoader;
   import com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.DynamicRareGemSound;
   import com.popcap.flash.bejeweledblitz.logic.raregems.character.ICharacterManager;
   import flash.display.FrameLabel;
   
   public class CharacterProgressBar
   {
       
      
      private var _progress:Progressbar;
      
      private var _app:Blitz3App;
      
      private var _currentPercentage:int;
      
      private var _delta:int;
      
      private var _currState:int;
      
      private var _currCharacter:FinisherFacade;
      
      private var _progressStartFrame:int;
      
      private var _progressAnimStartFrame:int;
      
      public function CharacterProgressBar(param1:Blitz3App)
      {
         super();
         this._app = param1;
         this._progress = null;
         this._currCharacter = this._app.sessionData.finisherManager.GetActiveFinishers()[0];
         this._currentPercentage = 0;
         this._progressStartFrame = 0;
         this._progressAnimStartFrame = 0;
      }
      
      public function Initialize(param1:Progressbar) : void
      {
         if(this._currCharacter != null && param1 != null && this._app.logic.rareGemsLogic.currentRareGem.hasLinkedCharacter())
         {
            this.OnProgressBarLoaded(param1);
            FinisherItemLoader.attachBitmap(this._currCharacter.GetFinisherConfig().GetID(),"Progressicon",this._progress.RGPlaceholder,0.5,0.5);
            this._progress.gotoAndStop(1);
            this._progress.addFrameScript(this._progress.totalFrames - 1,this.EndFrameCallback);
            this._progressStartFrame = this.getFrameByLabel("warmup");
            this._progressAnimStartFrame = this.getFrameByLabel("outro");
            if(this._progressStartFrame == -1)
            {
               this._progressStartFrame = 1;
            }
            if(this._progressAnimStartFrame == -1)
            {
               this._progressAnimStartFrame = 101;
            }
         }
      }
      
      public function Reset() : void
      {
         this._progressStartFrame = 0;
         this._progressAnimStartFrame = 0;
         this._progress.visible = false;
      }
      
      public function Update() : void
      {
         var _loc4_:int = 0;
         if(!this._progress.visible || this._app.logic.rareGemsLogic.currentRareGem == null)
         {
            return;
         }
         var _loc1_:ICharacterManager = this._app.logic.rareGemsLogic.currentRareGem.getLinkedCharacter();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:String = this._app.logic.rareGemsLogic.currentRareGem.getStringID();
         _loc2_ = Utils.getFirstUppercase(_loc2_);
         var _loc3_:int = _loc1_.GetPercentage();
         if(_loc3_ > 100)
         {
            _loc3_ = 100;
         }
         if(!_loc1_.ShouldShowProgress())
         {
            this._progress.visible = false;
            return;
         }
         if(_loc3_ != this._currentPercentage)
         {
            this._delta = _loc3_ - this._currentPercentage;
            this._currentPercentage = _loc3_;
            if(this._delta > 0)
            {
               if(_loc3_ == 100)
               {
                  DynamicRareGemSound.play(_loc2_,DynamicRareGemSound.PROGRESS_COMPLETE_ID);
               }
               else
               {
                  DynamicRareGemSound.play(_loc2_,DynamicRareGemSound.PROGRESS_NORMAL_ID);
               }
               if((_loc4_ = this._progressStartFrame + (this._progressAnimStartFrame - this._progressStartFrame) / 100 * this._currentPercentage) >= this._progressAnimStartFrame)
               {
                  _loc4_ = this._progressAnimStartFrame - 1;
               }
               this._progress.gotoAndStop(_loc4_);
               this._delta = 0;
            }
         }
      }
      
      public function EndFrameCallback() : void
      {
         this._progress.gotoAndStop(this._progressStartFrame);
      }
      
      private function getFrameByLabel(param1:String) : int
      {
         var _loc5_:FrameLabel = null;
         var _loc6_:String = null;
         var _loc2_:Array = this._progress.currentLabels;
         var _loc3_:int = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = (_loc5_ = _loc2_[_loc4_]).name;
            if(param1 == _loc6_)
            {
               return _loc5_.frame;
            }
            _loc4_++;
         }
         return -1;
      }
      
      private function OnProgressBarLoaded(param1:Progressbar) : void
      {
         this._progress = param1;
         this._progress.visible = true;
      }
   }
}
