if (skip_click > 0) { skip_click--; exit; }

// Centro na GUI
var gx = display_get_gui_width()  * 0.5;
var gy = display_get_gui_height() * 0.5;

// Mouse em coordenadas GUI
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Retângulo do popup (GUI)
var left   = gx - w * 0.5;
var top    = gy - h * 0.5;
var right  = gx + w * 0.5;
var bottom = gy + h * 0.5;

// ESC fecha
if (keyboard_check_pressed(vk_escape)) {
    instance_destroy();
    exit;
}

// Clique fora fecha
if (mouse_check_button_pressed(mb_left)) {
    if (!(mx >= left && mx <= right && my >= top && my <= bottom)) {
        instance_destroy();
        exit;
    }
}

// Layout
var rx = right - 24;

var y_full = top + 70;
var y_fxoff = top + 110; // NOVO
var y_mus  = top + 170;
var y_sfx  = top + 230;

var slider_w = 240;
var slider_h = 12;
var slider_x1 = rx - slider_w;
var slider_x2 = rx;

// Toggle fullscreen
var box = 22;
var full_box_x1 = rx - box;
var full_box_y1 = y_full - box * 0.5;
var full_box_x2 = rx;
var full_box_y2 = y_full + box * 0.5;

// Toggle "Desativar efeitos" (checkbox)
var fx_box_x1 = rx - box;
var fx_box_y1 = y_fxoff - box * 0.5;
var fx_box_x2 = rx;
var fx_box_y2 = y_fxoff + box * 0.5;

// Sliders
var mus_y1 = y_mus - slider_h * 0.5;
var mus_y2 = y_mus + slider_h * 0.5;

var sfx_y1 = y_sfx - slider_h * 0.5;
var sfx_y2 = y_sfx + slider_h * 0.5;

// Botão fechar
var close_w = 120;
var close_h = 32;
var close_x1 = gx - close_w * 0.5;
var close_x2 = gx + close_w * 0.5;
var close_y1 = bottom - 50;
var close_y2 = close_y1 + close_h;

// Botão voltar ao menu (logo acima do Fechar)
var back_w = 220;
var back_h = 32;
var back_x1 = gx - back_w * 0.5;
var back_x2 = gx + back_w * 0.5;
var back_y2 = close_y1 - 10;
var back_y1 = back_y2 - back_h;

// --- Fullscreen toggle
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= full_box_x1 && mx <= full_box_x2 && my >= full_box_y1 && my <= full_box_y2) {
        global.fullscreen = !global.fullscreen;
        window_set_fullscreen(global.fullscreen);
    }
}

// --- Desativar efeitos toggle
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= fx_box_x1 && mx <= fx_box_x2 && my >= fx_box_y1 && my <= fx_box_y2) {
        global.desativar_efeitos = !global.desativar_efeitos;
    }
}

// --- Começa drag slider
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= slider_x1 && mx <= slider_x2 && my >= mus_y1 && my <= mus_y2) drag_mus = true;
    if (mx >= slider_x1 && mx <= slider_x2 && my >= sfx_y1 && my <= sfx_y2) drag_sfx = true;
}

if (mouse_check_button_released(mb_left)) {
    drag_mus = false;
    drag_sfx = false;
}

// --- Atualiza sliders
if (drag_mus) {
    var t = clamp((mx - slider_x1) / (slider_x2 - slider_x1), 0, 1);
    global.vol_musica = t;
    // aplica volume (ver obj_config abaixo)
    if (instance_exists(obj_config)) with (obj_config) aplica_audio();
}

if (drag_sfx) {
    var t2 = clamp((mx - slider_x1) / (slider_x2 - slider_x1), 0, 1);
    global.vol_sfx = t2;
    if (instance_exists(obj_config)) with (obj_config) aplica_audio();
}

// --- Voltar ao menu
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= back_x1 && mx <= back_x2 && my >= back_y1 && my <= back_y2) {

        // (opcional) salva config antes de sair
        //if (function_exists(config_save)) config_save();

        // (opcional) para áudio da partida (use se você tiver som tocando e quiser limpar)
        audio_stop_all();

        // Troca de room
        room_goto(rm_menu); // 

        // Fecha o popup (boa prática; apesar do room_goto já destruir instâncias)
        instance_destroy();
        exit;
    }
}



// --- Fechar
if (mouse_check_button_pressed(mb_left)) {
    if (mx >= close_x1 && mx <= close_x2 && my >= close_y1 && my <= close_y2) {
        instance_destroy();
        exit;
    }
}