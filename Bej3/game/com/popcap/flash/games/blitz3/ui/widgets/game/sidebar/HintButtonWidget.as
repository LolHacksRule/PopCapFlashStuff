package com.popcap.flash.games.blitz3.ui.widgets.game.sidebar
{
   import com.popcap.flash.framework.resources.images.ImageManager;
   import com.popcap.flash.games.bej3.Board;
   import com.popcap.flash.games.bej3.Gem;
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.MoveFinder;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import com.popcap.flash.games.blitz3.ui.sprites.FadeButton;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class HintButtonWidget extends FadeButton
   {
       
      
      private var mApp:Blitz3App;
      
      private var mIsInited:Boolean = false;
      
      public function HintButtonWidget(app:Blitz3App)
      {
         super(app);
         this.mApp = app;
         addEventListener(MouseEvent.CLICK,this.HandleClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
      }
      
      public function Init() : void
      {
         var imgMan:ImageManager = this.mApp.imageManager;
         var hintBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_HINT_UP));
         hintBitmap.smoothing = true;
         up.addChild(hintBitmap);
         var overBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3Images.IMAGE_UI_HINT_OVER));
         overBitmap.smoothing = true;
         over.addChild(overBitmap);
         Center();
         this.mIsInited = true;
      }
      
      public function Reset() : void
      {
      }
      
      public function Draw() : void
      {
      }
      
      override protected function Update() : void
      {
         SetEnabled(this.mApp.logic.timerLogic.GetTimeRemaining() > 0);
         super.Update();
      }
      
      private function HandleMouseOver(e:MouseEvent) : void
      {
         this.mApp.soundManager.playSound(Blitz3Sounds.SOUND_BUTTON_OVER);
      }
      
      private function HandleClick(e:Event) : void
      {
         if(this.mApp.logic.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         var board:Board = this.mApp.logic.board;
         var moveFinder:MoveFinder = board.moveFinder;
         var moves:Vector.<MoveData> = moveFinder.FindAllMoves(board);
         if(moves.length == 0)
         {
            return;
         }
         var moveData:MoveData = moves[0];
         var gem:Gem = moveData.sourceGem;
         gem.mIsHinted = true;
      }
   }
}
