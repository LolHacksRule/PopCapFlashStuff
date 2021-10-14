package com.popcap.flash.bejeweledblitz.replay
{
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayCommands;
   import com.popcap.flash.bejeweledblitz.logic.game.ReplayData;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class CommandSerializer
   {
       
      
      public function CommandSerializer()
      {
         super();
      }
      
      public static function SerializeCommands(commands:Vector.<ReplayData>) : ByteArray
      {
         var data:ReplayData = null;
         var move:Vector.<int> = null;
         var commandID:int = 0;
         var numItems:int = 0;
         var i:int = 0;
         var buffer:ByteArray = new ByteArray();
         buffer.endian = Endian.LITTLE_ENDIAN;
         for each(data in commands)
         {
            move = data.command;
            commandID = move[0];
            if(commandID < 0)
            {
               if(commandID == ReplayCommands.COMMAND_SEED)
               {
                  buffer.writeByte(ReplayCommands.COMMAND_SEED);
                  buffer.writeInt(move[1]);
               }
               else if(commandID == ReplayCommands.COMMAND_BOOST)
               {
                  buffer.writeByte(ReplayCommands.COMMAND_BOOST);
                  buffer.writeByte(move[1]);
               }
               else if(commandID == ReplayCommands.COMMAND_RAREGEM)
               {
                  buffer.writeByte(ReplayCommands.COMMAND_RAREGEM);
                  buffer.writeByte(move[1]);
               }
               else if(commandID == ReplayCommands.COMMAND_SET_GAME_DURATION)
               {
                  buffer.writeByte(ReplayCommands.COMMAND_SET_GAME_DURATION);
                  buffer.writeShort(move[1]);
               }
            }
            else
            {
               buffer.writeByte(commandID);
               buffer.writeShort(move[1]);
               buffer.writeByte(move.length - 2);
               numItems = move.length;
               for(i = 2; i < numItems; i++)
               {
                  buffer.writeShort(move[i]);
               }
            }
         }
         buffer.compress();
         return buffer;
      }
      
      public static function DeserializeCommands(buffer:ByteArray) : Vector.<ReplayData>
      {
         var commandID:int = 0;
         var data:ReplayData = null;
         var command:Vector.<int> = null;
         var numArgs:int = 0;
         var i:int = 0;
         var commands:Vector.<ReplayData> = new Vector.<ReplayData>();
         try
         {
            buffer.uncompress();
            while(buffer.bytesAvailable > 0)
            {
               commandID = buffer.readByte();
               data = new ReplayData();
               command = data.command;
               command[0] = commandID;
               if(commandID >= 0)
               {
                  command.push(buffer.readUnsignedShort());
                  numArgs = buffer.readUnsignedByte();
                  for(i = 0; i < numArgs; i++)
                  {
                     command.push(buffer.readUnsignedShort());
                  }
               }
               else if(command[0] == ReplayCommands.COMMAND_SEED)
               {
                  command.push(buffer.readInt());
               }
               else if(command[0] == ReplayCommands.COMMAND_BOOST)
               {
                  command.push(buffer.readUnsignedByte());
               }
               else if(command[0] == ReplayCommands.COMMAND_RAREGEM)
               {
                  command.push(buffer.readUnsignedByte());
               }
               else if(command[0] == ReplayCommands.COMMAND_SET_GAME_DURATION)
               {
                  command.push(buffer.readShort());
               }
               commands.push(data);
            }
         }
         catch(err:Error)
         {
            trace(err.getStackTrace());
         }
         return commands;
      }
   }
}
