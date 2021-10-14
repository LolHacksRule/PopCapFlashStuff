package com.popcap.flash.bejeweledblitz.leaderboard.view.basic
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseEntryWheel;
   import flash.events.Event;
   import flash.geom.PerspectiveProjection;
   import flash.geom.Point;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   
   public class EntryWheel extends BaseEntryWheel implements IInterfaceComponent
   {
      
      public static const ROT_SPEED:Number = 360 * 1.5;
      
      public static const FIELD_OF_VIEW_ANGLE:Number = 15;
       
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_CurTime:Number;
      
      protected var m_PrevTime:Number;
      
      protected var m_TargetRot:Number;
      
      protected var m_Handlers:Vector.<IEntryWheelHandler>;
      
      public function EntryWheel(leaderboard:LeaderboardWidget)
      {
         super();
         this.m_Leaderboard = leaderboard;
         this.m_Handlers = new Vector.<IEntryWheelHandler>();
      }
      
      public function Init() : void
      {
         var majorNumber:int = 0;
         var minorNumber:int = 0;
         var projection:PerspectiveProjection = null;
         var versionString:String = Capabilities.version;
         var tokens:Array = versionString.split(" ");
         if(tokens.length >= 2)
         {
            tokens = (tokens[1] as String).split(",");
            if(tokens.length >= 2)
            {
               majorNumber = int(tokens[0]);
               minorNumber = int(tokens[1]);
               if(majorNumber >= 10 && minorNumber >= 1)
               {
                  projection = new PerspectiveProjection();
                  projection.fieldOfView = FIELD_OF_VIEW_ANGLE;
                  projection.projectionCenter = this.localToGlobal(new Point(0,0));
                  transform.perspectiveProjection = projection;
               }
            }
         }
         this.m_TargetRot = 0;
         back.visible = false;
         bottom.visible = false;
         top.visible = false;
         this.m_CurTime = getTimer();
         this.m_PrevTime = this.m_CurTime;
         addEventListener(Event.ENTER_FRAME,this.HandleEnterFrame);
      }
      
      public function Reset() : void
      {
         this.ResetRotation();
      }
      
      public function ResetRotation() : void
      {
         this.m_TargetRot = 0;
         rotationX = 0;
         front.visible = true;
         back.visible = false;
         bottom.visible = false;
         top.visible = false;
      }
      
      public function AddHandler(handler:IEntryWheelHandler) : void
      {
         this.m_Handlers.push(handler);
      }
      
      public function Flip() : void
      {
         this.m_TargetRot += 180;
         if(this.m_TargetRot > 180)
         {
            this.m_TargetRot = 180;
         }
      }
      
      public function BackFlip() : void
      {
         this.m_TargetRot -= 180;
         if(this.m_TargetRot < -180)
         {
            this.m_TargetRot = -180;
         }
      }
      
      public function IsFlipping() : Boolean
      {
         return Math.abs(this.m_TargetRot - rotationX) > Number.MIN_VALUE;
      }
      
      public function IsFrontFacing() : Boolean
      {
         return rotationX % 360 < 180;
      }
      
      protected function DispatchFlipToBackBegin() : void
      {
         var handler:IEntryWheelHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlipToBackBegin();
         }
      }
      
      protected function DispatchFlipToBackComplete() : void
      {
         var handler:IEntryWheelHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlipToBackComplete();
         }
      }
      
      protected function DispatchFlipToFrontBegin() : void
      {
         var handler:IEntryWheelHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlipToFrontBegin();
         }
      }
      
      protected function DispatchFlipToFrontComplete() : void
      {
         var handler:IEntryWheelHandler = null;
         for each(handler in this.m_Handlers)
         {
            handler.HandleFlipToFrontComplete();
         }
      }
      
      protected function HandleEnterFrame(event:Event) : void
      {
         this.m_CurTime = getTimer();
         var dt:Number = (this.m_CurTime - this.m_PrevTime) * 0.001;
         this.m_PrevTime = this.m_CurTime;
         if(!this.IsFlipping())
         {
            return;
         }
         var dRot:Number = this.m_TargetRot - rotationX;
         if(Math.abs(dRot) > dt * ROT_SPEED)
         {
            dRot = dt * ROT_SPEED * (dRot > 0 ? 1 : -1);
         }
         var nextRot:Number = rotationX + dRot;
         if(Math.abs(rotationX % 360) < 180 && Math.abs(nextRot % 360) >= 180)
         {
            this.DispatchFlipToBackComplete();
         }
         if(Math.abs(rotationX % 360) < 360 && Math.abs(nextRot % 360) >= 0)
         {
            this.DispatchFlipToFrontComplete();
         }
         var normalizedRot:Number = nextRot;
         while(normalizedRot < 0)
         {
            normalizedRot += 360;
         }
         normalizedRot %= 360;
         if(normalizedRot >= 90 && normalizedRot < 270)
         {
            front.visible = false;
            back.visible = !front.visible;
         }
         else
         {
            front.visible = true;
            back.visible = !front.visible;
         }
         if(normalizedRot > 0 && normalizedRot < 180)
         {
            top.visible = true;
            bottom.visible = !top.visible;
         }
         else if(normalizedRot > 180 && normalizedRot < 360)
         {
            top.visible = false;
            bottom.visible = !top.visible;
         }
         else
         {
            top.visible = false;
            bottom.visible = false;
         }
         rotationX = nextRot;
      }
   }
}
