package
{
	import flash.events.Event;
	public class App
	{
		private var nPlayer:VideoExample
		public function App(path:String)
		{
			trace("APP started");
			nPlayer = new VideoExample(path);
			nPlayer.addEventListener(Event.RESIZE,handleStageResize);
		}
		public function getVideoPlayer():VideoExample{
			return nPlayer;
		}
		
		public function handleStageResize(event:Event):void{
			var originalSize:Object = nPlayer.getSize();
			var stageRatio:Number = event.target.stage.stageWidth/event.target.stage.stageHeight;
			var ratio:Number = originalSize.width/originalSize.height;
			var diferenceY:Number = 0
			var diferenceX:Number = 0
			if(stageRatio>1){
				nPlayer.width = event.target.stage.stageWidth;
				nPlayer.height = nPlayer.width/ratio;
				diferenceY = Math.round((event.target.stage.stageHeight-nPlayer.height)/2);
			} else {
				nPlayer.height = event.target.stage.stageHeight;
				nPlayer.width = nPlayer.parent.height*ratio;
				diferenceX = Math.round((event.target.stage.stageWidth-nPlayer.width)/2);
			}
			trace(diferenceX,diferenceY)
			nPlayer.x = diferenceX;
			nPlayer.y = diferenceY;
		}
	}
}