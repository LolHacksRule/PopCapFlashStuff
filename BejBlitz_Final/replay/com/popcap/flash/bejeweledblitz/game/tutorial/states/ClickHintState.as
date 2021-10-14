package com.popcap.flash.bejeweledblitz.game.tutorial.states
{
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameLoc;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ClickHintState extends BaseTutorialState
   {
      
      private static const POST_HINT_DELAY:int = 150;
       
      
      private var m_App:Blitz3Game;
      
      private var m_Timer:int;
      
      public function ClickHintState(app:Blitz3Game)
      {
         super(app);
         this.m_App = app;
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
         this.m_App.ui.game.sidebar.buttons.hintButton.addEventListener(MouseEvent.CLICK,this.HandleHintClicked);
         this.m_App.metaUI.tutorial.ShowInfoBox(this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_HINT_BUTTON_TITLE),this.m_App.TextManager.GetLocString(Blitz3GameLoc.LOC_TUTORIAL_HINT_BUTTON));
         var rect:Rectangle = this.m_App.ui.game.sidebar.buttons.hintButton.getRect(this.m_App.ui.game.sidebar.buttons.hintButton);
         var target:Point = new Point(rect.x + rect.width * 0.5,rect.y);
         target = this.m_App.ui.game.sidebar.buttons.hintButton.localToGlobal(target);
         target = this.m_App.metaUI.tutorial.globalToLocal(target);
         this.m_App.metaUI.tutorial.ShowArrow(target,270);
         target = new Point(rect.x + rect.width * 0.5,rect.y + rect.height * 0.5);
         var dimensions:Point = new Point(rect.width,rect.height);
         target = this.m_App.ui.game.sidebar.buttons.hintButton.localToGlobal(target);
         dimensions = this.m_App.ui.game.sidebar.buttons.hintButton.localToGlobal(dimensions);
         target = this.m_App.metaUI.tutorial.globalToLocal(target);
         dimensions = this.m_App.metaUI.tutorial.globalToLocal(dimensions);
         this.m_App.metaUI.highlight.HighlightCircle(target.x,target.y,dimensions.x * 0.33,true);
         this.m_App.ui.game.sidebar.buttons.menuButton.SetEnabled(false);
      }
      
      override public function ExitState() : void
      {
         this.m_App.ui.game.sidebar.buttons.hintButton.removeEventListener(MouseEvent.CLICK,this.HandleHintClicked);
         super.ExitState();
      }
      
      private function HandleHintClicked(event:MouseEvent) : void
      {
         this.m_Timer = POST_HINT_DELAY;
         this.m_App.metaUI.highlight.Hide();
         this.m_App.metaUI.tutorial.HideArrow();
         this.m_App.ui.game.sidebar.buttons.menuButton.SetEnabled(true);
      }
   }
}
