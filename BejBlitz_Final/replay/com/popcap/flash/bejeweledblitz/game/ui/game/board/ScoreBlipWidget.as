package com.popcap.flash.bejeweledblitz.game.ui.game.board
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.logic.game.IBlitzScoreKeeperHandler;
   import com.popcap.flash.bejeweledblitz.logic.game.ScoreData;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class ScoreBlipWidget extends Sprite implements IBlitzScoreKeeperHandler
   {
       
      
      private var m_App:Blitz3App;
      
      private var mMatchBlips:Dictionary;
      
      private var mGemBlips:Dictionary;
      
      public function ScoreBlipWidget(app:Blitz3App)
      {
         super();
         this.m_App = app;
      }
      
      public function Init() : void
      {
         this.mMatchBlips = new Dictionary();
         this.mGemBlips = new Dictionary();
         this.m_App.logic.scoreKeeper.AddHandler(this);
      }
      
      public function Reset() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         this.mMatchBlips = new Dictionary();
         this.mGemBlips = new Dictionary();
      }
      
      public function Update() : void
      {
         if(this.m_App.logic.timerLogic.IsPaused())
         {
            return;
         }
         for(var i:int = 0; i < numChildren; i++)
         {
            (getChildAt(i) as ScoreBlip).Update();
         }
      }
      
      public function HandlePointsScored(data:ScoreData) : void
      {
         var blip:ScoreBlip = null;
         if(data.gem != null)
         {
            blip = this.mGemBlips[data.id];
            if(blip == null)
            {
               blip = new ScoreBlip(data);
               this.mGemBlips[data.id] = blip;
            }
            else
            {
               blip.Init(data);
            }
            if(!contains(blip))
            {
               addChild(blip);
            }
         }
         else
         {
            blip = this.mMatchBlips[data.id];
            if(blip == null)
            {
               blip = new ScoreBlip(data);
               this.mMatchBlips[data.id] = blip;
            }
            else
            {
               blip.Init(data);
            }
            if(!contains(blip))
            {
               addChild(blip);
            }
         }
      }
   }
}
