package com.popcap.flash.framework.input.keyboard
{
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   public class KeyCode
   {
      
      public static const UP:int = Keyboard.UP;
      
      public static const DOWN:int = Keyboard.DOWN;
      
      public static const LEFT:int = Keyboard.LEFT;
      
      public static const RIGHT:int = Keyboard.RIGHT;
      
      public static const SHIFT:int = Keyboard.SHIFT;
      
      public static const CONTROL:int = Keyboard.CONTROL;
      
      public static const TAB:int = Keyboard.TAB;
      
      public static const CAPS_LOCK:int = Keyboard.CAPS_LOCK;
      
      public static const ENTER:int = Keyboard.ENTER;
      
      public static const ESCAPE:int = Keyboard.ESCAPE;
      
      public static const END:int = Keyboard.END;
      
      public static const HOME:int = Keyboard.HOME;
      
      public static const INSERT:int = Keyboard.INSERT;
      
      public static const PAGE_UP:int = Keyboard.PAGE_UP;
      
      public static const PAGE_DOWN:int = Keyboard.PAGE_DOWN;
      
      public static const DELETE:int = Keyboard.DELETE;
      
      public static const BACKSPACE:int = Keyboard.BACKSPACE;
      
      public static const SPACE:int = Keyboard.SPACE;
      
      public static const F1:int = Keyboard.F1;
      
      public static const F2:int = Keyboard.F2;
      
      public static const F3:int = Keyboard.F3;
      
      public static const F4:int = Keyboard.F4;
      
      public static const F5:int = Keyboard.F5;
      
      public static const F6:int = Keyboard.F6;
      
      public static const F7:int = Keyboard.F7;
      
      public static const F8:int = Keyboard.F8;
      
      public static const F9:int = Keyboard.F9;
      
      public static const F11:int = Keyboard.F11;
      
      public static const F12:int = Keyboard.F12;
      
      public static const F13:int = Keyboard.F13;
      
      public static const F14:int = Keyboard.F14;
      
      public static const F15:int = Keyboard.F15;
      
      public static const NUMPAD_0:int = Keyboard.NUMPAD_0;
      
      public static const NUMPAD_1:int = Keyboard.NUMPAD_1;
      
      public static const NUMPAD_2:int = Keyboard.NUMPAD_2;
      
      public static const NUMPAD_3:int = Keyboard.NUMPAD_3;
      
      public static const NUMPAD_4:int = Keyboard.NUMPAD_4;
      
      public static const NUMPAD_5:int = Keyboard.NUMPAD_5;
      
      public static const NUMPAD_6:int = Keyboard.NUMPAD_6;
      
      public static const NUMPAD_7:int = Keyboard.NUMPAD_7;
      
      public static const NUMPAD_8:int = Keyboard.NUMPAD_8;
      
      public static const NUMPAD_9:int = Keyboard.NUMPAD_9;
      
      public static const NUMPAD_MULTIPLY:int = Keyboard.NUMPAD_MULTIPLY;
      
      public static const NUMPAD_ADD:int = Keyboard.NUMPAD_ADD;
      
      public static const NUMPAD_ENTER:int = Keyboard.NUMPAD_ENTER;
      
      public static const NUMPAD_SUBTRACT:int = Keyboard.NUMPAD_SUBTRACT;
      
      public static const NUMPAD_DECIMAL:int = Keyboard.NUMPAD_DECIMAL;
      
      public static const NUMPAD_DIVIDE:int = Keyboard.NUMPAD_DIVIDE;
      
      public static const NUM_0:int = 48;
      
      public static const NUM_1:int = 49;
      
      public static const NUM_2:int = 50;
      
      public static const NUM_3:int = 51;
      
      public static const NUM_4:int = 52;
      
      public static const NUM_5:int = 53;
      
      public static const NUM_6:int = 54;
      
      public static const NUM_7:int = 55;
      
      public static const NUM_8:int = 56;
      
      public static const NUM_9:int = 57;
      
      public static const A:int = 65;
      
      public static const B:int = 66;
      
      public static const C:int = 67;
      
      public static const D:int = 68;
      
      public static const E:int = 69;
      
      public static const F:int = 70;
      
      public static const G:int = 71;
      
      public static const H:int = 72;
      
      public static const I:int = 73;
      
      public static const J:int = 74;
      
      public static const K:int = 75;
      
      public static const L:int = 76;
      
      public static const M:int = 77;
      
      public static const N:int = 78;
      
      public static const O:int = 79;
      
      public static const P:int = 80;
      
      public static const Q:int = 81;
      
      public static const R:int = 82;
      
      public static const S:int = 83;
      
      public static const T:int = 84;
      
      public static const U:int = 85;
      
      public static const V:int = 86;
      
      public static const W:int = 87;
      
      public static const X:int = 88;
      
      public static const Y:int = 89;
      
      public static const Z:int = 90;
      
      public static const SEMICOLON:int = 186;
      
      public static const COLON:int = 186;
      
      public static const EQUALS:int = 187;
      
      public static const PLUS:int = 187;
      
      public static const MINUS:int = 189;
      
      public static const UNDERSCORE:int = 189;
      
      public static const FORESLASH:int = 191;
      
      public static const QUESTION_MARK:int = 191;
      
      public static const ACCENT_GRAVE:int = 192;
      
      public static const TILDE:int = 192;
      
      public static const LEFT_BRACKET:int = 219;
      
      public static const LEFT_BRACE:int = 219;
      
      public static const BACKSLASH:int = 220;
      
      public static const PIPE:int = 220;
      
      public static const RIGHT_BRACKET:int = 221;
      
      public static const RIGHT_BRACE:int = 221;
      
      public static const SINGLE_QUOTE:int = 222;
      
      public static const COMMA:int = 188;
      
      public static const LESS_THAN:int = 188;
      
      public static const PERIOD:int = 190;
      
      public static const GREATER_THAN:int = 190;
      
      private static var mInstance:KeyCode;
       
      
      private var mCodeMap:Dictionary;
      
      public function KeyCode()
      {
         super();
         this.mCodeMap = new Dictionary();
         this.mCodeMap["LEFT"] = LEFT;
         this.mCodeMap["RIGHT"] = RIGHT;
         this.mCodeMap["SHIFT"] = SHIFT;
         this.mCodeMap["CONTROL"] = CONTROL;
         this.mCodeMap["TAB"] = TAB;
         this.mCodeMap["CAPS_LOCK"] = CAPS_LOCK;
         this.mCodeMap["ENTER"] = ENTER;
         this.mCodeMap["ESCAPE"] = ESCAPE;
         this.mCodeMap["END"] = END;
         this.mCodeMap["HOME"] = HOME;
         this.mCodeMap["INSERT"] = INSERT;
         this.mCodeMap["PAGE_UP"] = PAGE_UP;
         this.mCodeMap["PAGE_DOWN"] = PAGE_DOWN;
         this.mCodeMap["DELETE"] = DELETE;
         this.mCodeMap["BACKSPACE"] = BACKSPACE;
         this.mCodeMap["SPACE"] = SPACE;
         this.mCodeMap["F1"] = F1;
         this.mCodeMap["F2"] = F2;
         this.mCodeMap["F3"] = F3;
         this.mCodeMap["F4"] = F4;
         this.mCodeMap["F5"] = F5;
         this.mCodeMap["F6"] = F6;
         this.mCodeMap["F7"] = F7;
         this.mCodeMap["F8"] = F8;
         this.mCodeMap["F9"] = F9;
         this.mCodeMap["F11"] = F11;
         this.mCodeMap["F12"] = F12;
         this.mCodeMap["F13"] = F13;
         this.mCodeMap["F14"] = F14;
         this.mCodeMap["F15"] = F15;
         this.mCodeMap["NUMPAD_0"] = NUMPAD_0;
         this.mCodeMap["NUMPAD_1"] = NUMPAD_1;
         this.mCodeMap["NUMPAD_2"] = NUMPAD_2;
         this.mCodeMap["NUMPAD_3"] = NUMPAD_3;
         this.mCodeMap["NUMPAD_4"] = NUMPAD_4;
         this.mCodeMap["NUMPAD_5"] = NUMPAD_5;
         this.mCodeMap["NUMPAD_6"] = NUMPAD_6;
         this.mCodeMap["NUMPAD_7"] = NUMPAD_7;
         this.mCodeMap["NUMPAD_8"] = NUMPAD_8;
         this.mCodeMap["NUMPAD_9"] = NUMPAD_9;
         this.mCodeMap["NUMPAD_MULTIPLY"] = NUMPAD_MULTIPLY;
         this.mCodeMap["NUMPAD_ADD"] = NUMPAD_ADD;
         this.mCodeMap["NUMPAD_ENTER"] = NUMPAD_ENTER;
         this.mCodeMap["NUMPAD_SUBTRACT"] = NUMPAD_SUBTRACT;
         this.mCodeMap["NUMPAD_DECIMAL"] = NUMPAD_DECIMAL;
         this.mCodeMap["NUMPAD_DIVIDE"] = NUMPAD_DIVIDE;
         this.mCodeMap["NUM_0"] = NUM_0;
         this.mCodeMap["NUM_1"] = NUM_1;
         this.mCodeMap["NUM_2"] = NUM_2;
         this.mCodeMap["NUM_3"] = NUM_3;
         this.mCodeMap["NUM_4"] = NUM_4;
         this.mCodeMap["NUM_5"] = NUM_5;
         this.mCodeMap["NUM_6"] = NUM_6;
         this.mCodeMap["NUM_7"] = NUM_7;
         this.mCodeMap["NUM_8"] = NUM_8;
         this.mCodeMap["NUM_9"] = NUM_9;
         this.mCodeMap["A"] = A;
         this.mCodeMap["B"] = B;
         this.mCodeMap["C"] = C;
         this.mCodeMap["D"] = D;
         this.mCodeMap["E"] = E;
         this.mCodeMap["F"] = F;
         this.mCodeMap["G"] = G;
         this.mCodeMap["H"] = H;
         this.mCodeMap["I"] = I;
         this.mCodeMap["J"] = J;
         this.mCodeMap["K"] = K;
         this.mCodeMap["L"] = L;
         this.mCodeMap["M"] = M;
         this.mCodeMap["N"] = N;
         this.mCodeMap["O"] = O;
         this.mCodeMap["P"] = P;
         this.mCodeMap["Q"] = Q;
         this.mCodeMap["R"] = R;
         this.mCodeMap["S"] = S;
         this.mCodeMap["T"] = T;
         this.mCodeMap["U"] = U;
         this.mCodeMap["V"] = V;
         this.mCodeMap["W"] = W;
         this.mCodeMap["X"] = X;
         this.mCodeMap["Y"] = Y;
         this.mCodeMap["Z"] = Z;
         this.mCodeMap["SEMICOLON"] = SEMICOLON;
         this.mCodeMap["COLON"] = COLON;
         this.mCodeMap["EQUALS"] = EQUALS;
         this.mCodeMap["PLUS"] = PLUS;
         this.mCodeMap["MINUS"] = MINUS;
         this.mCodeMap["UNDERSCORE"] = UNDERSCORE;
         this.mCodeMap["FORESLASH"] = FORESLASH;
         this.mCodeMap["QUESTION_MARK"] = QUESTION_MARK;
         this.mCodeMap["ACCENT_GRAVE"] = ACCENT_GRAVE;
         this.mCodeMap["TILDE"] = TILDE;
         this.mCodeMap["LEFT_BRACKET"] = LEFT_BRACKET;
         this.mCodeMap["LEFT_BRACE"] = LEFT_BRACE;
         this.mCodeMap["BACKSLASH"] = BACKSLASH;
         this.mCodeMap["PIPE"] = PIPE;
         this.mCodeMap["RIGHT_BRACKET"] = RIGHT_BRACKET;
         this.mCodeMap["RIGHT_BRACE"] = RIGHT_BRACE;
         this.mCodeMap["SINGLE_QUOTE"] = SINGLE_QUOTE;
         this.mCodeMap["COMMA"] = COMMA;
         this.mCodeMap["LESS_THAN"] = LESS_THAN;
         this.mCodeMap["PERIOD"] = PERIOD;
         this.mCodeMap["GREATER_THAN"] = GREATER_THAN;
      }
      
      private static function GetInstance() : KeyCode
      {
         if(mInstance == null)
         {
            mInstance = new KeyCode();
         }
         return mInstance;
      }
      
      public static function GetCodeFromString(str:String) : int
      {
         var id:String = str.toUpperCase();
         return int(GetInstance().mCodeMap[id]);
      }
   }
}
