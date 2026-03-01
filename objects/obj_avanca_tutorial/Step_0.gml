if (global.mundo == "invertido") 
{
    image_alpha = 0;
    layer_set_visible(id_layer, false);
    mask_index = spr_mask_vazia;
    
}
else 
{
    draw_self();
    layer_set_visible(id_layer, true); 
    image_alpha = 0.75;
    mask_index = spr_player_idle;
    
}