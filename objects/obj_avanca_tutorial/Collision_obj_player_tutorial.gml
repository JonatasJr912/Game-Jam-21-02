if (!colidiu)
{
    audio_play_sound(sfx_vitoria,2,0);
	alarm[0] = game_get_speed(gamespeed_fps);
    colidiu = true;
}

    //Garantindo que a grid não fique visivel durante a animação
    with(obj_chao) 
    { 
        visivel = false;
    }
    //Enquanto estamos invertendo mundo não queremos que seja possivel o player se movimentar
    if(instance_exists(obj_player_tutorial))
    {
         obj_player_tutorial.movimenta = true;
    }

