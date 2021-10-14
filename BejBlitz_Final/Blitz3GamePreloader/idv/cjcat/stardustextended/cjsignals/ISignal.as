package idv.cjcat.stardustextended.cjsignals
{
   public interface ISignal
   {
       
      
      function get listeners() : Array;
      
      function get valueClasses() : Array;
      
      function clear() : void;
      
      function add(param1:Function, param2:int = 0) : Function;
      
      function addOnce(param1:Function, param2:int = 0) : Function;
      
      function remove(param1:Function) : Function;
      
      function dispatch(... rest) : Signal;
      
      function getPriority(param1:Function) : Number;
   }
}
