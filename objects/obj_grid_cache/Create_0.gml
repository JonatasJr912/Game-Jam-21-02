//id do obj_chao (px/py)
global.tile_by_xy = ds_map_create();

// Preenche uma vez no início da room
with (obj_chao)
{
    var k = string(px) + "," + string(py);
    ds_map_replace(global.tile_by_xy, k, id);
}
