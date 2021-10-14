package com.popcap.flash.bejeweledblitz.game.ui.raregems.dynamicgem.prestige
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   
   public class PrestigeFactory
   {
      
      public static const TYPE_GACHA:String = "gacha";
      
      public static const TYPE_SCRATCH:String = "scratch";
      
      public static const TYPE_NO_CLICK:String = "noClick";
      
      public static const TYPE_NONE:String = "none";
       
      
      private var _app:Blitz3App;
      
      public function PrestigeFactory(param1:Blitz3App)
      {
         super();
         this._app = param1;
      }
      
      public function get(param1:String) : IPrestige
      {
         var _loc2_:IPrestige = null;
         switch(param1)
         {
            case TYPE_GACHA:
               _loc2_ = new GachaPrestige(this._app);
               break;
            case TYPE_SCRATCH:
               _loc2_ = new ScratchPrestige(this._app);
               break;
            case TYPE_NO_CLICK:
               _loc2_ = new NoClickPrestige(this._app);
               break;
            case TYPE_NONE:
               _loc2_ = new NonePrestige(this._app);
               break;
            default:
               _loc2_ = new NullPrestige();
         }
         return _loc2_;
      }
   }
}
