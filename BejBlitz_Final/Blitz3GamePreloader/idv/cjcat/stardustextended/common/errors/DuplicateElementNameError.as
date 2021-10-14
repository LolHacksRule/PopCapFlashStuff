package idv.cjcat.stardustextended.common.errors
{
   import idv.cjcat.stardustextended.common.StardustElement;
   
   public class DuplicateElementNameError extends Error
   {
       
      
      private var _element1:StardustElement;
      
      private var _element2:StardustElement;
      
      private var _name:String;
      
      public function DuplicateElementNameError(param1:*, param2:String, param3:StardustElement, param4:StardustElement)
      {
         super(param1);
         this._element1 = param3;
         this._element2 = param4;
         this._name = param2;
      }
      
      public function get element1() : StardustElement
      {
         return this._element1;
      }
      
      public function get element2() : StardustElement
      {
         return this._element2;
      }
      
      public function get elementName() : String
      {
         return this._name;
      }
   }
}
