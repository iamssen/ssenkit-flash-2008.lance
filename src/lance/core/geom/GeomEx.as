package lance.core.geom 
{
	import flash.geom.Rectangle;	
	/**
	 * geom util functions
	 * @author SSen
	 */
	public class GeomEx 
	{
		/** innerGrid to scal9Grid */
		static public function innerTo9Grid(inn : InnerGrid) : Rectangle
		{
			return new Rectangle(inn.left, inn.top, inn.gridWidth - inn.left - inn.right, inn.gridHeight - inn.top - inn.bottom);
		}
		/** scale9Grid to innerGrid */
		static public function grid9ToInner(grid : Rectangle, width : Number, height : Number) : InnerGrid
		{
			return new InnerGrid(grid.x, width - grid.width - grid.x, grid.y, height - grid.height - grid.y);
		}
	}
}
