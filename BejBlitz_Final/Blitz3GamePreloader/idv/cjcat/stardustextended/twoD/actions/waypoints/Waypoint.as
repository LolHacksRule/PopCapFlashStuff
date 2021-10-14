package idv.cjcat.stardustextended.twoD.actions.waypoints
{
   public class Waypoint
   {
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var radius:Number;
      
      public var strength:Number;
      
      public var attenuationPower:Number;
      
      public var epsilon:Number;
      
      public function Waypoint(param1:Number = 0, param2:Number = 0, param3:Number = 20, param4:Number = 1, param5:Number = 0, param6:Number = 1)
      {
         super();
         this.x = param1;
         this.y = param2;
         this.radius = param3;
         this.strength = param4;
         this.attenuationPower = param5;
         this.epsilon = param6;
      }
   }
}
