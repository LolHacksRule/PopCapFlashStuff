package com.popcap.flash.games.zuma2.logic
{
   import com.popcap.flash.framework.Canvas;
   import com.popcap.flash.framework.widgets.Widget;
   import com.popcap.flash.framework.widgets.WidgetContainer;
   import de.polygonal.ds.DLinkedList;
   
   public class Board extends WidgetContainer implements Widget
   {
       
      
      public var mBulletList:DLinkedList;
      
      public var mGameState:int;
      
      public var mLevel:Level;
      
      public var mLives:int;
      
      public var mScore:int;
      
      public var mAdventureMode:Boolean;
      
      public var mLevelNum:int;
      
      public var mFrog:Gun;
      
      private var mApp:Zuma2App;
      
      public function Board(param1:Zuma2App)
      {
         super();
         this.mApp = param1;
      }
      
      override public function draw(param1:Canvas) : void
      {
      }
      
      override public function update() : void
      {
      }
      
      public function StartLevel(param1:String) : void
      {
         this.SetupTunnels(this.mLevel);
         this.mLevel.StartLevel();
         this.mLevel.SetFrog(this.mFrog);
      }
      
      public function SetupTunnels(param1:Level) : void
      {
      }
      
      override public function onMouseMove(param1:Number, param2:Number) : void
      {
         this.UpdateGunPos(param1,param2);
      }
      
      public function UpdateGunPos(param1:Number, param2:Number) : void
      {
         var _loc3_:int = this.mFrog.GetCenterX();
         var _loc4_:int = this.mFrog.GetCenterY();
         var _loc5_:int = param1 - _loc3_;
         var _loc6_:int = _loc4_ - param2;
         var _loc7_:Number = Math.atan2(_loc6_,_loc5_) + Math.PI / 2;
         this.mFrog.SetDestAngle(_loc7_);
      }
   }
}
