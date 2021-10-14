package com.popcap.flash.bejeweledblitz.replay.ui.game
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.games.blitz3replay.resources.Blitz3ReplayImages;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ReplayOverWidget extends Sprite
   {
      
      protected static const QUERY_PARAMS:Array = new Array("lpt","kt_type","kt_ut","kt_st1","kt_st2","kt_st3");
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Image:DisplayObject;
      
      protected var m_QueryString:String;
      
      public function ReplayOverWidget(app:Blitz3App)
      {
         super();
         buttonMode = true;
         useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.OnLinkClicked);
         this.m_QueryString = "";
         this.m_App = app;
         this.m_Image = new Bitmap(app.ImageManager.getBitmapData(Blitz3ReplayImages.IMAGE_REPLAY_OVER));
         this.m_Image.x = 25;
         this.m_Image.y = 50;
         addChild(this.m_Image);
         visible = false;
      }
      
      public function Init() : void
      {
         if(stage)
         {
            this.ParseQueryString();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.OnAddedToStage);
         }
         this.Reset();
      }
      
      public function Reset() : void
      {
         visible = false;
      }
      
      protected function ParseQueryString() : void
      {
         var params:Array = null;
         var loaderParams:Object = null;
         var param:String = null;
         try
         {
            params = new Array();
            if(stage.loaderInfo && stage.loaderInfo.parameters)
            {
               loaderParams = stage.loaderInfo.parameters;
               for each(param in QUERY_PARAMS)
               {
                  if(param in loaderParams)
                  {
                     params.push(param + "=" + loaderParams[param]);
                  }
               }
               if(params.length > 0)
               {
                  this.m_QueryString = "?" + params[0];
                  params.shift();
                  for each(param in params)
                  {
                     this.m_QueryString += "&" + param;
                  }
               }
            }
         }
         catch(err:Error)
         {
            trace("Error while parsing query string for links\n" + err + "\nstacktrace:\n" + err.getStackTrace());
         }
      }
      
      public function OnLinkClicked(event:MouseEvent) : void
      {
         var request:URLRequest = new URLRequest("http://apps.facebook.com/bejeweledblitz/" + this.m_QueryString);
         navigateToURL(request,"_blank");
      }
      
      protected function OnAddedToStage(event:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.OnAddedToStage);
         this.ParseQueryString();
      }
   }
}
