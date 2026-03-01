if (!ds_exists(global.tile_by_xy, ds_type_map))
    global.tile_by_xy = ds_map_create();
else
    ds_map_clear(global.tile_by_xy);

with (obj_chao)
{
    var k = string(px) + "," + string(py);
    ds_map_set(global.tile_by_xy, k, id);
}