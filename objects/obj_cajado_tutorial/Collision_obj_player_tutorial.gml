if(instance_exists(obj_player_tutorial) && instance_exists(obj_chao))
{
    with (obj_player_tutorial)
    {
        if (snd_cajado_h != -1) audio_stop_sound(snd_cajado_h);
        snd_cajado_h = audio_play_sound(sfx_desbloqueio_cajado, 1, false);
        poder = true;
        estado = estado_pegando_cajado;
        if (layer_exists("TutorialInverte")) 
        {
            alarm[1] = game_get_speed(gamespeed_fps);
        
        }
    
        
    }
    
    with (obj_chao) 
    {
        if (assets == "true") 
        {
            tipo = "parede";
        	
        }
    	
    }
  
    instance_create_layer(78,49,"Paredes",obj_parede_tutorial);
    instance_create_layer(102,37,"Paredes",obj_parede_tutorial);
    
    instance_destroy();
    
}