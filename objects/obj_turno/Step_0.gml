// Exemplo: você decide quando o player termina o turno (botão, acabou pontos, etc.)
if (global.turno == "player")
{
    if (global.pedido_fim_turno)
    {
        global.pedido_fim_turno = false;
        global.turno = "inimigos";

        // --- prepara reserva do turno inimigo (ANTES deles decidirem) ---
        if (!variable_global_exists("reserva_tiles"))
        {
            global.reserva_tiles = ds_map_create();
        }
        else if (!ds_exists(global.reserva_tiles, ds_type_map))
        {
            global.reserva_tiles = ds_map_create();
        }
        else
        {
            ds_map_clear(global.reserva_tiles);
        }
        // --- prepara mapas do turno inimigo ---
if (!variable_global_exists("reserva_tiles") || !ds_exists(global.reserva_tiles, ds_type_map))
    global.reserva_tiles = ds_map_create();
else
    ds_map_clear(global.reserva_tiles);

if (!variable_global_exists("ocupacao_tiles") || !ds_exists(global.ocupacao_tiles, ds_type_map))
    global.ocupacao_tiles = ds_map_create();
else
    ds_map_clear(global.ocupacao_tiles);

        // --- preenche ocupação com posição ATUAL de cada inimigo (por px/py) ---
        // --- preenche ocupação com posição ATUAL de cada inimigo (por px/py) ---
        with (obj_inimigo1)
        {
            var t = instance_position(x, y, obj_chao);
            if (t != noone)
            {
                var k = string(t.px) + "," + string(t.py);
                ds_map_set(global.ocupacao_tiles, k, 1);
            }
        }
        
        with (obj_inimigo2)
        {
            var t = instance_position(x, y, obj_chao);
            if (t != noone)
            {
                var k = string(t.px) + "," + string(t.py);
                ds_map_set(global.ocupacao_tiles, k, 1);
            }
        }
        
        if (!instance_exists(obj_ui_turno_inimigo)) 
        {    
            instance_create_layer(0,90,"UI",obj_ui_turno_inimigo);
        }
        
        with (obj_inimigo1) iniciar_turno_inimigo();
        with (obj_inimigo2) iniciar_turno_inimigo();
        
    }
    
}
else if (global.turno == "inimigos")
{   
    // quando todos terminaram a ação, volta pro player
    var terminou_todos = true;
    
    with (obj_inimigo1)
    {
        if (!terminou_turno) terminou_todos = false;
    }
    with (obj_inimigo2)
    {
        if (!terminou_turno) terminou_todos = false;
    }

    if (terminou_todos)
    {
        global.turno = "player";
        
        instance_create_layer(0,90,"UI",obj_ui_turno_player);

        // (opcional) limpa reserva ao voltar pro player
        if (variable_global_exists("reserva_tiles") && ds_exists(global.reserva_tiles, ds_type_map))
        {
            ds_map_clear(global.reserva_tiles);
        }

        //Resetando atributos e coldowns de skills
        with (obj_player) 
        {
            pontos_movimento = 1; 
            
            if (max_pontos_acao > 0)
            {
                pontos_acao = 1;	
            }
            
            
        }
        
    }
}