package com.popcap.flash.bejeweledblitz.game.session
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.GameBoardSeed;
   import com.popcap.flash.bejeweledblitz.logic.Board;
   import com.popcap.flash.bejeweledblitz.logic.MoveData;
   import com.popcap.flash.bejeweledblitz.logic.MoveFinder;
   import com.popcap.flash.bejeweledblitz.logic.game.BlitzLogic;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   
   public class SessionSnapShot
   {
       
      
      private var snapshot:Object;
      
      private var logic:BlitzLogic;
      
      private var snapShotBuffer:int;
      
      private var batchLimit:int;
      
      private var numSnapShots:int;
      
      private var batchCount:int;
      
      public function SessionSnapShot(param1:BlitzLogic, param2:int, param3:int)
      {
         super();
         this.logic = param1;
         this.snapshot = new Object();
         this.numSnapShots = 0;
         this.batchCount = 0;
         this.snapShotBuffer = param2;
         this.batchLimit = param3;
      }
      
      public function RecordSnapshot() : void
      {
         var _loc1_:Vector.<MoveData> = new Vector.<MoveData>();
         var _loc2_:Board = this.logic.board;
         var _loc3_:MoveFinder = _loc2_.moveFinder;
         _loc3_.FindAllMoves(_loc2_,_loc1_);
         this.snapshot[GameBoardSeed.GetCurrentSeed().toString()] = this.GetMinimalMoveData(_loc1_);
         this.numSnapShots += 1;
         if(this.numSnapShots >= this.snapShotBuffer)
         {
            this.FlushToServer();
         }
      }
      
      private function GetMinimalMoveData(param1:Vector.<MoveData>) : Vector.<Object>
      {
         var _loc4_:MoveData = null;
         var _loc5_:Vector.<int> = null;
         var _loc2_:Vector.<Object> = new Vector.<Object>();
         var _loc3_:int = param1.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = param1[_loc3_];
            (_loc5_ = new Vector.<int>()).push(_loc4_.sourcePos.x * 10 + _loc4_.sourcePos.y);
            _loc5_.push(_loc4_.swapPos.x * 10 + _loc4_.swapPos.y);
            _loc2_.push(_loc5_);
            _loc3_--;
         }
         return _loc2_;
      }
      
      public function FlushToServer() : void
      {
         var _loc1_:URLRequest = new URLRequest(Blitz3App.app.network.parameters.pathToPHP + "ingestSeed.php");
         _loc1_.method = URLRequestMethod.POST;
         _loc1_.data = JSON.stringify(this.snapshot);
         var _loc2_:URLLoader = new URLLoader(_loc1_);
         _loc2_.load(_loc1_);
         ++this.batchCount;
         this.snapshot = new Object();
         this.numSnapShots = 0;
         if(this.batchCount >= this.batchLimit)
         {
            Blitz3Game(Blitz3App.app).EnableFastForwardMode(false);
         }
      }
   }
}
