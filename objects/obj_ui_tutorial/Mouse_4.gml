if (!instance_exists(obj_player_tutorial)) exit;
if(global.ui_bloqueada)exit;

// Evita o clique “vazar” pro chão por trás 
global.ui_bloqueada = true;
alarm[0] = 1; // solta no próximo frame 

// Decide pelo tipo do botão
switch (botao)
{
    case "mover":
    {
        with (obj_player_tutorial)
        {
            if (movimenta) exit;
            if (pontos_movimento <= 0) exit;

            // mesma lógica do "clicou no player"
            global.tile_atual = instance_position(x, y, obj_chao);
            global.player = id;
            global.ui_mover = !global.ui_mover;

            with (obj_chao) checa_movimento();
        }
    } break;

    case "inverte":
    {
        with (obj_player_tutorial)
        {
            if (estado != estado_parado) exit;
            if (pontos_acao <= 0) exit;
            if(!poder) exit;

            // mesmo efeito do K (inclui som)
            estado = estado_invertendo_mundo;

            if (snd_cajado_h != -1) audio_stop_sound(snd_cajado_h);
            snd_cajado_h = audio_play_sound(sfx_pegando_cajado, 1, false);
        }
    } break;

}