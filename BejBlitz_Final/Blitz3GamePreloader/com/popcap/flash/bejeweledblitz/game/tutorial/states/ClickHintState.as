package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.bejeweledblitz.BJBDataEvent;
   import com.popcap.flash.bejeweledblitz.game.ui.MainWidgetGame;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ClickHintState extends BaseTutorialState
   {
      
      private static const POST_HINT_DELAY:int = 150;
      
      public static const TUTORIAL_HINT_CLICKED:String = "TutorialHintClicked";
       
      
      private var m_App:Blitz3Game;
      
      private var m_Timer:int;
      
      public function ClickHintState(param1:Blitz3Game)
      {
         super(param1);
         this.m_App = param1;
         this.m_Timer = 0;
      }
      
      override public function Update() : void
      {
         --this.m_Timer;
         if(this.m_Timer <= 0)
         {
            isDone = true;
         }
      }
      
      override public function EnterState() : void
      {
         super.EnterState();
         this.m_Timer = int.MAX_VALUE;
         this.m_App.bjbEventDispatcher.addEventListener(ClickHintState.TUTORIAL_HINT_CLICKED,this.HandleHintClicked);
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_HINT_BUTTON_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_HINT_BUTTON));
         var _loc1_:Rectangle = (this.m_App.ui as MainWidgetGame).game.hint.getRect((this.m_App.ui as MainWidgetGame).game.hint);
         var _loc2_:Point = new Point(_loc1_.x,_loc1_.y + _loc1_.height * 0.5);
         _loc2_ = (this.m_App.ui as MainWidgetGame).game.hint.localToGlobal(_loc2_);
         _loc2_ = this.m_App.metaUI.tutorial.globalToLocal(_loc2_);
         this.m_App.metaUI.tutorial.ShowArrow(_loc2_,180);
         _loc2_ = new Point(_loc1_.x,_loc1_.y);
         var _loc3_:Point = new Point(_loc1_.x + _loc1_.width,_loc1_.y + _loc1_.height);
         _loc2_ = (this.m_App.ui as MainWidgetGame).game.hint.localToGlobal(_loc2_);
         _loc3_ = (this.m_App.ui as MainWidgetGame).game.hint.localToGlobal(_loc3_);
         _loc2_ = this.m_App.metaUI.tutorial.globalToLocal(_loc2_);
         _loc3_ = this.m_App.metaUI.tutorial.globalToLocal(_loc3_);
         this.m_App.metaUI.highlight.HighlightRect(_loc2_.x,_loc2_.y,_loc3_.x - _loc2_.x,_loc3_.y - _loc2_.y,true,true,0.65);
      }
      
      override public function ExitState() : void
      {
         this.m_App.bjbEventDispatcher.removeEventListener(ClickHintState.TUTORIAL_HINT_CLICKED,this.HandleHintClicked);
         super.ExitState();
      }
      
      private function HandleHintClicked(param1:BJBDataEvent) : void
      {
         this.m_Timer = POST_HINT_DELAY;
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.tutorial.HideArrow();
      }
   }
}
