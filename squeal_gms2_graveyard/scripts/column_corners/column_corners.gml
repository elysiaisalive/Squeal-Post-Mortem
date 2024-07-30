function column_corners( _var )
{
	var i = _var;

	x1 = bodyX + (i * columnWidth);
	y1 = bodyY + TargetHeight[i] - Height[i];
	x2 = x1 + columnWidth;
	y2 = bodyY + TargetHeight[i];
	right_y1 = y1;

	if (i < columns - 1)
	{
		right_y1 = bodyY + TargetHeight[i + 1] - Height[i + 1 ];
	}
}