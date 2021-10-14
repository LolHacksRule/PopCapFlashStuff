package §if §
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class §_-iq§ extends EventDispatcher
   {
      
      public static const §_-l7§:String = "start";
      
      public static var §_-1z§:Object = {
         "x":true,
         "y":true
      };
      
      public static var §_-BS§:Boolean = false;
      
      public static const §_-88§:String = "frame";
      
      protected static var §_-gV§:Dictionary = new Dictionary();
      
      protected static var §_-G8§:ITicker;
      
      protected static var §_-Uu§:uint = 40;
      
      public static const §_-ZO§:String = "tween";
      
      public static const §_-3U§:String = "time";
      
      public static var §_-VS§:Object = {
         "rotation":true,
         "rotationX":true,
         "rotationY":true,
         "rotationZ":true
      };
      
      public static const §_-g§:String = "delay";
      
      public static var §_-Hf§:Function;
      
      protected static var §_-AC§:String;
      
      public static const END:String = "end";
      
      public static const §_-pG§:String = "hybrid";
       
      
      public var §_-KW§:Boolean = true;
      
      protected var _position:Number = 0;
      
      protected var §_-4N§:ITicker;
      
      protected var §_-2A§:Number = 0;
      
      public var duration:Number = 1;
      
      public var §_-33§:int = 0;
      
      protected var §_-21§:Number;
      
      protected var §_-X9§:Number;
      
      protected var §_-Yi§:Object;
      
      public var data;
      
      protected var §_-0c§:Boolean;
      
      protected var §_-IH§:Object;
      
      protected var §_-6r§:Number = 0;
      
      protected var §_-Mn§:Boolean;
      
      public var §_-jy§:Boolean = false;
      
      public var §_-0H§:Boolean = false;
      
      public var §_-Uo§:§_-iq§;
      
      protected var §_-Ws§:String;
      
      public var §_-4A§:Boolean = true;
      
      protected var §_-eX§:Object;
      
      protected var §_-LP§:Boolean;
      
      public var §_-FZ§:Boolean = false;
      
      protected var §_-M9§:Object;
      
      protected var §_-VU§:Boolean;
      
      protected var §_-AR§:Boolean = true;
      
      protected var §_-7p§:Object;
      
      public var §_-k1§:Function;
      
      protected var §_-SJ§:TargetProxy;
      
      protected var §_-99§:Number;
      
      public function §_-iq§(param1:Object = null, param2:Number = 10, param3:Object = null, param4:Object = null)
      {
         §_-k1§ = §_-Rt§;
         super();
         §_-4N§ = §_-56§;
         this.target = param1;
         this.duration = param2;
         §_-k1§ = §_-Hf§ || §_-Rt§;
         §_-Vy§(param3);
         §_-1m§(param4);
      }
      
      public static function set §_-dl§(param1:uint) : void
      {
         §_-Uu§ = param1;
         if(§_-G8§ is TimeTicker)
         {
            (§_-G8§ as TimeTicker).interval = §_-Uu§ / 1000;
         }
      }
      
      public static function get §_-hL§() : String
      {
         return §_-AC§;
      }
      
      public static function get §_-56§() : ITicker
      {
         if(§_-AC§ == null)
         {
            §_-hL§ = §_-pG§;
         }
         return §_-G8§;
      }
      
      public static function set §_-hL§(param1:String) : void
      {
         param1 = param1 == §_-88§ || param1 == §_-3U§ ? param1 : §_-pG§;
         if(param1 == §_-AC§)
         {
            return;
         }
         §_-AC§ = param1;
         if(§_-AC§ == §_-3U§)
         {
            §_-G8§ = new TimeTicker();
            (§_-G8§ as TimeTicker).interval = §_-Uu§ / 1000;
         }
         else if(§_-AC§ == §_-88§)
         {
            §_-G8§ = new FrameTicker();
         }
         else
         {
            §_-G8§ = new HybridTicker();
         }
      }
      
      public static function §_-Rt§(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1;
      }
      
      public static function get §_-dl§() : uint
      {
         return §_-Uu§;
      }
      
      protected function §_-j7§(param1:Boolean) : void
      {
         if(param1)
         {
            if(§_-IH§ is IEventDispatcher)
            {
               §_-IH§.addEventListener("GDS__NONEXISTENT_EVENT",§_-2I§,false,0,false);
            }
            else
            {
               §_-gV§[this] = true;
            }
         }
         else
         {
            if(§_-IH§ is IEventDispatcher)
            {
               §_-IH§.removeEventListener("GDS__NONEXISTENT_EVENT",§_-2I§);
            }
            delete §_-gV§[this];
         }
      }
      
      public function get target() : Object
      {
         return §_-IH§;
      }
      
      public function get delay() : Number
      {
         return §_-2A§;
      }
      
      public function set delay(param1:Number) : void
      {
         if(_position == -§_-2A§)
         {
            §_-9W§(-param1);
         }
         §_-2A§ = param1;
      }
      
      protected function §_-4f§() : void
      {
         var _loc1_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         §_-0c§ = true;
         if(§_-LP§)
         {
            return;
         }
         §_-Yi§ = {};
         if(§_-eX§ && §_-Ws§)
         {
            §_-7p§ = §_-eX§[§_-Ws§];
         }
         for(_loc1_ in §_-M9§)
         {
            if(§_-FZ§ && §_-VS§[_loc1_])
            {
               _loc2_ = §_-M9§[_loc1_] = §_-M9§[_loc1_] % 360;
               _loc3_ = §_-7p§[_loc1_] % 360;
               §_-Yi§[_loc1_] = _loc3_ + (Math.abs(_loc3_ - _loc2_) < 180 ? 0 : (_loc3_ > _loc2_ ? -360 : 360));
            }
            else
            {
               §_-Yi§[_loc1_] = §_-7p§[_loc1_];
            }
         }
      }
      
      public function get §_-P-§() : String
      {
         if(_position == -§_-2A§ && §_-AR§)
         {
            §§push(§_-l7§);
         }
         else
         {
            if(_position >= 0)
            {
               return §_-33§ != -1 && _position >= (§_-33§ + 1) * duration ? END : §_-ZO§;
            }
            §§push(§_-g§);
         }
         §§goto(addr18);
      }
      
      public function get §_-Ls§() : Boolean
      {
         return §_-LP§;
      }
      
      public function deleteProperty(param1:String) : Boolean
      {
         return delete §_-M9§[param1];
      }
      
      public function set target(param1:Object) : void
      {
         §_-7p§ = §_-IH§ = param1 === null ? {} : param1;
         §_-0c§ = false;
      }
      
      public function set §_-jF§(param1:Boolean) : void
      {
         if(param1 == §_-Mn§)
         {
            return;
         }
         §_-Mn§ = param1;
         if(!§_-0c§)
         {
            §_-4f§();
         }
         §_-9W§(_position,true);
      }
      
      public function get position() : Number
      {
         return _position;
      }
      
      public function §_-9W§(param1:Number, param2:Boolean = true) : void
      {
         var _loc4_:Number = NaN;
         §_-X9§ = _position;
         _position = param1;
         if(!§_-VU§ && !§_-Jd§)
         {
            §_-nH§();
         }
         var _loc3_:Number = (§_-33§ + 1) * duration;
         if(param1 < 0)
         {
            _loc4_ = !!§_-Mn§ ? Number(duration) : Number(0);
         }
         else if(§_-33§ == -1 || param1 < _loc3_)
         {
            _loc4_ = param1 % duration;
            if((§_-0H§ && param1 / duration % 2 >= 1) != §_-Mn§)
            {
               _loc4_ = duration - _loc4_;
            }
         }
         else
         {
            _loc4_ = (§_-0H§ && §_-33§ % 2 >= 1) != §_-Mn§ ? Number(0) : Number(duration);
         }
         if(_loc4_ == §_-6r§)
         {
            return;
         }
         §_-99§ = §_-6r§;
         §_-6r§ = _loc4_;
         if(!param2 && hasEventListener(Event.CHANGE))
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
         if(!§_-0c§ && §_-X9§ <= 0 && _position >= 0)
         {
            §_-4f§();
            if(!param2 && hasEventListener(Event.INIT))
            {
               dispatchEvent(new Event(Event.INIT));
            }
         }
         §_-5B§();
         if(§_-33§ != -1 && §_-X9§ < _loc3_ && param1 >= _loc3_)
         {
            if(!param2 && hasEventListener(Event.COMPLETE))
            {
               dispatchEvent(new Event(Event.COMPLETE));
            }
            §_-Jd§ = true;
            if(§_-Uo§)
            {
               §_-Uo§.§_-Jd§ = false;
            }
         }
      }
      
      public function set §_-Ls§(param1:Boolean) : void
      {
         if(param1 && !§_-0c§)
         {
            §_-4f§();
         }
         §_-LP§ = param1;
      }
      
      public function get §_-Jd§() : Boolean
      {
         return §_-AR§;
      }
      
      public function get §_-Zp§() : Number
      {
         return §_-6r§;
      }
      
      public function §_-iv§() : void
      {
         §_-0c§ = false;
         if(_position > 0)
         {
            _position = 0;
            §_-nH§();
         }
         if(§_-KW§)
         {
            §_-Jd§ = false;
         }
      }
      
      public function §_-Us§() : Object
      {
         return §_-KS§(§_-M9§);
      }
      
      public function get propertyTarget() : Object
      {
         return §_-7p§;
      }
      
      public function play() : void
      {
         §_-Jd§ = false;
      }
      
      public function §_-au§(param1:Object = null, param2:String = null) : void
      {
         this.§_-eX§ = param1;
         this.§_-Ws§ = param2;
         §_-0c§ = false;
      }
      
      public function get §_-jF§() : Boolean
      {
         return §_-Mn§;
      }
      
      public function set position(param1:Number) : void
      {
         §_-9W§(param1,true);
      }
      
      protected function §_-VR§(param1:String, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = param2 + (param3 - param2) * param4;
         if(§_-jy§ && §_-1z§[param1])
         {
            _loc5_ = Math.round(_loc5_);
         }
         if(param1 == "currentFrame")
         {
            §_-7p§.gotoAndStop(_loc5_ << 0);
         }
         else
         {
            §_-7p§[param1] = _loc5_;
         }
      }
      
      public function §_-Vy§(param1:Object) : void
      {
         var _loc2_:* = null;
         §_-M9§ = {};
         for(_loc2_ in param1)
         {
            setProperty(_loc2_,param1[_loc2_]);
         }
      }
      
      public function getProperty(param1:String) : Number
      {
         return §_-M9§[param1];
      }
      
      public function end() : void
      {
         §_-9W§(§_-33§ == -1 ? Number(duration) : Number((§_-33§ + 1) * duration));
      }
      
      public function set §_-Jd§(param1:Boolean) : void
      {
         if(param1 == §_-AR§)
         {
            return;
         }
         §_-AR§ = param1;
         if(param1)
         {
            §_-4N§.removeEventListener("tick",§_-S8§);
         }
         else
         {
            §_-4N§.addEventListener("tick",§_-S8§,false,0,true);
            if(§_-33§ != -1 && _position >= duration * (§_-33§ + 1))
            {
               position = 0;
            }
            else
            {
               §_-nH§();
            }
         }
         §_-j7§(!param1);
      }
      
      public function §_-mk§() : void
      {
         §_-9W§(-§_-2A§);
      }
      
      public function setProperty(param1:String, param2:Number) : void
      {
         if(isNaN(param2))
         {
            return;
         }
         §_-M9§[param1] = param2;
         if(§_-LP§ && §_-Yi§[param1] == null)
         {
            §_-Yi§[param1] = §_-7p§[param1];
         }
         §_-iv§();
      }
      
      protected function §_-nH§() : void
      {
         §_-21§ = §_-4N§.position - _position;
      }
      
      protected function §_-KS§(param1:Object) : Object
      {
         var _loc3_:* = null;
         var _loc2_:Object = {};
         for(_loc3_ in param1)
         {
            _loc2_[param1] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public function §_-1m§(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:* = null;
         if(!param1)
         {
            return;
         }
         if("position" in param1)
         {
            _loc2_ = param1.position;
            delete param1.position;
         }
         if("initListener" in param1)
         {
            addEventListener(Event.INIT,param1.initListener,false,0,true);
            delete param1.initListener;
         }
         if("completeListener" in param1)
         {
            addEventListener(Event.COMPLETE,param1.completeListener,false,0,true);
            delete param1.completeListener;
         }
         if("changeListener" in param1)
         {
            addEventListener(Event.CHANGE,param1.changeListener,false,0,true);
            delete param1.changeListener;
         }
         for(_loc3_ in param1)
         {
            this[_loc3_] = param1[_loc3_];
         }
         if(!isNaN(_loc2_))
         {
            position = _loc2_;
         }
      }
      
      protected function §_-5B§() : void
      {
         var _loc2_:* = null;
         var _loc1_:Number = §_-k1§(§_-6r§ / duration,0,1,1);
         for(_loc2_ in §_-M9§)
         {
            §_-VR§(_loc2_,§_-Yi§[_loc2_],§_-M9§[_loc2_],_loc1_);
         }
         if(§_-4A§ && "alpha" in §_-M9§ && "alpha" in §_-7p§ && "visible" in §_-7p§)
         {
            §_-7p§.visible = §_-7p§.alpha > 0;
         }
         if(§_-eX§ && §_-Ws§)
         {
            §_-eX§[§_-Ws§] = §_-7p§;
         }
      }
      
      public function §_-GQ§(param1:Boolean = true) : void
      {
         var _loc2_:Number = §_-33§ == -1 ? Number(duration - _position % duration) : Number((§_-33§ + 1) * duration - _position);
         if(§_-0H§)
         {
            §_-Mn§ = position / duration % 2 >= 1 == _loc2_ / duration % 2 >= 1 != §_-Mn§;
         }
         else
         {
            §_-Mn§ = !§_-Mn§;
         }
         §_-9W§(_loc2_,param1);
      }
      
      public function §_-U5§(param1:Object) : void
      {
         §_-Yi§ = §_-KS§(param1);
         §_-0c§ = true;
      }
      
      protected function §_-S8§(param1:Event) : void
      {
         §_-VU§ = true;
         if(§_-BS§)
         {
            §_-nH§();
         }
         else
         {
            §_-9W§(§_-4N§.position - §_-21§,false);
         }
         §_-VU§ = false;
      }
      
      public function get §_-10§() : Object
      {
         if(§_-SJ§ == null)
         {
            §_-SJ§ = new TargetProxy(this);
         }
         return §_-SJ§;
      }
      
      public function pause() : void
      {
         §_-Jd§ = true;
      }
      
      protected function §_-2I§(param1:Event) : void
      {
      }
      
      public function §_-1q§() : Object
      {
         return §_-KS§(§_-Yi§);
      }
   }
}

import flash.events.IEventDispatcher;

interface ITicker extends IEventDispatcher
{
    
   
   function get position() : Number;
}

import flash.display.Shape;
import flash.events.Event;
import flash.events.EventDispatcher;

class FrameTicker extends EventDispatcher implements ITicker
{
    
   
   protected var shape:Shape;
   
   protected var _position:Number = 0;
   
   function FrameTicker()
   {
      super();
      shape = new Shape();
      shape.addEventListener(Event.ENTER_FRAME,tick);
   }
   
   public function get position() : Number
   {
      return _position;
   }
   
   protected function tick(param1:Event) : void
   {
      ++_position;
      dispatchEvent(new Event("tick"));
   }
}

import flash.utils.Proxy;
import flash.utils.flash_proxy;
import §if §.§_-iq§;

dynamic class TargetProxy extends Proxy
{
    
   
   private var gTween:§_-iq§;
   
   function TargetProxy(param1:§_-iq§)
   {
      super();
      this.gTween = param1;
   }
   
   override flash_proxy function deleteProperty(param1:*) : Boolean
   {
      return gTween.deleteProperty(param1);
   }
   
   override flash_proxy function callProperty(param1:*, ... rest) : *
   {
      return gTween.propertyTarget[param1].apply(null,rest);
   }
   
   override flash_proxy function setProperty(param1:*, param2:*) : void
   {
      if(isNaN(param2))
      {
         gTween.propertyTarget[param1] = param2;
      }
      else
      {
         gTween.setProperty(String(param1),Number(param2));
      }
   }
   
   override flash_proxy function getProperty(param1:*) : *
   {
      var _loc2_:Number = gTween.getProperty(param1);
      return !!isNaN(_loc2_) ? gTween.propertyTarget[param1] : _loc2_;
   }
}

import flash.display.Shape;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

class HybridTicker extends EventDispatcher implements ITicker
{
    
   
   protected var shape:Shape;
   
   function HybridTicker()
   {
      super();
      shape = new Shape();
      shape.addEventListener(Event.ENTER_FRAME,tick);
   }
   
   public function get position() : Number
   {
      return getTimer() / 1000;
   }
   
   protected function tick(param1:Event) : void
   {
      dispatchEvent(new Event("tick"));
   }
}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;
import flash.utils.getTimer;

class TimeTicker extends EventDispatcher implements ITicker
{
    
   
   protected var timer:Timer;
   
   function TimeTicker()
   {
      super();
      timer = new Timer(20);
      timer.start();
      timer.addEventListener(TimerEvent.TIMER,tick);
   }
   
   public function get position() : Number
   {
      return getTimer() / 1000;
   }
   
   public function set interval(param1:Number) : void
   {
      timer.delay = param1 * 1000;
   }
   
   protected function tick(param1:TimerEvent) : void
   {
      dispatchEvent(new Event("tick"));
      param1.updateAfterEvent();
   }
}
