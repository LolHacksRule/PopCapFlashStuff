package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.display.DisplayObject;
   
   public class SidebarWidgetGame extends SidebarWidget
   {
       
      
      public function SidebarWidgetGame(app:Blitz3App)
      {
         super(app);
         starMedal = app.uiFactory.GetStarMedalWidget();
         highScore = app.uiFactory.GetHighScoreWidget();
         buttons = new ButtonPanelWidget(app);
      }
      
      override public function Reset() : void
      {
         super.Reset();
         starMedal.Reset();
         highScore.Reset();
      }
      
      override protected function AddChildren() : void
      {
         addChild(starMedal);
         addChild(highScore);
         addChild(buttons);
         super.AddChildren();
      }
      
      override protected function InitChildren() : void
      {
         super.InitChildren();
         starMedal.Init();
         highScore.Init();
         buttons.Init();
         this.SetLayout(84,6,4);
      }
      
      private function SetLayout(xPos:int, yPos:int, elementSpacing:int) : void
      {
         this.SetYPosLayout(yPos,elementSpacing,[speed,score,boostIcons,rareGem]);
         this.SetYPosLayout(rareGem.y + 14,elementSpacing + 2,[starMedal,highScore,buttons]);
         boostIcons.Clear();
         this.SetXPosLayout(xPos);
         speed.y += 2;
      }
      
      private function SetXPosLayout(xPos:int) : void
      {
         var obj:DisplayObject = null;
         for(var i:int = 0; i < numChildren; i++)
         {
            obj = getChildAt(i);
            obj.x = xPos - 0.5 * obj.getRect(this).width;
         }
      }
      
      private function SetYPosLayout(initY:int, elementSpacing:int, elements:Array) : void
      {
         var visibleHeight:int = 0;
         var yStride:int = initY;
         for(var i:int = 0; i < elements.length; i++)
         {
            elements[i].y = yStride;
            visibleHeight = (elements[i] as DisplayObject).getRect(this).height;
            yStride = visibleHeight > 0 ? int(visibleHeight + yStride + elementSpacing) : int(yStride + elementSpacing);
         }
      }
   }
}
