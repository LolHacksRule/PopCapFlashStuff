package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseMedalView;
   import flash.events.MouseEvent;
   
   public class MedalView extends BaseMedalView implements IInterfaceComponent, IMedalStripHandler
   {
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Strip:MedalStrip;
      
      public function MedalView(app:App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_Strip = new MedalStrip(app,leaderboard);
      }
      
      public function Init() : void
      {
         addChild(this.m_Strip);
         this.m_Strip.x = anchorMedalStrip.x - this.m_Strip.width * 0.5;
         this.m_Strip.y = anchorMedalStrip.y;
         this.m_Strip.Init();
         btnLeft.addEventListener(MouseEvent.CLICK,this.HandleLeftClick);
         btnRight.addEventListener(MouseEvent.CLICK,this.HandleRightClick);
         this.m_Strip.AddHandler(this);
         btnLeft.mouseEnabled = false;
         btnRight.mouseEnabled = true;
         clipLeftDisabled.visible = true;
         clipRightDisabled.visible = false;
      }
      
      public function Reset() : void
      {
         this.m_Strip.Reset();
      }
      
      public function SetPlayerData(data:PlayerData) : void
      {
         this.m_Strip.SetPlayerData(data);
      }
      
      public function HandleStripMoved() : void
      {
         btnLeft.mouseEnabled = true;
         clipLeftDisabled.visible = false;
         btnRight.mouseEnabled = true;
         clipRightDisabled.visible = false;
         if(this.m_Strip.IsMaxLeft())
         {
            btnLeft.mouseEnabled = false;
            clipLeftDisabled.visible = true;
         }
         if(this.m_Strip.IsMaxRight())
         {
            btnRight.mouseEnabled = false;
            clipRightDisabled.visible = true;
         }
      }
      
      protected function HandleLeftClick(event:MouseEvent) : void
      {
         this.m_Strip.ScrollLeft();
      }
      
      protected function HandleRightClick(event:MouseEvent) : void
      {
         this.m_Strip.ScrollRight();
      }
   }
}
