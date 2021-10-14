package com.popcap.flash.bejeweledblitz.quest
{
   import com.caurina.transitions.Tweener;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.UserData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class QuestPanel extends Sprite
   {
       
      
      private var _app:Blitz3Game;
      
      private var _quest:Quest;
      
      private var newQuestIncoming:Boolean;
      
      private var _lastProgressText:String;
      
      private var _questPanel:MovieClip;
      
      private var _goalText:TextField;
      
      private var _goalTextCenterY:Number;
      
      private var _rewardText:TextField;
      
      private var _progressText:TextField;
      
      private var _expirationText:TextField;
      
      private var _rewardTextTitle:TextField;
      
      private var _unlockText:TextField;
      
      private var _isInitialized:Boolean = false;
      
      private var _lastFrame:String = "";
      
      public var _index:int;
      
      public var isLocked:Boolean = true;
      
      public function QuestPanel(param1:Blitz3Game, param2:MovieClip, param3:int)
      {
         super();
         this._app = param1;
         this._index = param3;
         this._questPanel = param2;
         this._questPanel.controller = this;
         this._goalText = param2.goalT;
         this._unlockText = param2.unlockT;
         this._rewardTextTitle = param2.rewardTitleMC.rewardTitleT;
         this._rewardText = param2.rewardBodyMC.rewardBodyT;
         this._progressText = param2.progressT;
         this._expirationText = param2.expirationT;
         this._goalTextCenterY = this._goalText.y + this._goalText.textHeight / 2;
      }
      
      public function Init() : void
      {
         this.newQuestIncoming = false;
      }
      
      public function resetDisplay() : void
      {
         this._rewardTextTitle.htmlText = "";
         this._rewardText.htmlText = "";
         this._goalText.htmlText = "";
         this._progressText.htmlText = "";
         this._expirationText.htmlText = "";
         this._unlockText.htmlText = "";
      }
      
      public function Update() : void
      {
         var _loc1_:String = this._progressText.text;
         if(this._lastProgressText != null && _loc1_ != this._lastProgressText)
         {
            this._lastProgressText = _loc1_;
         }
         if(this._lastProgressText == null)
         {
            this._lastProgressText = _loc1_;
         }
         this.UpdateQuestDisplay();
      }
      
      private function resetDisplayObject(param1:Sprite, param2:Number, param3:Number) : void
      {
         Tweener.addTween(param1,{
            "scaleX":1,
            "scaleY":1,
            "x":param2,
            "y":param3,
            "time":0.25,
            "_color":null,
            "transition":"linear"
         });
      }
      
      public function SetQuest(param1:Quest = null) : void
      {
         var _loc2_:String = null;
         if(param1 == null)
         {
            this.resetDisplay();
            _loc2_ = "Play To Unlock";
            this._rewardText.htmlText = "";
            this.setFrame("lock");
            if(this._app.questManager.IsFeatureUnlockComplete())
            {
               _loc2_ = "Reveal at Rank %rank%";
               if(this._index == 0)
               {
                  _loc2_ = "";
               }
               else if(this._index == 1)
               {
                  _loc2_ = _loc2_.replace("%rank%",UserData.QUEST_SLOT_MEDIUM_LEVEL);
               }
               else if(this._index == 2)
               {
                  _loc2_ = _loc2_.replace("%rank%",UserData.QUEST_SLOT_HARD_LEVEL);
               }
            }
            this._unlockText.htmlText = _loc2_;
         }
         else
         {
            this.isLocked = false;
            if(this._quest && this._quest.GetGoalString() != param1.GetGoalString() && this._goalText.htmlText != "")
            {
               this.newQuestIncoming = true;
            }
            if(this._isInitialized == false)
            {
               this.newQuestIncoming = false;
               this._isInitialized = true;
            }
            this._quest = param1;
            if(this.newQuestIncoming)
            {
               this.setFrame("new");
            }
            else if(param1.IsComplete())
            {
               this.setFrame("completed");
            }
            else
            {
               this.setFrame("normal");
            }
            this._rewardTextTitle.htmlText = "REWARD";
            this._rewardText.htmlText = this._quest.GetRewardString();
            this._goalText.htmlText = this._quest.GetGoalString();
            this._progressText.htmlText = this._quest.GetProgressString();
            if(param1.IsComplete())
            {
               this._expirationText.htmlText = "";
            }
            else
            {
               this._expirationText.htmlText = this._quest.GetExpiraryString();
            }
         }
         this.fixGoalY();
         if(this._questPanel.facebookIcon != null)
         {
            this._questPanel.facebookIcon.visible = false;
         }
      }
      
      private function fixGoalY() : void
      {
         this._goalText.y = this._goalTextCenterY - this._goalText.textHeight * 0.5;
      }
      
      public function GetQuest() : Quest
      {
         return this._quest;
      }
      
      public function HasQuest() : Boolean
      {
         return this._quest != null;
      }
      
      public function UpdateCurrentQuest() : void
      {
         if(this.HasQuest())
         {
            if(this._quest.IsActive())
            {
               this.SetQuest(this._quest);
            }
            else
            {
               this.clearQuest();
            }
         }
      }
      
      private function setFrame(param1:String) : void
      {
         this._questPanel.gotoAndStop(param1);
         if("lock" == param1)
         {
            this._unlockText.visible = true;
            this._goalText.visible = false;
         }
         else
         {
            this._unlockText.visible = false;
            this._goalText.visible = true;
         }
         if(this._lastFrame != param1)
         {
            this._lastFrame = param1;
            this._questPanel.keyMC.gotoAndPlay(param1);
         }
         if(!this._quest)
         {
            return;
         }
         var _loc2_:String = "feature";
         switch(this._quest.GetData().id)
         {
            case QuestManager.QUEST_DYNAMIC_HARD:
               _loc2_ = "hard";
               break;
            case QuestManager.QUEST_DYNAMIC_MEDIUM:
               _loc2_ = "medium";
               break;
            case QuestManager.QUEST_DYNAMIC_EASY:
               _loc2_ = "easy";
         }
         this._questPanel.keyMC.keyPH.gotoAndStop(_loc2_);
         this._progressText.htmlText = this._quest.GetProgressString();
      }
      
      public function get hitMC() : MovieClip
      {
         return this._questPanel.hitMC;
      }
      
      public function unlockSlot() : void
      {
         this.isLocked = false;
         this.setFrame("normal");
      }
      
      private function clearQuest() : void
      {
         this._quest = null;
         this.resetDisplay();
      }
      
      private function UpdateQuestDisplay() : void
      {
         if(this._quest == null)
         {
            return;
         }
         var _loc1_:String = this._quest.GetProgressString();
         if(_loc1_ != this._lastProgressText)
         {
            this._progressText.htmlText = _loc1_;
         }
      }
      
      public function playCompleteAnimation() : void
      {
         this.setFrame("completed");
      }
      
      public function playExpiredQuest() : void
      {
         this.setFrame("expired");
         if(this._questPanel != null && this._questPanel.extendBtn != null)
         {
            this._questPanel.extendBtn.timeT.text = "+2 day";
            this._questPanel.extendBtn.costT.text = "100";
            this._questPanel.extendBtn.visible = false;
         }
      }
      
      private function showComplete() : Boolean
      {
         if(this._quest == null)
         {
            return false;
         }
         var _loc1_:String = this._quest.GetData().id;
         return _loc1_ == QuestManager.QUEST_DYNAMIC_EASY || _loc1_ == QuestManager.QUEST_DYNAMIC_MEDIUM || _loc1_ == QuestManager.QUEST_DYNAMIC_HARD ? true : false;
      }
   }
}
