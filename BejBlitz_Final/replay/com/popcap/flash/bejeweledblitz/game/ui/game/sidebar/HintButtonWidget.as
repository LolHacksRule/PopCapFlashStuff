package com.popcap.flash.bejeweledblitz.game.ui.game.sidebar
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.SkinButton;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.Gem;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MoveFinder;
   import com.popcap.flash.framework.resources.images.BaseImageManager;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameImages;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class HintButtonWidget extends SkinButton
   {
       
      
      private var m_App:Blitz3App;
      
      private var m_Moves:Vector.<MoveData>;
      
      public function HintButtonWidget(app:Blitz3App)
      {
         super(app);
         this.m_App = app;
         this.m_Moves = new Vector.<MoveData>();
         addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      public function Init() : void
      {
         var imgMan:BaseImageManager = this.m_App.ImageManager;
         var hintBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_HINT_UP));
         up.addChild(hintBitmap);
         var overBitmap:Bitmap = new Bitmap(imgMan.getBitmapData(Blitz3GameImages.IMAGE_UI_HINT_OVER));
         over.addChild(overBitmap);
         Center();
      }
      
      override protected function HandleFrame(e:Event) : void
      {
         SetEnabled(this.m_App.logic.timerLogic.GetTimeRemaining() > 0);
         super.HandleFrame(e);
      }
      
      private function HandleClick(e:Event) : void
      {
         if(this.m_App.logic.timerLogic.GetTimeRemaining() <= 0)
         {
            return;
         }
         var board:Board = this.m_App.logic.board;
         var moveFinder:MoveFinder = board.moveFinder;
         moveFinder.FindAllMoves(board,this.m_Moves);
         if(this.m_Moves.length <= 0)
         {
            return;
         }
         var moveData:MoveData = this.m_Moves[0];
         var gem:Gem = moveData.sourceGem;
         gem.isHinted = true;
         this.m_App.logic.movePool.FreeMoves(this.m_Moves);
      }
   }
}
