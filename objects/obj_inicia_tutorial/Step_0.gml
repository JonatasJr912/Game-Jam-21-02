if (keyboard_check_pressed(ord("K"))) 
{
    if (!global.inicia) 
    {
        layer_sequence_create("transicao_intro", 0, -7, sq_intro);
       
        //Destruindo o fundo escuro
        alarm[0] = game_get_speed(gamespeed_fps) / 2;
       
        global.transicao = true;
    	global.inicia = true;
    }
   
	
}