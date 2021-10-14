package com.popcap.flash.bejeweledblitz.navigation
{
   import com.popcap.flash.bejeweledblitz.Utils;
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.GenericButtonClip;
   import com.popcap.flash.bejeweledblitz.quest.QuestPanelToolTip;
   import com.popcap.flash.framework.resources.localization.BaseLocalizationManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class NavigationButton extends GenericButtonClip
   {
       
      
      private var _app:Blitz3App;
      
      private var _counter:NavigationBadge;
      
      private var _enabled:Boolean = true;
      
      private var _clipListener:MovieClip;
      
      private var _counterPlaceHolder:MovieClip;
      
      private var _questPanelTooltip:QuestPanelToolTip;
      
      private var _canShowTooltip:Boolean;
      
      public function NavigationButton(param1:Blitz3App, param2:MovieClip, param3:String, param4:Function, param5:NavigationBadge, param6:MovieClip = null, param7:Boolean = false)
      {
         var _loc8_:BaseLocalizationManager = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         super(param1,param2,true,true);
         setRelease(param4);
         this._clipListener = param2;
         this._counter = param5;
         this._counterPlaceHolder = param6;
         if(param5)
         {
            if(this._counterPlaceHolder != null)
            {
               Utils.removeAllChildrenFrom(this._counterPlaceHolder);
               this._counterPlaceHolder.addChild(this._counter);
            }
         }
         if(param7)
         {
            this._questPanelTooltip = new QuestPanelToolTip(param1);
            this._questPanelTooltip.visible = false;
            _loc9_ = (_loc8_ = param1.TextManager).GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_BODY_NOT_APPLICABLE);
            _loc10_ = _loc8_.GetLocString(Blitz3GameLoc.LOC_QUEST_TOOL_TIP_TITLE_EASY);
            this._questPanelTooltip.scaleX = 1.3;
            this._questPanelTooltip.scaleY = 1.3;
            this._questPanelTooltip.setContent("",_loc9_,QuestPanelToolTip.LEFT);
            this._questPanelTooltip.x += 10;
            this._clipListener.addChild(this._questPanelTooltip);
            this._questPanelTooltip.rotation = -this._clipListener.rotation;
         }
         this._canShowTooltip = false;
      }
      
      public function get image() : MovieClip
      {
         return this._clipListener;
      }
      
      public function get counter() : NavigationBadgeCounter
      {
         return this._counter as NavigationBadgeCounter;
      }
      
      public function setNotificationText(param1:int) : void
      {
         var _loc2_:NavigationBadgeCounter = null;
         if(this._counter)
         {
            _loc2_ = this._counter as NavigationBadgeCounter;
            _loc2_.value = param1;
         }
      }
      
      public function setNotificationString(param1:String) : void
      {
         var _loc2_:NavigationBadgeString = null;
         if(this._counter)
         {
            _loc2_ = this._counter as NavigationBadgeString;
            _loc2_.value = param1;
         }
      }
      
      public function isEnabled() : Boolean
      {
         return this._enabled;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this._enabled = param1;
         this._clipListener.useHandCursor = this._enabled;
         if(this._counter)
         {
            this._counter.visible = this._counter.empty() == false;
            this._counter.setEnabled(param1);
         }
         super.SetDisabled(!param1);
      }
      
      private function onmouseOut(param1:MouseEvent) : void
      {
         if(this._questPanelTooltip && this._canShowTooltip)
         {
            this._questPanelTooltip.visible = false;
         }
      }
      
      private function onmouseOver(param1:MouseEvent) : void
      {
         if(this._questPanelTooltip && this._canShowTooltip)
         {
            this._questPanelTooltip.visible = true;
         }
      }
      
      public function set canShowTooltip(param1:Boolean) : void
      {
         this._canShowTooltip = param1;
         if(param1)
         {
            this._clipListener.addEventListener(MouseEvent.MOUSE_OVER,this.onmouseOver);
            this._clipListener.addEventListener(MouseEvent.MOUSE_OUT,this.onmouseOut);
         }
         else
         {
            this._clipListener.removeEventListener(MouseEvent.MOUSE_OVER,this.onmouseOver);
            this._clipListener.removeEventListener(MouseEvent.MOUSE_OUT,this.onmouseOut);
         }
      }
      
      public function setCallbackFn(param1:Function) : void
      {
         setRelease(param1);
      }
   }
}
