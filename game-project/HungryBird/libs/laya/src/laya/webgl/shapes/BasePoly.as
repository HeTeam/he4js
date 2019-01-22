package laya.webgl.shapes
{
	import laya.maths.Matrix;
	public class BasePoly {
		/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
		private static var tempData:Array = new Array(256);
		
		/**
		 * 构造线的三角形数据。根据一个位置数组生成vb和ib
		 * @param	p
		 * @param	indices
		 * @param	lineWidth
		 * @param	indexBase				顶点开始的值，ib中的索引会加上这个
		 * @param	outVertex
		 * @return
		 */
		public static function createLine2(p:Array, indices:Array, lineWidth:Number, indexBase:Number, outVertex:Array, loop:Boolean):Array{
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			if (p.length < 4) return null;
			var points:Array = tempData.length>(p.length+2)?tempData:new Array(p.length + 2);	//可能有loop，所以+2
			points[0] = p[0]; points[1] = p[1];
			/*
			var points:Array = p.concat();
			if (loop) {
				points.push(points[0], points[1]);
			}
			*/
			var newlen:int = 2;	//points的下标，也是points的实际长度
			var i:int = 0;
			var length:int = p.length;
			//先过滤一下太相近的点
			for ( i = 2; i < length; i += 2) {
				if ( Math.abs(p[i] - p[i - 2]) + Math.abs(p[i + 1] - p[i - 1]) > 0.01) {//只是判断是否重合，所以不用sqrt
					points[newlen++] = p[i]; points[newlen++] = p[i + 1];
				}
			}
			//如果终点和起点没有重合，且要求loop的情况的处理
			if (loop && Math.abs(p[0] - points[newlen - 2]) + Math.abs( p[1] - points[newlen - 1]) > 0.01) {
				points[newlen++] = p[0]; points[newlen++] = p[1];
			}
			
			var result:Array = outVertex;
			length = newlen / 2;	//points可能有多余的点，所以要用inew来表示
			var w:Number = lineWidth / 2;
			
			var px:Number, py:Number, p1x:Number, p1y:Number, p2x:Number, p2y:Number, p3x:Number, p3y:Number;
			var perpx:Number, perpy:Number, perp2x:Number, perp2y:Number, perp3x:Number, perp3y:Number;
			var a1:Number, b1:Number, c1:Number, a2:Number, b2:Number, c2:Number;
			var denom:Number, pdist:Number, dist:Number;
			
			p1x = points[0];
			p1y = points[1];
			p2x = points[2];
			p2y = points[3];
			
			perpx = -(p1y - p2y);
			perpy = p1x - p2x;
			dist = Math.sqrt(perpx * perpx + perpy * perpy);
			perpx = perpx / dist * w ;
			perpy = perpy / dist * w ;
			//应用矩阵。 只要旋转缩放
			var tpx:Number = perpx, tpy:Number = perpy;
			
			result.push(p1x - perpx , p1y - perpy , p1x + perpx , p1y + perpy );
			for (i = 1; i < length - 1; i++)
			{
				p1x = points[(i - 1) * 2];
				p1y = points[(i - 1) * 2 + 1];
				p2x = points[(i) * 2];
				p2y = points[(i) * 2 + 1];
				p3x = points[(i + 1) * 2];
				p3y = points[(i + 1) * 2 + 1];
				
				perpx = -(p1y - p2y);
				perpy = p1x - p2x;
				dist = Math.sqrt(perpx * perpx + perpy * perpy);
				perpx = perpx / dist * w;
				perpy = perpy / dist * w;
				
				perp2x = -(p2y - p3y);
				perp2y = p2x - p3x;
				dist = Math.sqrt(perp2x * perp2x + perp2y * perp2y);
				perp2x = perp2x / dist * w ;
				perp2y = perp2y / dist * w ;
				
				a1 = (-perpy + p1y) - (-perpy + p2y);
				b1 = (-perpx + p2x) - (-perpx + p1x);
				c1 = (-perpx + p1x) * (-perpy + p2y) - (-perpx + p2x) * (-perpy + p1y);
				a2 = (-perp2y + p3y) - (-perp2y + p2y);
				b2 = (-perp2x + p2x) - (-perp2x + p3x);
				c2 = (-perp2x + p3x) * (-perp2y + p2y) - (-perp2x + p2x) * (-perp2y + p3y);
				denom = a1 * b2 - a2 * b1;
				if (Math.abs(denom) < 0.1)
				{
					denom += 10.1;
					result.push(p2x - perpx , p2y - perpy , p2x + perpx , p2y + perpy );
					continue;
				}
				px = (b1 * c2 - b2 * c1) / denom;
				py = (a2 * c1 - a1 * c2) / denom;
				pdist = (px - p2x) * (px - p2x) + (py - p2y) + (py - p2y);
				result.push(px, py ,p2x - (px - p2x) , p2y - (py - p2y) );
			}
			
			p1x = points[newlen - 4];
			p1y = points[newlen - 3];
			p2x = points[newlen - 2];
			p2y = points[newlen - 1];
			
			perpx = -(p1y - p2y);
			perpy = p1x - p2x;
			dist = Math.sqrt(perpx * perpx + perpy * perpy);
			perpx = perpx / dist * w ;
			perpy = perpy / dist * w ;
			
			result.push(p2x - perpx , p2y - perpy , p2x + perpx , p2y + perpy );
			for (i = 1; i < length; i++){
				indices.push(indexBase + (i - 1) * 2, indexBase + (i - 1) * 2 + 1, indexBase + i * 2 + 1, indexBase + i * 2 + 1, indexBase + i * 2, indexBase + (i - 1) * 2);
			}
			
			return result;
		}
		
		/**
		 * 相邻的两段线，边界会相交，这些交点可以作为三角形的顶点。有两种可选，一种是采用左左,右右交点，一种是采用 左右，左右交点。当两段线夹角很小的时候，如果采用
		 * 左左，右右会产生很长很长的交点，这时候就要采用左右左右交点，相当于把尖角截断。
		 * 当采用左左右右交点的时候，直接用切线的垂线。采用左右左右的时候，用切线
		 * 切线直接采用两个方向的平均值。不能用3-1的方式，那样垂线和下一段可能都在同一方向（例如都在右方）
		 * 注意把重合的点去掉
		 * @param	path
		 * @param	color
		 * @param	width
		 * @param	loop
		 * @param	outvb
		 * @param	vbstride  顶点占用几个float,(bytelength/4)
		 * @param	outib
		 * test:
		 * 横线
		 * [100,100, 400,100]
		 * 竖线
		 * [100,100, 100,400]
		 * 直角
		 * [100,100, 400,100, 400,400]
		 * 重合点
		 * [100,100,100,100,400,100]
		 * 同一直线上的点
		 * [100,100,100,200,100,3000]
		 * 像老式电视的左边不封闭的图形
		 * [98,176,  163,178, 95,66, 175,177, 198,178, 252,56, 209,178,  248,175,  248,266,  209,266, 227,277, 203,280, 188,271,  150,271, 140,283, 122,283, 131,268, 99,268]
		 * 
		 */
		//TODO:coverage
		public static function createLineTriangle(path:Array, color:uint, width:Number, loop:Boolean, outvb:Float32Array, vbstride:uint, outib:Uint16Array):void {
			/*[DISABLE-ADD-VARIABLE-DEFAULT-VALUE]*/
			var points:Array = path.slice();
			var ptlen:int = points.length;
			var p1x:Number = points[0], p1y:Number = points[1];
			var p2x:Number = points[2], p2y:Number = points[2];
			var len:Number = 0;
			var rp:Number = 0;
			var dx:Number = 0, dy:Number = 0;
			
			//计算每一段的长度，取出有效数据。保存:长度，方向，拐角，切线
			//x,y,len,dx,dy,tx,ty,dot
			//数组中每个都表示当前点开始的长度，方向
			//x,y,dx,dy
			
			var pointnum:int = ptlen / 2;
			if (pointnum <= 1) return;
			if (pointnum == 2) {
				//TODO
				return;
			}
			
			var tmpData:Array = new Array(pointnum * 4);//TODO 做到外面
			var realPtNum:int = 0;	//去掉重复点后的实际点个数。同一直线上的点不做优化
			//var segNum:int = pointnum + (loop?1:0);
			var ci:int = 0;
			for ( var i:int = 0; i < pointnum-1; i++) {
				p1x = points[ci++], p1y = points[ci++];
				p2x = points[ci++], p2y = points[ci++];
				dx = p2x - p1x, dy= p2y - p1y;
				if(dx!=0 && dy!=0 ){
					len = Math.sqrt(dx * dx + dy * dy);
					if (len > 1e-3) {
						rp = realPtNum * 4;
						tmpData[rp] = p1x;
						tmpData[rp + 1] = p1y;
						tmpData[rp + 2] = dx / len;
						tmpData[rp + 3] = dy / len;
						realPtNum++;
					}
				}
			}
			if (loop) {//loop的话，需要取第一个点来算
				p1x = points[ptlen-2], p1y = points[ptlen-1];
				p2x = points[0], p2y = points[1];
				dx = p2x - p1x, dy = p2y - p1y;
				if(dx!=0 && dy!=0 ){//如果长度为零的话，最后这个点就不用加了，上一个点就是指向了第一个点。
					len = Math.sqrt(dx * dx + dy * dy);
					if (len > 1e-3) {
						rp = realPtNum * 4;
						tmpData[rp] = p1x;
						tmpData[rp + 1] = p1y;
						tmpData[rp + 2] = dx / len;
						tmpData[rp + 3] = dy / len;
						realPtNum++;
					}
				}
			}else {//不是loop的话，直接取当前段的朝向，记录在上一个点上
				rp = realPtNum * 4;
				tmpData[rp] = p1x;
				tmpData[rp + 1] = p1y;
				tmpData[rp + 2] = dx / len;
				tmpData[rp + 3] = dy / len;
				realPtNum++;
			}
			ci = 0;

			/**
			 * 根据前后两段的方向，计算垂线的方向，根据这个方向和任意一边的dxdy的垂线的点积为w/2可以得到长度。就可以得到增加的点
			 */
			//如果相邻两段朝向的dot值接近-1，则表示反向了，需要改成切
			
			for ( i= 0; i < pointnum; i++) {
				p1x = points[ci], p1y = points[ci + 1];
				p2x = points[ci + 2], p2y = points[ci + 3];
				var p3x:Number = points[ci + 4], p3y:Number = points[ci + 5];
				
			}
			if ( loop ) {
				
			}
			
		}
	}
}