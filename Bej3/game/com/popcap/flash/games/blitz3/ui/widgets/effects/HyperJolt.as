package com.popcap.flash.games.blitz3.ui.widgets.effects
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class HyperJolt extends Sprite
   {
       
      
      public var color:int = 0;
      
      public var isDead:Boolean = false;
      
      public var numUpdates:int = 0;
      
      public var isInvalid:Boolean = false;
      
      public var pullX:Number = 0.0;
      
      public var pullY:Number = 0.0;
      
      public var percentDone:Number = 0.0;
      
      public var points:Array;
      
      public function HyperJolt()
      {
         this.points = new Array();
         super();
      }
      
      public function Update() : void
      {
         var pullFactor:Number = NaN;
         var startX:Number = NaN;
         var startY:Number = NaN;
         var endX:Number = NaN;
         var endY:Number = NaN;
         var i:int = 0;
         var dist:Number = NaN;
         var centerMult:Number = NaN;
         var centerX:Number = NaN;
         var centerY:Number = NaN;
         var p:Point = null;
         var pr:Point = null;
         var widthMult:Number = NaN;
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
            pullFactor = Math.max(0,1 - (1 - this.percentDone) * 3);
            startX = this.points[0][0].x;
            startY = this.points[0][0].y;
            endX = this.points[7][0].x;
            endY = this.points[7][0].y;
            for(i = 0; i < 8; i++)
            {
               dist = i / 7;
               centerMult = 1 - Math.abs(1 - dist * 2);
               centerX = startX * (1 - dist) + endX * dist + centerMult * (Math.random() * (40 / 128) + pullFactor * this.pullX);
               centerY = startY * (1 - dist) + endY * dist + centerMult * (Math.random() * (40 / 128) + pullFactor * this.pullY);
               p = this.points[i][0];
               pr = this.points[i][1];
               if(i == 0 || i == 7)
               {
                  p.x = centerX;
                  p.y = centerY;
                  pr.x = centerX;
                  pr.y = centerY;
               }
               else
               {
                  widthMult = 24;
                  p.x = centerX + Math.random() * widthMult;
                  p.y = centerY + Math.random() * widthMult;
                  pr.x = centerX + Math.random() * widthMult;
                  pr.y = centerY + Math.random() * widthMult;
               }
            }
         }
         ++this.numUpdates;
      }
      
      public function Draw() : void
      {
         var p:Point = null;
         var px:Number = NaN;
         var py:Number = NaN;
         var pr:Point = null;
         var prx:Number = NaN;
         var pry:Number = NaN;
         var pd:Point = null;
         var pdx:Number = NaN;
         var pdy:Number = NaN;
         var prd:Point = null;
         var prdx:Number = NaN;
         var prdy:Number = NaN;
         var sidePct:Number = NaN;
         var centerX:Number = NaN;
         var centerY:Number = NaN;
         var centerRX:Number = NaN;
         var centerRY:Number = NaN;
         var centerDX:Number = NaN;
         var centerDY:Number = NaN;
         var centerRDX:Number = NaN;
         var centerRDY:Number = NaN;
         var g:Graphics = null;
         if(!this.isInvalid)
         {
            return;
         }
         this.isInvalid = false;
         var bright:Number = Math.min((1 - this.percentDone) * 8,1);
         var centerColor:int = int(16777215 * bright);
         graphics.clear();
         for(var i:int = 0; i < 7; i++)
         {
            p = this.points[i][0];
            px = p.x;
            py = p.y;
            pr = this.points[i][1];
            prx = pr.x;
            pry = pr.y;
            pd = this.points[i + 1][0];
            pdx = pd.x;
            pdy = pd.y;
            prd = this.points[i + 1][1];
            prdx = prd.x;
            prdy = prd.y;
            sidePct = 0.3;
            centerX = px * sidePct + prx * (1 - sidePct);
            centerY = py * sidePct + pry * (1 - sidePct);
            centerRX = prx * sidePct + px * (1 - sidePct);
            centerRY = pry * sidePct + py * (1 - sidePct);
            centerDX = pdx * sidePct + prdx * (1 - sidePct);
            centerDY = pdy * sidePct + prdy * (1 - sidePct);
            centerRDX = prdx * sidePct + pdx * (1 - sidePct);
            centerRDY = prdy * sidePct + pdy * (1 - sidePct);
            g = graphics;
            g.beginFill(this.color);
            g.moveTo(px,py);
            g.lineTo(prdx,prdy);
            g.lineTo(pdx,pdy);
            g.lineTo(px,py);
            g.moveTo(px,py);
            g.lineTo(prx,pry);
            g.lineTo(prdx,prdy);
            g.lineTo(px,py);
            g.endFill();
            g.beginFill(centerColor);
            g.moveTo(centerX,centerY);
            g.lineTo(centerRDX,centerRDY);
            g.lineTo(centerDX,centerDY);
            g.lineTo(centerX,centerY);
            g.moveTo(centerX,centerY);
            g.lineTo(centerRX,centerRY);
            g.lineTo(centerRDX,centerRDY);
            g.lineTo(centerX,centerY);
            g.endFill();
         }
      }
   }
}
