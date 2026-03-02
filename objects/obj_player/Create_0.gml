//Iniciando
//Som da transição
snd_transicao_h = -1;
snd_transicao_h = audio_play_sound(sfx_transicao, 10, false);

//Quando é criado verifica o chao embaixo do player para definir sua posição inicial dentro do x e y do referido chão
var _inicio = instance_position(x,y,obj_chao);
if(_inicio != noone)
{
    //Deixando no centro do tile atual
    x = _inicio.x;
    y = _inicio.y + 2;
    
}

//Variáveis de controle movimentação
movimenta = false;
chegou = false;
alvo_x = noone;
alvo_y = noone;

//Variável de controle da escala x, lado esquerdo e direito (a escala_sprite é a escala que reduzimos a sprite)
escala_sprite = 0.6;
escala_imagem = escala_sprite;

//Variáveis
estado = noone;
pontos_movimento = 1;
pontos_acao = 1;
max_pontos_acao = 3;
invertendo = false;
brilho = false;

//Controlador do sprite orbe
next_x = 69;
step_x = -9;
y_fix = 125;

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
    
    //if (snd_move_h != -1) { audio_stop_sound(snd_move_h); snd_move_h = -1; }
    if (snd_cajado_h != -1) { audio_stop_sound(snd_move_h); snd_move_h = -1; }
    
    if (keyboard_check_pressed(ord("K")) && pontos_acao > 0) 
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
            
            //morreu se caiu no tile do inimigo (imediato)
            morre_se_inimigo_no_tile();
            if (estado == estado_morrendo)
            {
                // cancela o movimento pra não ter “mais um frame” de coisas estranhas
                movimenta = false;
                alvo_x = noone;
                alvo_y = noone;
                chegou = false;
                exit;
            }
            
        }
        
    }else 
    {
        // Se chegou,
        // Para o movimento e limpa alvo
        movimenta = false;
        alvo_x = noone; 
        alvo_y = noone;
    
        // Reseta para poder movimentar novamente
        chegou = false;
    
        // Se não morreu, segue normal
        estado = estado_parado;
        instance_create_layer(x,y,"Particulas",obj_particula_pousar);
    
        if (layer_exists("TutorialCombate")) 
        {
            layer_destroy("TutorialCombate");
        }
    
        exit;  
    }
           
       
    
    
} 

estado_invertendo_mundo = function()
{
    //Garantindo que a grid não fique visivel durante a animação
    with(obj_chao) 
    { 
        visivel = false;
    }
    
    if (layer_exists("TutorialCombate")) 
    {
        
        layer_destroy("TutorialCombate");
        
    }
    
    //Enquanto estamos invertendo mundo não queremos que seja possivel o player se movimentar
    movimenta = true;
    //E desmarcamos a UI de mover
    global.ui_mover = false;
    
    //Mudando para a sprite da animação de inverter o mundo
    troca_sprite(spr_player_pegando_cajado);
    
    if(!global.desativar_efeitos)
    {
        //Criando efeitos
        cria_efeito_inverte_mundo();
        tremer(2);
        brilho = true;
        //
    }
    
    //Invertendo o estado do mundo
    if (global.mundo == "normal" && invertendo == false)
    {
        global.mundo = "invertido";	
        invertendo = true;
        
    }else if(global.mundo == "invertido" && invertendo == false)
    {
        global.mundo = "normal";
        invertendo = true;
    }
    //
    
    //Finalizando o estado quando a animação acabar
    if (acabou_animacao()) 
    {
        //Ativando o alarme para checar se temos algum inimigo vivo
        alarm[0] = game_get_speed(gamespeed_fps) * 2;
        
        //Destruindo efeitos
        destroi_efeito_inverte_mundo();
        brilho = false;
        //
        //Resetando estado
        estado = estado_parado;
        movimenta = false;
        //
        //Gastando o ponto gasto para usar a habilidade
        pontos_acao -= 1;
        max_pontos_acao -= 1;
    
        layer_sprite_create("Orbe",next_x, y_fix, spr_ponto_fim);
        next_x += step_x;
        
        //Parando o som do cajado
        //if (snd_cajado_h != -1) {
            //audio_stop_sound(snd_cajado_h);
            //snd_cajado_h = -1;
        //}
        
        //alarm[1] = game_get_speed(gamespeed_fps) * 2;
        //
        
        
    }
    
} 


estado_pegando_cajado = function()
{
    //Trocando o sprite para o da animação
    troca_sprite(spr_player_pegando_cajado);
    
    if (acabou_animacao()) 
    {
    	estado = estado_parado;
    }
    
} 

//Estado matando o player
estado_morrendo = function()
{
    //Garantindo que a grid não fique visivel durante a animação
    with(obj_chao) 
    { 
        visivel = false;
    }
    //Enquanto estamos invertendo mundo não queremos que seja possivel o player se movimentar
    movimenta = true;
    
    troca_sprite(spr_player_morrendo)
    
    if(acabou_animacao())
    {
        room_restart();
        
    }
    
} 

morre_se_inimigo_no_tile = function()
{
    // sem inimigos, sem trabalho
    if (!instance_exists(obj_inimigo1) && !instance_exists(obj_inimigo2)) return;

    // pega meu tile atual (grid)
    var t_me = instance_position(x, y, obj_chao);
    if (t_me == noone) return;

    var my_px = t_me.px;
    var my_py = t_me.py;

    // procura inimigo1 no mesmo px/py
    var n1 = instance_number(obj_inimigo1);
    for (var i = 0; i < n1; i++)
    {
        var e = instance_find(obj_inimigo1, i);
        if (e == noone) continue;

        // opcional: ignora inimigo já morrendo
        if (e.estado == e.estado_morrendo) continue;

        var te = instance_position(e.x, e.y, obj_chao);
        if (te != noone && te.px == my_px && te.py == my_py)
        {
            estado = estado_morrendo;
            return;
        }
    }

    // procura inimigo2 no mesmo px/py
    var n2 = instance_number(obj_inimigo2);
    for (var j = 0; j < n2; j++)
    {
        var e2 = instance_find(obj_inimigo2, j);
        if (e2 == noone) continue;

        if (e2.estado == e2.estado_morrendo) continue;

        var te2 = instance_position(e2.x, e2.y, obj_chao);
        if (te2 != noone && te2.px == my_px && te2.py == my_py)
        {
            estado = estado_morrendo;
            return;
        }
    }
}








//Começando o estado
estado = estado_parado;