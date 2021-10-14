package com.popcap.flash.bejeweledblitz.dailyspin2.UI
{
   public class SpinBoardTileCursorAction
   {
       
      
      public var mAction:uint;
      
      public var mTileView:SpinBoardTileView;
      
      public var mActionCompleteCallback:Function;
      
      public var mTileId:uint;
      
      public var mCanBePreempted:Boolean;
      
      public var mFrameIdToStopAt:uint;
      
      public function SpinBoardTileCursorAction(param1:uint, param2:SpinBoardTileView, param3:uint, param4:Function, param5:Boolean, param6:uint)
      {
         super();
         this.mAction = param1;
         this.mTileView = param2;
         this.mActionCompleteCallback = param4;
         this.mTileId = param3;
         this.mCanBePreempted = param5;
         this.mFrameIdToStopAt = param6;
      }
   }
}
