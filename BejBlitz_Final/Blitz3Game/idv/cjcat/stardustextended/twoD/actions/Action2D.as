package idv.cjcat.stardustextended.twoD.actions
{
   import idv.cjcat.stardustextended.common.actions.Action;
   
   public class Action2D extends Action
   {
       
      
      public function Action2D()
      {
         super();
         _supports3D = false;
      }
      
      override public function getXMLTagName() : String
      {
         return "Action2D";
      }
   }
}
