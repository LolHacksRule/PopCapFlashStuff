package com.popcap.flash.bejeweledblitz.leaderboard
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.ServerIO;
   import com.popcap.flash.bejeweledblitz.error.ErrorReporting;
   import com.popcap.flash.bejeweledblitz.game.session.FriendPopupServerIO;
   import com.popcap.flash.bejeweledblitz.game.session.feature.FeatureManager;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class PlayersData
   {
      
      public static const FAKE_PLAYER_ID:String = "1";
      
      public static const _JS_COMMAND_JUSTPASSED:String = "justPassed";
      
      public static const LEADERBOARD_UPDATED:String = "leaderboardUpdated";
      
      private static var _app:Blitz3Game;
      
      private static var _leaderboard:LeaderboardWidget;
      
      private static var _instantFriendFactory:InstantFriendDataFactory;
      
      private static var _cachedPlayerDataArray:Vector.<PlayerData>;
      
      private static var _playerDataDictionary:Dictionary;
      
      private static var _sortedPlayerFuidArray:Vector.<String>;
      
      private static var _friendscore:int;
      
      private static var _isFirstTourney:Boolean;
      
      private static var _cachedScore:int;
      
      private static var _cachedEndDate:Number;
      
      private static var _friendsBeatenPrompt:FriendBeatenTauntDialog;
      
      private static var _currentBeatenFriend:PlayerData;
      
      private static var _currentUserScore:int;
      
      private static var _beatenRank:Number = 0;
      
      private static var _isInited:Boolean = false;
       
      
      public function PlayersData()
      {
         super();
      }
      
      public static function init(param1:Blitz3Game, param2:LeaderboardWidget) : void
      {
         if(_isInited)
         {
            return;
         }
         _isInited = true;
         _app = param1;
         _leaderboard = param2;
         _instantFriendFactory = new InstantFriendDataFactory(_app);
         _cachedPlayerDataArray = new Vector.<PlayerData>();
         _playerDataDictionary = new Dictionary();
         _sortedPlayerFuidArray = new Vector.<String>();
         _isFirstTourney = true;
         _cachedScore = 0;
         _cachedEndDate = 0;
         ServerIO.registerCallback("getUser",onGetUser);
         _friendsBeatenPrompt = new FriendBeatenTauntDialog(_app);
         _friendsBeatenPrompt.x = Dimensions.LEFT_BORDER_WIDTH + Dimensions.GAME_WIDTH / 2 - _friendsBeatenPrompt.width / 2;
         _friendsBeatenPrompt.y = Dimensions.TOP_BORDER_WIDTH + Dimensions.GAME_HEIGHT / 2 - _friendsBeatenPrompt.height / 2;
      }
      
      public static function Reset() : void
      {
         _sortedPlayerFuidArray.length = 0;
         _playerDataDictionary = new Dictionary();
      }
      
      public static function ParseBasicXML(param1:XML) : void
      {
         var _loc4_:PlayerData = null;
         var _loc5_:Boolean = false;
         var _loc6_:XML = null;
         var _loc7_:PlayerData = null;
         var _loc8_:PlayerData = null;
         var _loc9_:Boolean = false;
         Reset();
         var _loc2_:int = int(param1.current_tourney.id.text().toString());
         _friendscore = int(param1.friendscore.text().toString());
         var _loc3_:Vector.<PlayerData> = _instantFriendFactory.GetFriendData(_loc2_);
         for each(_loc4_ in _loc3_)
         {
            addPlayerData(_loc4_);
         }
         _loc5_ = _app.sessionData.featureManager.isFeatureEnabled(FeatureManager.FEATURE_LEADERBOARD_FULL);
         for each(_loc6_ in param1.player)
         {
            (_loc8_ = new PlayerData(_app)).parseBasicXML(_loc6_,_loc2_);
            _loc9_ = Boolean(_loc8_.playerFuid == _leaderboard.currentPlayerFUID);
            if(_loc5_ || _loc9_)
            {
               addPlayerData(_loc8_);
            }
            else
            {
               _cachedPlayerDataArray.push(_loc8_);
            }
         }
         UpdateRanks();
         _app.mainmenuLeaderboard.GetMessageStoreConfig();
         DispatchUserInfo(param1);
         if(!(_loc7_ = getPlayerData(_leaderboard.currentPlayerFUID)))
         {
            return;
         }
         _cachedScore = _loc7_.curTourneyData.score;
         _cachedEndDate = _loc7_.curTourneyData.date.getTime();
      }
      
      public static function ParseExtendedJSON(param1:Object) : void
      {
         var _loc6_:PlayerData = null;
         var _loc7_:Boolean = false;
         var _loc2_:String = String(param1.params);
         var _loc3_:String = String(param1.passthrough.fuid);
         var _loc4_:String = "";
         if(param1.data != null && param1.data.payload != null && param1.data.payload.misc != null && param1.data.payload.misc.userId != null)
         {
            _loc4_ = String(param1.data.payload.misc.userId);
         }
         var _loc5_:Boolean = false;
         if(param1.data != null)
         {
            _loc5_ = Boolean(param1.data.success);
         }
         if(_loc5_ && _loc4_ != "")
         {
            if(_loc3_ == _loc4_ && _loc4_ in _playerDataDictionary)
            {
               if(_loc7_ = (_loc6_ = _playerDataDictionary[_loc4_]).parseExtendedJSON(param1.data.payload,true))
               {
                  _app.DispatchShowTourneyRefresh();
                  _isFirstTourney = false;
               }
            }
         }
         else if(_loc3_ in _playerDataDictionary)
         {
            (_loc6_ = _playerDataDictionary[_loc3_]).parseExtendedJSON(param1.data.payload,false);
         }
      }
      
      public static function GetList() : Vector.<String>
      {
         return _sortedPlayerFuidArray.slice();
      }
      
      public static function GetFriendscore() : int
      {
         return _friendscore;
      }
      
      public static function GetBasicDebugString() : String
      {
         var _loc2_:String = null;
         var _loc3_:PlayerData = null;
         var _loc1_:String = "";
         for each(_loc2_ in _sortedPlayerFuidArray)
         {
            _loc3_ = _playerDataDictionary[_loc2_];
            _loc1_ += _loc3_.playerFuid + " - " + _loc3_.playerName + " - " + _loc3_.curTourneyData.score + "\n";
         }
         if(_loc1_.length > 1)
         {
            _loc1_ = _loc1_.slice(0,_loc1_.length - 1);
         }
         return _loc1_;
      }
      
      public static function GetExtendedDebugString(param1:String) : String
      {
         var _loc4_:TourneyData = null;
         var _loc5_:MedalData = null;
         var _loc2_:* = "";
         if(!(param1 in _playerDataDictionary))
         {
            return "No data for FUID " + param1;
         }
         var _loc3_:PlayerData = _playerDataDictionary[param1];
         _loc2_ += _loc3_.playerFuid + "\n" + _loc3_.playerName + "\n";
         _loc2_ += "Current high score: " + _loc3_.curTourneyData.score + "\n";
         _loc2_ += "Score history:\n";
         for each(_loc4_ in _loc3_.tourneyHistory)
         {
            _loc2_ += " " + _loc4_.id + " - " + _loc4_.score + "\n";
         }
         _loc2_ += "Achievements:\n";
         for each(_loc5_ in _loc3_.medalHistory)
         {
            _loc2_ += " " + _loc5_.name + " - " + _loc5_.count + "\n";
         }
         return _loc2_.slice(0,_loc2_.length - 1);
      }
      
      public static function getPlayerData(param1:String) : PlayerData
      {
         if(param1 != "")
         {
            if(!(param1 in _playerDataDictionary))
            {
               if(param1 == FAKE_PLAYER_ID)
               {
                  _playerDataDictionary[param1] = new PlayerData(_app,param1,"BJORN",InstantFriendDataFactory.BJORN_IMAGE_URL);
               }
               else
               {
                  _playerDataDictionary[param1] = new PlayerData(_app,param1);
               }
            }
            return _playerDataDictionary[param1];
         }
         return null;
      }
      
      public static function UpdateScore(param1:String, param2:int) : void
      {
         var _loc3_:PlayerData = getPlayerData(param1);
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:int = _loc3_.curTourneyData.score;
         _loc3_.setScore(param2);
         if(param2 <= _loc4_)
         {
            _app.bjbEventDispatcher.SendEvent(LEADERBOARD_UPDATED,GetList());
            return;
         }
         _friendscore -= _loc4_;
         _friendscore += param2;
         if(param1 == _leaderboard.currentPlayerFUID)
         {
            DispatchBeatenList(_loc3_,param2,_loc4_);
         }
         var _loc5_:int;
         if((_loc5_ = _sortedPlayerFuidArray.indexOf(param1)) < 0)
         {
            return;
         }
         _app.bjbEventDispatcher.SendEvent(LEADERBOARD_UPDATED,GetList());
         _sortedPlayerFuidArray.splice(_loc5_,1);
         InsertPlayerIntoList(param1);
         UpdateRanks();
      }
      
      public static function addCachedFriends() : void
      {
         var _loc1_:PlayerData = null;
         for each(_loc1_ in _cachedPlayerDataArray)
         {
            addPlayerData(_loc1_);
         }
         _cachedPlayerDataArray.length = 0;
         UpdateRanks();
      }
      
      private static function onGetUser(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param1.data != null)
         {
            _loc2_ = String(param1.data.id);
            _loc3_ = String(param1.data.name);
            _loc4_ = String(param1.data.picture);
            if(_playerDataDictionary[_loc2_] != null)
            {
               (_playerDataDictionary[_loc2_] as PlayerData).onGetUser(_loc3_,_loc4_);
            }
         }
         else
         {
            ErrorReporting.sendError(ErrorReporting.ERROR_TYPE_RUNTIME,ErrorReporting.ERROR_LEVEL_ERROR_MEDIUM,"PlayersData onGetUser data not found in obj: " + param1);
         }
      }
      
      private static function addPlayerData(param1:PlayerData) : void
      {
         _playerDataDictionary[param1.playerFuid] = param1;
         InsertPlayerIntoList(param1.playerFuid);
      }
      
      private static function InsertPlayerIntoList(param1:String) : void
      {
         var _loc4_:PlayerData = null;
         if(!(param1 in _playerDataDictionary))
         {
            return;
         }
         var _loc2_:PlayerData = _playerDataDictionary[param1];
         var _loc3_:int = 0;
         for(; _loc3_ < _sortedPlayerFuidArray.length; _loc3_++)
         {
            if(_sortedPlayerFuidArray[_loc3_] in _playerDataDictionary)
            {
               _loc4_ = _playerDataDictionary[_sortedPlayerFuidArray[_loc3_]];
               if(_loc2_.playerFuid != _loc4_.playerFuid)
               {
                  if(!(_loc2_.curTourneyData.score <= _loc4_.curTourneyData.score && _loc2_.playerFuid != _leaderboard.currentPlayerFUID || _loc2_.curTourneyData.score < _loc4_.curTourneyData.score))
                  {
                     _sortedPlayerFuidArray.splice(_loc3_,0,_loc2_.playerFuid);
                  }
                  continue;
               }
            }
            continue;
            continue;
            return;
         }
         _sortedPlayerFuidArray.push(_loc2_.playerFuid);
      }
      
      private static function UpdateRanks() : void
      {
         var _loc2_:String = null;
         var _loc3_:PlayerData = null;
         var _loc1_:int = 0;
         while(_loc1_ < _sortedPlayerFuidArray.length)
         {
            _loc2_ = _sortedPlayerFuidArray[_loc1_];
            if(_loc2_ in _playerDataDictionary)
            {
               _loc3_ = _playerDataDictionary[_loc2_];
               _loc3_.rank = _loc1_ + 1;
               _app.DispatchValidatePokeAndFlagButtonsForPlayer(_loc3_);
            }
            _loc1_++;
         }
      }
      
      private static function DispatchUserInfo(param1:XML) : void
      {
         var _loc5_:XML = null;
         if(!("userinfo" in param1))
         {
            return;
         }
         var _loc2_:XMLList = param1.userinfo;
         if(!_loc2_ || _loc2_.length() <= 0)
         {
            return;
         }
         var _loc3_:XML = _loc2_[0];
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Object = new Object();
         for each(_loc5_ in _loc3_.children())
         {
            _loc4_[_loc5_.localName().toString()] = _loc5_.toString();
         }
         _app.mainmenuLeaderboard.pageInterface.SetUserInfo(_loc4_);
      }
      
      private static function DispatchBeatenList(param1:PlayerData, param2:int, param3:int) : void
      {
         var _loc6_:String = null;
         var _loc7_:PlayerData = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         if(!_app.questManager.IsFeatureUnlockComplete())
         {
            return;
         }
         var _loc4_:Array = new Array();
         var _loc5_:Array = new Array();
         for each(_loc6_ in _sortedPlayerFuidArray)
         {
            if(_loc6_ != param1.playerFuid)
            {
               if(_loc7_ = getPlayerData(_loc6_))
               {
                  if((_loc8_ = _loc7_.curTourneyData.score) > 0 && param3 <= _loc8_ && param2 > _loc8_)
                  {
                     _loc4_.push({
                        "score":_loc8_,
                        "playerData":_loc7_,
                        "fuid":_loc6_
                     });
                     if(!_loc7_.isFakePlayer)
                     {
                        _loc5_.push({
                           "score":_loc8_,
                           "playerData":_loc7_,
                           "fuid":_loc6_
                        });
                     }
                  }
               }
            }
         }
         _beatenRank = 0;
         if(_loc5_.length > 0 && _app.logic.IsGameOver())
         {
            _loc4_.sortOn("score",Array.NUMERIC | Array.DESCENDING);
            _loc5_.sortOn("score",Array.NUMERIC | Array.DESCENDING);
            _currentBeatenFriend = _loc5_[0].playerData;
            _currentUserScore = param1.curTourneyData.score;
            _loc9_ = new Array();
            _loc10_ = 0;
            while(_loc10_ < _loc5_.length)
            {
               if(_loc5_[_loc10_].fuid != null && _loc5_[_loc10_].score != null && _loc5_[_loc10_].score > 0)
               {
                  _loc9_.push(_loc5_[_loc10_].fuid);
               }
               _loc10_++;
            }
            _beatenRank = _loc4_[0].playerData.rank;
            ServerIO.sendToServer(_JS_COMMAND_JUSTPASSED,{
               "leaderboardPosition":_beatenRank,
               "userIds":_loc9_,
               "score":_currentUserScore
            });
            if(_beatenRank == 1)
            {
               FriendPopupServerIO.showPopup(_app,FriendPopupServerIO.INDEX_ON_TOP_LEADERBOARD);
            }
            else if(_beatenRank > 1)
            {
               FriendPopupServerIO.showPopup(_app,FriendPopupServerIO.INDEX_ON_PASSED_FRIEND);
            }
         }
      }
      
      private static function handleAcceptClick(param1:MouseEvent) : void
      {
         _app.network.ExternalCall("postJustBeatFriend",{
            "friendId":_currentBeatenFriend.playerFuid,
            "friendName":_currentBeatenFriend.playerName,
            "playerScore":_currentUserScore,
            "friendScore":_currentBeatenFriend.curTourneyData.score
         });
         _app.metaUI.highlight.hidePopUp();
      }
      
      private static function handleDeclineClick(param1:MouseEvent) : void
      {
         _app.metaUI.highlight.hidePopUp();
      }
      
      public static function getCurrentPlayerIndexInLeaderboard() : int
      {
         return _sortedPlayerFuidArray.indexOf(_leaderboard.currentPlayerFUID,0);
      }
   }
}
