package com.popcap.flash.bejeweledblitz.messages
{
   import com.popcap.flash.bejeweledblitz.Dimensions;
   import com.popcap.flash.bejeweledblitz.game.session.Blitz3Network;
   import com.popcap.flash.bejeweledblitz.game.ui.buttons.ButtonWidget;
   import com.popcap.flash.bejeweledblitz.messages.common.ParamLoader;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameFonts;
   import com.popcap.flash.games.blitz3game.resources.Blitz3GameSounds;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flashx.textLayout.formats.TextAlign;
   
   public class MessagesWidget extends Sprite
   {
      
      public static const EVENT_CLOSE_CANCEL:String = "EVT_CLOSE_CANCEL";
      
      public static const EVENT_CLOSE_SHARE:String = "EVT_CLOSE_SHARE";
      
      private static var m_MessageQueue:Vector.<MessagesWidget>;
       
      
      protected var m_App:Blitz3Game;
      
      protected var m_Params:ParamLoader;
      
      protected var m_Initialized:Boolean;
      
      protected var m_Messages:Object;
      
      protected var m_BackgroundAnim:MessagesBackground;
      
      protected var m_MessageText:TextField;
      
      protected var m_Buttons:ButtonWidget;
      
      protected var m_MessageKey:String;
      
      protected var m_CurrentMessage:Sprite;
      
      protected var m_CurrentMessageId:String;
      
      protected var m_DefaultMessage:Object;
      
      public function MessagesWidget(app:Blitz3Game)
      {
         super();
         this.m_App = app;
         this.initAssets();
         this.m_Params = new ParamLoader(this.m_DefaultMessage);
         addEventListener(EVENT_CLOSE_CANCEL,this.onCloseCancel);
         addEventListener(EVENT_CLOSE_SHARE,this.onCloseShare);
         m_MessageQueue = new Vector.<MessagesWidget>();
      }
      
      public function Show(configId:String) : void
      {
         this.getSwfConfig(configId);
         if(this.m_MessageKey == null)
         {
            this.displayMessage(null);
         }
         else
         {
            this.displayMessage(this.m_Params.getParamStr(this.m_MessageKey).toLowerCase());
         }
         if(m_MessageQueue.length == 0)
         {
            this.m_App.ui.MessageMode(true,this);
         }
         m_MessageQueue.push(this);
      }
      
      public function getSwfConfig(configId:String) : void
      {
         var config:Object = this.m_App.network.ExternalCall(Blitz3Network.GET_SWF_CONFIG,configId);
         if(config)
         {
            this.m_Params = new ParamLoader(config);
         }
      }
      
      public function RotateMessage(event:MouseEvent = null) : void
      {
         var key:* = null;
         this.m_App.ui.MessageMode(false);
         this.m_App.ui.MessageMode(true,this);
         if(this.m_CurrentMessage != null && contains(this.m_CurrentMessage))
         {
            removeChild(this.m_CurrentMessage);
         }
         var first:String = null;
         var useNext:Boolean = false;
         for(key in this.m_Messages)
         {
            if(useNext)
            {
               this.displayMessage(key);
               return;
            }
            if(this.m_CurrentMessageId == key)
            {
               useNext = true;
            }
            if(first == null)
            {
               first = key;
            }
         }
         this.displayMessage(first);
      }
      
      protected function initAssets() : void
      {
      }
      
      protected function displayMessage(msg:String) : void
      {
         if(!msg)
         {
            msg = "msg";
         }
         this.m_CurrentMessageId = msg;
         this.m_CurrentMessage = this.m_Messages[msg];
         if(!this.m_CurrentMessage)
         {
            trace("no message named: " + msg + " is available");
            this.onClose({"post":false});
            return;
         }
         this.m_App.SoundManager.playSound(Blitz3GameSounds.SOUND_MESSAGE_APPEAR);
      }
      
      protected function createMessageTextField() : void
      {
         this.m_MessageText = new TextField();
         var tf:TextFormat = new TextFormat(Blitz3GameFonts.FONT_BLITZ_STANDARD,16,16777215,true);
         tf.align = TextAlign.CENTER;
         this.m_MessageText.defaultTextFormat = tf;
         this.m_MessageText.embedFonts = true;
         this.m_MessageText.multiline = true;
         this.m_MessageText.selectable = false;
         this.m_MessageText.autoSize = TextFieldAutoSize.CENTER;
         this.m_MessageText.filters = [new GlowFilter(0,1,2,2,20)];
         this.m_MessageText.x = 0.5 * (Dimensions.GAME_WIDTH - this.m_MessageText.width);
         addChild(this.m_MessageText);
      }
      
      protected function onCloseShare(e:Event) : void
      {
         this.onClose({"post":true});
      }
      
      protected function onCloseCancel(e:Event) : void
      {
         this.onClose({"post":false});
      }
      
      protected function onClose(shareData:Object) : void
      {
         if(this.m_CurrentMessage != null && contains(this.m_CurrentMessage))
         {
            removeChild(this.m_CurrentMessage);
         }
         this.m_App.network.ExternalCall(this.m_Params.getParamStr("callback"),shareData);
         this.m_App.ui.MessageMode(false);
         m_MessageQueue.shift();
         if(m_MessageQueue.length > 0)
         {
            this.m_App.ui.MessageMode(true,m_MessageQueue[0]);
         }
      }
   }
}
