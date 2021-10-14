package com.plumbee.stardustplayer
{
   import com.plumbee.stardustplayer.emitter.DisplayListEmitterValueObject;
   import com.plumbee.stardustplayer.emitter.EmitterBuilder;
   import com.plumbee.stardustplayer.project.ProjectValueObject;
   import com.plumbee.stardustplayer.sequenceLoader.ISequenceLoader;
   import com.plumbee.stardustplayer.sequenceLoader.LoadByteArrayJob;
   import com.plumbee.stardustplayer.sequenceLoader.SequenceLoader;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import idv.cjcat.stardustextended.twoD.display.bitmapParticle.BitmapParticle;
   import org.as3commons.zip.Zip;
   
   public class SimLoader extends EventDispatcher implements ISimLoader
   {
      
      private static const bitmapParticle:BitmapParticle = null;
      
      public static const DESCRIPTOR_FILENAME:String = "descriptor.json";
      
      private static const BACKGROUND_JOB_ID:String = "backgroundID";
       
      
      private const sequenceLoader:ISequenceLoader = new SequenceLoader();
      
      private var _project:ProjectValueObject;
      
      private var projectLoaded:Boolean = false;
      
      public function SimLoader()
      {
         super();
      }
      
      public function loadSim(param1:ByteArray) : void
      {
         var _loc2_:Zip = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:ByteArray = null;
         var _loc8_:XML = null;
         var _loc9_:DisplayListEmitterValueObject = null;
         var _loc10_:LoadByteArrayJob = null;
         var _loc11_:LoadByteArrayJob = null;
         this.projectLoaded = false;
         this.sequenceLoader.clearAllJobs();
         _loc2_ = new Zip();
         _loc2_.loadBytes(param1);
         var _loc3_:Object = JSON.parse(_loc2_.getFileByName(DESCRIPTOR_FILENAME).getContentAsString());
         this._project = new ProjectValueObject(_loc3_);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.getFileCount())
         {
            _loc5_ = _loc2_.getFileAt(_loc4_).filename;
            if(ZipFileNames.isEmitterXMLName(_loc5_))
            {
               _loc6_ = ZipFileNames.getEmitterID(_loc5_);
               _loc7_ = _loc2_.getFileByName(_loc5_).content;
               _loc8_ = new XML(_loc7_.readUTFBytes(_loc7_.length));
               _loc9_ = new DisplayListEmitterValueObject(_loc6_,EmitterBuilder.buildEmitter(_loc8_));
               this._project.emitters[_loc6_] = _loc9_;
               _loc9_.prepareForDisplayList();
               _loc10_ = new LoadByteArrayJob(_loc6_.toString(),ZipFileNames.getImageName(_loc6_),_loc2_.getFileByName(ZipFileNames.getImageName(_loc6_)).content);
               this.sequenceLoader.addJob(_loc10_);
            }
            _loc4_++;
         }
         if(_loc2_.getFileByName(this._project.backgroundFileName) != null)
         {
            _loc11_ = new LoadByteArrayJob(BACKGROUND_JOB_ID,this._project.backgroundFileName,_loc2_.getFileByName(this._project.backgroundFileName).content);
            this.sequenceLoader.addJob(_loc11_);
         }
         this.sequenceLoader.addEventListener(Event.COMPLETE,this.onProjectAssetsLoaded);
         this.sequenceLoader.loadSequence();
      }
      
      private function onProjectAssetsLoaded(param1:Event) : void
      {
         var _loc2_:DisplayListEmitterValueObject = null;
         var _loc3_:LoadByteArrayJob = null;
         this.sequenceLoader.removeEventListener(Event.COMPLETE,this.onProjectAssetsLoaded);
         for each(_loc2_ in this._project.emitters)
         {
            _loc3_ = this.sequenceLoader.getJobByName(_loc2_.id.toString());
            _loc2_.image = Bitmap(_loc3_.content).bitmapData;
         }
         if(this.sequenceLoader.getJobByName(BACKGROUND_JOB_ID))
         {
            this._project.backgroundImage = this.sequenceLoader.getJobByName(BACKGROUND_JOB_ID).content;
            this._project.backgroundRawData = this.sequenceLoader.getJobByName(BACKGROUND_JOB_ID).byteArray;
         }
         this.sequenceLoader.clearAllJobs();
         this.projectLoaded = true;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function get project() : ProjectValueObject
      {
         if(this.projectLoaded)
         {
            return this._project;
         }
         return null;
      }
   }
}
