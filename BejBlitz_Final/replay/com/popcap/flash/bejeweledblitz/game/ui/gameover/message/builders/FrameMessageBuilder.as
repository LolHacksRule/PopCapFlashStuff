package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.builders
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages.PostGameMessage;
   import flash.utils.Dictionary;
   
   public class FrameMessageBuilder extends PostGameMessageBuilder
   {
      
      private static const NUM_IMGS:int = 3;
       
      
      private var m_ImageMap:Object;
      
      private var m_IdList:Vector.<String>;
      
      private var m_CurPos:int;
      
      private var m_JSFunctionName:String;
      
      private var m_MessageClass:Class;
      
      private var m_MessageText:String;
      
      public function FrameMessageBuilder(app:Blitz3App, jsFunc:String, messageClass:Class, msg:String)
      {
         super(app);
         this.m_IdList = new Vector.<String>();
         this.m_JSFunctionName = jsFunc;
         this.m_MessageClass = messageClass;
         this.m_MessageText = msg;
      }
      
      override public function CanBuild() : Boolean
      {
         return !m_App.network.isOffline;
      }
      
      override public function BuildMessage() : PostGameMessage
      {
         this.UpdateImageList();
         trace("num friends: " + this.m_IdList.length);
         if(this.m_IdList.length < NUM_IMGS)
         {
            return null;
         }
         return new this.m_MessageClass(m_App,this.m_MessageText,this.GetNextImages());
      }
      
      private function UpdateImageList() : void
      {
         if(this.m_IdList.length > 0)
         {
            return;
         }
         this.m_ImageMap = m_App.network.ExternalCall(this.m_JSFunctionName);
         if(this.m_ImageMap)
         {
            this.CreateShuffledList();
            this.m_CurPos = 0;
         }
      }
      
      private function CreateShuffledList() : void
      {
         var id:* = null;
         var numImgs:int = 0;
         var numSwaps:int = 0;
         var i:int = 0;
         var idx0:int = 0;
         var idx1:int = 0;
         var tmp:String = null;
         this.m_IdList.length = 0;
         for(id in this.m_ImageMap)
         {
            this.m_IdList.push(id);
         }
         numImgs = this.m_IdList.length;
         numSwaps = numImgs * 2;
         for(i = 0; i < numSwaps; i++)
         {
            idx0 = Math.random() * numImgs;
            idx1 = Math.random() * numImgs;
            tmp = this.m_IdList[idx0];
            this.m_IdList[idx0] = this.m_IdList[idx1];
            this.m_IdList[idx1] = tmp;
         }
      }
      
      private function GetNextImages() : Dictionary
      {
         var curId:String = null;
         var result:Dictionary = new Dictionary();
         var numImgs:int = this.m_IdList.length;
         for(var i:int = 0; i < NUM_IMGS; i++)
         {
            curId = this.m_IdList[(this.m_CurPos + i) % numImgs];
            result[curId] = this.m_ImageMap[curId];
         }
         this.m_CurPos += NUM_IMGS;
         return result;
      }
   }
}
