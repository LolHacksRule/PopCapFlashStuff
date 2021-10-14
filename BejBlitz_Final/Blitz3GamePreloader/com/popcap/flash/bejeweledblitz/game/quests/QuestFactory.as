package com.popcap.flash.bejeweledblitz.game.quests
{
   import com.popcap.flash.bejeweledblitz.ServerURLResolver;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.quests.availability.FeatureAvailabilityStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.availability.IQuestAvailabilityStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.availability.NullAvailabilityStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.availability.QuestCompletionAvailabilityStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.AutoCompletedCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.CompoundCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.ConfigSettingCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.IQuestCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.LevelUpMilestoneCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.MinimumScoreCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NBoostedGamesCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NMinimumScoreGamesCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.NRareGemGamesCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completion.QuestSettingsCompletionStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.completionbuilder.DynamicQuestCompletionBuilder;
   import com.popcap.flash.bejeweledblitz.game.quests.expirary.IQuestExpiraryStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.expirary.NullExpiraryStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.expirary.TimeExpiraryStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.CompoundRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.ConfigSettingFlagRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.FeatureUnlockRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.IQuestRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.MysteryTreasureAwardRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.QuestSettingsRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.reward.SpecificRareGemOfferRewardStrategy;
   import com.popcap.flash.bejeweledblitz.game.quests.rewardbuilder.DynamicQuestRewardBuilder;
   import com.popcap.flash.bejeweledblitz.game.session.config.ConfigManager;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import com.popcap.flash.bejeweledblitz.leaderboard.InstantFriendDataFactory;
   import com.popcap.flash.bejeweledblitz.logic.raregems.CatseyeRGLogic;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class QuestFactory
   {
      
      private static const GENERIC_FACEBOOK_PROFILE_ICON:String = "images/unknownMug.gif";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Quests:Vector.<Quest>;
      
      private var m_PrevQuestId:String;
      
      private var m_CompletionBuilder:DynamicQuestCompletionBuilder;
      
      private var m_RewardBuilder:DynamicQuestRewardBuilder;
      
      private var m_Loader_Num:int;
      
      private var m_Loaders:Array;
      
      private var m_LoaderContainer:DisplayObjectContainer;
      
      public function QuestFactory(param1:Blitz3Game)
      {
         super();
         this.m_App = param1;
         this.m_PrevQuestId = "";
         this.m_CompletionBuilder = new DynamicQuestCompletionBuilder(this.m_App);
         this.m_RewardBuilder = new DynamicQuestRewardBuilder(this.m_App);
      }
      
      public function GetQuests() : Vector.<Quest>
      {
         this.m_Quests = new Vector.<Quest>();
         this.AddQuest(this.BuildInitialQuest());
         this.AddQuest(this.BuildUnlockBasicLeaderboardQuest());
         this.AddQuest(this.BuildUnlockBoostsQuest());
         this.AddQuest(this.BuildUnlockFriendScoreQuest());
         this.AddQuest(this.BuildUnlockStarMedalsQuest());
         this.AddQuest(this.BuildUnlockRareGemsQuest());
         this.AddQuest(this.BuildUnlockLevelsQuest());
         return this.m_Quests;
      }
      
      public function BuildDynamicQuest(param1:Object, param2:String, param3:Array = null) : Quest
      {
         var _loc5_:IQuestExpiraryStrategy = null;
         var _loc11_:int = 0;
         var _loc4_:Boolean = false;
         if(param3 != null)
         {
            if(param3.indexOf(1) != -1 && param2 == QuestManager.QUEST_DYNAMIC_MEDIUM)
            {
               _loc4_ = true;
            }
            else if(param3.indexOf(2) != -1 && param2 == QuestManager.QUEST_DYNAMIC_HARD)
            {
               _loc4_ = true;
            }
         }
         if(!_loc4_)
         {
            if((_loc11_ = param1["unlock"]) > this.m_App.sessionData.userData.GetLevel())
            {
               return null;
            }
            _loc5_ = this.BuildDynamicQuestExpiraryStrategy(param1,param2);
         }
         else
         {
            _loc5_ = new NullExpiraryStrategy();
         }
         var _loc6_:QuestData = this.BuildDynamicQuestData(param1,param2);
         var _loc7_:IQuestAvailabilityStrategy = this.BuildDynamicQuestAvailabilityStrategy(param1,param2);
         var _loc8_:IQuestCompletionStrategy = this.BuildDynamicQuestCompletionStrategy(param1,param2);
         var _loc9_:IQuestRewardStrategy = this.BuildDynamicQuestRewardStrategy(param1,param2);
         var _loc10_:String = "";
         if(_loc6_ == null)
         {
            _loc10_ = "QUESTDATA";
         }
         else if(_loc7_ == null)
         {
            _loc10_ = "AVAILABILITY";
         }
         else if(_loc8_ == null)
         {
            _loc10_ = "COMPLETION";
         }
         else if(_loc9_ == null)
         {
            _loc10_ = "REWARD";
         }
         return new Quest(this.m_App,_loc6_,_loc7_,_loc8_,_loc9_,_loc5_,_loc11_,param1);
      }
      
      public function BuildLevelUpQuest(param1:Object, param2:String) : Quest
      {
         var _loc3_:QuestData = this.BuildDynamicQuestData(param1,param2);
         var _loc4_:IQuestAvailabilityStrategy = new FeatureAvailabilityStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_LEVELUP_MILESTONE);
         var _loc5_:IQuestCompletionStrategy = new LevelUpMilestoneCompletionStrategy(param1,this.m_App.sessionData.configManager,param2);
         var _loc6_:IQuestRewardStrategy = this.BuildDynamicQuestRewardStrategy(param1,param2);
         var _loc7_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,-1);
      }
      
      private function AddQuest(param1:Quest) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.m_Quests.push(param1);
         this.m_PrevQuestId = param1.GetData().id;
      }
      
      private function BuildInitialQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_QUEST_WIDGET);
         var _loc2_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc3_:Vector.<IQuestCompletionStrategy> = new Vector.<IQuestCompletionStrategy>();
         _loc3_.push(new ConfigSettingCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.FLAG_TUTORIAL_COMPLETE,false));
         _loc3_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_QUEST_WIDGET));
         var _loc4_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc3_,false);
         var _loc5_:Vector.<IQuestRewardStrategy>;
         (_loc5_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_QUEST_WIDGET,""));
         _loc5_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_QUEST_WIDGET));
         var _loc6_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc5_);
         var _loc7_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc2_,_loc4_,_loc6_,_loc7_,1);
      }
      
      private function BuildUnlockBasicLeaderboardQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_BASIC_LEADERBOARD,"",null,"",30);
         var _loc2_:Loader = new Loader();
         _loc2_.load(new URLRequest(InstantFriendDataFactory.BJORN_IMAGE_URL));
         _loc1_.rewardScreenVisual = _loc2_;
         var _loc3_:GlowFilter = new GlowFilter(14587181,1,2,2,3,1,true);
         _loc2_.filters = [_loc3_];
         var _loc4_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc5_:IQuestCompletionStrategy = new AutoCompletedCompletionStrategy();
         var _loc6_:Vector.<IQuestRewardStrategy>;
         (_loc6_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_LEADERBOARD_BASIC,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_LEADERBOARD_BASIC)));
         _loc6_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_LEADERBOARD_BASIC));
         var _loc7_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc6_);
         var _loc8_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc4_,_loc5_,_loc7_,_loc8_);
      }
      
      private function BuildUnlockBoostsQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_BOOSTS);
         _loc1_.rewardScreenVisual = this.CreateVisualWithSpacing(this.CreateImageGroup([this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MYSTERY),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_DETONATE),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_SCRAMBLE),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_5SECOND),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_BOOST_SMALL_MULTIPLIER)]),20);
         var _loc2_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc3_:Vector.<IQuestCompletionStrategy> = new Vector.<IQuestCompletionStrategy>();
         _loc3_.push(new MinimumScoreCompletionStrategy(this.m_App.logic,this.m_App.sessionData.configManager,1000,ConfigManager.OBJ_QUEST_UNLOCK_BOOSTS,"","Beat a PopCap friend\'s score"));
         _loc3_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_BOOSTS));
         var _loc4_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc3_,false);
         var _loc5_:Vector.<IQuestRewardStrategy>;
         (_loc5_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_BOOSTS,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_BOOSTS)));
         _loc5_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_BOOSTS));
         var _loc6_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc5_);
         var _loc7_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc2_,_loc4_,_loc6_,_loc7_);
      }
      
      private function BuildUnlockFriendScoreQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_FRIENDSCORE);
         _loc1_.rewardScreenVisual = new Sprite();
         var _loc2_:Loader = new Loader();
         var _loc3_:String = this.m_App.network.GetMediaPath() + ServerURLResolver.resolveUrl(this.m_App.network.GetFlashPath() + GENERIC_FACEBOOK_PROFILE_ICON);
         _loc2_.load(new URLRequest(_loc3_),new LoaderContext(true));
         var _loc4_:Loader;
         (_loc4_ = new Loader()).load(new URLRequest(_loc3_),new LoaderContext(true));
         var _loc5_:Loader;
         (_loc5_ = new Loader()).load(new URLRequest(_loc3_),new LoaderContext(true));
         this.CreateLoaderGroup([_loc2_,_loc4_,_loc5_],_loc1_.rewardScreenVisual);
         var _loc6_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc7_:Vector.<IQuestCompletionStrategy>;
         (_loc7_ = new Vector.<IQuestCompletionStrategy>()).push(new NBoostedGamesCompletionStrategy(this.m_App,3,ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN,"%cur% of %max%","Play %max% games with Boosts",this.m_App.sessionData.boostV2Manager));
         _loc7_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN));
         var _loc8_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc7_,false);
         var _loc9_:Vector.<IQuestRewardStrategy>;
         (_loc9_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_FRIENDSCORE,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_FRIENDSCORE)));
         _loc9_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_PROGRESSIVE_DAILY_SPIN,""));
         _loc9_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_FRIENDSCORE));
         _loc9_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_DAILY_SPIN));
         var _loc10_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc9_);
         var _loc11_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc6_,_loc8_,_loc10_,_loc11_);
      }
      
      private function BuildUnlockStarMedalsQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_STAR_MEDALS);
         _loc1_.rewardScreenVisual = this.CreateImageGroup([this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_25K),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_250K),this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_STARMEDAL_500K)],0.6,true);
         var _loc2_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc3_:Vector.<IQuestCompletionStrategy> = new Vector.<IQuestCompletionStrategy>();
         _loc3_.push(new MinimumScoreCompletionStrategy(this.m_App.logic,this.m_App.sessionData.configManager,25000,ConfigManager.OBJ_QUEST_UNLOCK_STAR_MEDALS,"","Score over<br><font color=\'#b0017d\'>%min%</font> points"));
         _loc3_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_STAR_MEDALS));
         var _loc4_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc3_,false);
         var _loc5_:Vector.<IQuestRewardStrategy>;
         (_loc5_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_STAR_MEDALS,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_STAR_MEDALS)));
         _loc5_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_STAR_MEDALS,1));
         var _loc6_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc5_);
         var _loc7_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc2_,_loc4_,_loc6_,_loc7_);
      }
      
      private function BuildUnlockRareGemsQuest() : Quest
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_RARE_GEMS);
         _loc2_.rewardScreenVisual = _loc1_;
         var _loc3_:Bitmap = new Bitmap(this.m_App.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_RG_CATSEYE));
         _loc3_.filters = [new GlowFilter(0,1,_loc3_.width,_loc3_.height,2,BitmapFilterQuality.LOW,true,true)];
         _loc1_.addChild(_loc3_);
         var _loc4_:TextField;
         (_loc4_ = new TextField()).defaultTextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,48,16764239,null,null,null,null,null,TextFormatAlign.CENTER);
         _loc4_.autoSize = TextFieldAutoSize.CENTER;
         _loc4_.multiline = false;
         _loc4_.embedFonts = true;
         _loc4_.selectable = false;
         _loc4_.mouseEnabled = false;
         _loc4_.htmlText = this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_SCREEN_MYSTERY_RARE_GEM);
         _loc4_.x = _loc3_.width * 0.5 - _loc4_.width * 0.5;
         _loc4_.y = _loc3_.height * 0.5 - _loc4_.height * 0.5;
         _loc4_.filters = [new GlowFilter(10838300,1,7,7,1.65,BitmapFilterQuality.HIGH,true),new DropShadowFilter(-1,90,16776103,1,2,2,2.07,BitmapFilterQuality.HIGH,true),new DropShadowFilter(1,77,2754823,1,4,4,10,BitmapFilterQuality.HIGH),new GlowFilter(854298,1,38,38,0.81,BitmapFilterQuality.HIGH)];
         _loc1_.addChild(_loc4_);
         var _loc5_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc6_:Vector.<IQuestCompletionStrategy>;
         (_loc6_ = new Vector.<IQuestCompletionStrategy>()).push(new NMinimumScoreGamesCompletionStrategy(this.m_App,3,ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS,"%cur% of %max%","Earn %max% STAR MEDALS",25000));
         _loc6_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS));
         var _loc7_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc6_,false,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_COMPOUND_SEPARATOR));
         var _loc8_:Vector.<IQuestRewardStrategy>;
         (_loc8_ = new Vector.<IQuestRewardStrategy>()).push(new SpecificRareGemOfferRewardStrategy(this.m_App.sessionData.configManager,this.m_App.sessionData.rareGemManager,CatseyeRGLogic.ID,ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS,1));
         _loc8_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_RARE_GEMS,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_REWARD_RARE_GEMS)));
         _loc8_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_MENU_TIPS,""));
         _loc8_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_RARE_GEMS));
         var _loc9_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc8_);
         var _loc10_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc2_,_loc5_,_loc7_,_loc9_,_loc10_);
      }
      
      private function BuildUnlockLevelsQuest() : Quest
      {
         var _loc1_:QuestData = new QuestData(QuestManager.QUEST_UNLOCK_LEVELS,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_SCREEN_TITLE_ALL),null,this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_QUEST_EXTENDED_REWARD_LEVELS));
         var _loc2_:IQuestAvailabilityStrategy = this.BuildNextQuestAvailabilityStrategy();
         var _loc3_:Vector.<IQuestCompletionStrategy> = new Vector.<IQuestCompletionStrategy>();
         _loc3_.push(new NRareGemGamesCompletionStrategy(this.m_App,1,ConfigManager.OBJ_QUEST_FIND_RARE_GEM,"","Play to find and<br>use a Rare Gem","featureunlock"));
         _loc3_.push(new QuestSettingsCompletionStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_LEVELS));
         var _loc4_:IQuestCompletionStrategy = new CompoundCompletionStrategy(_loc3_,false);
         var _loc5_:Vector.<IQuestRewardStrategy>;
         (_loc5_ = new Vector.<IQuestRewardStrategy>()).push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_XP,""));
         _loc5_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_DYNAMIC_EASY_QUESTS,""));
         _loc5_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_MULTIPLAYER,""));
         _loc5_.push(new FeatureUnlockRewardStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_RARE_GEM_STREAKS,""));
         _loc5_.push(new MysteryTreasureAwardRewardStrategy(this.m_App.network,"<font size=\'-2\'>Mystery Treasure</font>"));
         _loc5_.push(new QuestSettingsRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.OBJ_QUEST_UNLOCK_LEVELS));
         _loc5_.push(new ConfigSettingFlagRewardStrategy(this.m_App.sessionData.configManager,ConfigManager.FLAG_NEW_USER_ENROLLED,false));
         var _loc6_:IQuestRewardStrategy = new CompoundRewardStrategy(_loc5_);
         var _loc7_:IQuestExpiraryStrategy = new NullExpiraryStrategy();
         return new Quest(this.m_App,_loc1_,_loc2_,_loc4_,_loc6_,_loc7_);
      }
      
      private function BuildNextQuestAvailabilityStrategy() : IQuestAvailabilityStrategy
      {
         if(this.m_PrevQuestId == "")
         {
            return new NullAvailabilityStrategy();
         }
         return new QuestCompletionAvailabilityStrategy(this.m_App.questManager,this.m_PrevQuestId);
      }
      
      private function BuildDynamicQuestData(param1:Object, param2:String) : QuestData
      {
         return new QuestData(param2,"",null,"");
      }
      
      private function BuildDynamicQuestAvailabilityStrategy(param1:Object, param2:String) : IQuestAvailabilityStrategy
      {
         return new FeatureAvailabilityStrategy(this.m_App.sessionData.featureManager,FeatureManager.FEATURE_DYNAMIC_EASY_QUESTS);
      }
      
      private function BuildDynamicQuestCompletionStrategy(param1:Object, param2:String) : IQuestCompletionStrategy
      {
         if(!(QuestConstants.KEY_COMPLETION in param1))
         {
            return null;
         }
         var _loc3_:Object = param1[QuestConstants.KEY_COMPLETION];
         return this.m_CompletionBuilder.BuildQuestCompletionStrategy(_loc3_,param2);
      }
      
      private function BuildDynamicQuestRewardStrategy(param1:Object, param2:String) : IQuestRewardStrategy
      {
         if(!(QuestConstants.KEY_REWARD in param1))
         {
            return null;
         }
         var _loc3_:Object = param1[QuestConstants.KEY_REWARD];
         return this.m_RewardBuilder.BuildQuestRewardStrategy(_loc3_,param2);
      }
      
      private function BuildDynamicQuestExpiraryStrategy(param1:Object, param2:String) : IQuestExpiraryStrategy
      {
         if(!(QuestConstants.KEY_EXPIRARY in param1))
         {
            return new NullExpiraryStrategy();
         }
         var _loc3_:Object = param1[QuestConstants.KEY_EXPIRARY];
         if(!(QuestConstants.KEY_EXPIRARY_TIME in _loc3_))
         {
            return new NullExpiraryStrategy();
         }
         var _loc4_:Number = parseFloat(_loc3_[QuestConstants.KEY_EXPIRARY_TIME_REMAINING]);
         return new TimeExpiraryStrategy(_loc4_,this.m_App.TextManager);
      }
      
      private function CreateImageGroup(param1:Array, param2:Number = 1, param3:Boolean = false) : Sprite
      {
         var _loc6_:BitmapData = null;
         var _loc7_:Bitmap = null;
         var _loc4_:Sprite = new Sprite();
         var _loc5_:int = 0;
         for each(_loc6_ in param1)
         {
            if(_loc6_ != null)
            {
               _loc7_ = new Bitmap(_loc6_);
               _loc7_.scaleX = _loc7_.scaleY = param2;
               _loc7_.x = _loc5_;
               _loc5_ += _loc7_.width;
               _loc7_.smoothing = param3;
               _loc4_.addChild(_loc7_);
            }
         }
         return _loc4_;
      }
      
      private function CreateLoaderGroup(param1:Array, param2:DisplayObject) : void
      {
         var _loc3_:Loader = null;
         this.m_Loader_Num = 0;
         this.m_Loaders = param1;
         this.m_LoaderContainer = param2 as DisplayObjectContainer;
         for each(_loc3_ in param1)
         {
            _loc3_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.HandleLoadComplete,false,0,true);
            _loc3_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleLoadError,false,0,true);
            _loc3_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleLoadError,false,0,true);
         }
      }
      
      private function HandleLoadComplete(param1:Event) : void
      {
         var _loc3_:Loader = null;
         ++this.m_Loader_Num;
         var _loc2_:int = 0;
         if(this.m_Loader_Num == this.m_Loaders.length)
         {
            for each(_loc3_ in this.m_Loaders)
            {
               _loc3_.x = _loc2_;
               _loc2_ += _loc3_.width + 10;
               this.m_LoaderContainer.addChild(_loc3_);
            }
         }
      }
      
      private function HandleLoadError(param1:Event) : void
      {
         ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_ASSET_LOADING,ErrorReporting.ERROR_LEVEL_ERROR_HIGH,"QuestFactory load error: " + param1.toString());
      }
      
      private function CreateSpacer(param1:Number) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,1,0,param1);
         _loc2_.cacheAsBitmap = true;
         return _loc2_;
      }
      
      private function CreateVisualWithSpacing(param1:DisplayObject, param2:Number) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         param1.y = param2;
         _loc3_.addChild(param1);
         var _loc4_:Shape;
         (_loc4_ = this.CreateSpacer(param2)).y = param1.y + param1.height;
         _loc3_.addChild(_loc4_);
         return _loc3_;
      }
   }
}
