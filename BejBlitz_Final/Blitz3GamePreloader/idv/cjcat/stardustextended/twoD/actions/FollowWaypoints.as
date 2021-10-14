package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.emitters.Emitter;
   import idv.cjcat.stardustextended.common.particles.Particle;
   import idv.cjcat.stardustextended.common.xml.XMLBuilder;
   import idv.cjcat.stardustextended.twoD.actions.waypoints.Waypoint;
   import idv.cjcat.stardustextended.twoD.geom.Vec2D;
   import idv.cjcat.stardustextended.twoD.geom.Vec2DPool;
   import idv.cjcat.stardustextended.twoD.particles.Particle2D;
   
   public class FollowWaypoints extends Action2D
   {
       
      
      public var loop:Boolean;
      
      public var massless:Boolean;
      
      private var _waypoints:Array;
      
      public function FollowWaypoints(param1:Array = null, param2:Boolean = false, param3:Boolean = true)
      {
         super();
         this.loop = param2;
         this.massless = param3;
         this.waypoints = param1;
      }
      
      public function get waypoints() : Array
      {
         return this._waypoints;
      }
      
      public function set waypoints(param1:Array) : void
      {
         if(!param1)
         {
            param1 = [];
         }
         this._waypoints = param1;
      }
      
      public function addWaypoint(param1:Waypoint) : void
      {
         this._waypoints.push(param1);
      }
      
      public function clearWaypoints() : void
      {
         this._waypoints = [];
      }
      
      override public function update(param1:Emitter, param2:Particle, param3:Number, param4:Number) : void
      {
         if(!this._waypoints.length)
         {
            return;
         }
         var _loc5_:Particle2D;
         if(!(_loc5_ = Particle2D(param2)).dictionary[FollowWaypoints])
         {
            _loc5_.dictionary[FollowWaypoints] = 0;
         }
         var _loc6_:int = _loc5_.dictionary[FollowWaypoints];
         var _loc7_:Waypoint = this._waypoints[_loc6_] as Waypoint;
         var _loc8_:Number = _loc5_.x - _loc7_.x;
         var _loc9_:Number = _loc5_.y - _loc7_.y;
         if(_loc8_ * _loc8_ + _loc9_ * _loc9_ <= _loc7_.radius * _loc7_.radius)
         {
            if(_loc6_ < this._waypoints.length - 1)
            {
               ++_loc5_.dictionary[FollowWaypoints];
               _loc7_ = this._waypoints[_loc6_ + 1];
            }
            else
            {
               if(!this.loop)
               {
                  return;
               }
               _loc7_ = this._waypoints[0];
            }
            _loc8_ = _loc5_.x - _loc7_.x;
            _loc9_ = _loc5_.y - _loc7_.y;
         }
         var _loc11_:Number;
         var _loc10_:Vec2D;
         if((_loc11_ = (_loc10_ = Vec2DPool.get(_loc8_,_loc9_)).length) < _loc7_.epsilon)
         {
            _loc11_ = _loc7_.epsilon;
         }
         _loc10_.length = -_loc7_.strength * Math.pow(_loc11_,-0.5 * _loc7_.attenuationPower);
         if(!this.massless)
         {
            _loc10_.length /= _loc5_.mass;
         }
         Vec2DPool.recycle(_loc10_);
         _loc5_.vx += _loc10_.x;
         _loc5_.vy += _loc10_.y;
      }
      
      override public function getXMLTagName() : String
      {
         return "FollowWaypoints";
      }
      
      override public function toXML() : XML
      {
         var _loc3_:Waypoint = null;
         var _loc4_:XML = null;
         var _loc1_:XML = super.toXML();
         var _loc2_:XML = <waypoints/>;
         for each(_loc3_ in this._waypoints)
         {
            (_loc4_ = <Waypoint/>).@x = _loc3_.x;
            _loc4_.@y = _loc3_.y;
            _loc4_.@radius = _loc3_.radius;
            _loc4_.@strength = _loc3_.strength;
            _loc4_.@attenuationPower = _loc3_.attenuationPower;
            _loc4_.@epsilon = _loc3_.epsilon;
            _loc2_.appendChild(_loc4_);
         }
         _loc1_.appendChild(_loc2_);
         return _loc1_;
      }
      
      override public function parseXML(param1:XML, param2:XMLBuilder = null) : void
      {
         var _loc3_:XML = null;
         var _loc4_:Waypoint = null;
         super.parseXML(param1,param2);
         this.clearWaypoints();
         for each(_loc3_ in param1.waypoints.Waypoint)
         {
            (_loc4_ = new Waypoint()).x = parseFloat(_loc3_.@x);
            _loc4_.y = parseFloat(_loc3_.@y);
            _loc4_.radius = parseFloat(_loc3_.@radius);
            _loc4_.strength = parseFloat(_loc3_.@strength);
            _loc4_.attenuationPower = parseFloat(_loc3_.@attenuationPower);
            _loc4_.epsilon = parseFloat(_loc3_.@epsilon);
            this.addWaypoint(_loc4_);
         }
      }
   }
}
