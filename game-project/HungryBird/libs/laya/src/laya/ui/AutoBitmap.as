package laya.ui {
	import laya.display.Graphics;
	import laya.renders.Render;
	import laya.resource.Texture;
	import laya.utils.Utils;
	import laya.utils.WeakObject;
	
	/**
	 * <code>AutoBitmap</code> 类是用于表示位图图像或绘制图形的显示对象。
	 * <p>封装了位置，宽高及九宫格的处理，供UI组件使用。</p>
	 */
	public class AutoBitmap extends Graphics {
		/**@private 是否自动缓存命令*/
		public var autoCacheCmd:Boolean = true;
		/**@private 宽度*/
		private var _width:Number = 0;
		/**@private 高度*/
		private var _height:Number = 0;
		/**@private 源数据*/
		private var _source:Texture;
		/**@private 网格数据*/
		private var _sizeGrid:Array;
		/**@private */
		protected var _isChanged:Boolean;
		/**@private */
		public var _offset:Array;
		///**@private */
		//private var _key:String;
		
		/**@inheritDoc */
		override public function destroy():void {
			super.destroy();
			_source = null;
			_sizeGrid = null;
			_offset = null;
		}
		
		/**
		 * 当前实例的有效缩放网格数据。
		 * <p>如果设置为null,则在应用任何缩放转换时，将正常缩放整个显示对象。</p>
		 * <p>数据格式：[上边距,右边距,下边距,左边距,是否重复填充(值为0：不重复填充，1：重复填充)]。
		 * <ul><li>例如：[4,4,4,4,1]</li></ul></p>
		 * <p> <code>sizeGrid</code> 的值如下所示：
		 * <ol>
		 * <li>上边距</li>
		 * <li>右边距</li>
		 * <li>下边距</li>
		 * <li>左边距</li>
		 * <li>是否重复填充(值为0：不重复填充，1：重复填充)</li>
		 * </ol></p>
		 * <p>当定义 <code>sizeGrid</code> 属性时，该显示对象被分割到以 <code>sizeGrid</code> 数据中的"上边距,右边距,下边距,左边距" 组成的矩形为基础的具有九个区域的网格中，该矩形定义网格的中心区域。网格的其它八个区域如下所示：
		 * <ul>
		 * <li>矩形上方的区域</li>
		 * <li>矩形外的右上角</li>
		 * <li>矩形左侧的区域</li>
		 * <li>矩形右侧的区域</li>
		 * <li>矩形外的左下角</li>
		 * <li>矩形下方的区域</li>
		 * <li>矩形外的右下角</li>
		 * <li>矩形外的左上角</li>
		 * </ul>
		 * 同时也支持3宫格，比如0,4,0,4,1为水平3宫格，4,0,4,0,1为垂直3宫格，3宫格性能比9宫格高。
		 * </p>
		 */
		public function get sizeGrid():Array {
			return _sizeGrid;
		}
		
		public function set sizeGrid(value:Array):void {
			_sizeGrid = value;
			_setChanged();
		}
		
		/**
		 * 表示显示对象的宽度，以像素为单位。
		 */
		public function get width():Number {
			if (_width) return _width;
			if (_source) return _source.sourceWidth;
			return 0;
		}
		
		public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				_setChanged();
			}
		}
		
		/**
		 * 表示显示对象的高度，以像素为单位。
		 */
		public function get height():Number {
			if (_height) return _height;
			if (_source) return _source.sourceHeight;
			return 0;
		}
		
		public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				_setChanged();
			}
		}
		
		/**
		 * 对象的纹理资源。
		 * @see laya.resource.Texture
		 */
		public function get source():Texture {
			return _source;
		}
		
		public function set source(value:Texture):void {
			if (value) {
				_source = value
				_setChanged();
			} else {
				_source = null;
				clear();
			}
		}
		
		/** @private */
		protected function _setChanged():void {
			if (!_isChanged) {
				_isChanged = true;
				Laya.timer.callLater(this, changeSource);
			}
		}
		
		/**
		 * @private
		 * 修改纹理资源。
		 */
		protected function changeSource():void {
			_isChanged = false;
			var source:Texture = this._source;
			if (!source || !source.bitmap) return;
			
			var width:Number = this.width;
			var height:Number = this.height;
			var sizeGrid:Array = this._sizeGrid;
			var sw:Number = source.sourceWidth;
			var sh:Number = source.sourceHeight;
			
			//如果没有设置9宫格，或大小未改变，则直接用原图绘制
			if (!sizeGrid || (sw === width && sh === height)) {
				clear();
				drawTexture(source, _offset ? _offset[0] : 0, _offset ? _offset[1] : 0, width, height);
			} else {
				//从缓存中读取渲染命令(和回收冲突，暂时去掉)
				//source.$_GID || (source.$_GID = Utils.getGID());
				//_key = source.$_GID + "." + width + "." + height + "." + sizeGrid.join(".");
				//if (Utils.isOKCmdList(WeakObject.I.get(_key))) {
					//this.cmds = WeakObject.I.get(_key);
					//return;
				//}
				
				clear();
				var top:Number = sizeGrid[0];
				var right:Number = sizeGrid[1];
				var bottom:Number = sizeGrid[2];
				var left:Number = sizeGrid[3];
				var repeat:Boolean = sizeGrid[4];
				var needClip:Boolean = false;
				if (width == sw) {
					left = right = 0;
				}
				if (height == sh) {
					top = bottom = 0;
				}
				//处理进度条不好看的问题
				if (left + right > width) {
					var clipWidth:Number = width;
					needClip = true;
					width = left + right;
					save();
					clipRect(0, 0, clipWidth, height);
				}
				
				//绘制四个角
				left && top && drawImage(getTexture(source, 0, 0, left, top), 0, 0, left, top);
				right && top && drawImage(getTexture(source, sw - right, 0, right, top), width - right, 0, right, top);
				left && bottom && drawImage(getTexture(source, 0, sh - bottom, left, bottom), 0, height - bottom, left, bottom);
				right && bottom && drawImage(getTexture(source, sw - right, sh - bottom, right, bottom), width - right, height - bottom, right, bottom);
				//绘制上下两个边
				top && drawBitmap(repeat, getTexture(source, left, 0, sw - left - right, top), left, 0, width - left - right, top);
				bottom && drawBitmap(repeat, getTexture(source, left, sh - bottom, sw - left - right, bottom), left, height - bottom, width - left - right, bottom);
				//绘制左右两边
				left && drawBitmap(repeat, getTexture(source, 0, top, left, sh - top - bottom), 0, top, left, height - top - bottom);
				right && drawBitmap(repeat, getTexture(source, sw - right, top, right, sh - top - bottom), width - right, top, right, height - top - bottom);
				//绘制中间
				drawBitmap(repeat, getTexture(source, left, top, sw - left - right, sh - top - bottom), left, top, width - left - right, height - top - bottom);
				
				if (needClip) restore();
				
				//缓存命令
				//if (autoCacheCmd && !Render.isConchApp) WeakObject.I.set(_key, this.cmds);
			}
			_repaint();
		}
		
		private function drawBitmap(repeat:Boolean, tex:Texture, x:Number, y:Number, width:Number = 0, height:Number = 0):void {
			if (width < 0.1 || height < 0.1) return;
			if (repeat && (tex.width != width || tex.height != height)) fillTexture(tex, x, y, width, height);
			else drawImage(tex, x, y, width, height);
		}
		
		private static function getTexture(tex:Texture, x:Number, y:Number, width:Number, height:Number):Texture {
			if (width <= 0) width = 1;
			if (height <= 0) height = 1;
			tex.$_GID || (tex.$_GID = Utils.getGID())
			//var key:String = tex.$_GID + "." + x + "." + y + "." + width + "." + height;
			//var texture:Texture = WeakObject.I.get(key);
			var texture:Texture;
			if (!texture || !texture._getSource()) {
				texture = Texture.createFromTexture(tex, x, y, width, height);
				//WeakObject.I.set(key, texture);
			}
			return texture;
		}
		
		//override public function clear(recoverCmds:Boolean = true):void {
			////重写clear，防止缓存被清理
			//super.clear(recoverCmds);
			//_key && WeakObject.I.del(_key);
		//}
	}
}