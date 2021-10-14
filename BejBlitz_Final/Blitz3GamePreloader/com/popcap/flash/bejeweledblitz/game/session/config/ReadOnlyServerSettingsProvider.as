package com.popcap.flash.bejeweledblitz.game.session.config
{
   import com.popcap.flash.bejeweledblitz.game.Blitz3App;
   import flash.utils.Dictionary;
   
   public class ReadOnlyServerSettingsProvider extends BaseServerSettingsProvider
   {
       
      
      protected var m_App:Blitz3App;
      
      private var m_DataId:String;
      
      private var m_AlwaysUpdate:Boolean;
      
      public function ReadOnlyServerSettingsProvider(param1:Blitz3App, param2:String, param3:Vector.<String>, param4:Dictionary, param5:String, param6:Boolean = false)
      {
         super(param2,"",param3,param4);
         this.m_App = param1;
         this.m_DataId = param5;
         this.m_AlwaysUpdate = param6;
      }
      
      override public function CommitChanges(param1:Boolean, param2:Boolean) : void
      {
         if(!IsEnabled())
         {
            return;
         }
         if(!param2 && !this.m_AlwaysUpdate && !DoesHaveChanges())
         {
            return;
         }
         this.m_App.network.AddServerData(this.m_DataId,this.GetDataString());
         CopySettings();
      }
      
      private function GetDataString() : String
      {
         var _loc3_:* = null;
         var _loc1_:* = "{";
         var _loc2_:Boolean = true;
         for(_loc3_ in m_Values)
         {
            if(!_loc2_)
            {
               _loc1_ += ", ";
            }
            _loc1_ += "\"" + _loc3_ + "\":" + JSON.stringify(m_Values[_loc3_]);
            _loc2_ = false;
         }
         return _loc1_ + "}";
      }
   }
}
