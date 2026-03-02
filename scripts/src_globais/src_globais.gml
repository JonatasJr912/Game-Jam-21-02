#region Variáveis Globais
//Variáveis globais

global.tile_atual = noone;

global.player = noone;

global.mundo = "normal";

global.ui_mover = false;

global.ui_bloqueada = false;

global.desativar_efeitos = false;

global.nome_fase = noone;


#endregion



#region Funções Globais

function checa_estado_mundo(_normal = 0,_invertido = 1)
{
    if (global.mundo == "normal") 
    {
        image_index = _normal;
    }
    else 
    {
        image_index = _invertido;
        image_alpha = 1;
    	
    }
        
        
}

function cria_efeito_inverte_mundo()
{
    instance_create_layer(x,y,"Efeito",obj_inverte_mundo);
    
}

function destroi_efeito_inverte_mundo()
{
    instance_destroy(obj_inverte_mundo);
    
}

//function get_tipo_mundo(_mundo = global.mundo)
//{
    ////Normal
    //if (_mundo == "normal") return tipo;
//
    //// invertido
    //if (tipo == "parede") return "buraco";
    //return "chao";
    //
//}

function voltar_menu()
{
    room_goto(rm_menu);
    
}


function avancar_fase()
{
    var nome = room_get_name(room);
    
    // pega tudo depois do último "_" (o número)
    var pos = string_last_pos("_", nome);
    if (pos <= 0) {
        show_debug_message("Nome de room não segue rm_fase_X: " + nome);
        return;
    }
    
    var n_str = string_copy(nome, pos + 1, string_length(nome) - pos);
    var n = real(n_str);
    
    var proxima_nome = "rm_fase_" + string(n + 1);
    var proxima_room = asset_get_index(proxima_nome);
    
    if (proxima_room != -1) room_goto(proxima_room);
    else show_debug_message("Próxima fase não existe: " + proxima_nome);
}

function aplica_audio() {
    // Carrega grupos necessários
    audio_group_load(audiogroup_sfx);
    audio_group_load(audiogroup_music);
    
    audio_group_set_gain(audiogroup_music, clamp(global.vol_musica, 0, 1));
    audio_group_set_gain(audiogroup_sfx,   clamp(global.vol_sfx, 0, 1));
}

function aplica_fullscreen() {
    window_set_fullscreen(global.fullscreen);
}

function scr_nome_fase(_room)
{
    switch (_room)
    {
        case rm_fase_2: return "- O Cume que cai -";
        case rm_fase_3: return "- Maratona espectral -";
        case rm_fase_4: return "- Xeque-mate Undercut -";
        case rm_fase_5: return "- Pedala Maguinho -";
        case rm_fase_6: return "- Bispo,Rainha,Rei -";
        case rm_fase_7: return "- 'Efeito Borboleta' -";
        case rm_fase_8: return "- Dois Pesos duas medidas";
        case rm_fase_9: return "- Cabo de Guerra -";
        case rm_fase_10: return "- Encruzilhada do Espelheto -";
        // ...adicione todas as fases aqui

        default:
            // fallback: mostra o nome da room do projeto (rm_faseXX)
            return room_get_name(_room);
    }
}


#endregion