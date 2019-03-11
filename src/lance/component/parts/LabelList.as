package lance.component.parts 
{
	import lance.component.events.SkinEvent;
	import lance.component.parts.AbstList;
	import lance.component.skin.LabelListSkin;
	import lance.component.skin.LanceSkin;
	import lance.core.contents.BitmapDataContent;
	import lance.core.array.Values;
	import lance.core.skinObject.BitmapDataSet;
	import lance.core.skinObject.SkinSprite;
	import lance.core.text.TextStyle;
	import lance.lance;		
	
	use namespace lance;
	/**
	 * @author SSen
	 */
	public class LabelList extends AbstList 
	{
		private var _data : XML = <list>
			<cell title="title1title1title1title1title1title1title1title1title1title1" thumbnail="icon1" value1="value1" />
			<cell title="title2" thumbnail="icon2" value1="value2" />
			<cell title="title3title3title3title3title3title3" thumbnail="icon3" value1="value3" />
			<cell title="title4" thumbnail="icon4" value1="value4" />
		</list>;
		private var _cellWidth : Number;
		private var _cellHeight : Number;
		private var _iconSet : BitmapDataSet;
		private var _textStyles : Array;
		private var _textStyle : TextStyle;

		// .<TextStyle>
		public function LabelList(skin : LabelListSkin, data : XML, textStyle : TextStyle, iconSet : BitmapDataSet = null, width : int = 0, height : int = 0)
		{	
			_cellHeight = height;
			_cellWidth = width;
			_iconSet = iconSet;
			_textStyle = textStyle;
			_textStyles = new Array();
			
			var list : Array = new Array();
			var label : LabelListCell;
			var cellData : XML;
			var bg : SkinSprite;
			var cnt : int = 0;
			var thumbnail : BitmapDataContent;
			var thumb : Boolean;
			var f : int;
			var style : TextStyle;
			for (f = 0;f <= skin.length; f++) {
				style = textStyle.clone();
				style.colors = skin.fontColors(f);
				_textStyles[f] = style;
			}
			for each (cellData in _data["cell"]) {
				bg = skin.bgs(cnt);
				thumb = iconSet != null && cellData.@thumbnail != undefined && iconSet[String(cellData.@thumbnail)] != undefined;
				thumbnail = (thumb) ? new BitmapDataContent(iconSet[String(cellData.@thumbnail)]) : null;
				label = new LabelListCell(cellData.@title, bg, _textStyles[cnt], width, height, thumbnail);
				for (f = 0;f < cellData.attributes().length(); f++) {
					label.values[cellData.attributes()[f].name()] = String(cellData.attributes()[f]);
				}
				list.push(label);
				cnt++;
				cnt = cnt % skin.length;
			}
			
			super(skin, width, height, list);
		}
		override protected function init() : void
		{
			var cell : LabelListCell;
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				addChild(cell);
			}
			super.init();
			
			refresh();
		}
		override public function set data(data : XML) : void
		{
			var f : int;
			for (f = 0; f < _cells.length; f++) {
				removeChild(_cells[f]);
			}
			_cells = new Array();
			
			var item : XML;
			var values : Values;
			for each (item in data["cell"]) {
				values = new Values();
				for (f = 0;f < item.attributes().length(); f++) {
					values[item.attributes()[f].name()] = String(item.attributes()[f]);
				}
				addList(item.@title, values, item.@thumbnail);
			}
		}
		override public function set skin(skin : LanceSkin) : void
		{
			_skin = skin;
			_textStyles = new Array();
			
			var f : int;
			var style : TextStyle;
			for (f = 0;f <= labelListSkin.length; f++) {
				style = _textStyle.clone();
				style.colors = labelListSkin.fontColors(f);
				_textStyles[f] = style;
			}
			
			skinning();
			
			dispatchEvent(new SkinEvent(SkinEvent.CHANGE));
		}
		override public function set enabled(bool : Boolean) : void
		{
			super.enabled = bool;
			var cell : LabelListCell;
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				cell.enabled = bool;
			}
		}
		override lance function skinning(modeName : String = null) : void
		{
			var cell : LabelListCell;
			var f : int;
			var c : int;
			for (f = 0;f < _cells.length; f++) {
				c = f % labelListSkin.length;
				cell = _cells[f];
				cell.bg = labelListSkin.bgs(c);
				cell.textStyle = _textStyles[c];
				cell.skinning();
			}
		}
		override public function refresh() : void
		{
			var cell : LabelListCell;
			var f : int;
			var c : int;
			for (f = 0;f < _cells.length; f++) {
				c = f % labelListSkin.length;
				cell = _cells[f];
				cell.x = 0;
				cell.y = _cellHeight * f;
			}
			super.refresh();
		}
		private function get labelListSkin() : LabelListSkin
		{
			return _skin as LabelListSkin;
		}
		override public function get height() : Number
		{
			return _cells.length * _cellHeight;
		}
		override public function set height(value : Number) : void
		{
			var cell : IListCell = _cells[0];
			var h : int = value / _cells.length;
			if (cell.minHeight > 0 && h < cell.minHeight) {
				h = cell.minHeight;
			}
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				cell.height = h;
			}
			_cellHeight = h;
			refresh();
			
			super.height = h * _cells.length;
		}
		override public function get width() : Number
		{
			return _cellWidth;
		}
		override public function set width(value : Number) : void
		{
			var cell : IListCell = _cells[0];
			var w : int = value;
			if (cell.minWidth > 0 && w < cell.minWidth) {
				w = cell.minWidth;
			}
			var f : int;
			for (f = 0;f < _cells.length; f++) {
				cell = _cells[f];
				cell.width = w;
			}
			_cellWidth = w;
			refresh();
			
			super.width = w;
		}
		public function addList(title : String, values : Values = null, thumbnail : String = "") : IListCell
		{
			var cnt : int = _cells.length % labelListSkin.length;
			var bg : SkinSprite = labelListSkin.bgs(cnt);
			var thumb : Boolean = _iconSet != null && thumbnail != "" && _iconSet[thumbnail] != undefined;
			var thumbObject : BitmapDataContent = (thumb) ? new BitmapDataContent(_iconSet[thumbnail]) : null;
			var label : LabelListCell = new LabelListCell(title, bg, _textStyles[cnt], width, height, thumbObject);
			if (values == null) values = new Values();
			values["title"] = title;
			if (thumb) values["thumbnail"] = thumbnail;
			label.values = values;
			label.width = _cellWidth;
			label.height = _cellHeight;
			_cells.push(label);
			
			return addListCell(label);
		}
		public function removeList(cell : IListCell) : IListCell
		{
			return removeListCell(cell);
		}
	}
}
