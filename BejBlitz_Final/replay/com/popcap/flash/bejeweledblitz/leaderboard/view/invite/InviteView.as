package com.popcap.flash.bejeweledblitz.leaderboard.view.invite
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseInviteView;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   
   public class InviteView extends BaseInviteView implements IInterfaceComponent
   {
       
      
      protected var m_App:Blitz3App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_TxtHeader:TextField;
      
      protected var m_TxtExtended:TextField;
      
      protected var m_ImageLoader:Loader;
      
      protected var m_Image:Bitmap;
      
      protected var m_FUID:String;
      
      public function InviteView(app:Blitz3App, leaderboard:LeaderboardWidget)
      {
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_ImageLoader = new Loader();
         this.m_ImageLoader.contentLoaderInfo.addEventListener(Event.INIT,this.HandleImageLoadComplete);
         this.m_TxtHeader = txtHeader;
         this.m_TxtHeader.selectable = false;
         this.m_TxtHeader.mouseEnabled = false;
         this.m_TxtExtended = txtExtended;
         this.m_TxtExtended.selectable = false;
         this.m_TxtExtended.mouseEnabled = false;
         this.m_Image = new Bitmap();
         clipAddButton.gotoAndStop(1);
         buttonMode = true;
         useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.HandleClick);
         addEventListener(MouseEvent.MOUSE_OVER,this.HandleMouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.HandleMouseOut);
      }
      
      public function Init() : void
      {
         addChildAt(this.m_Image,getChildIndex(clipImage));
         this.m_Image.x = clipImage.x;
         this.m_Image.y = clipImage.y;
         this.m_App.network.AddExternalCallback("updateInvitee",this.HandleInviteData);
         txtHeader.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_INVITE_HEADER);
         txtExtended.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_INVITE_SUBTITLE);
      }
      
      public function Reset() : void
      {
      }
      
      protected function HandleInviteData(data:Object) : void
      {
         if("pic_square" in data)
         {
            this.LoadImage(data["pic_square"]);
         }
      }
      
      protected function LoadImage(imageURL:String) : void
      {
         if(imageURL.replace(/^\s+|\s+$/g,"").length <= 0)
         {
            return;
         }
         this.m_ImageLoader.load(new URLRequest(imageURL),new LoaderContext(true));
      }
      
      protected function HandleImageLoadComplete(event:Event) : void
      {
         var tmpImg:Bitmap = null;
         tmpImg = this.m_ImageLoader.content as Bitmap;
         if(!tmpImg)
         {
            return;
         }
         this.m_Image.scaleY = 1;
         this.m_Image.scaleX = 1;
         this.m_Image.bitmapData = tmpImg.bitmapData;
         this.m_Image.scaleX = clipImage.width / this.m_Image.width;
         this.m_Image.scaleY = clipImage.height / this.m_Image.height;
         this.m_Image.smoothing = true;
      }
      
      protected function HandleClick(event:MouseEvent) : void
      {
         this.m_Leaderboard.pageInterface.IniviteLink();
      }
      
      protected function HandleMouseOver(event:MouseEvent) : void
      {
         clipAddButton.gotoAndStop(2);
      }
      
      protected function HandleMouseOut(event:MouseEvent) : void
      {
         clipAddButton.gotoAndStop(1);
      }
   }
}
