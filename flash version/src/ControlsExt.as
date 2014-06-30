package
{
	// autor @ ace - http://www.pixelkiller.net
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	import caurina.transitions.Tweener;

	public class ControlsExt extends VideoExample
	{
		private var DISPLAY_TIMER_UPDATE_DELAY:int	= 10;
		private var DEFAULT_VOLUME:Number = 0;
		private var LAST_VOLUME:Number = 0.6;
		private var BUFFER_TIME:Number = 8;
		private var tmrDisplay:Timer;
		private var tmrDisplay_buffer:Timer;
		private var __start__point__:int;
		private var Paused:Boolean = false;
		private var __tracking_width__:int = 300;
		private var SoundScrubber:int  = 262;
		public var mcVideoControls:MovieClip
		private var bolVolumeScrub:Boolean = false;
		private var bolProgressScrub:Boolean = false;
		public function ControlsExt(path:String,controls:MovieClip)
		{
			super(path);
			mcVideoControls = controls;
			init();
			trace("init extension controls")
		}
		public function init():void{
			// hide buttons
			mcVideoControls.btnUnmute.visible = false;
			mcVideoControls.lblTimeDuration.htmlText		= "<font color='#ffffff'>00.00:00</font> / 00.00:00";
			
			mcVideoControls.btnMute.addEventListener(MouseEvent.CLICK, muteClicked);
			mcVideoControls.btnUnmute.addEventListener(MouseEvent.CLICK, unmuteClicked);
			mcVideoControls.btnVolumeBar.addEventListener(MouseEvent.MOUSE_DOWN, volumeScrubberClicked);
			mcVideoControls.btnVolumeBar.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			this.addEventListener(Event.ADDED_TO_STAGE,stageAdded);
			
			mcVideoControls.btnVolumeBar.addEventListener(MouseEvent.MOUSE_OUT, hideVolume);
			mcVideoControls.btnVolumeBar.buttonMode = true;
			
			mcVideoControls.btnMute.addEventListener(MouseEvent.MOUSE_OVER, showVolume);
			mcVideoControls.btnUnmute.addEventListener(MouseEvent.MOUSE_OVER, showVolume);
			mcVideoControls.rolloutarea.addEventListener(MouseEvent.MOUSE_OVER, hideVolume);
			
			tmrDisplay = new Timer(DISPLAY_TIMER_UPDATE_DELAY);
			tmrDisplay.addEventListener(TimerEvent.TIMER, updateDisplay);
			tmrDisplay.start();
			setVolume(DEFAULT_VOLUME);
			
		}
		public function updateDisplay(e:TimerEvent):void {
			var _percent_:Number = stream.bytesLoaded/stream.bytesTotal;
			if(_percent_<1){
				mcVideoControls.lblTimeDuration.htmlText		= "<font color='#ffffff'>"+formatTime(stream.time)+"</font> / "+formatTime(duration)+"<font color='#ffffff'> Loading file</font> "+Math.round(_percent_*100)+"%";
			} else {
				mcVideoControls.lblTimeDuration.htmlText		= "<font color='#ffffff'>"+formatTime(stream.time)+"</font> / "+formatTime(duration);
			}
		}
		private function formatTime(t:int):String {
			var s:int = Math.round(t);
			var m:int = 0;
			if (s > 0) {
				while (s > 59) {
					m++; s -= 60;
				}
				return String((m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
			} else {
				return "00:00";
			}
		}
		private function stageAdded(e:Event):void{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			mcVideoControls.y = stage.stageHeight-21;
			mcVideoControls.x = Math.round((stage.stageWidth/2)-(mcVideoControls.width/2));
		}
		public function stageResize(e:Event):void{
			mcVideoControls.y = stage.stageHeight-21;
			mcVideoControls.x = Math.round((stage.stageWidth/2)-(mcVideoControls.width/2));
		}
		private function showVolume(event:MouseEvent):void{
			Tweener.addTween(mcVideoControls.hideshowbar,{time:.2,width:1,x:262+35});
		}
		private function hideVolume(event:MouseEvent):void{
			Tweener.addTween(mcVideoControls.hideshowbar,{time:.2,width:35,x:262});
		}
		private function setVolume(intVolume:Number = 0):void {
			var sndTransform:SoundTransform		= new SoundTransform(intVolume);
			stream.soundTransform	= sndTransform;
			var TotalsizeVolume:int = 30;
			if(intVolume==0){
				mcVideoControls.btnMute.visible = false;
				mcVideoControls.btnUnmute.visible = true;
			} else {
				mcVideoControls.btnMute.visible = true;
				mcVideoControls.btnUnmute.visible = false;
			}
			Tweener.addTween(mcVideoControls.mcVolumeScrubber,{x:SoundScrubber+Math.round(TotalsizeVolume*intVolume),time:.2});
			Tweener.addTween(mcVideoControls.mcVolumeFill.mcFillRed,{width:Math.round(TotalsizeVolume*intVolume),time:.2});
		}
		private function muteClicked(e:MouseEvent):void {
			LAST_VOLUME = stream.soundTransform.volume;
			setVolume(0);
		}
		private function unmuteClicked(e:MouseEvent):void {
			var tmpVolume:Number = LAST_VOLUME;
			setVolume(tmpVolume);
		}
		private function volumeScrubberClicked(e:MouseEvent):void {
			bolVolumeScrub = true;
			var x_ini:int = mcVideoControls.btnVolumeBar.x;
			var y_ini:int = mcVideoControls.btnVolumeBar.y;
			var __width__:int = mcVideoControls.btnVolumeBar.width;
			mcVideoControls.mcVolumeScrubber.startDrag(true, new Rectangle(x_ini, y_ini, __width__, 0)); // NOW TRUE
		}
		private function mouseReleased(e:MouseEvent):void {
			mcVideoControls.mcVolumeScrubber.stopDrag();
			var value:int = mcVideoControls.mcVolumeScrubber.x-SoundScrubber;
			var percent:Number = (value/30);
			setVolume(percent);
		}
	}
}