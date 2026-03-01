global.ui_bloqueada = true;

skip_click = 2; // 1 ou 2 frames

// Tamanho do popup (GUI)
w = 520;
h = 360;

// Sliders (0..1)
drag_mus = false;
drag_sfx = false;

// Se essas globais não existirem ainda, cria defaults
if (!variable_global_exists("vol_musica")) global.vol_musica = 0.8;
if (!variable_global_exists("vol_sfx"))    global.vol_sfx    = 0.8;
if (!variable_global_exists("fullscreen")) global.fullscreen = window_get_fullscreen();
    
// desativar efeitos (performance)
if (!variable_global_exists("desativar_efeitos")) global.desativar_efeitos = false;