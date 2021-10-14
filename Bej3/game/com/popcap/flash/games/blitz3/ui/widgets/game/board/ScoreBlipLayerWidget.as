package com.popcap.flash.games.blitz3.ui.widgets.game.board
{
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.blitz.ScoreEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class ScoreBlipLayerWidget extends Sprite
   {
       
      
      private var mApp:Blitz3App;
      
      private var mMatchBlips:Dictionary;
      
      private var mGemBlips:Dictionary;
      
      public function ScoreBlipLayerWidget(app:Blitz3App)
      {
         super();
         this.mApp = app;
      }
      
      public function Init() : void
      {
         this.mMatchBlips = new Dictionary();
         this.mGemBlips = new Dictionary();
         this.mApp.logic.scoreKeeper.addEventListener(ScoreEvent.ID,this.HandleScoreEvent);
      }
      
      public function Reset() : void
      {
         var blip:ScoreBlipSprite = null;
         for each(blip in this.mMatchBlips)
         {
            if(blip.parent != null)
            {
               blip.parent.removeChild(blip);
            }
         }
         for each(blip in this.mGemBlips)
         {
            if(blip.parent != null)
            {
               blip.parent.removeChild(blip);
            }
         }
         this.mMatchBlips = new Dictionary();
         this.mGemBlips = new Dictionary();
      }
      
      public function Update() : void
      {
         if(this.mApp.logic.timerLogic.IsPaused())
         {
            return;
         }
         var blip:ScoreBlipSprite = null;
         for each(blip in this.mMatchBlips)
         {
            blip.Update();
         }
         for each(blip in this.mGemBlips)
         {
            blip.Update();
         }
      }
      
      public function Draw() : void
      {
      }
      
      private function HandleScoreEvent(e:ScoreEvent) : void
      {
         var blip:ScoreBlipSprite = null;
         blip = null;
         if(e.gem != null)
         {
            blip = this.mGemBlips[e.id];
            if(blip == null)
            {
               blip = new ScoreBlipSprite();
               addChild(blip);
               this.mGemBlips[e.id] = blip;
               blip.x = e.x * 40 + x + 20;
               blip.y = e.y * 40 + y + 20;
               blip.SetColor(e.color,e.gem.type == Gem.TYPE_MULTI);
            }
         }
         else
         {
            blip = this.mMatchBlips[e.id];
            if(blip == null)
            {
               blip = new ScoreBlipSprite();
               addChild(blip);
               this.mMatchBlips[e.id] = blip;
               blip.x = e.x * 40 + x + 20;
               blip.y = e.y * 40 + y + 20;
               blip.SetColor(e.color);
            }
         }
         blip.SetLife(100);
         blip.SetValue(e.value);
      }
   }
}
