package com.popcap.flash.bejeweledblitz.quest
{
   import com.caurina.transitions.properties.ColorShortcuts;
   import com.popcap.flash.bejeweledblitz.game.quests.IQuestManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.quests.Quest;
   import com.popcap.flash.bejeweledblitz.game.quests.QuestManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.IFeatureManagerHandler;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.games.blitz3.quests.KeystoneContainer;
   import com.popcap.flash.games.blitz3.quests.KeystonePanel;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class QuestWidget extends Sprite implements IQuestManagerHandler, IFeatureManagerHandler
   {
      
      private static const NUM_QUEST_PANELS:int = 3;
       
      
      private var _app:Blitz3Game;
      
      private var _keystonePanels:Vector.<QuestPanel>;
      
      private var _questPanelTooltip:QuestPanelToolTip;
      
      private var _keystoneContainer:KeystoneContainer;
      
      private var m_close:GenericButtonClip;
      
      public function QuestWidget(param1:Blitz3Game)
      {
         super();
         this._app = param1;
         ColorShortcuts.init();
      }
      
      public function Init() : void
      {
         var _loc3_:MovieClip = null;
         this._keystoneContainer = new KeystoneContainer();
         addChild(this._keystoneContainer);
         this._keystonePanels = new Vector.<QuestPanel>();
         var _loc1_:int = 0;
         while(_loc1_ < NUM_QUEST_PANELS)
         {
            _loc3_ = this.getPanel(_loc1_);
            _loc3_.hitMC.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver,false,0,true);
            _loc3_.hitMC.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut,false,0,true);
            this._keystonePanels.push(new QuestPanel(this._app,_loc3_,_loc1_));
            _loc1_++;
         }
         this._questPanelTooltip = new QuestPanelToolTip(this._app);
         this._questPanelTooltip.visible = false;
         addChild(this._questPanelTooltip);
         this.m_close = new GenericButtonClip(this._app,this._keystoneContainer.closebutton);
         this.m_close.setRelease(this.Hide);
         this.m_close.activate();
         this._app.questManager.AddHandler(this);
         this._app.sessionData.featureManager.AddHandler(this);
         var _loc2_:MainWidgetGame = this._app.ui as MainWidgetGame;
      }
      
      public function getPanel(param1:int) : KeystonePanel
      {
         return this._keystoneContainer["questPanel" + param1];
      }
      
      public function getPanelBackground(param1:int) : MovieClip
      {
         return this._keystoneContainer["questPanel" + param1].hitMC;
      }
      
      public function reset() : void
      {
      }
      
      public function Update() : void
      {
         var _loc1_:QuestPanel = null;
         if(visible && this._keystonePanels != null)
         {
            for each(_loc1_ in this._keystonePanels)
            {
               _loc1_.Update();
            }
         }
      }
      
      public function Show(param1:Boolean = false) : void
      {
         if(!this._app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_QUEST_WIDGET))
         {
            return;
         }
         if(this._app.isTournamentScreenOrMode())
         {
            this.Hide();
            return;
         }
         this.m_close.clipListener.visible = param1;
         visible = true;
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_OPEN);
      }
      
      public function Hide() : void
      {
         visible = false;
         this._app.SoundManager.playSound(Blitz3GameSounds.SOUND_GENERIC_CLOSE);
      }
      
      public function HandleQuestComplete(param1:Quest) : void
      {
         var _loc3_:QuestPanel = null;
         var _loc4_:Quest = null;
         var _loc2_:String = param1.GetData().id;
         if(_loc2_ == QuestManager.QUEST_UNLOCK_QUEST_WIDGET || _loc2_ == QuestManager.QUEST_UNLOCK_FRIENDSCORE)
         {
            return;
         }
         for each(_loc3_ in this._keystonePanels)
         {
            if(_loc4_ = _loc3_.GetQuest())
            {
               if(_loc2_ == _loc4_.GetData().id)
               {
                  _loc3_.playCompleteAnimation();
               }
            }
         }
      }
      
      public function HandleQuestExpire(param1:Quest) : void
      {
         var _loc3_:QuestPanel = null;
         var _loc4_:Quest = null;
         var _loc2_:String = param1.GetData().id;
         for each(_loc3_ in this._keystonePanels)
         {
            if(_loc4_ = _loc3_.GetQuest())
            {
               if(_loc2_ == _loc4_.GetData().id)
               {
                  _loc3_.playExpiredQuest();
               }
            }
         }
      }
      
      public function HandleQuestsUpdated(param1:Boolean) : void
      {
         if(!param1)
         {
            this.RefreshQuests();
         }
      }
      
      public function HandleFeatureEnabled(param1:String) : void
      {
         if(param1 == FeatureManager.FEATURE_QUEST_WIDGET)
         {
            this.Show(true);
         }
      }
      
      private function RefreshQuests(param1:Array = null) : void
      {
         var _loc3_:QuestPanel = null;
         var _loc4_:Quest = null;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc2_:Vector.<Quest> = this._app.questManager.GetActiveQuests(param1);
         for each(_loc3_ in this._keystonePanels)
         {
            if((_loc4_ = _loc3_.GetQuest()) != null)
            {
               if(!this._app.questManager.IsDynamicQuest(_loc4_.GetData().id))
               {
                  _loc5_ = _loc2_.indexOf(_loc4_);
                  _loc3_.UpdateCurrentQuest();
                  if(_loc5_ >= 0)
                  {
                     _loc2_.splice(_loc5_,1);
                  }
               }
            }
         }
         for each(_loc3_ in this._keystonePanels)
         {
            _loc4_ = _loc3_.GetQuest();
            if(!_loc3_.HasQuest() || this._app.questManager.IsDynamicQuest(_loc4_.GetData().id))
            {
               _loc6_ = false;
               if(_loc3_._index == 0)
               {
                  for each(_loc4_ in _loc2_)
                  {
                     if(_loc4_.GetData().id == QuestManager.QUEST_DYNAMIC_EASY)
                     {
                        _loc3_.SetQuest(_loc4_);
                        _loc6_ = true;
                     }
                  }
               }
               else if(_loc3_._index == 1)
               {
                  for each(_loc4_ in _loc2_)
                  {
                     if(_loc4_.GetData().id == QuestManager.QUEST_DYNAMIC_MEDIUM)
                     {
                        _loc3_.SetQuest(_loc4_);
                        _loc6_ = true;
                     }
                  }
               }
               else if(_loc3_._index == 2)
               {
                  for each(_loc4_ in _loc2_)
                  {
                     if(_loc4_.GetData().id == QuestManager.QUEST_DYNAMIC_HARD)
                     {
                        _loc3_.SetQuest(_loc4_);
                        _loc6_ = true;
                     }
                  }
               }
               if(!_loc6_)
               {
                  _loc3_.SetQuest(null);
               }
            }
         }
      }
      
      private function mouseOver(param1:MouseEvent) : void
      {
         if(!this._app.questManager.IsFeatureUnlockComplete())
         {
            return;
         }
         var _loc2_:MovieClip = MovieClip(param1.currentTarget.parent);
         var _loc3_:int = int(_loc2_.name.substr(-1));
         this._questPanelTooltip.x = this._keystoneContainer["TooltipPlaceholder" + _loc3_].x;
         this._questPanelTooltip.y = this._keystoneContainer["TooltipPlaceholder" + _loc3_].y;
         var _loc4_:BaseLocalizationManager;
         var _loc5_:String = (_loc4_ = this._app.TextManager).GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_BODY);
         if(_loc3_ == 0)
         {
            this._questPanelTooltip.setContent(_loc4_.GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_TITLE_EASY),_loc5_,QuestPanelToolTip.LEFT);
         }
         else if(_loc3_ == 1)
         {
            this._questPanelTooltip.setContent(_loc4_.GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_TITLE_MEDIUM),_loc5_,QuestPanelToolTip.LEFT);
         }
         else
         {
            this._questPanelTooltip.setContent(_loc4_.GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_TITLE_HARD),_loc5_,QuestPanelToolTip.LEFT);
         }
         this._questPanelTooltip.visible = true;
      }
      
      private function mouseOut(param1:MouseEvent) : void
      {
         this._questPanelTooltip.visible = false;
      }
      
      public function toggleClose() : void
      {
         this.m_close.clipListener.visible = visible;
      }
   }
}
