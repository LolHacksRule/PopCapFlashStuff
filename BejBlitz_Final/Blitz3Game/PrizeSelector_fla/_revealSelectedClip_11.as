package PrizeSelector_fla
{
   import adobe.utils.*;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   public dynamic class _revealSelectedClip_11 extends MovieClip
   {
       
      
      public var txtPrize:TextField;
      
      public var lightseedClip:MovieClip;
      
      public var txtlightseed:TextField;
      
      public var centerClip:MovieClip;
      
      public var coinClip:MovieClip;
      
      public var center:MovieClip;
      
      public var __animFactory_centeraf1:AnimatorFactory3D;
      
      public var __animArray_centeraf1:Array;
      
      public var ____motion_centeraf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_centeraf1_matArray__:Array;
      
      public var __motion_centeraf1:MotionBase;
      
      public function _revealSelectedClip_11()
      {
         super();
         if(this.__animFactory_centeraf1 == null)
         {
            this.__animArray_centeraf1 = new Array();
            this.__motion_centeraf1 = new MotionBase();
            this.__motion_centeraf1.duration = 25;
            this.__motion_centeraf1.overrideTargetTransform();
            this.__motion_centeraf1.addPropertyArray("visible",[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]);
            this.__motion_centeraf1.addPropertyArray("cacheAsBitmap",[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]);
            this.__motion_centeraf1.addPropertyArray("blendMode",["normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal","normal"]);
            this.__motion_centeraf1.addPropertyArray("opaqueBackground",[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]);
            this.__motion_centeraf1.is3D = true;
            this.__motion_centeraf1.motion_internal::spanStart = 0;
            this.____motion_centeraf1_matArray__ = new Array();
            this.____motion_centeraf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_centeraf1_mat3DVec__[0] = 1;
            this.____motion_centeraf1_mat3DVec__[1] = 0;
            this.____motion_centeraf1_mat3DVec__[2] = 0;
            this.____motion_centeraf1_mat3DVec__[3] = 0;
            this.____motion_centeraf1_mat3DVec__[4] = 0;
            this.____motion_centeraf1_mat3DVec__[5] = 1;
            this.____motion_centeraf1_mat3DVec__[6] = 0;
            this.____motion_centeraf1_mat3DVec__[7] = 0;
            this.____motion_centeraf1_mat3DVec__[8] = 0;
            this.____motion_centeraf1_mat3DVec__[9] = 0;
            this.____motion_centeraf1_mat3DVec__[10] = 1;
            this.____motion_centeraf1_mat3DVec__[11] = 0;
            this.____motion_centeraf1_mat3DVec__[12] = 41.700001;
            this.____motion_centeraf1_mat3DVec__[13] = 51.650002;
            this.____motion_centeraf1_mat3DVec__[14] = 0;
            this.____motion_centeraf1_mat3DVec__[15] = 1;
            this.____motion_centeraf1_matArray__.push(new Matrix3D(this.____motion_centeraf1_mat3DVec__));
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.____motion_centeraf1_matArray__.push(null);
            this.__motion_centeraf1.addPropertyArray("matrix3D",this.____motion_centeraf1_matArray__);
            this.__animArray_centeraf1.push(this.__motion_centeraf1);
            this.__animFactory_centeraf1 = new AnimatorFactory3D(null,this.__animArray_centeraf1);
            this.__animFactory_centeraf1.addTargetInfo(this,"center",0,true,0,true,null,-1);
         }
      }
   }
}
