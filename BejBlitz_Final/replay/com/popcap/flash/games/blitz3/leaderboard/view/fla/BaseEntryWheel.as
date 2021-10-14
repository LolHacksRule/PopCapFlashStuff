package com.popcap.flash.games.blitz3.leaderboard.view.fla
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
   
   public dynamic class BaseEntryWheel extends MovieClip
   {
       
      
      public var top:EntryEndcap;
      
      public var front:EntryFront;
      
      public var bottom:EntryEndcap;
      
      public var back:EntryBack;
      
      public var __animFactory_backaf1:AnimatorFactory3D;
      
      public var __animArray_backaf1:Array;
      
      public var ____motion_backaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_backaf1_matArray__:Array;
      
      public var __motion_backaf1:MotionBase;
      
      public var __animFactory_frontaf1:AnimatorFactory3D;
      
      public var __animArray_frontaf1:Array;
      
      public var ____motion_frontaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_frontaf1_matArray__:Array;
      
      public var __motion_frontaf1:MotionBase;
      
      public var __animFactory_bottomaf1:AnimatorFactory3D;
      
      public var __animArray_bottomaf1:Array;
      
      public var ____motion_bottomaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_bottomaf1_matArray__:Array;
      
      public var __motion_bottomaf1:MotionBase;
      
      public var __animFactory_topaf1:AnimatorFactory3D;
      
      public var __animArray_topaf1:Array;
      
      public var ____motion_topaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_topaf1_matArray__:Array;
      
      public var __motion_topaf1:MotionBase;
      
      public function BaseEntryWheel()
      {
         super();
         if(this.__animFactory_backaf1 == null)
         {
            this.__animArray_backaf1 = new Array();
            this.__motion_backaf1 = new MotionBase();
            this.__motion_backaf1.duration = 1;
            this.__motion_backaf1.overrideTargetTransform();
            this.__motion_backaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_backaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_backaf1.is3D = true;
            this.__motion_backaf1.motion_internal::spanStart = 0;
            this.____motion_backaf1_matArray__ = new Array();
            this.____motion_backaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_backaf1_mat3DVec__[0] = 1;
            this.____motion_backaf1_mat3DVec__[1] = 0;
            this.____motion_backaf1_mat3DVec__[2] = 0;
            this.____motion_backaf1_mat3DVec__[3] = 0;
            this.____motion_backaf1_mat3DVec__[4] = 0;
            this.____motion_backaf1_mat3DVec__[5] = -1;
            this.____motion_backaf1_mat3DVec__[6] = 0;
            this.____motion_backaf1_mat3DVec__[7] = 0;
            this.____motion_backaf1_mat3DVec__[8] = 0;
            this.____motion_backaf1_mat3DVec__[9] = 0;
            this.____motion_backaf1_mat3DVec__[10] = -1;
            this.____motion_backaf1_mat3DVec__[11] = 0;
            this.____motion_backaf1_mat3DVec__[12] = 0;
            this.____motion_backaf1_mat3DVec__[13] = 0;
            this.____motion_backaf1_mat3DVec__[14] = 1;
            this.____motion_backaf1_mat3DVec__[15] = 1;
            this.____motion_backaf1_matArray__.push(new Matrix3D(this.____motion_backaf1_mat3DVec__));
            this.__motion_backaf1.addPropertyArray("matrix3D",this.____motion_backaf1_matArray__);
            this.__animArray_backaf1.push(this.__motion_backaf1);
            this.__animFactory_backaf1 = new AnimatorFactory3D(null,this.__animArray_backaf1);
            this.__animFactory_backaf1.sceneName = "EntryWheel";
            this.__animFactory_backaf1.addTargetInfo(this,"back",0,true,0,true,null,-1);
         }
         if(this.__animFactory_frontaf1 == null)
         {
            this.__animArray_frontaf1 = new Array();
            this.__motion_frontaf1 = new MotionBase();
            this.__motion_frontaf1.duration = 1;
            this.__motion_frontaf1.overrideTargetTransform();
            this.__motion_frontaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_frontaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_frontaf1.is3D = true;
            this.__motion_frontaf1.motion_internal::spanStart = 0;
            this.____motion_frontaf1_matArray__ = new Array();
            this.____motion_frontaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_frontaf1_mat3DVec__[0] = 1;
            this.____motion_frontaf1_mat3DVec__[1] = 0;
            this.____motion_frontaf1_mat3DVec__[2] = 0;
            this.____motion_frontaf1_mat3DVec__[3] = 0;
            this.____motion_frontaf1_mat3DVec__[4] = 0;
            this.____motion_frontaf1_mat3DVec__[5] = 1;
            this.____motion_frontaf1_mat3DVec__[6] = 0;
            this.____motion_frontaf1_mat3DVec__[7] = 0;
            this.____motion_frontaf1_mat3DVec__[8] = 0;
            this.____motion_frontaf1_mat3DVec__[9] = 0;
            this.____motion_frontaf1_mat3DVec__[10] = 1;
            this.____motion_frontaf1_mat3DVec__[11] = 0;
            this.____motion_frontaf1_mat3DVec__[12] = 0;
            this.____motion_frontaf1_mat3DVec__[13] = 0;
            this.____motion_frontaf1_mat3DVec__[14] = -1;
            this.____motion_frontaf1_mat3DVec__[15] = 1;
            this.____motion_frontaf1_matArray__.push(new Matrix3D(this.____motion_frontaf1_mat3DVec__));
            this.__motion_frontaf1.addPropertyArray("matrix3D",this.____motion_frontaf1_matArray__);
            this.__animArray_frontaf1.push(this.__motion_frontaf1);
            this.__animFactory_frontaf1 = new AnimatorFactory3D(null,this.__animArray_frontaf1);
            this.__animFactory_frontaf1.sceneName = "EntryWheel";
            this.__animFactory_frontaf1.addTargetInfo(this,"front",0,true,0,true,null,-1);
         }
         if(this.__animFactory_bottomaf1 == null)
         {
            this.__animArray_bottomaf1 = new Array();
            this.__motion_bottomaf1 = new MotionBase();
            this.__motion_bottomaf1.duration = 1;
            this.__motion_bottomaf1.overrideTargetTransform();
            this.__motion_bottomaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_bottomaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_bottomaf1.is3D = true;
            this.__motion_bottomaf1.motion_internal::spanStart = 0;
            this.____motion_bottomaf1_matArray__ = new Array();
            this.____motion_bottomaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_bottomaf1_mat3DVec__[0] = 1;
            this.____motion_bottomaf1_mat3DVec__[1] = 0;
            this.____motion_bottomaf1_mat3DVec__[2] = 0;
            this.____motion_bottomaf1_mat3DVec__[3] = 0;
            this.____motion_bottomaf1_mat3DVec__[4] = 0;
            this.____motion_bottomaf1_mat3DVec__[5] = 0;
            this.____motion_bottomaf1_mat3DVec__[6] = 1;
            this.____motion_bottomaf1_mat3DVec__[7] = 0;
            this.____motion_bottomaf1_mat3DVec__[8] = 0;
            this.____motion_bottomaf1_mat3DVec__[9] = -1;
            this.____motion_bottomaf1_mat3DVec__[10] = 0;
            this.____motion_bottomaf1_mat3DVec__[11] = 0;
            this.____motion_bottomaf1_mat3DVec__[12] = 0;
            this.____motion_bottomaf1_mat3DVec__[13] = 29.549999;
            this.____motion_bottomaf1_mat3DVec__[14] = 1;
            this.____motion_bottomaf1_mat3DVec__[15] = 1;
            this.____motion_bottomaf1_matArray__.push(new Matrix3D(this.____motion_bottomaf1_mat3DVec__));
            this.__motion_bottomaf1.addPropertyArray("matrix3D",this.____motion_bottomaf1_matArray__);
            this.__animArray_bottomaf1.push(this.__motion_bottomaf1);
            this.__animFactory_bottomaf1 = new AnimatorFactory3D(null,this.__animArray_bottomaf1);
            this.__animFactory_bottomaf1.sceneName = "EntryWheel";
            this.__animFactory_bottomaf1.addTargetInfo(this,"bottom",0,true,0,true,null,-1);
         }
         if(this.__animFactory_topaf1 == null)
         {
            this.__animArray_topaf1 = new Array();
            this.__motion_topaf1 = new MotionBase();
            this.__motion_topaf1.duration = 1;
            this.__motion_topaf1.overrideTargetTransform();
            this.__motion_topaf1.addPropertyArray("cacheAsBitmap",[false]);
            this.__motion_topaf1.addPropertyArray("blendMode",["normal"]);
            this.__motion_topaf1.is3D = true;
            this.__motion_topaf1.motion_internal::spanStart = 0;
            this.____motion_topaf1_matArray__ = new Array();
            this.____motion_topaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_topaf1_mat3DVec__[0] = 1;
            this.____motion_topaf1_mat3DVec__[1] = 0;
            this.____motion_topaf1_mat3DVec__[2] = 0;
            this.____motion_topaf1_mat3DVec__[3] = 0;
            this.____motion_topaf1_mat3DVec__[4] = 0;
            this.____motion_topaf1_mat3DVec__[5] = 0;
            this.____motion_topaf1_mat3DVec__[6] = -1;
            this.____motion_topaf1_mat3DVec__[7] = 0;
            this.____motion_topaf1_mat3DVec__[8] = 0;
            this.____motion_topaf1_mat3DVec__[9] = 1;
            this.____motion_topaf1_mat3DVec__[10] = 0;
            this.____motion_topaf1_mat3DVec__[11] = 0;
            this.____motion_topaf1_mat3DVec__[12] = 0;
            this.____motion_topaf1_mat3DVec__[13] = -29.5;
            this.____motion_topaf1_mat3DVec__[14] = -1;
            this.____motion_topaf1_mat3DVec__[15] = 1;
            this.____motion_topaf1_matArray__.push(new Matrix3D(this.____motion_topaf1_mat3DVec__));
            this.__motion_topaf1.addPropertyArray("matrix3D",this.____motion_topaf1_matArray__);
            this.__animArray_topaf1.push(this.__motion_topaf1);
            this.__animFactory_topaf1 = new AnimatorFactory3D(null,this.__animArray_topaf1);
            this.__animFactory_topaf1.sceneName = "EntryWheel";
            this.__animFactory_topaf1.addTargetInfo(this,"top",0,true,0,true,null,-1);
         }
      }
   }
}
