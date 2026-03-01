persistent = true;
if (instance_number(obj_config) > 1) { instance_destroy(); exit; }


if (!variable_global_exists("vol_musica")) global.vol_musica = 0.8;
if (!variable_global_exists("vol_sfx"))    global.vol_sfx    = 0.8;
    
// Carrega grupos necessários
audio_group_load(audiogroup_sfx);
audio_group_load(audiogroup_music);

// Aplica volume (agora funciona)
audio_group_set_gain(audiogroup_music, clamp(global.vol_musica, 0, 1));
audio_group_set_gain(audiogroup_sfx,   clamp(global.vol_sfx, 0, 1));

global.fullscreen = window_get_fullscreen();



