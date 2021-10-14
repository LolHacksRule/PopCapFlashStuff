package patternpark.net
{
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public function navigateToWindow(param1:String, param2:Object = null, param3:String = "") : IContextObject
   {
      var _loc16_:URLRequest = null;
      param3 = param3 == "" ? String(Math.round(9999 * Math.random()) + new Date().getTime()) : param3;
      var _loc4_:String = "navigateToWindow_" + param3;
      param2 = param2 || new Object();
      var _loc5_:Number = param2.toolbar == null ? Number(1) : Number(param2.toolbar);
      var _loc6_:Number = param2.scrollbars == null ? Number(1) : Number(param2.scrollbars);
      var _loc7_:Number = param2.location == null ? Number(1) : Number(param2.location);
      var _loc8_:Number = param2.status == null ? Number(1) : Number(param2.status);
      var _loc9_:Number = param2.menubar == null ? Number(1) : Number(param2.menubar);
      var _loc10_:Number = param2.resizable == null ? Number(1) : Number(param2.resizable);
      var _loc11_:Number = param2.width == null ? Number(100) : Number(param2.width);
      var _loc12_:Number = param2.height == null ? Number(100) : Number(param2.height);
      var _loc13_:Number = param2.left == null ? Number(0) : Number(param2.left);
      var _loc14_:Number = param2.top == null ? Number(0) : Number(param2.top);
      var _loc15_:String = (<![CDATA[
            function(url, winName, toolbar, scrollbars, location, status, menubar, resizable, width, height, left, top, uniqueWinName) {
                var winFeatures = new Array();
                winFeatures.push("toolbar=" + toolbar);
                winFeatures.push("scrollbars=" + scrollbars);
                winFeatures.push("location=" + location);
                winFeatures.push("status=" + status);
                winFeatures.push("menubar=" + menubar);
                winFeatures.push("resizable=" + resizable);
                winFeatures.push("width=" + width);
                winFeatures.push("height=" + height);
                winFeatures.push("left=" + left);
                winFeatures.push("top=" + top);
                    
                var winNew = this[uniqueWinName] = window.open(url,winName,winFeatures.join(","));

                if(!winNew) {
                    return false;
                }
                else {
                    winNew.focus();
                    return true;
                }
            }
        ]]>).toString();
      if(!ExternalInterface.available || !ExternalInterface.call(_loc15_,param1,param3,_loc5_,_loc6_,_loc7_,_loc8_,_loc9_,_loc10_,_loc11_,_loc12_,_loc13_,_loc14_,_loc4_))
      {
         _loc16_ = new URLRequest(param1);
         navigateToURL(_loc16_,"_blank");
         _loc4_ = null;
      }
      return new §_-9o§(_loc4_);
   }
}
