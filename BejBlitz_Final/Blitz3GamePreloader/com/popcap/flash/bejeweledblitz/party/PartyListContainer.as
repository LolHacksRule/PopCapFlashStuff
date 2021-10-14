package com.popcap.flash.bejeweledblitz.party
{
   import com.caurina.transitions.Tweener;
   import com.caurina.transitions.properties.FilterShortcuts;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButton;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class PartyListContainer extends Sprite
   {
      
      public static const LIST_WIDTH:Number = 229;
      
      public static const BOX_HEIGHT:Number = 68;
      
      private static const _MAX_SCREEN_BOXES:Number = 4;
      
      private static const _LIST_HEIGHT:Number = BOX_HEIGHT * _MAX_SCREEN_BOXES;
      
      private static const _GRADIENT_BORDER_WIDTH:Number = 0.5;
      
      private static var _DESC_CONTENT_OFFSET_Y:Number = -28.5;
      
      private static const _USE_DESC:Boolean = true;
      
      private static var _DESC_OFFSET_Y:Number = -24;
       
      
      private var _app:Blitz3Game;
      
      private var _container:MovieClip;
      
      private var _tabCallback:Function;
      
      private var _btnUp:GenericButtonClip;
      
      private var _btnDown:GenericButtonClip;
      
      private var _txtPageDivider:TextField;
      
      private var _listBoxArray:Vector.<PartyListBox>;
      
      private var _minY:Number = 0;
      
      private var _currentTopBoxIndex:int = 0;
      
      private var _maxTopBoxIndex:int = 0;
      
      private var _tabInactive:GenericButton;
      
      private var _tabActive:GenericButton;
      
      private var _activeLineLeft:Bitmap;
      
      private var _activeLineRight:Bitmap;
      
      private var _maskContainer:Sprite;
      
      private var _boxContainer:Sprite;
      
      private var _isBtnUpActive:Boolean = false;
      
      private var _isBtnDownActive:Boolean = false;
      
      public function PartyListContainer(param1:Blitz3Game, param2:MovieClip, param3:Function, param4:GenericButtonClip, param5:GenericButtonClip, param6:TextField)
      {
         super();
         this._app = param1;
         this._container = param2;
         this._tabCallback = param3;
         this._btnUp = param4;
         this._btnDown = param5;
         this._txtPageDivider = param6;
         _DESC_OFFSET_Y = 0;
         FilterShortcuts.init();
         this._listBoxArray = new Vector.<PartyListBox>();
         this._maskContainer = new Sprite();
         this._maskContainer.scrollRect = new Rectangle(0,0,LIST_WIDTH,_LIST_HEIGHT);
         this._boxContainer = new Sprite();
         this._maskContainer.addChild(this._boxContainer);
         this._container.addChild(this._maskContainer);
         this._tabInactive = new GenericButton(this._app,14,Blitz3GameImages.IMAGE_CHALLENGE_TAB_BACK_CAP,Blitz3GameImages.IMAGE_CHALLENGE_TAB_BACK_MID);
         this._tabInactive.setOverSound();
         this._tabInactive.SetText("",50);
         this._tabInactive.y = -1;
         this._tabInactive.addEventListener(MouseEvent.CLICK,this.onInactiveTabPress);
         this._tabInactive.visible = false;
         this._container.addChild(this._tabInactive);
         this._tabActive = new GenericButton(this._app,14,Blitz3GameImages.IMAGE_CHALLENGE_TAB_FRONT_CAP,Blitz3GameImages.IMAGE_CHALLENGE_TAB_FRONT_MID);
         this._tabActive.setOverSound();
         this._tabActive.SetText("",50);
         this._tabActive.y = 0;
         this._tabActive.visible = false;
         this._tabActive.buttonMode = false;
         this._tabActive.useHandCursor = false;
         this._container.addChild(this._tabActive);
         this._activeLineLeft = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_CHALLENGE_LIST_BORDER));
         this._activeLineLeft.y = -this._activeLineLeft.height + _DESC_OFFSET_Y;
         this._activeLineLeft.visible = false;
         this._activeLineRight = new Bitmap(this._app.ImageManager.getBitmapData(Blitz3GameImages.IMAGE_CHALLENGE_LIST_BORDER));
         this._activeLineRight.y = -this._activeLineRight.height + _DESC_OFFSET_Y;
         this._activeLineRight.visible = false;
         this._container.addChild(this._activeLineLeft);
         this._container.addChild(this._activeLineRight);
      }
      
      public function initTab(param1:String) : void
      {
         this._tabInactive.SetText(param1);
         this._tabInactive.SetDimensions(this._tabInactive.width + 1,27);
         this._tabInactive.CenterText();
         this._tabInactive.y = Math.round(this._activeLineLeft.y - this._tabInactive.height + 3);
         this._tabInactive.getText().y = Math.round(this._tabInactive.getText().y + 2);
         this._tabInactive.addOverMult(0.25);
         this._tabActive.SetText(param1);
         this._tabActive.SetDimensions(this._tabActive.width + 1,30);
         this._tabActive.CenterText();
         this._tabActive.y = Math.round(this._activeLineLeft.y - Math.round(this._tabActive.height) + 6);
         this._tabActive.y = Math.round(this._tabActive.y);
      }
      
      public function setTabX(param1:Number) : void
      {
         this._tabInactive.x = param1;
         this._activeLineLeft.x = _GRADIENT_BORDER_WIDTH;
         this._activeLineLeft.width = param1 - _GRADIENT_BORDER_WIDTH + 1;
         this._tabActive.x = param1;
         this._activeLineRight.x = param1 + this._tabActive.width;
         this._activeLineRight.width = LIST_WIDTH - this._activeLineRight.x - _GRADIENT_BORDER_WIDTH;
      }
      
      public function getListLength() : Number
      {
         return this._listBoxArray.length;
      }
      
      public function getTabWidth() : Number
      {
         return this._tabActive.width;
      }
      
      public function clearList() : void
      {
         this._currentTopBoxIndex = 0;
         this._maxTopBoxIndex = 0;
         this._boxContainer.y = 0;
         this._minY = 0;
         while(this._boxContainer.numChildren > 0)
         {
            this._boxContainer.removeChildAt(0);
         }
         this._listBoxArray = new Vector.<PartyListBox>();
      }
      
      public function removeListBox(param1:String) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         while(_loc2_ < this._listBoxArray.length)
         {
            if(this._listBoxArray[_loc2_].partyData.partyID == param1 && this._boxContainer.contains(this._listBoxArray[_loc2_]))
            {
               this._boxContainer.removeChild(this._listBoxArray[_loc2_]);
               this._listBoxArray[_loc2_].destroy();
               this._listBoxArray.splice(_loc2_,1);
               _loc3_ = _loc2_;
               while(_loc3_ < this._listBoxArray.length)
               {
                  this._listBoxArray[_loc3_].y = _loc3_ * BOX_HEIGHT;
                  _loc3_++;
               }
               return;
            }
            _loc2_++;
         }
         this.setBoundaries();
         --this._currentTopBoxIndex;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
      }
      
      public function update() : void
      {
         this.updateScroll();
         this.handleArrowButtons();
      }
      
      public function buildList(param1:Vector.<PartyData>) : void
      {
         var _loc2_:PartyData = null;
         var _loc3_:uint = 0;
         var _loc5_:PartyListBox = null;
         this.clearList();
         var _loc4_:uint = 0;
         _loc3_ = 0;
         for(; _loc3_ < param1.length; _loc3_++)
         {
            _loc2_ = param1[_loc3_];
            if(!(_loc2_.isExpired() && _loc2_.partyState != PartyData.PARTY_STATE_COMPLETED_TO_COLLECT))
            {
               switch(_loc2_.partyState)
               {
                  case PartyData.PARTY_STATE_CURRENT_TO_PLAY:
                     _loc5_ = new PartyListBoxCurrentToPlay(this._app,this,_loc2_);
                     break;
                  case PartyData.PARTY_STATE_CURRENT_WAITING:
                     _loc5_ = new PartyListBoxCurrentWaiting(this._app,this,_loc2_);
                     break;
                  case PartyData.PARTY_STATE_COMPLETED_TO_COLLECT:
                     _loc5_ = new PartyListBoxCompletedToCollect(this._app,this,_loc2_);
                     break;
                  case PartyData.PARTY_STATE_COMPLETED_COLLECTED:
                     _loc5_ = new PartyListBoxCompletedCollected(this._app,this,_loc2_);
                     break;
                  default:
                     continue;
               }
               _loc5_.y = _loc4_ * BOX_HEIGHT;
               _loc4_++;
               this._listBoxArray.push(_loc5_);
               this._boxContainer.addChild(_loc5_);
            }
         }
         this.setBoundaries();
      }
      
      public function highlightText() : void
      {
         this.hideGlow(this._tabInactive.getText());
         this.hideGlow(this._tabActive.getText());
         if(this._listBoxArray.length > 0)
         {
            this.showGlow(this._tabInactive.getText());
            this.showGlow(this._tabActive.getText());
         }
      }
      
      private function hideGlow(param1:TextField) : void
      {
         Tweener.removeTweens(param1);
         param1.filters = null;
      }
      
      private function showGlow(param1:TextField) : void
      {
         var _loc3_:GlowFilter = new GlowFilter(16777215,1,8,8,1.75,BitmapFilterQuality.LOW);
         var _loc4_:GlowFilter = new GlowFilter(16777215,0,8,8,1.75,BitmapFilterQuality.LOW);
         var _loc5_:GlowFilter = new GlowFilter(16777215,1,8,8,0.9,BitmapFilterQuality.HIGH);
         Tweener.addTween(param1,{
            "time":0.5,
            "_filter":_loc3_,
            "transition":"easeOutCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5,
            "_filter":_loc4_,
            "transition":"easeInCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5 * 3,
            "_filter":_loc3_,
            "transition":"easeOutCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5 * 4,
            "_filter":_loc4_,
            "transition":"easeInCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5 * 6,
            "_filter":_loc3_,
            "transition":"easeOutCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5 * 7,
            "_filter":_loc4_,
            "transition":"easeInCubic"
         });
         Tweener.addTween(param1,{
            "time":0.5,
            "delay":0.5 * 9,
            "_filter":_loc5_,
            "transition":"easeOutCubic"
         });
      }
      
      private function setBoundaries() : void
      {
         if(this._listBoxArray.length > _MAX_SCREEN_BOXES)
         {
            this._minY = -(this._listBoxArray.length - _MAX_SCREEN_BOXES) * BOX_HEIGHT;
            this._maxTopBoxIndex = this._listBoxArray.length - _MAX_SCREEN_BOXES;
         }
         else
         {
            this._minY = 0;
            this._maxTopBoxIndex = 0;
         }
      }
      
      public function showMe(param1:String = "") : void
      {
         var _loc2_:uint = 0;
         this._tabInactive.visible = false;
         this._tabActive.visible = true;
         if(!_USE_DESC)
         {
            this._activeLineLeft.visible = true;
            this._activeLineRight.visible = true;
         }
         if(param1 != "")
         {
            _loc2_ = 0;
            while(_loc2_ < this._listBoxArray.length)
            {
               if(this._listBoxArray[_loc2_].partyData.partyID == param1)
               {
                  this._currentTopBoxIndex = _loc2_;
                  if(this._currentTopBoxIndex > this._maxTopBoxIndex)
                  {
                     this._currentTopBoxIndex = this._maxTopBoxIndex;
                  }
                  break;
               }
               _loc2_++;
            }
            this.updateScroll();
         }
         if(this._maxTopBoxIndex == 0)
         {
            this._btnUp.clipListener.visible = false;
            this._btnDown.clipListener.visible = false;
         }
         else
         {
            this._btnUp.clipListener.visible = true;
            this._btnDown.clipListener.visible = true;
         }
         this._boxContainer.visible = true;
         this.handleArrowButtons();
      }
      
      public function hideMe() : void
      {
         this._tabInactive.visible = true;
         this._tabActive.visible = false;
         this._activeLineLeft.visible = false;
         this._activeLineRight.visible = false;
         this._boxContainer.visible = false;
      }
      
      private function onInactiveTabPress(param1:MouseEvent) : void
      {
         if(this._tabInactive.visible == true)
         {
            this._tabCallback.call();
         }
      }
      
      public function upPress() : void
      {
         if(!this._isBtnUpActive)
         {
            return;
         }
         this._currentTopBoxIndex -= _MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex < 0)
         {
            this._currentTopBoxIndex = 0;
         }
         this.updateScroll();
         this.handleArrowButtons();
      }
      
      public function downPress() : void
      {
         if(!this._isBtnDownActive)
         {
            return;
         }
         this._currentTopBoxIndex += _MAX_SCREEN_BOXES;
         if(this._currentTopBoxIndex > this._maxTopBoxIndex)
         {
            this._currentTopBoxIndex = this._maxTopBoxIndex;
         }
         this.updateScroll();
         this.handleArrowButtons();
      }
      
      private function updateScroll() : void
      {
         Tweener.removeTweens(this._boxContainer);
         Tweener.addTween(this._boxContainer,{
            "y":-this._currentTopBoxIndex * BOX_HEIGHT,
            "time":0.5
         });
      }
      
      private function handleArrowButtons() : void
      {
         if(this._currentTopBoxIndex <= 0)
         {
            this._currentTopBoxIndex = 0;
            this._btnUp.deactivate();
            this._btnUp.clipListener.alpha = 0.2;
            this._isBtnUpActive = false;
         }
         else
         {
            this._btnUp.activate();
            this._btnUp.clipListener.alpha = 1;
            this._isBtnUpActive = true;
         }
         if(this._currentTopBoxIndex >= this._maxTopBoxIndex)
         {
            this._currentTopBoxIndex = this._maxTopBoxIndex;
            this._btnDown.deactivate();
            this._btnDown.clipListener.alpha = 0.2;
            this._isBtnDownActive = false;
         }
         else
         {
            this._btnDown.activate();
            this._btnDown.clipListener.alpha = 1;
            this._isBtnDownActive = true;
         }
         var _loc1_:Number = Math.max(1,Math.ceil(this._listBoxArray.length / _MAX_SCREEN_BOXES));
         var _loc2_:Number = Math.ceil(this._currentTopBoxIndex / _MAX_SCREEN_BOXES) + 1;
         this._txtPageDivider.htmlText = _loc2_ + " / " + _loc1_;
      }
   }
}
