package com.popcap.flash.bejeweledblitz.leaderboard.view.extended
{
   import com.popcap.flash.bejeweledblitz.leaderboard.LeaderboardWidget;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.IPlayerDataHandler;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.PlayerData;
   import com.popcap.flash.bejeweledblitz.leaderboard.model.TourneyData;
   import com.popcap.flash.bejeweledblitz.leaderboard.view.IInterfaceComponent;
   import com.popcap.flash.framework.App;
   import com.popcap.flash.games.blitz3.leaderboard.view.fla.BaseGraphView;
   import com.popcap.flash.games.leaderboard.resources.LeaderboardLoc;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class GraphView extends BaseGraphView implements IInterfaceComponent, IPlayerDataHandler
   {
      
      protected static const VERT_GRAPH_BUFFER:Number = 5;
      
      protected static const HORIZ_GRAPH_BUFFER:Number = 12;
      
      protected static const SELF_COLOR:int = 13186986;
      
      protected static const OTHER_COLOR:int = 16750865;
       
      
      protected var m_App:App;
      
      protected var m_Leaderboard:LeaderboardWidget;
      
      protected var m_Graph:Sprite;
      
      protected var m_Labels:Vector.<TextField>;
      
      protected var m_LabelNums:Vector.<int>;
      
      protected var m_Nodes:Vector.<Point>;
      
      protected var m_GraphNodes:Vector.<Vector.<GraphNode>>;
      
      protected var m_CurData:Vector.<PlayerData>;
      
      public function GraphView(app:App, leaderboard:LeaderboardWidget)
      {
         var label:TextField = null;
         var i:int = 0;
         super();
         this.m_App = app;
         this.m_Leaderboard = leaderboard;
         this.m_CurData = new Vector.<PlayerData>(2);
         this.m_Graph = new Sprite();
         this.m_Labels = new Vector.<TextField>();
         this.m_Labels.push(txtScoreBottom);
         this.m_Labels.push(txtScoreMiddle);
         this.m_Labels.push(txtScoreTop);
         this.m_LabelNums = new Vector.<int>(this.m_Labels.length);
         for each(label in this.m_Labels)
         {
            label.selectable = false;
            label.cacheAsBitmap = true;
         }
         this.m_Nodes = new Vector.<Point>(PlayerData.NUM_TOURNEYS);
         this.m_GraphNodes = new Vector.<Vector.<GraphNode>>(2);
         this.m_GraphNodes[0] = new Vector.<GraphNode>(PlayerData.NUM_TOURNEYS);
         this.m_GraphNodes[1] = new Vector.<GraphNode>(PlayerData.NUM_TOURNEYS);
         for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
         {
            this.m_Nodes[i] = new Point();
            this.m_GraphNodes[0][i] = new GraphNode(leaderboard,i);
            this.m_GraphNodes[1][i] = new GraphNode(leaderboard,i);
         }
         clipYou.visible = true;
         clipYouFriend.visible = false;
         clipBorder.mouseEnabled = false;
         clipShadow.mouseEnabled = false;
      }
      
      public function Init() : void
      {
         clipYouFriend.txtFriend.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_EXTENDED_GRAPH_FRIEND);
         clipYouFriend.txtYou.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_EXTENDED_GRAPH_YOU);
         clipYouFriend.txtVS.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_EXTENDED_GRAPH_VS);
         clipYou.txtYou.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_EXTENDED_GRAPH_YOU);
         txtLastWeeks.htmlText = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_EXTENDED_GRAPH_LAST_5_WEEKS);
         addChild(this.m_Graph);
         setChildIndex(clipShadow,numChildren - 1);
         this.m_Graph.x = anchorGraphTopLeft.x;
         this.m_Graph.y = anchorGraphTopLeft.y;
         for(var i:int = 0; i < PlayerData.NUM_TOURNEYS; i++)
         {
            this.m_Graph.addChild(this.m_GraphNodes[0][i]);
            this.m_Graph.addChild(this.m_GraphNodes[1][i]);
            this.m_GraphNodes[0][i].Init();
            this.m_GraphNodes[1][i].Init();
         }
      }
      
      public function Reset() : void
      {
         var i:int = 0;
         var cur:PlayerData = null;
         var numStoredData:int = this.m_CurData.length;
         for(i = 0; i < numStoredData; i++)
         {
            cur = this.m_CurData[i];
            if(cur != null)
            {
               cur.RemoveHandler(this);
            }
            this.m_CurData[i] = null;
         }
         this.m_Graph.graphics.clear();
         for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
         {
            this.m_GraphNodes[0][i].Reset();
            this.m_GraphNodes[1][i].Reset();
         }
      }
      
      public function SetPlayerData(data:PlayerData, otherData:PlayerData = null) : void
      {
         var cur:PlayerData = null;
         var numStoredData:int = this.m_CurData.length;
         for(var i:int = 0; i < numStoredData; i++)
         {
            cur = this.m_CurData[i];
            if(cur != null)
            {
               cur.RemoveHandler(this);
            }
            this.m_CurData[i] = null;
         }
         this.m_CurData[0] = data;
         data.AddHandler(this);
         if(otherData != null)
         {
            this.m_CurData[1] = otherData;
            otherData.AddHandler(this);
         }
         this.GraphScores(data,otherData);
         if(otherData)
         {
            clipYou.visible = false;
            clipYouFriend.visible = true;
         }
         else
         {
            clipYou.visible = true;
            clipYouFriend.visible = false;
         }
      }
      
      public function HandleStarMedalAwarded(data:PlayerData, id:int) : void
      {
         var cur:PlayerData = null;
         var isDisplayed:Boolean = false;
         for each(cur in this.m_CurData)
         {
            if(cur.fuid == data.fuid)
            {
               isDisplayed = true;
               break;
            }
         }
         if(isDisplayed)
         {
            this.GraphScores(this.m_CurData[0],this.m_CurData[1]);
         }
      }
      
      public function HandleMedalBucketFilled(data:PlayerData, id:int) : void
      {
      }
      
      protected function GetMaxScore(data:PlayerData, otherData:PlayerData = null) : int
      {
         var tourney:TourneyData = null;
         var maxScore:int = 0;
         for each(tourney in data.tourneyHistory)
         {
            if(tourney.score > maxScore)
            {
               maxScore = tourney.score;
            }
         }
         if(otherData != null)
         {
            for each(tourney in otherData.tourneyHistory)
            {
               if(tourney.score > maxScore)
               {
                  maxScore = tourney.score;
               }
            }
         }
         return maxScore;
      }
      
      protected function GraphScores(data:PlayerData, otherData:PlayerData = null) : void
      {
         var i:int = 0;
         var j:int = 0;
         var num:int = 0;
         var content:String = null;
         var curData:PlayerData = null;
         var numSavedScores:int = 0;
         var color:int = 0;
         var graphNode:GraphNode = null;
         this.m_Graph.graphics.clear();
         var maxScore:int = this.GetMaxScore(data,otherData);
         var graphWidth:Number = anchorGraphBottomRight.x - this.m_Graph.x;
         var graphHeight:Number = anchorGraphBottomRight.y - this.m_Graph.y;
         var graphRect:Rectangle = new Rectangle(HORIZ_GRAPH_BUFFER,VERT_GRAPH_BUFFER,graphWidth - 2 * HORIZ_GRAPH_BUFFER,graphHeight - 2 * VERT_GRAPH_BUFFER);
         var numLabels:int = this.m_LabelNums.length;
         this.m_LabelNums[0] = 0;
         if(maxScore >= 10000)
         {
            this.m_LabelNums[numLabels - 1] = Math.ceil(maxScore / 20000) * 20000;
         }
         else if(maxScore >= 1000)
         {
            this.m_LabelNums[numLabels - 1] = Math.ceil(maxScore / 2000) * 2000;
         }
         else
         {
            this.m_LabelNums[numLabels - 1] = 0;
         }
         for(i = 1; i < numLabels - 1; i++)
         {
            this.m_LabelNums[i] = this.m_LabelNums[0] + (this.m_LabelNums[numLabels - 1] - this.m_LabelNums[0]) * (i / (numLabels - 1));
         }
         for(i = 0; i < numLabels; i++)
         {
            num = this.m_LabelNums[i];
            content = num.toString();
            if(num > 1000 || num == 0)
            {
               content = this.m_App.TextManager.GetLocString(LeaderboardLoc.LOC_THOUSANDS_ABREVIATION);
               content = content.replace("%s",Math.round(num * 0.001));
            }
            this.m_Labels[i].htmlText = content;
         }
         for(j = 0; j < 2; j++)
         {
            for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
            {
               this.m_GraphNodes[j][i].visible = false;
            }
            curData = data;
            if(j == 1)
            {
               curData = otherData;
            }
            if(curData)
            {
               numSavedScores = curData.tourneyHistory.length;
               color = curData.fuid == this.m_Leaderboard.curPlayerFUID ? int(SELF_COLOR) : int(OTHER_COLOR);
               for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
               {
                  this.m_Nodes[i].x = graphRect.x + i / (PlayerData.NUM_TOURNEYS - 1) * graphRect.width;
                  this.m_Nodes[i].y = 0;
                  if(i < numSavedScores)
                  {
                     this.m_Nodes[i].y = graphRect.y + graphRect.height - curData.tourneyHistory[i].score * graphRect.height / maxScore;
                  }
               }
               this.m_Graph.graphics.lineStyle(2,color);
               this.m_Graph.graphics.moveTo(0,this.m_Nodes[0].y);
               for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
               {
                  this.m_Graph.graphics.lineTo(this.m_Nodes[i].x,this.m_Nodes[i].y);
               }
               this.m_Graph.graphics.lineTo(graphWidth,this.m_Nodes[PlayerData.NUM_TOURNEYS - 1].y);
               for(i = 0; i < PlayerData.NUM_TOURNEYS; i++)
               {
                  graphNode = this.m_GraphNodes[j][i];
                  graphNode.x = this.m_Nodes[i].x;
                  graphNode.y = this.m_Nodes[i].y;
                  graphNode.score = curData.tourneyHistory[i].score;
                  graphNode.SetColor(color);
                  graphNode.visible = true;
               }
            }
         }
      }
   }
}
