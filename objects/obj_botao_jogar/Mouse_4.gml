if (global.ui_bloqueada) exit;
    
image_index = 2;

layer_sequence_create("transicao",0,0,sq_transicao_1);

alarm[0] = game_get_speed(gamespeed_fps) * 1;

