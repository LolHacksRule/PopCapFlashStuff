package com.popcap.flash.bejeweledblitz.game.ui.game.board.gems.effects
{
   import flash.display.Graphics;
   import flash.display.GraphicsPathCommand;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HyperGemBolt extends Sprite
   {
       
      
      public var color:int = 0;
      
      public var isDead:Boolean = false;
      
      public var numUpdates:int = 0;
      
      public var isInvalid:Boolean = false;
      
      public var pullX:Number = 0.0;
      
      public var pullY:Number = 0.0;
      
      public var percentDone:Number = 0.0;
      
      public var percentToDo:Number = 0.0;
      
      public var points:Array;
      
      public var draw_commands:Vector.<int>;
      
      public var draw_coords:Vector.<Number>;
      
      public function HyperGemBolt()
      {
         this.points = new Array();
         super();
         this.draw_commands = new Vector.<int>(8,true);
         this.draw_commands[0] = GraphicsPathCommand.MOVE_TO;
         this.draw_commands[1] = GraphicsPathCommand.LINE_TO;
         this.draw_commands[2] = GraphicsPathCommand.LINE_TO;
         this.draw_commands[3] = GraphicsPathCommand.LINE_TO;
         this.draw_commands[4] = GraphicsPathCommand.MOVE_TO;
         this.draw_commands[5] = GraphicsPathCommand.LINE_TO;
         this.draw_commands[6] = GraphicsPathCommand.LINE_TO;
         this.draw_commands[7] = GraphicsPathCommand.LINE_TO;
      }
      
      public function Update() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Point = null;
         var _loc12_:Point = null;
         var _loc13_:Number = NaN;
         if(this.isDead)
         {
            return;
         }
         this.percentDone += 0.01;
         if(this.percentDone > 1)
         {
            this.isDead = true;
            visible = false;
            if(parent != null)
            {
               parent.removeChild(this);
            }
         }
         if(this.numUpdates % 4 == 0)
         {
            this.isInvalid = true;
            this.percentToDo = (1 - this.percentDone) * 3;
            _loc1_ = 1 > this.percentToDo ? Number(1 - this.percentToDo) : Number(0);
            _loc2_ = this.points[0][0].x;
            _loc3_ = this.points[0][0].y;
            _loc4_ = this.points[7][0].x;
            _loc5_ = this.points[7][0].y;
            _loc6_ = 0;
            while(_loc6_ < 8)
            {
               _loc7_ = _loc6_ / 7;
               _loc8_ = 1 - Math.abs(1 - _loc7_ * 2);
               _loc9_ = _loc2_ * (1 - _loc7_) + _loc4_ * _loc7_ + _loc8_ * (Math.random() * (40 / 128) + _loc1_ * this.pullX);
               _loc10_ = _loc3_ * (1 - _loc7_) + _loc5_ * _loc7_ + _loc8_ * (Math.random() * (40 / 128) + _loc1_ * this.pullY);
               _loc11_ = this.points[_loc6_][0];
               _loc12_ = this.points[_loc6_][1];
               if(_loc6_ == 0 || _loc6_ == 7)
               {
                  _loc11_.x = _loc9_;
                  _loc11_.y = _loc10_;
                  _loc12_.x = _loc9_;
                  _loc12_.y = _loc10_;
               }
               else
               {
                  _loc13_ = 24;
                  _loc11_.x = _loc9_ + Math.random() * _loc13_;
                  _loc11_.y = _loc10_ + Math.random() * _loc13_;
                  _loc12_.x = _loc9_ + Math.random() * _loc13_;
                  _loc12_.y = _loc10_ + Math.random() * _loc13_;
               }
               _loc6_++;
            }
         }
         ++this.numUpdates;
      }
      
      public function Draw() : void
      {
         var _loc7_:Point = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Point = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Point = null;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Point = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Graphics = null;
         if(!this.isInvalid)
         {
            return;
         }
         this.isInvalid = false;
         var _loc1_:Number = (1 - this.percentDone) * 8;
         var _loc2_:Number = 1 < _loc1_ ? Number(1) : Number(_loc1_);
         var _loc3_:int = int(16777215 * _loc2_);
         graphics.clear();
         var _loc6_:int = 0;
         while(_loc6_ < 7)
         {
            _loc8_ = (_loc7_ = this.points[_loc6_][0]).x;
            _loc9_ = _loc7_.y;
            _loc11_ = (_loc10_ = this.points[_loc6_][1]).x;
            _loc12_ = _loc10_.y;
            _loc14_ = (_loc13_ = this.points[_loc6_ + 1][0]).x;
            _loc15_ = _loc13_.y;
            _loc17_ = (_loc16_ = this.points[_loc6_ + 1][1]).x;
            _loc18_ = _loc16_.y;
            _loc19_ = _loc8_ * 0.3 + _loc11_ * 0.7;
            _loc20_ = _loc9_ * 0.3 + _loc12_ * 0.7;
            _loc21_ = _loc11_ * 0.3 + _loc8_ * 0.7;
            _loc22_ = _loc12_ * 0.3 + _loc9_ * 0.7;
            _loc23_ = _loc14_ * 0.3 + _loc17_ * 0.7;
            _loc24_ = _loc15_ * 0.3 + _loc18_ * 0.7;
            _loc25_ = _loc17_ * 0.3 + _loc14_ * 0.7;
            _loc26_ = _loc18_ * 0.3 + _loc15_ * 0.7;
            _loc27_ = graphics;
            this.draw_coords = Vector.<Number>([_loc8_,_loc9_,_loc17_,_loc18_,_loc14_,_loc15_,_loc8_,_loc9_,_loc8_,_loc9_,_loc11_,_loc12_,_loc17_,_loc18_,_loc8_,_loc9_]);
            _loc27_.beginFill(this.color);
            _loc27_.drawPath(this.draw_commands,this.draw_coords);
            _loc27_.endFill();
            this.draw_coords = Vector.<Number>([_loc19_,_loc20_,_loc25_,_loc26_,_loc23_,_loc24_,_loc19_,_loc20_,_loc19_,_loc20_,_loc21_,_loc22_,_loc25_,_loc26_,_loc19_,_loc20_]);
            _loc27_.beginFill(_loc3_);
            _loc27_.drawPath(this.draw_commands,this.draw_coords);
            _loc27_.endFill();
            _loc6_++;
         }
      }
   }
}
