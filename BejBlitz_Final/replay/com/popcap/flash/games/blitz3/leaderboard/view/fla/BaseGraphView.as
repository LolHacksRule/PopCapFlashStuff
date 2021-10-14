package com.popcap.flash.games.blitz3.leaderboard.view.fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class BaseGraphView extends MovieClip
   {
       
      
      public var anchorGraphTopLeft:AnchorPoint;
      
      public var txtScoreBottom:TextField;
      
      public var clipBorder:MovieClip;
      
      public var txtLastWeeks:TextField;
      
      public var clipYouFriend:GraphYouFriend;
      
      public var txtScoreMiddle:TextField;
      
      public var clipYou:BaseGraphHeader;
      
      public var txtScoreTop:TextField;
      
      public var anchorGraphBottomRight:AnchorPoint;
      
      public var clipShadow:MovieClip;
      
      public function BaseGraphView()
      {
         super();
      }
   }
}
