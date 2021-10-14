package com.popcap.flash.bejeweledblitz.game.ui.gameover.message.messages
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.framework.resources.images.ImageUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class FrameMessage extends PostGameMessage
   {
       
      
      protected var frame:Bitmap;
      
      private var m_ImageMap:Dictionary;
      
      private var m_Images:Vector.<Loader>;
      
      private var m_IDList:Vector.<String>;
      
      private var m_URLList:Vector.<String>;
      
      private var m_NumLoaded:int;
      
      private var m_ClickJSFunc:String;
      
      private var m_JSCallArgs:Object;
      
      public function FrameMessage(app:Blitz3App, msg:String, imgMap:Dictionary, clickJSFunc:String, jsCallArgs:Object)
      {
         this.m_Images = new Vector.<Loader>();
         this.m_IDList = new Vector.<String>();
         this.m_URLList = new Vector.<String>();
         this.m_NumLoaded = 0;
         this.m_ClickJSFunc = clickJSFunc;
         this.m_JSCallArgs = jsCallArgs;
         this.SetImageMap(imgMap);
         addEventListener(MouseEvent.CLICK,this.HandleClick);
         super(app,msg);
      }
      
      private function SetImageMap(imgMap:Dictionary) : void
      {
         var id:* = null;
         this.m_ImageMap = imgMap;
         for(id in imgMap)
         {
            this.m_IDList.push(id);
            this.m_URLList.push(imgMap[id]);
         }
      }
      
      private function LoadImages() : void
      {
         var url:String = null;
         var loader:Loader = null;
         for each(url in this.m_URLList)
         {
            if(url && url.length > 0)
            {
               loader = this.LoadImage(url);
               this.m_Images.push(loader);
               addChild(loader);
            }
            else
            {
               trace(this + " LoadImages invalid url: " + url);
            }
         }
      }
      
      private function LoadImage(url:String) : Loader
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleLoadComplete);
         loader.load(new URLRequest(url),new LoaderContext(true));
         return loader;
      }
      
      override protected function BuildComponents() : void
      {
         super.BuildComponents();
         this.LoadImages();
         this.BuildFrame();
      }
      
      protected function BuildFrame() : void
      {
      }
      
      override protected function LayoutComponents() : void
      {
         super.LayoutComponents();
         if(this.m_Images.length > 0)
         {
            this.m_Images[0].x = this.frame.x + 45;
            this.m_Images[0].y = this.frame.y + 30;
         }
         if(this.m_Images.length > 1)
         {
            this.m_Images[1].x = this.frame.x + 102;
            this.m_Images[1].y = this.frame.y + 30;
         }
         if(this.m_Images.length > 2)
         {
            this.m_Images[2].x = this.frame.x + 159;
            this.m_Images[2].y = this.frame.y + 30;
         }
      }
      
      private function HandleLoadComplete(event:Event) : void
      {
         var img:Loader = null;
         var child:DisplayObject = null;
         var info:LoaderInfo = event.target as LoaderInfo;
         if(info == null)
         {
            return;
         }
         var image:Bitmap = info.content as Bitmap;
         if(image != null)
         {
            ImageUtils.ResizeBitmap(image,50,50);
         }
         ++this.m_NumLoaded;
         if(this.m_NumLoaded >= this.m_Images.length)
         {
            for each(img in this.m_Images)
            {
               if(img.numChildren > 0)
               {
                  child = img.getChildAt(0);
                  child.x = child.width * -0.5;
                  child.y = child.height * -0.5;
               }
            }
         }
      }
      
      private function HandleClick(event:MouseEvent) : void
      {
         m_App.network.ExternalCall(this.m_ClickJSFunc,this.m_JSCallArgs);
      }
   }
}
