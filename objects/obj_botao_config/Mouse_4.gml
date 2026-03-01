if (global.ui_bloqueada) exit;

image_index = 2;

// Evita criar vários popups
if (!instance_exists(obj_popup_opcoes)) {
    // Cria em uma layer NORMAL de instâncias
    instance_create_layer(0, 0, "UI", obj_popup_opcoes);
    
}

alarm[0] = game_get_speed(gamespeed_fps);