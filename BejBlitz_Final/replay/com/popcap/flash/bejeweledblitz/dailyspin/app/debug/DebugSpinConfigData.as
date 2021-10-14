package com.popcap.flash.bejeweledblitz.dailyspin.app.debug
{
   public class DebugSpinConfigData
   {
      
      private static const debugSlotsConfig:Object = {
         "config":{
            "numStrips":3,
            "maxDays":7,
            "content":"images/",
            "spinMinCount":3,
            "spinDelta":2,
            "spinVelocity":1.7,
            "minimalMode":false,
            "mysteryShareAmount":1000000
         },
         "prices":{"facebook":2},
         "title":{"ads":[{
            "imageURL":"http://labs.local.popcap.com/facebook/bj2/images/slots/ad_images/zuma_ad_1.png",
            "link":""
         },{
            "imageURL":"http://labs.local.popcap.com/facebook/bj2/images/slots/ad_images/test_ad_img.png",
            "link":"http://www.popcap.com"
         },{
            "imageURL":"http://labs.local.popcap.com/facebook/bj2/images/slots/ad_images/zuma_ad_2.png",
            "link":"http://www.yahoo.com"
         }]},
         "bonuses":[{
            "id":"daily",
            "val":100,
            "max":700
         },{
            "id":"friends",
            "val":100,
            "max":10000
         }],
         "prizes":[{
            "id":"PRIZE_0",
            "pct":0.008,
            "count":500,
            "ordered":false,
            "share":false,
            "anim":0,
            "value":"500",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_1",
            "shareAmount":0,
            "symbols":["SYMBOL_ANY","SYMBOL_ANY","SYMBOL_ANY"]
         },{
            "id":"PRIZE_1",
            "pct":0.3,
            "count":1000,
            "ordered":false,
            "share":false,
            "anim":0,
            "value":"1,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_2",
            "shareAmount":0,
            "symbols":["SYMBOL_0","SYMBOL_NONE","SYMBOL_NONE"]
         },{
            "id":"PRIZE_2",
            "pct":0.152,
            "count":2500,
            "ordered":false,
            "share":false,
            "anim":1,
            "value":"2,500",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_2",
            "shareAmount":0,
            "symbols":["SYMBOL_0","SYMBOL_0","SYMBOL_NONE"]
         },{
            "id":"PRIZE_3",
            "pct":0.1,
            "count":5000,
            "ordered":false,
            "share":false,
            "anim":1,
            "value":"5,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_3",
            "shareAmount":0,
            "symbols":["SYMBOL_6","SYMBOL_6","SYMBOL_6"]
         },{
            "id":"PRIZE_4",
            "pct":0.1,
            "count":10000,
            "ordered":false,
            "share":false,
            "anim":2,
            "value":"10,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_3",
            "shareAmount":0,
            "symbols":["SYMBOL_5","SYMBOL_5","SYMBOL_5"]
         },{
            "id":"PRIZE_5",
            "pct":0.1,
            "count":25000,
            "ordered":false,
            "share":true,
            "anim":2,
            "value":"25,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_3",
            "shareAmount":5000,
            "symbols":["SYMBOL_4","SYMBOL_4","SYMBOL_4"]
         },{
            "id":"PRIZE_6",
            "pct":0.15,
            "count":50000,
            "ordered":false,
            "share":true,
            "anim":3,
            "value":"50,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_4",
            "shareAmount":5000,
            "symbols":["SYMBOL_3","SYMBOL_3","SYMBOL_3"]
         },{
            "id":"PRIZE_7",
            "pct":0.07,
            "count":100000,
            "ordered":false,
            "share":true,
            "anim":3,
            "value":"100,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_4",
            "shareAmount":10000,
            "symbols":["SYMBOL_2","SYMBOL_2","SYMBOL_2"]
         },{
            "id":"PRIZE_8",
            "pct":0.013,
            "count":250000,
            "ordered":false,
            "share":true,
            "anim":3,
            "value":"250,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_4",
            "shareAmount":10000,
            "symbols":["SYMBOL_1","SYMBOL_1","SYMBOL_1"]
         },{
            "id":"PRIZE_9",
            "pct":0.007,
            "count":1000000,
            "ordered":false,
            "share":true,
            "anim":4,
            "value":"1,000,000",
            "sound":"SOUND_DAILYSPIN_PRIZE_WIN_5",
            "shareAmount":10000,
            "symbols":["SYMBOL_0","SYMBOL_0","SYMBOL_0"]
         }],
         "symbolImageMap":{
            "SYMBOL_5":"http://labs.local.popcap.com/facebook/bj2/images/slots/ad_images/zuma_ball_purple.png",
            "SYMBOL_3":"http://labs.local.popcap.com/facebook/bj2/images/slots/ad_images/zuma_ad_1.png"
         }
      };
       
      
      public function DebugSpinConfigData()
      {
         super();
      }
      
      public static function createPurchasedSpinData() : Object
      {
         var spinData:Object = new Object();
         spinData["spin"] = generatePrize();
         spinData["credits"] = 3;
         spinData["spinAmount"] = 6000;
         return spinData;
      }
      
      public static function createDSInitData() : Object
      {
         var initData:Object = new Object();
         initData["slotsConfig"] = debugSlotsConfig;
         initData["allowPurchase"] = true;
         initData["nextSpinDelta"] = 24 * 60 * 60;
         initData["credits"] = 0;
         initData["numFriends"] = 5;
         initData["currentDay"] = 4;
         initData["pid"] = 1277474947;
         initData["minimalMode"] = false;
         initData["shareSpin"] = "Spin.shareSpin";
         initData["purchaseSpin"] = "Spin.purchaseSpin";
         initData["consumeSpin"] = "Spin.consumeSpin";
         initData["dailySpinShutdown"] = "Spin.shutdown";
         initData["hasMysteryGift"] = false;
         initData["spin"] = generatePrize();
         return initData;
      }
      
      private static function generatePrize() : String
      {
         return "PRIZE_6";
      }
   }
}
