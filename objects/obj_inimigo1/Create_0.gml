// Alinha no tile inicialmente assim como o player
var t0 = instance_position(x, y, obj_chao);
if (t0 != noone) { x = t0.x; y = t0.y + 2; }

#region Variáveis

// Turno
terminou_turno = true;

//Variáveis de controle movimentação
movimenta = false;
chegou = false;
alvo_x = noone;
alvo_y = noone;
__ocupado = false;

troca_esqueleto = false;

//Variável de controle da escala x, lado esquerdo e direito (a escala_sprite é a escala que reduzimos a sprite)
escala_sprite = 0.6;
escala_imagem = escala_sprite;

//Teste
contador = 0;

// Mundo
mundo_anterior = global.mundo;

//Sprites do inimigo1 (fantasma/esqueleto)
spr_fantasma  = spr_inimigo_fantasma_idle;
spr_esqueleto = spr_inimigo_esqueleto_idle;

//Variáveis aúdio

tocou_som = false;
snd_movimento_h    = -1;

//Variáveis tipo inimigo
fantasma_quando_normal = true;   // inimigo1 = fantasma no normal
morte_skeleton_tipo    = "buraco"; // inimigo1 morre como esqueleto caindo no buraco


#endregion


/////////////////////////////////////////////////////////////////////////////////////////////


#region Métodos
// Métodos

troca_sprite = function(_sprite)
{
    //Checando se a minha sprite atual é diferente da sprite que vou mudar
    if (sprite_index != _sprite)
    {
        //Se for diferente, mudo a sprite e
        sprite_index = _sprite;
        //Zero a animação    
        image_index = 0;
    }
}

//Método de retornar para a global.mundo que ela é "normal" se o inimigo for fantasma
eh_fantasma = function()
{
    if (fantasma_quando_normal)
        return (global.mundo == "normal");
    else
        return (global.mundo == "invertido");
}

//Método que atualiza a sprite do inimigo com base na global.mundo
atualiza_forma = function()
{
    //Se a global.mundo for normal, troca para a sprite fantasma
    if (eh_fantasma()) 
    {
        troca_sprite(spr_fantasma);
         if(troca_esqueleto == true)
        {
            if(image_xscale > 0)
            {
            image_xscale = 0.6;
            image_yscale = 0.6; 
            escala_imagem = 0.6;
                
            }else 
            { 
            image_xscale = -0.6;
            image_yscale = 0.6; 
            escala_imagem = 0.6;
            	
            }
            
            
            troca_esqueleto = false;
        }
            
        
    }//Se não, é esqueleto
    else 
    {
        troca_sprite(spr_esqueleto);
        
        if(troca_esqueleto == false)
        {
            if(image_xscale > 0)
            {
            image_xscale = 0.65;
            image_yscale = 0.65; 
            escala_imagem = 0.65;
                
            }else 
            { 
            image_xscale = -0.65;
            image_yscale = 0.65; 
            escala_imagem = 0.65;
            	
            }
            
            
            troca_esqueleto = true;
        }
        
    }
    
}

//Método que devolve qual a grid/instância atual que o inimigo está colidindo
get_tile_atual = function()
{
    return instance_position(x, y, obj_chao);
}

// pega tile por px/py usando cache global
get_tile_xy = function(_px, _py)
{
    if (!ds_exists(global.tile_by_xy, ds_type_map)) return noone;

    var k = string(_px) + "," + string(_py);
    if (ds_map_exists(global.tile_by_xy, k)) return global.tile_by_xy[? k];
    return noone;
}

// converte tipo conforme mundo (se você já criou get_tipo_mundo no obj_chao, ele usa)
get_tipo_tile_no_mundo = function(_tile, _mundo)
{
    if (_tile == noone) return "nada";

    // Se existir método no tile, usa:
    if (is_undefined(_tile.get_tipo_mundo) == false)
        return _tile.get_tipo_mundo(_mundo);

    // Fallback: seu modelo atual (tipo = "chao" ou "parede"; no invertido parede -> buraco)
    if (_mundo == "normal") return _tile.tipo;
    if (_tile.tipo == "parede") return "buraco";
    return _tile.tipo;
}

//Método que verifica se tem um inimigo no tile desejado
tile_ocupado_por_inimigo = function(_tile)
{
    if (_tile == noone) return true;

    if (!variable_global_exists("ocupacao_tiles")) return false;
    if (!ds_exists(global.ocupacao_tiles, ds_type_map)) return false;

    var k = key_tile(_tile);
    return ds_map_exists(global.ocupacao_tiles, k);
}

key_tile = function(_tile) { return string(_tile.px) + "," + string(_tile.py); }

tile_reservado = function(_tile)
{
    if (_tile == noone) return true;

    // se nem existe ainda, não tem reserva
    if (!variable_global_exists("reserva_tiles")) return false;
    if (!ds_exists(global.reserva_tiles, ds_type_map)) return false;

    return ds_map_exists(global.reserva_tiles, key_tile(_tile));
}

reservar_tile = function(_tile)
{
    if (_tile == noone) return;

    // reserva_tiles
    if (variable_global_exists("reserva_tiles") && ds_exists(global.reserva_tiles, ds_type_map))
    {
        ds_map_set(global.reserva_tiles, key_tile(_tile), 1);
    }

    // ocupacao_tiles (pra ninguém escolher esse grid depois)
    if (variable_global_exists("ocupacao_tiles") && ds_exists(global.ocupacao_tiles, ds_type_map))
    {
        ds_map_set(global.ocupacao_tiles, key_tile(_tile), 1);
    }
}

//Método que verifica se pode pisar
pode_pisar = function(_tile)
{

    if (_tile == noone) return false;

    // não entra no tile do player (ele ataca quando adjacente)
    var t_player = instance_position(obj_player.x, obj_player.y, obj_chao);
    if (t_player != noone && _tile == t_player) return false;

    // não empilha inimigos
    if (tile_ocupado_por_inimigo(_tile)) return false;

    // não deixa dois escolherem o mesmo tile no mesmo turno
    if (tile_reservado(_tile)) return false;
    
    var tp = get_tipo_tile_no_mundo(_tile, global.mundo);

    if (eh_fantasma())
    {
        //Fantasma anda em todos os terrenos
        return (tp == "chao" || tp == "parede" || tp == "buraco");
    }
    else
    {
        //Esqueleto só no chão
        return (tp == "chao");
    }
}

// queda ao virar esqueleto
checa_morte_skeleton = function()
{
    if (eh_fantasma()) return;

    var t = get_tile_atual();
    if (t == noone) { estado = estado_morrendo; exit; }

    var tp = get_tipo_tile_no_mundo(t, global.mundo);

    if (tp == morte_skeleton_tipo)
    {
        estado = estado_morrendo;
        exit;
    }
}

// distância em grid (Manhattan)
dist_grid = function(_a, _b)
{
    return abs(_a.px - _b.px) + abs(_a.py - _b.py);
}

// ========= BFS: retorna o PRIMEIRO passo (tile vizinho) pra chegar no player =========
primeiro_passo_ate_player = function()
{
    if (!instance_exists(obj_player)) return noone;

    var start = get_tile_atual();
    var goal  = instance_position(obj_player.x, obj_player.y, obj_chao);
    if (start == noone || goal == noone) return noone;

    // Se já está no goal, sem passo
    if (start == goal) return noone;

    // Fila BFS
    var q = ds_queue_create();
    ds_queue_enqueue(q, start);

    // came_from: key(tile) -> parent tile
    // e visited: key(tile) -> true
    var came = ds_map_create();
    var vis  = ds_map_create();

    var key_of = function(_t) { return string(_t.px) + "," + string(_t.py); }

    ds_map_set(vis,  key_of(start), 1);
    ds_map_set(came, key_of(start), ""); // start sem pai

    // ---- NOVO: melhor aproximação ----
    var best_tile = start;
    var best_dist = dist_grid(start, goal);
    var best_dy = abs(start.py - goal.py);
    var best_dx = abs(start.px - goal.px);

    // Ordem das direções: PY primeiro (se quiser)
    var dirs = [
        [ 0, 1],
        [ 0,-1],
        [ 1, 0],
        [-1, 0]
    ];

    while (ds_queue_size(q) > 0)
    {
        var cur = ds_queue_dequeue(q);

        var dcur = dist_grid(cur, goal);
        var dycur = abs(cur.py - goal.py);
        var dxcur = abs(cur.px - goal.px);
        
        // 1) menor Manhattan
        // 2) empate: menor dy (alinha no PY primeiro)
        // 3) empate: menor dx
        if (dcur < best_dist
        || (dcur == best_dist && dycur < best_dy)
        || (dcur == best_dist && dycur == best_dy && dxcur < best_dx))
        {
            best_dist = dcur;
            best_tile = cur;
            best_dy = dycur;
            best_dx = dxcur;
        }

        for (var i = 0; i < 4; i++)
        {
            var nx = cur.px + dirs[i][0];
            var ny = cur.py + dirs[i][1];

            var nb = get_tile_xy(nx, ny);
            if (nb == noone) continue;
            if (!pode_pisar(nb)) continue;

            var k = key_of(nb);
            if (ds_map_exists(vis, k)) continue;

            ds_map_set(vis, k, 1);
            ds_map_set(came, k, key_of(cur));
            ds_queue_enqueue(q, nb);
        }
    }

    // Se nem saiu do lugar (preso total)
    if (best_tile == start)
    {
        ds_queue_destroy(q);
        ds_map_destroy(came);
        ds_map_destroy(vis);
        return noone;
    }

    // Reconstrói o caminho do best_tile até o start e pega o 1º passo
    var k_best = key_of(best_tile);

    var k = k_best;
    var parent = ds_map_find_value(came, k);

    while (parent != "" && parent != key_of(start))
    {
        k = parent;
        parent = ds_map_find_value(came, k);
    }

    var passo = noone;

    // k agora é o primeiro passo (vizinho do start)
    var comma = string_pos(",", k);
    var px1 = real(string_copy(k, 1, comma - 1));
    var py1 = real(string_copy(k, comma + 1, string_length(k) - comma));

    passo = get_tile_xy(px1, py1);

    ds_queue_destroy(q);
    ds_map_destroy(came);
    ds_map_destroy(vis);

    return passo;
}

// ========= Ataque (adjacente 4-dir) =========
pode_atacar_player = function()
{
    if (!instance_exists(obj_player)) return false;

    var me = get_tile_atual();
    var pl = instance_position(obj_player.x, obj_player.y, obj_chao);
    if (me == noone || pl == noone) return false;

    return (dist_grid(me, pl) <= 1); // só 4 direções por Manhattan
}

#endregion


/////////////////////////////////////////////////////////////////////////////////////////////



#region Estados

// ========= Estados =========
estado = noone;

estado_parado = function()
{
    //Descobre se é esqueleto ou fantasma
    atualiza_forma();
    
    tocou_som = false;
}

estado_atacando = function()
{
    //Descobre se é esqueleto ou fantasma
    atualiza_forma();
    
    //audio_play_sound(sfx_movimento_inimigo,1,0);
    
    //Criar uma particula de hit
    if (image_xscale < 0 ) 
    {
        var _ataque = instance_create_layer(x - 6,y - 6, "Efeito", obj_particula_ataque); //particula de hit para esquerda
        _ataque.image_xscale = 0.7;
    	
    }else
    {
        var _ataque = instance_create_layer(x + 6,y - 6, "Efeito", obj_particula_ataque); //particula de hit para direita
        _ataque.image_xscale = -0.7;
    	
    }
    
    
     with (obj_player) 
    {
        estado = estado_morrendo; 
    
    }

    // ataque termina o turno
    terminou_turno = true;
    estado = estado_parado;
}

estado_movimentando = function()
{
    //Descobre se é esqueleto ou fantasma
    atualiza_forma();

    if (!movimenta) { estado = estado_parado; exit; }
    if (alvo_x == noone || alvo_y == noone) { estado = estado_parado; exit; }

    var eps = 0.5;
    var tx = alvo_x;
    var ty = alvo_y + 2;
    
    if (!chegou)
    {
        x = lerp(x, tx, 0.12);
        y = lerp(y, ty, 0.12);

        if (point_distance(x, y, tx, ty) <= eps)
        {
            x = tx; y = ty;
            chegou = true;
        }
    }
    else
    {
        movimenta = false;
        alvo_x = noone;
        alvo_y = noone;
        chegou = false;

        // se for esqueleto e caiu em buraco, morre
        checa_morte_skeleton();

        terminou_turno = true;
        
        
                    if(!tocou_som)
            {
                 // mata qualquer instância anterior desse som do Inimigo
                 if (snd_movimento_h != -1) audio_stop_sound(snd_movimento_h);
                 snd_movimento_h = audio_play_sound(sfx_transicao, 1, false);
            }

        if (estado != estado_morrendo) estado = estado_parado;
        exit;
    }
}

estado_morrendo = function()
{
    contador++;
    if (contador >= game_get_speed(gamespeed_fps) * 2) 
    {
        y+=0.1;
        image_alpha = lerp(image_alpha,0,.1);
        
        if (image_alpha <= 0.1) 
        {
            audio_play_sound(sfx_esqueleto_morrendo,20,0);
            instance_create_layer(x,y-3,"Efeito", obj_particula_cair);
            instance_destroy();
        	
        }
    	
    }
    

}

// ========= Turno do inimigo =========
iniciar_turno_inimigo = function()
{
    
    var start = get_tile_atual();
var goal  = instance_position(obj_player.x, obj_player.y, obj_chao);

show_debug_message("start=" + string(start) + " goal=" + string(goal));

if (start != noone)
{
    show_debug_message("start pxpy=" + string(start.px) + "," + string(start.py));
    var t_test = get_tile_xy(start.px, start.py);
    show_debug_message("lookup self=" + string(t_test));

    var up = get_tile_xy(start.px, start.py-1);
    var dn = get_tile_xy(start.px, start.py+1);
    var lf = get_tile_xy(start.px-1, start.py);
    var rt = get_tile_xy(start.px+1, start.py);
    show_debug_message("nb up/dn/lf/rt=" + string(up) + " / " + string(dn) + " / " + string(lf) + " / " + string(rt));
}
    
    terminou_turno = false;

    atualiza_forma();

    // se acabou de virar esqueleto em buraco, morre antes de agir
    checa_morte_skeleton();
    
    if (estado == estado_morrendo) { terminou_turno = true; exit; }

    // 1) Se está adjacente (4 dir), ataca
    if (pode_atacar_player())
    {
        estado = estado_atacando;
        exit;
    }

    // 2) Senão, anda 1 passo pelo caminho BFS
    var passo = primeiro_passo_ate_player();
    if (passo == noone)
    {
        terminou_turno = true;
        estado = estado_parado;
        exit;
    }
    
    // reserva o tile escolhido (impede outro inimigo escolher o mesmo)
    reservar_tile(passo);

    // vira pro lado (visual)
    if (passo.x < x) 
    {
        image_xscale = -escala_imagem;
        
    }
    else
    { 
        image_xscale = escala_imagem;
        
    }

    alvo_x = passo.x;
    alvo_y = passo.y;

    movimenta = true;
    estado = estado_movimentando;
}

#endregion


//Estado Inicial
estado = estado_parado;