package idv.cjcat.stardustextended.cjsignals
{
   class ListenerData
   {
       
      
      public var listener:Function;
      
      public var priority:int;
      
      public var once:Boolean;
      
      public var index:int;
      
      function ListenerData(param1:Function, param2:int, param3:Boolean)
      {
         super();
         this.listener = param1;
         this.priority = param2;
         this.once = param3;
      }
   }
}
