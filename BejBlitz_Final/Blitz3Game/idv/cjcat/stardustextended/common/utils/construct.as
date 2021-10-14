package idv.cjcat.stardustextended.common.utils
{
   import flash.errors.IllegalOperationError;
   
   public function construct(param1:Class, param2:Array = null) : *
   {
      if(!param2)
      {
         return new param1();
      }
      switch(param2.length)
      {
         case 0:
            return new param1();
         case 1:
            return new param1(param2[0]);
         case 2:
            return new param1(param2[0],param2[1]);
         case 3:
            return new param1(param2[0],param2[1],param2[2]);
         case 4:
            return new param1(param2[0],param2[1],param2[2],param2[3]);
         case 5:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
         case 6:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
         case 7:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
         case 8:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
         case 9:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
         case 10:
            return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
         default:
            throw new IllegalOperationError("The number of parameters given exceeds the maximum number this method can handle.");
      }
   }
}
