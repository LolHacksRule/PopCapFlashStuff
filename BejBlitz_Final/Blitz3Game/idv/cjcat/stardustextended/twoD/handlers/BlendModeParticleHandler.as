package idv.cjcat.stardustextended.twoD.handlers
{
   import idv.cjcat.stardustextended.common.handlers.ParticleHandler;
   
   public class BlendModeParticleHandler extends ParticleHandler
   {
       
      
      private var _supportedBlendModes:Vector.<String>;
      
      private var _blendMode:String = "normal";
      
      public function BlendModeParticleHandler(param1:Vector.<String>)
      {
         super();
         this._supportedBlendModes = param1;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function set blendMode(param1:String) : void
      {
         if(this._supportedBlendModes.indexOf(param1) > -1)
         {
            this._blendMode = param1;
         }
      }
   }
}
