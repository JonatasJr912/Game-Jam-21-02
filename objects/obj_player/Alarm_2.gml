//Avançando fase
if(room != rm_fase_10)
{
    avancar_fase();
    
}

if(room == rm_fase_10)
{
    global.ui_bloqueada = true;
    image_alpha = 0;
    layer_sequence_create("TransicaoFim", 0, 0, sq_final);
    if(instance_exists(obj_nome_fase))
    {
        instance_destroy(obj_nome_fase);
    }
}