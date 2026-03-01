if (global.ui_bloqueada) exit;
// Se clicou em cima de um botão de UI, não processa clique de movimento
if (instance_position(mouse_x, mouse_y, obj_ui2) != noone) exit;
    
var _alvo = collision_point(mouse_x, mouse_y, obj_chao, true, false);

if(_alvo == noone) exit;


// clicou no player?
if(position_meeting(mouse_x,mouse_y,id))
{
    if (!global.inicia || global.transicao) {
    	exit;
    }
    
    if (movimenta) return;
    
    if(pontos_movimento > 0)
    {
        //Globalizando as variáveis da instância que é o tile atual do player, e o próprio personagem atual do player
        global.tile_atual = instance_position(x,y,obj_chao);
        global.player = id;
        global.ui_mover = !global.ui_mover;
           
        //Rodando o código de checar as posições disponiveis no obj_chão
        with(obj_chao)
        {
            checa_movimento();	
        }
    }
        
    exit;
}


// só pode andar em tiles válidos
if(_alvo.visivel && global.inicia)
{
    
    global.tile_atual = _alvo;
    global.ui_mover = false;

    if(_alvo.x < global.player.x)
    {
        image_xscale = -escala_imagem;
    }else
    {
        image_xscale = escala_imagem;
    	
    }
    alvo_x = _alvo.x;
    alvo_y = _alvo.y;
    
    instance_create_layer(x,y,"Particulas",obj_particula_pular);
    movimenta = true;
    estado = estado_movimentando;
    
    // mata qualquer instância anterior desse som do player
    if (snd_move_h != -1) audio_stop_sound(snd_move_h);
    snd_move_h = audio_play_sound(sfx_movimento, 1, false);
    //pontos_movimento -= 1;

        with(obj_chao)
         {
             visivel = false;
         }

}