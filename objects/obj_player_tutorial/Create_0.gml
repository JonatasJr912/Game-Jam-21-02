//Iniciando
//Quando é criado verifica o chao embaixo do player para definir sua posição inicial dentro do x e y do referido chão
inicio = instance_position(x,y,obj_chao);
if(inicio != noone)
{
    //Deixando no centro do tile atual
    x = inicio.x;
    y = inicio.y + 2;
    
}

//Variáveis
poder = false;
estado = noone;
pontos_movimento = 1;
pontos_acao = 1;

brilho = false;

//Variável de controle da escala x, lado esquerdo e direito
escala_imagem = image_xscale;

//Variáveis de controle movimentação
movimenta = false;
chegou = false;
alvo_x = noone;
alvo_y = noone;
invertendo = false;

//Variáveis aúdio

snd_cajado_h    = -1;
snd_move_h      = -1;
snd_vitoria_h   = -1;




//Métodos
troca_sprite = function(_sprite)
{
    //Checando se a minha sprite atual é diferente da sprite que vou mudar
    if(sprite_index != _sprite)
    {
       sprite_index = _sprite;
       //Zero a animação    
       image_index = 0;
           
    }    
    
} 

acabou_animacao = function()
{
    var _spd = sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps);
    return (image_index + _spd >= image_number);
    
} 


//Estados

//Estado padrão de movimento
estado_parado = function()
{
    troca_sprite(spr_player_idle); 
    
    invertendo = false;
    
    if (snd_cajado_h != -1) { audio_stop_sound(snd_move_h); snd_move_h = -1; }
    
    if (keyboard_check_pressed(ord("K")) && poder) 
    {
        estado = estado_invertendo_mundo;
              // evita empilhar se o jogador apertar rápido
        if (snd_cajado_h != -1) audio_stop_sound(snd_cajado_h);
        snd_cajado_h = audio_play_sound(sfx_pegando_cajado, 1, false);
    	
    }
    
    
} 


estado_movimentando = function()
{
    troca_sprite(spr_player_andando); 
    

    
    //Se movimenta for false e sem alvo saimos do método
    if(!movimenta){estado = estado_parado; exit; }
    if (alvo_x == noone || alvo_y == noone) {estado = estado_parado; exit; }
    
    //Variáveis para conferir se chegou
    var eps = 0.5; // tolerância
    var tx = alvo_x; // Destino x
    var ty = alvo_y + 2; // Destino y

    //Verificando
    //Se ainda não chegou, continua movendo
    if(!chegou)
    {
        x = lerp(x, tx, 0.12);
        y = lerp(y, ty, 0.12);

        if (point_distance(x, y, tx, ty) <= eps)
        {
            // Snapa no lugar exato
            x = tx;
            y = ty; 
            chegou = true; //Agora é só esperar a animação terminar
        }
        
    }else 
    {
            //Se chegou,
            //Para o movimento e limpa alvo
            movimenta = false;
            alvo_x = noone; 
            alvo_y = noone;
            
            //Reseta para poder movimentar novamente
            chegou = false; 
            estado = estado_parado;
            instance_create_layer(x,y,"Particulas",obj_particula_pousar);
        
            if (layer_exists("TutorialMove")) 
            {
                layer_destroy("TutorialMove");
                
            }
        
            exit;  
        	
    }
           
       
    
    
} 

estado_invertendo_mundo = function()
{
    
    with(obj_chao) 
    { 
        visivel = false;
    }
    
    if(layer_exists("TutorialInverte"))
    {
        layer_destroy("TutorialInverte");
        
    }
    
    movimenta = true;
    troca_sprite(spr_player_pegando_cajado)
    
    if(!global.desativar_efeitos)
    {
        instance_create_layer(x,y,"Efeito2",obj_inverte_mundo);
        tremer(2);
        brilho = true;
    }
        
    if (global.mundo == "normal" && invertendo == false)
    {
        global.mundo = "invertido";	
        invertendo = true;
        
    }else if(global.mundo == "invertido" && invertendo == false)
    {
        global.mundo = "normal";
        invertendo = true;
    }
    
    if (acabou_animacao()) 
    {
        instance_destroy(obj_inverte_mundo);
    	estado = estado_parado;
        brilho = false;
        movimenta = false;
        inst_2B0325F1.tipo = "chao";
        alarm[0] = game_get_speed(gamespeed_fps) * 2;
        
    }
    
} 


estado_pegando_cajado = function()
{
    x = global.tile_atual.x;
    y = global.tile_atual.y+2;
    troca_sprite(spr_player_pegando_cajado);
    
    
    if(!global.desativar_efeitos)
    {
        instance_create_layer(x,y,"Efeito2",obj_inverte_mundo);
        brilho = true;
        tremer(5);
    }
        
    if (acabou_animacao()) 
    {
    	estado = estado_parado;
        movimenta = false;
        alvo_x = noone; 
        alvo_y = noone;
        chegou = false; 
        instance_destroy(obj_inverte_mundo);
        brilho = false;
        poder = true;
        
        exit;
    }
    
} 


//Começando o estado
estado = estado_parado;