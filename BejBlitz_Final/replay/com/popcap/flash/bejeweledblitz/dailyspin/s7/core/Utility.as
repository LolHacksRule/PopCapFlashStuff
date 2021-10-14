package com.popcap.flash.bejeweledblitz.dailyspin.s7.core
{
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getQualifiedClassName;
   
   public class Utility
   {
       
      
      public var _fmt:TextFormat;
      
      public function Utility()
      {
         this._fmt = new TextFormat();
         super();
      }
      
      public static function shuffle(aItems:Array) : void
      {
         var j:int = 0;
         var tmp:* = undefined;
         var len:int = aItems.length;
         for(var i:int = 0; i < len; i++)
         {
            j = i + Math.floor(Math.random() * (len - i));
            tmp = aItems[i];
            aItems[i] = aItems[j];
            aItems[j] = tmp;
         }
      }
      
      public static function cleanCRLF(refStr:String) : String
      {
         var str:String = null;
         str = refStr.split("\r\n").join("\n");
         str = str.split("\r").join("\n");
         return str.split("\\n").join("\n");
      }
      
      public static function updateBitmap(clip:MovieClip, bmp:BitmapData, smooth:Boolean) : void
      {
         bmp.draw(clip,new Matrix(),new ColorTransform(),null,null,smooth);
      }
      
      public static function updateTextField(container:DisplayObjectContainer, refTextField:TextField, updatedTextField:TextField, txtName:String, txt:String, letterSpacing:Number) : TextField
      {
         var tf:TextField = null;
         var fmt:TextFormat = null;
         var rot:Number = NaN;
         if(container != null && updatedTextField != null && container.contains(updatedTextField))
         {
            container.removeChild(updatedTextField);
         }
         tf = new TextField();
         fmt = refTextField.getTextFormat();
         rot = refTextField.rotation;
         refTextField.rotation = 0;
         fmt.letterSpacing = letterSpacing;
         fmt.kerning = true;
         tf.alpha = refTextField.alpha;
         tf.antiAliasType = refTextField.antiAliasType;
         tf.defaultTextFormat = fmt;
         tf.embedFonts = true;
         tf.gridFitType = refTextField.gridFitType;
         tf.height = refTextField.height;
         tf.mouseEnabled = refTextField.mouseEnabled;
         tf.mouseWheelEnabled = false;
         tf.multiline = refTextField.multiline;
         tf.name = txtName;
         tf.selectable = refTextField.selectable;
         tf.sharpness = refTextField.sharpness;
         tf.textColor = refTextField.textColor;
         tf.thickness = refTextField.thickness;
         tf.width = refTextField.width;
         tf.wordWrap = refTextField.wordWrap;
         tf.x = refTextField.x;
         tf.y = refTextField.y;
         tf.text = txt != null ? cleanCRLF(txt) : refTextField.text;
         tf.cacheAsBitmap = refTextField.cacheAsBitmap;
         tf.filters = refTextField.filters;
         tf.setTextFormat(fmt);
         tf.rotation = rot;
         refTextField.rotation = rot;
         if(container != null)
         {
            container.addChild(tf);
         }
         return tf;
      }
      
      public static function commaize(val:int, separator:String = ",", pos:int = 0) : String
      {
         var s:String = String(val % 10);
         if(val > 9)
         {
            if((pos + 1) % 3 == 0)
            {
               s = separator + s;
            }
            s = commaize(Math.floor(val / 10),separator,pos + 1) + s;
         }
         return s;
      }
      
      public static function getDigits(val:int, digits:Array) : void
      {
         digits.push(val % 10);
         if(val > 9)
         {
            getDigits(Math.floor(val / 10),digits);
         }
      }
      
      public static function ellipseText(t:TextField, str:String, maxLines:int, ellipsisSuffix:String) : void
      {
         t.text = str;
         if(ellipsisSuffix == null)
         {
            ellipsisSuffix = "...";
         }
         var len:int = str.length - 1;
         var w:Number = t.width - 0;
         var h:Number = t.height - 5;
         while(t.textWidth > w || t.numLines > maxLines)
         {
            t.text = str.substr(0,len--) + ellipsisSuffix;
         }
      }
      
      public static function drawBitmap(container:Sprite, b:BitmapData, color:uint, w:Number, h:Number, center:Boolean) : void
      {
         container.graphics.clear();
         if(b != null)
         {
            container.graphics.beginBitmapFill(b,null,false,true);
         }
         else
         {
            container.graphics.beginFill(~color & 16777215,1);
         }
         container.graphics.drawRect(0,0,w,h);
         container.graphics.endFill();
         if(center)
         {
            container.x = -w * 0.5;
            container.y = -h * 0.5;
         }
      }
      
      public static function makeRequest(vars:URLVariables, url:String) : URLLoader
      {
         var loader:URLLoader = new URLLoader();
         var request:URLRequest = new URLRequest(url);
         request.method = URLRequestMethod.POST;
         request.data = vars;
         loader.load(request);
         return loader;
      }
      
      public static function enumObject(o:Object, padding:String) : String
      {
         var tag:* = null;
         var str:String = "";
         for(tag in o)
         {
            str += processObjectItem(o[tag],o is Array ? "<" + tag + ">" : tag,padding);
         }
         return str;
      }
      
      private static function processObjectItem(item:Object, prefix:String, padding:String) : String
      {
         var t:String = getQualifiedClassName(item);
         prefix = padding + prefix + "[" + t + "]";
         if(t == "Object" || t == "Array")
         {
            prefix += ":\n" + enumObject(item,padding + "  ");
         }
         else
         {
            prefix += " = " + item + "\n";
         }
         return prefix;
      }
      
      public static function XMLtoObject(xml:XML) : Object
      {
         var child:XML = null;
         var val:Object = null;
         var id:String = null;
         var str:String = null;
         var o:Object = {};
         var children:XMLList = xml.children();
         for each(child in children)
         {
            id = child.name();
            if(child.children().length() == 1 && child.children()[0].nodeKind() == "text")
            {
               if(child.@id.length() > 0)
               {
                  id = String(child.@id);
               }
               str = String(child);
               if(str.toLowerCase() == "true")
               {
                  val = true;
               }
               else if(str.toLowerCase() == "false")
               {
                  val = false;
               }
               else if(isNaN(Number(str)))
               {
                  val = str;
               }
               else
               {
                  val = Number(str);
               }
            }
            else if(child.children().length() == 0)
            {
               if(child.@id.length() > 0)
               {
                  val = String(child.@id);
               }
            }
            else
            {
               val = XMLtoObject(child);
            }
            if(o[id] == null)
            {
               o[id] = val;
            }
            else if(o[id] is Array)
            {
               (o[id] as Array).push(val);
            }
            else
            {
               o[id] = new Array(o[id],val);
            }
         }
         return o;
      }
   }
}
