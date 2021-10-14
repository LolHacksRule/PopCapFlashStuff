package com.popcap.flash.games.bej3.gems.scramble
{
   import com.popcap.flash.games.bej3.MoveData;
   import com.popcap.flash.games.bej3.blitz.BlitzEvent;
   import com.popcap.flash.games.blitz3.Blitz3App;
   import flash.events.Event;
   
   public class ScrambleDelayEvent extends Event implements BlitzEvent
   {
      
      public static const ID:String = "ScrambleDelayEvent";
       
      
      protected var m_App:Blitz3App;
      
      protected var m_MoveData:MoveData;
      
      protected var m_IsDone:Boolean;
      
      public function ScrambleDelayEvent(app:Blitz3App, moveData:MoveData)
      {
         super(ID);
         this.m_App = app;
         this.m_MoveData = moveData;
         this.Init();
      }
      
      public function Init() : void
      {
         this.m_IsDone = false;
      }
      
      public function Update(gameSpeed:Number) : void
      {
         if(this.m_IsDone || !this.m_App.logic.board.IsStill())
         {
            return;
         }
         this.m_App.logic.AddBlockingEvent(new ScrambleEvent(this.m_App,this.m_MoveData));
         this.m_IsDone = true;
      }
      
      public function IsDone() : Boolean
      {
         return this.m_IsDone;
      }
   }
}
