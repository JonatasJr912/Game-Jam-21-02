if (ds_exists(global.tile_by_xy, ds_type_map))
{
    ds_map_destroy(global.tile_by_xy);
}