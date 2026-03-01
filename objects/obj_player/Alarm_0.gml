//checando se tem algum inimigo vivo ainda
if(!instance_exists(obj_inimigo1) && !instance_exists(obj_inimigo2))
{
    audio_play_sound(sfx_vitoria,20,0);
    alarm[2] = game_get_speed(gamespeed_fps);
    
}


