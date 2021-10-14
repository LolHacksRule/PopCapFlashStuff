package com.popcap.flash.bejeweledblitz.leaderboard.model
{
   import com.popcap.flash.framework.App;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class PlayerData
   {
      
      public static const NUM_MEDALS:int = 15;
      
      public static const NUM_TOURNEYS:int = 5;
      
      public static const LEVEL_STEP:int = 250000;
      
      public static const MAX_LEVEL:int = 182;
       
      
      public var fuid:String = "0";
      
      public var name:String = "Default Name";
      
      public var imageURL:String;
      
      public var rank:int;
      
      public var level:int;
      
      public var levelName:String;
      
      public var xp:Number;
      
      public var prevLevelCutoff:Number;
      
      public var nextLevelCutoff:Number;
      
      public var curTourneyData:TourneyData;
      
      public var tourneyHistory:Vector.<TourneyData>;
      
      public var medalHistory:Vector.<MedalData>;
      
      private var m_App:App;
      
      protected var m_ImageLoader:Loader;
      
      protected var m_ProfileImage:BitmapData;
      
      protected var m_IsImageLoadedStarted:Boolean = false;
      
      protected var m_IsExtendedDataLoaded:Boolean = false;
      
      protected var m_LoadCompleteHandlers:Vector.<IPlayerDataLoadHandler>;
      
      protected var m_Handlers:Vector.<IPlayerDataHandler>;
      
      protected var m_ImageLoadHandlers:Vector.<IPlayerDataImageLoadHandler>;
      
      public function PlayerData(app:App)
      {
         super();
         this.m_App = app;
         this.m_LoadCompleteHandlers = new Vector.<IPlayerDataLoadHandler>();
         this.m_Handlers = new Vector.<IPlayerDataHandler>();
         this.m_ImageLoadHandlers = new Vector.<IPlayerDataImageLoadHandler>();
         this.m_ImageLoader = new Loader();
         this.m_ImageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleProfileImageComplete);
         this.m_ImageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.HandleProfileImageIOError);
         this.m_ImageLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.HandleProfileImageSecurityError);
         this.curTourneyData = new TourneyData();
         this.tourneyHistory = new Vector.<TourneyData>();
         this.medalHistory = new Vector.<MedalData>(NUM_MEDALS);
         for(var i:int = 0; i < this.medalHistory.length; i++)
         {
            this.medalHistory[i] = new MedalData();
         }
      }
      
      public function ParseBasicXML(root:XML, curTourneyId:int) : void
      {
         this.fuid = root.id.text().toString();
         this.name = root.name.text().toString();
         this.imageURL = root.pic_square.text().toString();
         this.imageURL = this.imageURL.replace("https://","http://");
         this.curTourneyData.date = new Date();
         this.curTourneyData.score = int(root.score.text().toString());
         this.curTourneyData.id = curTourneyId;
         this.xp = Number(root.xp.text().toString());
         this.xp = Math.max(this.xp,0);
         this.RecalcLevel();
      }
      
      public function ParseExtendedXML(root:XML) : Boolean
      {
         var achievementXML:XML = null;
         var maxTourneyID:int = 0;
         var minTourneyID:int = 0;
         var tourneyData:TourneyData = null;
         var i:int = 0;
         var tourneyXML:XML = null;
         var medalID:int = 0;
         var curMedal:MedalData = null;
         var medalTime:String = null;
         var tourneyId:int = 0;
         var tourneyTime:String = null;
         var foundBadTourneyId:Boolean = false;
         for each(achievementXML in root.user_achievements.achievement)
         {
            medalID = int(achievementXML.id.text().toString());
            curMedal = new MedalData();
            curMedal.count = int(achievementXML.user_data.text().toString());
            curMedal.name = achievementXML.name.text().toString();
            medalTime = achievementXML.modified_date.text().toString();
            medalTime = medalTime.replace("-","/");
            curMedal.earnedDate.setTime(Date.parse(medalTime));
            curMedal.CalculateTier();
            this.medalHistory[medalID - 1] = curMedal;
         }
         maxTourneyID = this.curTourneyData.id - 1;
         minTourneyID = this.curTourneyData.id - (NUM_TOURNEYS - 1);
         for(i = minTourneyID; i <= maxTourneyID; i++)
         {
            tourneyData = new TourneyData();
            tourneyData.id = i;
            tourneyData.score = 0;
            tourneyData.date = new Date();
            this.tourneyHistory.push(tourneyData);
         }
         this.tourneyHistory.push(this.curTourneyData);
         for each(tourneyXML in root.tourneys.tourney)
         {
            tourneyId = int(tourneyXML.id.text().toString());
            if(tourneyId > this.curTourneyData.id)
            {
               foundBadTourneyId = true;
            }
            if(!(tourneyId < minTourneyID || tourneyId > maxTourneyID || tourneyId == this.curTourneyData.id))
            {
               tourneyData = null;
               for(i = 0; i < this.tourneyHistory.length; i++)
               {
                  if(this.tourneyHistory[i].id == tourneyId)
                  {
                     tourneyData = this.tourneyHistory[i];
                     break;
                  }
               }
               if(tourneyData)
               {
                  tourneyData.score = int(tourneyXML.score.text().toString());
                  tourneyTime = tourneyXML.score_date.text().toString();
                  tourneyTime = tourneyTime.replace("-","/");
                  tourneyData.date.setTime(Date.parse(tourneyTime));
               }
            }
         }
         this.m_IsExtendedDataLoaded = true;
         this.DispatchExtendedDataLoaded();
         this.m_LoadCompleteHandlers.length = 0;
         return foundBadTourneyId;
      }
      
      public function GetProfileImage() : BitmapData
      {
         if(!this.m_ProfileImage)
         {
            return null;
         }
         return this.m_ProfileImage.clone();
      }
      
      public function IsExtendedDataLoaded() : Boolean
      {
         return this.m_IsExtendedDataLoaded;
      }
      
      public function AddLoadCompleteHandler(handler:IPlayerDataLoadHandler) : void
      {
         if(this.m_IsExtendedDataLoaded)
         {
            handler.HandleExtendedPlayerDataLoaded(this);
            return;
         }
         this.m_LoadCompleteHandlers.push(handler);
      }
      
      public function AddHandler(handler:IPlayerDataHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function AddImageLoadHandler(handler:IPlayerDataImageLoadHandler) : void
      {
         if(this.m_ProfileImage)
         {
            handler.HandleProfileImageLoaded(this);
            return;
         }
         this.StartProfileImageLoad();
         this.m_ImageLoadHandlers.push(handler);
      }
      
      public function RemoveHandler(handler:IPlayerDataHandler) : void
      {
         var index:int = this.m_Handlers.indexOf(handler);
         if(index < 0)
         {
            return;
         }
         this.m_Handlers.splice(index,1);
      }
      
      public function RecalcLevel() : void
      {
         this.level = 0;
         var curLvlStep:Number = LEVEL_STEP;
         var curLvlCutoff:Number = 0;
         while(this.xp >= curLvlCutoff)
         {
            ++this.level;
            this.prevLevelCutoff = curLvlCutoff;
            curLvlCutoff += curLvlStep;
            curLvlStep += LEVEL_STEP;
         }
         this.nextLevelCutoff = curLvlCutoff;
         var index:int = Math.max(Math.min(this.level - 1,MAX_LEVEL - 1),0);
         this.levelName = this.m_App.TextManager.GetLocString("LOC_LEADERBOARD_LEVEL_NAME_" + index);
      }
      
      public function AddScore(newScore:int) : void
      {
         this.xp += newScore;
         this.RecalcLevel();
         if(newScore > this.curTourneyData.score)
         {
            this.curTourneyData.score = newScore;
         }
         var id:int = 0;
         if(newScore < 25000)
         {
            id = -1;
            return;
         }
         if(newScore <= 250000)
         {
            id = int(newScore / 25000) - 1;
         }
         else
         {
            id = 9 + int((newScore - 250000) / 50000);
         }
         id = Math.min(id,NUM_MEDALS - 1);
         var medal:MedalData = this.medalHistory[id];
         var prevTier:int = medal.tier;
         ++medal.count;
         medal.CalculateTier();
         this.DispatchStarMedalAwarded(id);
         if(medal.tier > prevTier)
         {
            this.DispatchMedalBucketFilled(id);
         }
      }
      
      protected function DispatchExtendedDataLoaded() : void
      {
         var handler:IPlayerDataLoadHandler = null;
         for each(handler in this.m_LoadCompleteHandlers)
         {
            handler.HandleExtendedPlayerDataLoaded(this);
         }
      }
      
      protected function DispatchStarMedalAwarded(id:int) : void
      {
         var handler:IPlayerDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleStarMedalAwarded(this,id);
         }
      }
      
      protected function DispatchMedalBucketFilled(id:int) : void
      {
         var handler:IPlayerDataHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleMedalBucketFilled(this,id);
         }
      }
      
      protected function DispatchProfileImageLoaded() : void
      {
         var handler:IPlayerDataImageLoadHandler = null;
         for each(handler in this.m_ImageLoadHandlers)
         {
            handler.HandleProfileImageLoaded(this);
         }
      }
      
      protected function StartProfileImageLoad() : void
      {
         if(this.imageURL.replace(/^\s+|\s+$/g,"").length <= 0 || this.m_IsImageLoadedStarted)
         {
            return;
         }
         try
         {
            this.m_ImageLoader.load(new URLRequest(this.imageURL),new LoaderContext(true));
            this.m_IsImageLoadedStarted = true;
         }
         catch(err:Error)
         {
            trace("profile image failed to load for " + name);
         }
      }
      
      protected function HandleProfileImageComplete(event:Event) : void
      {
         try
         {
            this.m_ProfileImage = (this.m_ImageLoader.content as Bitmap).bitmapData;
            this.DispatchProfileImageLoaded();
            this.m_ImageLoadHandlers.length = 0;
         }
         catch(err:Error)
         {
            trace("error referencing profile image for " + name);
         }
      }
      
      protected function HandleProfileImageIOError(event:IOErrorEvent) : void
      {
         trace("IOError while loading profile image for " + this.name + ": " + event);
      }
      
      protected function HandleProfileImageSecurityError(event:SecurityErrorEvent) : void
      {
         trace("SecurityError while loading profile image for " + this.name + ": " + event);
      }
   }
}
