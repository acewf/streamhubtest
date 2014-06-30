package
{
	// autor @ ace - http://www.pixelkiller.net
	import flash.display.MovieClip;
	import flash.events.Event;

	public class App
	{
		private var nPlayer:ControlsExt
		public function App(path:String,controls:MovieClip)
		{
			trace("APP started");
			nPlayer = new ControlsExt(path,controls);
			nPlayer.addEventListener(Event.RESIZE,handleStageResize);
			nPlayer.addEventListener(Event.ADDED_TO_STAGE,handleStageResize);
		}
		public function getVideoPlayer():VideoExample{
			return nPlayer;
		}
		
		public function handleStageResize(event:Event):void{
			var originalSize:Object = nPlayer.getSize();
			var stageRatio:Number = event.target.stage.stageWidth/event.target.stage.stageHeight;
			var ratio:Number = originalSize.width/originalSize.height;
			var diferenceY:Number = 0;
			var diferenceX:Number = 0;
			if(isNaN(ratio)){
				ratio = 300/200;
			}
			trace(event.target.stage.stageHeight)
			if(stageRatio>1){
				nPlayer.height = event.target.stage.stageHeight;
				nPlayer.width = nPlayer.height*ratio;
				diferenceX = Math.round((event.target.stage.stageWidth-nPlayer.width)/2);
			} else {
				nPlayer.width = event.target.stage.stageWidth;
				nPlayer.height = nPlayer.width/ratio;
				diferenceY = Math.round((event.target.stage.stageHeight-nPlayer.height)/2);
			}
			nPlayer.x = diferenceX;
			nPlayer.y = diferenceY;
			nPlayer.stageResize(event);
		}
	}
}