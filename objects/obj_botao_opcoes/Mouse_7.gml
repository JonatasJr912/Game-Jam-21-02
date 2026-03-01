if (global.ui_bloqueada) exit;

image_index = 0;

// Evita criar vários popups
if (instance_exists(obj_popup_opcoes)) exit;
    
instance_create_layer(0, 0, "GUI", obj_popup_opcoes);
